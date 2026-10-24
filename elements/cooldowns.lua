local _, ns = ...
local Filger = ns.Filger

-- Blizzard
local IsSpellKnown = C_SpellBook.IsSpellKnown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = C_Item.GetItemInfo
local GetItemCooldown = C_Container.GetItemCooldown
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local GetOverrideSpell = C_Spell and C_Spell.GetOverrideSpell
local C_Secrets = _G.C_Secrets
local issecretvalue = _G.issecretvalue

--------------------------------------------------
-- COOLDOWNS
--------------------------------------------------
local cooldown_proto = {
    casted = {},
    spells = {},
    createdButtons = 0,
    anchoredButtons = 0,
    visibleButtons = 0
}

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

        local button = self[index]
        if not button then
            button = Filger:CreateButton(self, index)

            table.insert(self, button)

            self.createdButtons = self.createdButtons + 1
        end

        button:SetSecret(data.durationObject ~= nil)

        -- tooltips
        button.unit = unit
        button.spellId = data.spellId
        button.slotId = data.slotId
        button.itemId = data.itemId

        -- timers
        button.name = data.name
        -- button.spellId = data.spellId
        button.duration = data.duration or 0
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

    function cooldown_proto:ProcessCooldownData(unit, data)
        local index, name, icon, start, duration, enabled, durationObject

        if data.spellId then
            index = "SPELL_" .. data.spellId
            local info = Filger.GetSpellInfo(data.spellId)
            if info then
                name = info.name
                icon = info.iconID
            end
            local cdInfo = Filger.GetSpellCooldown(data.spellId)
            if cdInfo then
                if C_Secrets and C_Secrets.ShouldSpellCooldownBeSecret(data.spellId) then
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
            index = "SLOT_" .. data.slotId
            local itemLink = GetInventoryItemLink(unit, data.slotId)
            if (itemLink) then
                name, _, _, _, _, _, _, _, _, icon, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
                start, duration, enabled = GetInventoryItemCooldown(unit, data.slotId)
            else
                enabled = 0
            end
        elseif data.itemId then
            index = "ITEM_" .. data.itemId
            name, _, _, _, _, _, _, _, _, icon, _, _, _, _, _, _, _ = GetItemInfo(data.itemId)
            start, duration, enabled = GetItemCooldown(data.itemId)
        end

        duration = duration or 0
        start = start or 0

        return {
            index = index,
            name = name,
            spellId = data.spellId,
            -- a talent can replace one tracked spell with another (e.g. Sentinel overrides Avenging Wrath)
            activeSpellId = data.spellId and GetOverrideSpell and GetOverrideSpell(data.spellId) or data.spellId,
            slotId = data.slotId,
            itemId = data.itemId,
            icon = icon,
            start = start,
            duration = duration,
            expirationTime = start + duration,
            durationObject = durationObject,
            enabled = (enabled ~= 0),
            casted = (not data.spellId) and true or self.casted[data.spellId],
            isKnown = (not data.spellId) and true or IsSpellKnown(data.spellId)
        }
    end

    function cooldown_proto:UpdateCooldowns(event, unit, spellID, baseSpellID)
        local changed = true
        self.active = self.active or {}
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
                else
                    self.active[row] = nil
                    if data.spellId then
                        self.casted[data.spellId] = nil
                    end
                end
            end
        end

        if changed then
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

            table.sort(self.sorted, self.SortCooldowns)

            local numVisible = math.min(self.limit, #self.sorted)

            for i = 1, numVisible do
                self:Update(unit, self.sorted[i], i)
            end

            local visibleChanged = true

            if (numVisible ~= self.visibleButtons) then
                self.visibleButtons = numVisible
                visibleChanged = true
            end

            for i = numVisible + 1, #self do
                self[i]:Hide()
            end

            if (visibleChanged or self.createdButtons > self.anchoredButtons) then
                if visibleChanged then
                    self:SetPosition(1, numVisible)
                else
                    self:SetPosition(self.anchoredButtons + 1, self.createdButtons)
                    self.anchoredButtons = self.createdButtons
                end
            end
        end
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
        if issecretvalue and issecretvalue(spellId) then return end
        self.casted[spellId] = true
    end
end

ns.cooldown_proto = cooldown_proto
