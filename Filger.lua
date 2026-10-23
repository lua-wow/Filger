local _, ns = ...
local Filger = ns.Filger

-- Blizzard
local CreateFrame = _G.CreateFrame
local IsSpellKnown = C_SpellBook.IsSpellKnown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = C_Item.GetItemInfo
local GetItemCooldown = C_Container.GetItemCooldown
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local GetOverrideSpell = C_Spell and C_Spell.GetOverrideSpell
local C_Secrets = _G.C_Secrets
local issecretvalue = _G.issecretvalue
local C_StringUtil = _G.C_StringUtil
local C_CurveUtil = _G.C_CurveUtil
local C_DurationUtil = _G.C_DurationUtil
local Enum = _G.Enum

--------------------------------------------------
-- Filger
--------------------------------------------------
local isInit = false

--------------------------------------------------
-- BUTTONS
--------------------------------------------------
do
    local button_proto = {}

    -- secret durations: text and color like OnUpdate ("2m", "45s", "4.3"; red under 5s)
    local timeFormatter = C_StringUtil.CreateSecondsFormatter()
    timeFormatter:SetDefaultAbbreviation(Enum.SecondsFormatterAbbreviation.OneLetter)
    timeFormatter:SetStripIntervalWhitespace(Enum.SecondsFormatterIntervalWhitespace.StripIgnoreLocale)
    timeFormatter:SetDesiredUnitCount(1)
    timeFormatter:SetCanRoundUpLastUnit(true)
    timeFormatter:SetMillisecondsThreshold(5)

    local timeColorCurve = C_CurveUtil.CreateColorCurve()
    timeColorCurve:SetType(Enum.LuaCurveType.Step)
    timeColorCurve:AddPoint(0, CreateColor(0.99, 0.31, 0.31))
    timeColorCurve:AddPoint(5, CreateColor(0.84, 0.75, 0.65))

    -- aura container duration text (Mainline); Classic bindings have no SetTextColorCurve
    if Filger.isMainline then
        Filger.timeTextOptions = {
            textFormatter = timeFormatter,
            textColor = { curve = timeColorCurve, property = Enum.DurationTextBindingProperty.RemainingDuration }
        }
    end

    function button_proto:OnEnter()
        if (GameTooltip:IsForbidden() and not self:IsVisible()) then return end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        if self.auraInstanceID and GameTooltip.SetUnitDebuffByAuraInstanceID then
            if self.isHarmful then
                GameTooltip:SetUnitDebuffByAuraInstanceID(self.unit, self.auraInstanceID)
            else
                GameTooltip:SetUnitBuffByAuraInstanceID(self.unit, self.auraInstanceID)
            end
        elseif self.itemId then
            GameTooltip:SetItemByID(self.itemId)
        elseif self.slotId then
            GameTooltip:SetInventoryItem(self.unit, self.slotId)
        elseif self.spellId then
            GameTooltip:SetSpellByID(self.spellId)
        end
    end

    -- secret durations can't drive the OnUpdate timer text, the duration text binding is used instead
    function button_proto:SetSecret(isSecret)
        if self.isSecret == isSecret then return end
        self.isSecret = isSecret
        if self.TimeBinding then
            self.TimeBinding:SetEnabled(isSecret)
        end
        self.Time:SetText("")
        if isSecret then
            self:SetScript("OnUpdate", nil)
        end
    end

    function button_proto:OnLeave()
        if GameTooltip:IsForbidden() then return end
        GameTooltip:Hide()
    end

    function button_proto:OnUpdate(elapsed)
        self.elapsed = (self.elapsed or 0) + elapsed
        if self.elapsed >= 0.1 then
            local remaining = (self.expirationTime or 0) - GetTime()
            if self.Time then
                if remaining > 0 then
                    self.Time:SetText(Filger.FormatTime(remaining))
                    if remaining <= 5 then
                        self.Time:SetTextColor(0.99, 0.31, 0.31)
                    else
                        self.Time:SetTextColor(0.84, 0.75, 0.65)
                    end
                else
                    self.Time:SetText("")
                    self:SetScript("OnUpdate", nil)
                    self:Hide()
                end
            end
            self.elapsed = 0
        end
    end

    --[[ Filger:StyleButton(button)
    Creates the button's visual regions (backdrop, cooldown, icon, count, time text).
    Shared by Filger buttons and aura container buttons.
    --]]
    function Filger:StyleButton(button)
        -- resources
        local font, fontSize, fontStyle = Filger.fonts.normal, 12, "OUTLINE"
        -- aura container buttons are unnamed; "$parent" would create globals like "Icon"
        local name = button:GetName()

        button:CreateBackdrop()
        -- ElvUI stores its backdrop as `backdrop`
        button.Backdrop = button.Backdrop or button.backdrop

        local cooldown = CreateFrame("Cooldown", name and name .. "CD", button, "CooldownFrameTemplate")
        cooldown:SetAllPoints()
        cooldown:SetReverse(true)
        cooldown:SetDrawEdge(false)
        cooldown:SetHideCountdownNumbers(true)
        -- cooldown.noOCC = true
        -- cooldown.noCooldownCount = true
        button.Cooldown = cooldown

        local icon = button:CreateTexture(name and name .. "Icon", "ARTWORK")
        icon:SetAllPoints()
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        button.Icon = icon

        local overlay = CreateFrame("Frame", name and name .. "Overlay", button, nil)
        overlay:SetAllPoints(button)
        overlay:SetFrameLevel(cooldown:GetFrameLevel() + 1)
        button.Overlay = overlay

        local count = overlay:CreateFontString(name and name .. "OverlayCount", "OVERLAY")
        count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
        count:SetFont(font, fontSize, fontStyle)
        count:SetJustifyH("RIGHT")
        count:SetTextColor(0.84, 0.75, 0.65)
        button.Count = count

        local time = overlay:CreateFontString(name and name .. "OverlayTime", "OVERLAY")
        time:SetPoint("CENTER", button, "CENTER", 0, 0)
        time:SetFont(font, 20, fontStyle)
        time:SetJustifyH("CENTER")
        time:SetTextColor(0.84, 0.75, 0.65)
        button.Time = time
    end

    --[[ Callback: button_proto:CreateButton(element, index)
	Creates an aura/cooldown button at a given position.

    * self     - the widget holding the aura buttons
    * index    - the position at which the aura button is to be created (number)

    ## Returns
	* button - the button used to represent the aura (Button)
    --]]
    function Filger:CreateButton(element, index)
        local button = Mixin(CreateFrame("Frame", element:GetName() .. "Aura" .. index, element), button_proto)
        button:SetWidth(element.size)
        button:SetHeight(element.size)
        self:StyleButton(button)

        local time = button.Time

        -- only secret cooldowns (Mainline) need it; Classic bindings have no SetTextColorCurve
        if Filger.isMainline then
            local timeBinding = C_DurationUtil.CreateDurationTextBinding()
            timeBinding:SetFontString(time)
            timeBinding:SetFormatter(timeFormatter)
            timeBinding:SetTextColorCurve(timeColorCurve, Enum.DurationTextBindingProperty.RemainingDuration)
            timeBinding:SetExpiredText("")
            timeBinding:SetZeroDurationText("")
            timeBinding:SetEnabled(false)
            button.TimeBinding = timeBinding
        end

        local animation = button:CreateAnimationGroup()
        animation:SetLooping("BOUNCE")
        button.Animation = animation

        local fadeout = animation:CreateAnimation("Alpha")
        fadeout:SetFromAlpha(1)
        fadeout:SetToAlpha(0.10)
        fadeout:SetDuration(0.50)
        fadeout:SetSmoothing("IN_OUT")
        animation.Fadeout = fadeout

        if self.config.general.gametooltip then
            button:SetScript("OnEnter", button.OnEnter)
            button:SetScript("OnLeave", button.OnLeave)
        end

        return button
    end
end

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

--------------------------------------------------
-- FILGER
--------------------------------------------------

do
    local element_proto = {}

    function element_proto:SetPosition(from, to)
        local element = self
        local sizex = element.size + element.spacing
        local sizey = element.size + element.spacing
        local anchor = element.initialAnchor or "BOTTOMLEFT"
        local growthx = (element["growth-x"] == "LEFT" and -1) or 1
        local growthy = (element["growth-y"] == "DOWN" and -1) or 1
        local cols = math.floor(element:GetWidth() / sizex + 0.5)
    
        for i = from, to do
            local button = element[i]
            if (not button) then break end

            if anchor == "CENTER" then
                -- Centralized positioning logic
                local index = i - from
                local col, row
                if index % 2 == 0 then
                    col = math.floor(index / 2)
                else
                    col = -math.floor(index / 2) - 1
                end
                row = math.floor(index / cols)
                
                button:ClearAllPoints()
                button:SetPoint(anchor, element, anchor, col * sizex, row * sizey)
            else
                local col = (i - 1) % cols
                local row = math.floor((i - 1) / cols)
        
                button:ClearAllPoints()
                button:SetPoint(anchor, element, anchor, col * sizex * growthx, row * sizey * growthy)
            end
        end
    end

    function Filger:Spawn(key, data)
        -- "PLAYER_AURAS" -> "FilgerPlayerAuras"
        local name = key:lower():gsub("^%l", string.upper):gsub("_(%l)", string.upper)
        local element = Mixin(CreateFrame("Frame", self:GetName() .. name, self), element_proto)

        -- configuration
        element.unit = data.unit or "player"
        element.filter = data.filter or "HELPFUL"
        element.caster = data.caster or nil

        element.limit = data.limit or 32
        element.size = data.size or 32
        element.spacing = data.spacing or 5
        element.initialAnchor = data.initialAnchor or "BOTTOMLEFT"
        element["growth-x"] = data["growth-x"] or "LEFT"
        element["growth-y"] = data["growth-y"] or "DOWN"

        element:SetPoint(unpack(data.anchor))
        element:SetWidth((element.limit * element.size) + (element.limit - 1) * element.spacing)
        element:SetHeight(element.size)
        -- element:CreateBackdrop()
    
        -- local text = element:CreateFontString(nil, "OVERLAY")
        -- text:SetPoint("CENTER", element, "CENTER", 0, 1)
        -- text:SetFont(Font, FontSize, FontStyle)
        -- text:SetText(element:GetName())
        -- text:SetJustifyH("CENTER")
        -- text:Hide()
        -- element.text = text
    
        if (element.filter == "COOLDOWN") then
            element = Mixin(element, cooldown_proto)
            
            -- overrider element functions with configurations
            element.SortCooldowns = data.SortCooldowns or element.SortCooldowns
            element.FilterCooldown = data.FilterCooldown or element.FilterCooldown

            element:RegisterEvent("SPELL_UPDATE_COOLDOWN")
            element:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", self.unit)
        elseif data.groups then
            -- Mainline only: Blizzard's secure aura container filters and displays the auras
            element = Mixin(element, ns.container_proto)
            element:CreateContainer(data)
        else
            element = Mixin(element, ns.aura_proto)

            -- overrider element functions with configurations
            element.SortAuras = data.SortAuras or element.SortAuras
            element.FilterAura = data.FilterAura or element.FilterAura

            element:RegisterEvent("UNIT_AURA")

            if (element.unit == "target") then
                element:RegisterEvent("PLAYER_TARGET_CHANGED")
            end

            if (element.unit == "focus") then
                element:RegisterEvent("PLAYER_FOCUS_CHANGED")
            end
        end

        element.spells = data.spells or element.spells or {}
    
        element:SetScript("OnEvent", function(self, event, ...)
            -- call event handler
            self[event](self, ...)
        end)
    
        return element
    end
end

Filger:RegisterEvent("ADDON_LOADED")
Filger:RegisterEvent("PLAYER_LOGIN")
Filger:SetScript("OnEvent", function(self, event, ...)
    if self[event] then
        -- call event handler
        self[event](self, ...)
    end
end)

function Filger:ADDON_LOADED(addon)
    if (addon ~= "Filger") then return end
    self.unit = "player"
    self.guid = UnitGUID(self.unit)

    -- Filger standalone
    if self.MergeAPI then
        self:MergeAPI()
    end
end

function Filger:PLAYER_LOGIN()
    if not isInit then
        -- self:RegisterEvent("PLAYER_ENTERING_WORLD")

        -- create panels based on spell list
        for key, data in pairs(self.config.frames) do
            if (data.enabled) then
                local element = self:Spawn(key, data)
                element:ForceUpdate()
                table.insert(self, element)
            end
        end

        isInit = true
    end
end
