local _, ns = ...
local Filger = ns.Filger

local LibDispel = LibStub("LibDispel")
assert(LibDispel, "Filger requires LibDispel")

local blacklist = ns.Filger.blacklist or {}

-- Blizzard
local UnitIsUnit = _G.UnitIsUnit
local UnitIsOwnerOrControllerOfUnit = _G.UnitIsOwnerOrControllerOfUnit
local C_Secrets = _G.C_Secrets

--------------------------------------------------
-- AURAS
--------------------------------------------------
local aura_proto = {}

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
                Filger:SetBorderColor(button.Backdrop, Filger.colors[data.dispelName])
            else
                Filger:SetBorderColor(button.Backdrop, Filger.config.general.backdrop.color)
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

        local button = self:AcquireButton(index)

        -- tooltips
        button.unit = unit
        button.filter = self.filter
        button.auraInstanceID = data.auraInstanceID
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

        if self.restricted then
            -- unit comparisons may be secret while restricted
            data.isPlayerAura = data.isFromPlayerOrPlayerPet
        else
            data.isPlayerAura = data.sourceUnit and (UnitIsUnit("player", data.sourceUnit) or UnitIsOwnerOrControllerOfUnit("player", data.sourceUnit))
        end

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

        return data
    end

    -- Retail: while auras are secret, tainted code can't list them; only spells whose aura
    -- isn't secret can be looked up one by one, so only listed spells are shown.
    function aura_proto:ScanSpellAuras(unit)
        local isHarmful = self.filter:find("HARMFUL") ~= nil
        local isPlayer = self.filter:find("PLAYER") ~= nil

        for spellId in next, self.spells do
            if not C_Secrets.ShouldSpellAuraBeSecret(spellId) then
                local data = C_UnitAuras.GetUnitAuraBySpellID(unit, spellId)
                if data and data.isHarmful == isHarmful and (not isPlayer or data.isFromPlayerOrPlayerPet) then
                    data = self:ProcessData(unit, data)
                    self.all[data.auraInstanceID] = data

                    if self:FilterAura(unit, data) then
                        self.actives[data.auraInstanceID] = true
                    end
                end
            end
        end
    end

    function aura_proto:UpdateAuras(event, unit, updateInfo)
        if (self.unit ~= unit) then return end

        local isRestricted = C_Secrets and C_Secrets.ShouldAurasBeSecret()
        -- updateInfo is secret while restricted; cached auras are stale right after it
	    local isFullUpdate = isRestricted or self.restricted or not updateInfo or updateInfo.isFullUpdate
        self.restricted = isRestricted

        local changed = false

        if isFullUpdate then
            self.all = table.wipe(self.all or {})
            self.actives = table.wipe(self.actives or {})
            changed = true

            if isRestricted then
                self:ScanSpellAuras(unit)
            else
                local slots = { C_UnitAuras.GetAuraSlots(unit, self.filter) }
                for i = 2, #slots do -- #1 return is continuationToken, we don't care about it
                    local data = self:ProcessData(unit, C_UnitAuras.GetAuraDataBySlot(unit, slots[i]))
                    self.all[data.auraInstanceID] = data

                    if self:FilterAura(unit, data) then
                        self.actives[data.auraInstanceID] = true
                    end
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

            self:Render(unit, self.sorted, self.SortAuras)
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

ns.aura_proto = aura_proto

--------------------------------------------------
-- FRAMES
--------------------------------------------------
local class = Filger.class
local spells = Filger.spells or {}
local all = Filger.all or {}

-- adds what each frame shows to its layout in config.lua
for key, data in next, {
    -- LEFT
    ["PLAYER_DEBUFFS"] = {
        type = "auras",
        filter = "HARMFUL",
        spells = {
            [124275] = { enabled = true, priority = 3 },    -- Light Stagger
            [124274] = { enabled = true, priority = 3 },    -- Moderate Stagger
            [124273] = { enabled = true, priority = 3 }     -- Heavy Stagger
        }
    },
    ["PLAYER_AURAS"] = {
        type = "auras",
        filter = "PLAYER|HELPFUL",
        spells = Mixin(spells[class] or {}, spells["ALL"] or {})
    },
    ["PLAYER_BUFFS"] = {
        type = "auras",
        filter = "HELPFUL",
        caster = "all",
        hidePlayer = true,
        FilterAura = function(element, unit, data)
            return data.enabled and not data.isPlayerAura
        end
    },
    -- RIGHT
    ["TARGET_DEBUFFS"] = {
        type = "auras",
        filter = "HARMFUL",
        spells = all,
        FilterAura = function(element, unit, data)
            if UnitCanAttack(unit, "player") then
                return data.enabled and data.isPlayerAura
            end
            return data.enabled and not data.isPlayerAura
        end,
        SortAuras = function(a, b)
            if (a.priority ~= b.priority) then
                return a.priority < b.priority
            end

            if (a.expirationTime ~= b.expirationTime) then
                return a.expirationTime < b.expirationTime
            end

            if (a.isPlayerAura ~= b.isPlayerAura) then
                return a.isPlayerAura
            end

            return a.auraInstanceID < b.auraInstanceID
        end
    },
    ["TARGET_AURAS"] = {
        type = "auras",
        filter = "HELPFUL",
        spells = all
    },
    ["FOCUS_DEBUFFS"] = {
        type = "auras",
        filter = "HARMFUL",
        desaturated = false,
        FilterAura = function(element, unit, data)
            return data.enabled and data.isBossAura or (data.sourceUnit == nil) or not data.isFromPlayerOrPlayerPet
        end
    },
    -- CENTER
    ["BOSS_DEBUFFS"] = {
        enabled = false,
        type = "auras",
        filter = "HARMFUL",
        FilterAura = function(element, unit, data)
            return data.enabled and data.isBossAura or (data.sourceUnit == nil)
        end
    },
} do
    Mixin(Filger.config.frames[key], data)
end
