local _, ns = ...

-- Blizzard
local IsSpellKnown = C_SpellBook.IsSpellKnown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = C_Item.GetItemInfo
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local GetOverrideSpell = C_Spell and C_Spell.GetOverrideSpell

-- Compat
local GetSpellInfo = ns.compat.GetSpellInfo
local GetSpellCooldown = ns.compat.GetSpellCooldown
local SpellCooldownSecret = ns.compat.SpellCooldownSecret
local IsSecret = ns.compat.IsSecret

--------------------------------------------------
-- COOLDOWNS
--------------------------------------------------
local cooldown_proto = {}

do
    --[[ Callback: cooldown_proto:Update(unit, data, index)
    Update the cooldown button and its components.

    * self   - the widget holding the aura buttons
    * unit   - the unit on which the aura is cast (string)
    * data   - the cooldown object (table)
    * index  - the actual position of the aura button (number)
    ]]--
    function cooldown_proto:Update(unit, data, index)
        if not data.name then return end

        local button = self:AcquireButton(index)

        button:SetSecret(data.durationObject ~= nil)

        -- tooltips
        button.unit = unit
        button.spellId = data.spellId
        button.slotId = data.slotId

        -- timers
        button.expirationTime = data.expirationTime or GetTime()

        if button.Cooldown then
            if data.durationObject then
                button.Cooldown:SetCooldownFromDurationObject(data.durationObject)
                button.TimeBinding:SetDuration(data.durationObject)
                button.Cooldown:Show()
            elseif data.duration and data.duration > 0 then
                button.Cooldown:SetCooldown(data.expirationTime - data.duration, data.duration, data.timeMod)
                button.Cooldown:Show()
            else
                button.Cooldown:Hide()
            end
        end

        if button.Icon then
            if data.icon then
                button.Icon:SetTexture(data.icon)
                button.Icon:Show()
            else
                button.Icon:Hide()
            end
        end

        if data.duration and data.duration > 0 then
            button:SetScript("OnUpdate", button.OnUpdate)
        end

        button:Show()
    end

    --[[ Override: cooldown_proto:FilterCooldown(data)
    Defines a custom filter that controls if the cooldown button should be shown.

    * self - the widget holding the aura buttons
    * data - the cooldown object (table)

    ## Returns

    * show - indicates whether the aura button should be shown (boolean)
    --]]
    function cooldown_proto:FilterCooldown(data)
        if not data.name then return end
        -- secret cooldown: already known to be active and off GCD; casts can't be recorded while restricted
        if data.durationObject then
            return data.enabled and data.isKnown
        end
        return data.name
            and data.enabled
            and data.isKnown
            and data.casted
            and (data.duration and data.duration > 1.5)     -- classic sometimes bring 1.5 duration
            and (data.start and data.start > 0)
    end

    --[[ Override: cooldown_proto.SortCooldowns(a, b)
    Defines a custom sorting algorithm for ordering the cooldowns.

    Overridden by the more specific SortCooldowns overrides if they are defined.
    --]]
    cooldown_proto.SortCooldowns = function(a, b)
        if (a.expirationTime ~= b.expirationTime) then
            return a.expirationTime < b.expirationTime
        end
        return a.index < b.index
    end

    -- returns the row's reused data table; name/icon are cached and only looked up again when they can change
    function cooldown_proto:ProcessCooldownData(unit, data)
        local d = self.rows[data]
        if not d then
            d = {
                index = data.spellId and ("SPELL_" .. data.spellId) or ("SLOT_" .. data.slotId),
                spellId = data.spellId,
                slotId = data.slotId
            }
            self.rows[data] = d
        end

        local start, duration, enabled, durationObject

        if data.spellId then
            -- a talent can replace one tracked spell with another (e.g. Sentinel overrides Avenging Wrath)
            local activeSpellId = GetOverrideSpell and GetOverrideSpell(data.spellId) or data.spellId
            -- iconID follows the override, so look it up again when the override changes
            if not d.name or d.activeSpellId ~= activeSpellId then
                local info = GetSpellInfo(data.spellId)
                d.name = info and info.name
                d.icon = info and info.iconID
            end
            d.activeSpellId = activeSpellId

            local cdInfo = GetSpellCooldown(data.spellId)
            if cdInfo then
                if SpellCooldownSecret(data.spellId) then
                    -- startTime/duration are secret; isActive/isOnGCD never are
                    if cdInfo.isActive and not cdInfo.isOnGCD then
                        durationObject = C_Spell.GetSpellCooldownDuration(data.spellId)
                    end
                else
                    start = cdInfo.startTime
                    duration = cdInfo.duration
                end
                enabled = cdInfo.isEnabled and 1 or 0
            end
        elseif data.slotId then
            local itemLink = GetInventoryItemLink(unit, data.slotId)
            if (itemLink) then
                if itemLink ~= d.itemLink then
                    local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemLink)
                    d.name = name
                    d.icon = icon
                    -- item info can be uncached on first lookup; keep retrying until it returns a name
                    d.itemLink = name and itemLink
                end
                start, duration, enabled = GetInventoryItemCooldown(unit, data.slotId)
            else
                d.name = nil
                d.icon = nil
                d.itemLink = nil
                enabled = 0
            end
        end

        duration = duration or 0
        start = start or 0

        d.start = start
        d.duration = duration
        d.expirationTime = start + duration
        d.durationObject = durationObject
        d.enabled = (enabled ~= 0)
        d.casted = (not data.spellId) and true or self.casted[data.spellId]
        d.isKnown = (not data.spellId) and true or IsSpellKnown(data.spellId)

        return d
    end

    function cooldown_proto:UpdateCooldowns(event, unit, spellID, baseSpellID)
        if not spellID then
            table.wipe(self.active)
        end

        for _, row in next, self.spells do
            -- no event fires when a cooldown ends, so shown rows are re-checked on every event;
            -- slots and items are always re-checked because their events carry the item's spell ID
            if not spellID or not row.spellId or self.active[row]
                or row.spellId == spellID or row.spellId == baseSpellID then
                local data = self:ProcessCooldownData(unit, row)

                if self:FilterCooldown(data) then
                    self.active[row] = data
                    -- a secret cooldown already shown counts as cast, in case the cast event's spellID was secret
                    if data.durationObject then
                        self.casted[data.spellId] = true
                    end
                else
                    self.active[row] = nil
                    if data.spellId then
                        self.casted[data.spellId] = nil
                    end
                end
            end
        end

        -- instead of removing auras one by one, just wipe the tables entirely
        -- and repopulate them, multiple table.remove calls are insanely slow
        self.sorted = table.wipe(self.sorted or {})
        self.shownSpells = table.wipe(self.shownSpells or {})

        for _, data in next, self.active do
            local id = data.activeSpellId
            if not id or not self.shownSpells[id] then
                if id then self.shownSpells[id] = true end
                table.insert(self.sorted, data)
            end
        end

        self:Render(unit, self.sorted, self.SortCooldowns)
    end

    function cooldown_proto:ForceUpdate()
        self:UpdateCooldowns("ForceUpdate", self.unit, nil)
    end

    -- spellID is nil when every cooldown should be updated
    function cooldown_proto:SPELL_UPDATE_COOLDOWN(spellID, baseSpellID)
        self:UpdateCooldowns("SPELL_UPDATE_COOLDOWN", self.unit, spellID, baseSpellID)
    end

    -- register which spell the player cast
    function cooldown_proto:UNIT_SPELLCAST_SUCCEEDED(unit, guid, spellId)
        if IsSecret(spellId) then return end
        self.casted[spellId] = true
    end

    function cooldown_proto:Enable(data)
        -- overrider element functions with configurations
        self.SortCooldowns = data.SortCooldowns or self.SortCooldowns
        self.FilterCooldown = data.FilterCooldown or self.FilterCooldown

        self.casted = {}
        self.active = {}
        self.rows = {}

        self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", self.unit)
    end
end

ns.elements.Cooldowns = cooldown_proto
