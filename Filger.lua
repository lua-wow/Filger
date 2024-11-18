local _, ns = ...
local Filger = ns.Filger

local LibDispel = LibStub("LibDispel")
assert(LibDispel, "Filger requires LibDispel")

local blacklist = ns.Filger.blacklist or {}
local cooldowns = ns.Filger.cooldowns or {}
local spells = ns.Filger.spells or {}

-- Blizzard
local CreateFrame = _G.CreateFrame
local UnitIsUnit = _G.UnitIsUnit
local UnitIsOwnerOrControllerOfUnit = _G.UnitIsOwnerOrControllerOfUnit
local IsSpellKnown = _G.IsSpellKnown
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo
local GetSpellName = C_Spell and C_Spell.GetSpellName or _G.GetSpellInfo
local GetSpellCooldown = _G.GetSpellCooldown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = _G.GetItemInfo
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown

--------------------------------------------------
-- Filger
--------------------------------------------------
local isInit = false

--------------------------------------------------
-- BUTTONS
--------------------------------------------------
do
    local button_proto = {}

    function button_proto:OnEnter()
        if (GameTooltip:IsForbidden() and not self:IsVisible()) then return end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        if self.auraIndex then
            -- classic aura tooltip
            GameTooltip:SetUnitAura(self.unit, self.auraIndex, self.isHarmful and "HARMFUL" or "HELPFUL")
        elseif self.auraInstanceID then
            -- retail aura tooltip
            if self.isHarmful then
                GameTooltip:SetUnitDebuffByAuraInstanceID(self.unit, self.auraInstanceID)
            else
                GameTooltip:SetUnitBuffByAuraInstanceID(self.unit, self.auraInstanceID)
            end
        elseif self.itemId then
            GameTooltip:SetItemByID(self.itemId)
        elseif self.slotId then
            GameTooltip:SetInventoryItem(self.slotId)
        elseif self.spellId then
            GameTooltip:SetSpellByID(self.spellId)
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

    --[[ Callback: button_proto:CreateButton(element, index)
	Creates an aura/cooldown button at a given position.

    * self     - the widget holding the aura buttons
    * index    - the position at which the aura button is to be created (number)

    ## Returns
	* button - the button used to represent the aura (Button)
    --]]
    function Filger:CreateButton(element, index)
        -- resources
        local font, fontSize, fontStyle = Filger.fonts.normal, 12, "OUTLINE"

        local button = Mixin(CreateFrame("Frame", element:GetName() .. "Aura" .. index, element), button_proto)
        button:SetWidth(element.size)
        button:SetHeight(element.size)
        button:CreateBackdrop()

        local cooldown = CreateFrame("Cooldown", "$parentCD", button, "CooldownFrameTemplate")
        cooldown:SetAllPoints()
        cooldown:SetReverse(true)
        cooldown:SetDrawEdge(false)
        cooldown:SetHideCountdownNumbers(true)
        -- cooldown.noOCC = true
        -- cooldown.noCooldownCount = true
        button.Cooldown = cooldown

        local icon = button:CreateTexture("$parentIcon", "ARTWORK")
        icon:SetAllPoints()
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        button.Icon = icon

        local overlay = CreateFrame("Frame", "$parentOverlay", button, nil)
        overlay:SetAllPoints(button)
        overlay:SetFrameLevel(cooldown:GetFrameLevel() + 1)
        button.Overlay = overlay

        local count = overlay:CreateFontString("$parentCount", "OVERLAY")
        count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
        count:SetFont(font, fontSize, fontStyle)
        count:SetJustifyH("RIGHT")
        count:SetTextColor(0.84, 0.75, 0.65)
        button.Count = count

        local time = overlay:CreateFontString("$parentTime", "OVERLAY")
        time:SetPoint("CENTER", button, "CENTER", 0, 0)
        time:SetFont(font, 20, fontStyle)
        time:SetJustifyH("CENTER")
        time:SetTextColor(0.84, 0.75, 0.65)
        button.Time = time

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
-- AURAS
--------------------------------------------------
local aura_proto = {
    createdButtons = 0,
    anchoredButtons = 0,
    visibleButtons = 0
}

do
    --[[ Callback: button:UpdateColor(button, unit, data)
    Called after the aura button has been updated.

    * self   - the widget holding the aura buttons
    * button - the updated aura button (Button)
    * unit   - the unit on which the aura is cast (string)
    * data   - the [UnitAuraInfo](https://wowpedia.fandom.com/wiki/Struct_UnitAuraInfo) object (table)
    * index  - the actual position of the aura button (number)
    ]]--
    function aura_proto:UpdateColor(button, unit, data)
        if button.Backdrop then
            if (data.isHarmful and UnitCanAssist("player", unit)) or (data.isHelpful and UnitCanAttack(unit, "player") and UnitCanAttack("player", unit)) then
                local color = Filger.colors[data.dispelName]
                button.Backdrop:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
            else
                local color = Filger.config.general.backdrop.color
                button.Backdrop:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
            end
        end

        if button.Icon and self.desaturated == true then
            button.Icon:SetDesaturated(data.isHarmful and not data.isPlayerAura and not UnitIsUnit(unit, "player"))
        end

        if button.Animation then
            if data.isDispelable or data.isStealable then
                button.Animation:Play()
                button.Animation.playing = true
            else
                button.Animation:Stop()
                button.Animation.playing = false
            end
        end
    end

    --[[ Callback: aura_proto:Update(unit, data, index)
    Update the aura button and its components.

    * self   - the widget holding the aura buttons
    * unit   - the unit on which the aura is cast (string)
    * data   - the [UnitAuraInfo](https://wowpedia.fandom.com/wiki/Struct_UnitAuraInfo) object (table)
    * index  - the actual position of the aura button (number)
    ]]--
    function aura_proto:Update(unit, data, index)
        if not data.name then return end

        local button = self[index]
        if not button then
            button = Filger:CreateButton(self, index)

            table.insert(self, button)

            self.createdButtons = self.createdButtons + 1
        end

        -- tooltips
        button.unit = unit
        button.filter = self.filter
        button.auraInstanceID = data.auraInstanceID
        button.auraIndex = data.auraIndex
        button.isHarmful = data.isHarmful

        -- timers
        button.name = data.name
        button.spellId = data.spellId
        button.duration = data.duration or 0
        button.expirationTime = data.expirationTime or GetTime()

        if button.Cooldown then
            if data.duration and data.duration > 0 then
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

        if button.Count then
            button.Count:SetText((data.applications and data.applications > 1) and data.applications or "")
        end

        if data.duration and data.duration > 0 then
            button:SetScript("OnUpdate", button.OnUpdate)
        end

        button:Show()

        self:UpdateColor(button, unit, data)
    end

    --[[ Override:  aura_proto.SortAuras(a, b)
    Defines a custom sorting algorithm for ordering the auras.

    Defaults to [AuraUtil.DefaultAuraCompare](https://github.com/Gethe/wow-ui-source/search?q=DefaultAuraCompare).

    Overridden by the more specific SortAuras overrides if they are defined.
    --]]
    aura_proto.SortAuras = function(a, b)
        if (a.priority ~= b.priority) then
            return a.priority > b.priority
        end

        if (a.expirationTime ~= b.expirationTime) then
            return a.expirationTime < b.expirationTime
        end

        -- if (a.canApplyAura ~= b.canApplyAura) then
        --     return a.canApplyAura
        -- end
    
        return a.auraInstanceID < b.auraInstanceID
    end

    --[[ Override: aura_proto:FilterAura(unit, data)
    Defines a custom filter that controls if the aura button should be shown.

    * self - the widget holding the aura buttons
    * unit - the unit for which the update has been triggered (string)
    * data - [UnitAuraInfo](https://wowpedia.fandom.com/wiki/Struct_UnitAuraInfo) object (table)

    ## Returns

    * show - indicates whether the aura button should be shown (boolean)
    --]]
    function aura_proto:FilterAura(unit, data)
        return data.enabled and data.applications >= data.stackThreshold
    end

    function aura_proto:GetAuraIndex(unit, auraInstanceID, filter)
        local index = 1
        repeat
            local data = C_UnitAuras.GetAuraDataByIndex(unit, index, filter)
            if not data then
                return nil
            elseif data.auraInstanceID == auraInstanceID then
                return index
            end
            index = index + 1
        until (not data)
        return nil
    end

    --[[ Override: aura_proto:ProcessData(unit, data)
    Add some custom value sto the UnitAuraInfo.

    * self - the widget holding the aura buttons
    * unit - the unit for which the update has been triggered (string)
    * data - [UnitAuraInfo](https://wowpedia.fandom.com/wiki/Struct_UnitAuraInfo) object (table)

    ## Returns

    * data - a custom 'UnitAuraInfo' object (table)
    --]]
    function aura_proto:ProcessData(unit, data)
        if not data then return end

        data.isPlayerAura = data.sourceUnit and (UnitIsUnit("player", data.sourceUnit) or UnitIsOwnerOrControllerOfUnit("player", data.sourceUnit))

        data.dispelName = LibDispel:GetDispelType(data.spellId, data.dispelName)
        data.isDispelable = LibDispel:IsDispelable(unit, data.spellId, data.dispelName, data.isHarmful)

        local spell = self.spells[data.spellId]
        if spell then
            data.enabled = spell.enabled or false
            data.priority = spell.priority or 0
            data.stackThreshold = spell.stackThreshold or 0
        else
            data.enabled = true
            data.priority = 0
            data.stackThreshold = 0
        end

        if blacklist[data.spellId] or blacklist[data.name] then
            data.enabled = false
        end

        if Filger.isClassic then
            data.auraIndex = self:GetAuraIndex(unit, data.auraInstanceID, self.filter)
        end

        return data
    end

    function aura_proto:UpdateAuras(event, unit, updateInfo)
        if (self.unit ~= unit) then return end

	    local isFullUpdate = not updateInfo or updateInfo.isFullUpdate

        local changed = false

        if isFullUpdate then
            self.all = table.wipe(self.all or {})
            self.actives = table.wipe(self.actives or {})
            changed = true

            local slots = { C_UnitAuras.GetAuraSlots(unit, self.filter) }
            for i = 2, #slots do -- #1 return is continuationToken, we don't care about it
                local data = self:ProcessData(unit, C_UnitAuras.GetAuraDataBySlot(unit, slots[i]))
                self.all[data.auraInstanceID] = data

                if self:FilterAura(unit, data) then
                    self.actives[data.auraInstanceID] = true
                end
            end
        else
            if updateInfo.addedAuras then
                for _, data in next, updateInfo.addedAuras do
                    if not C_UnitAuras.IsAuraFilteredOutByInstanceID(unit, data.auraInstanceID, self.filter) then
                        self.all[data.auraInstanceID] = self:ProcessData(unit, data)
                        if self:FilterAura(unit, data) then
                            self.actives[data.auraInstanceID] = true
                            changed = true
                        end
                    end
                end
            end

            if updateInfo.updatedAuraInstanceIDs then
                for _, auraInstanceID in next, updateInfo.updatedAuraInstanceIDs do
                    local data = self.all[auraInstanceID]
                    if data then
                        self.all[auraInstanceID] = self:ProcessData(unit, C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID))
                        if self:FilterAura(unit, data) then
                            self.actives[auraInstanceID] = true
                            changed = true
                        end
                    end
                end
            end

            if updateInfo.removedAuraInstanceIDs then
                for _, auraInstanceID in next, updateInfo.removedAuraInstanceIDs do
                    if self.all[auraInstanceID] then
                        self.all[auraInstanceID] = nil
                    end

                    if self.actives[auraInstanceID] then
                        self.actives[auraInstanceID] = nil
                        changed = true
                    end
                end
            end
        end

        if changed then
            -- instead of removing auras one by one, just wipe the tables entirely
            -- and repopulate them, multiple table.remove calls are insanely slow
            self.sorted = table.wipe(self.sorted or {})

            for auraInstanceID, _ in next, self.actives do
                table.insert(self.sorted, self.all[auraInstanceID])
            end

            table.sort(self.sorted, self.SortAuras)

            numVisible = math.min(self.limit, #self.sorted)

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

    function aura_proto:ForceUpdate()
        self:UpdateAuras("ForceUpdate", self.unit, nil)
    end

    function aura_proto:UNIT_AURA(unit, updateInfo)
        self:UpdateAuras("UNIT_AURA", unit, updateInfo)
    end

    function aura_proto:PLAYER_TARGET_CHANGED(...)
        self:ForceUpdate()
    end

    function aura_proto:PLAYER_FOCUS_CHANGED(...)
        self:ForceUpdate()
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
            if data.duration and data.duration > 0 then
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
        local index, name, icon, start, duration, enabled

        if data.spellId then
            index = "SPELL_" .. data.spellId
            local info = Filger.GetSpellInfo(data.spellId)
            if info then
                name = info.name
                icon = info.iconID
            end
            local cdInfo = Filger.GetSpellCooldown(data.spellId)
            if cdInfo then
                start = cdInfo.startTime
                duration = cdInfo.duration
                enabled = cdInfo.enabled
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
            name, _, _, _, _, itemType, _, _, _, icon, _, _, _, _, _, _, _ = GetItemInfo(data.itemId)
            start, duration, enabled = GetItemCooldown(data.itemId)
        end

        duration = duration or 0
        start = start or 0

        return {
            index = index,
            name = name,
            spellId = data.spellId,
            slotId = data.slotId,
            itemId = data.itemId,
            icon = icon,
            start = start,
            duration = duration,
            expirationTime = start + duration,
            enabled = (enabled ~= 0),
            casted = (not data.spellId) and true or self.casted[data.spellId],
            isKnown = (not data.spellId) and true or IsSpellKnown(data.spellId)
        }
    end

    function cooldown_proto:UpdateCooldowns(event, unit)
        local changed = true
        self.all = table.wipe(self.all or {})
        self.active = table.wipe(self.active or {})

        for _, row in next, self.spells do
            local data = self:ProcessCooldownData(unit, row)
            self.all[data.index] = data

            if self:FilterCooldown(data) then
                self.active[data.index] = true
            elseif data.spellId then
                self.casted[data.spellId] = nil
            end
        end

        if changed then
            -- instead of removing auras one by one, just wipe the tables entirely
            -- and repopulate them, multiple table.remove calls are insanely slow
            self.sorted = table.wipe(self.sorted or {})

            for index, _ in next, self.active do
                table.insert(self.sorted, self.all[index])
            end

            table.sort(self.sorted, self.SortCooldowns)

            numVisible = math.min(self.limit, #self.sorted)

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

    function cooldown_proto:SPELL_UPDATE_COOLDOWN()
        self:UpdateCooldowns("SPELL_UPDATE_COOLDOWN", self.unit)
    end

    -- register which spell the player cast
    function cooldown_proto:UNIT_SPELLCAST_SUCCEEDED(unit, guid, spellId)
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

    function Filger:Spawn(data)
        local index = #self
        local unit = data.unit:gsub("^%l", string.upper):gsub("t(arget)", "T%1")
        local element = Mixin(CreateFrame("Frame", self:GetName() .. unit .. index, self), element_proto)

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
        else
            element = Mixin(element, aura_proto)

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
        for _, data in pairs(self.config.frames) do
            if (data.enabled) then
                local element = self:Spawn(data)
                element:ForceUpdate()
                table.insert(self, element)
            end
        end

        isInit = true
    end
end
