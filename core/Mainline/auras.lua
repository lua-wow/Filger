local _, ns = ...
local Filger = ns.Filger

local LibDispel = LibStub("LibDispel")
assert(LibDispel, "Filger requires LibDispel")

local blacklist = ns.Filger.blacklist or {}

-- Blizzard
local UnitIsUnit = _G.UnitIsUnit
local C_Secrets = _G.C_Secrets

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

        -- UnitIsUnit/UnitIsOwnerOrControllerOfUnit on sourceUnit can be secret even out of combat
        -- (NPC sources, restricted maps), so rely on the aura's own flag
        data.isPlayerAura = data.isFromPlayerOrPlayerPet

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

        if Filger.isVanilla then
            data.auraIndex = self:GetAuraIndex(unit, data.auraInstanceID, self.filter)
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

            table.sort(self.sorted, self.SortAuras)

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
-- AURA CONTAINERS
--------------------------------------------------
-- Blizzard's secure container filters, sorts and displays auras that are secret to Filger.
local container_proto = {}

do
    local AnchorUtil = _G.AnchorUtil
    local AuraContainerSortMethod = _G.AuraContainerSortMethod
    local C_XMLUtil = _G.C_XMLUtil

    local TEMPLATE = "CustomAuraContainerTemplate"

    -- container buttons can only be styled here: once auras are secret, tainted code can't touch them
    local function CreateInitializer(element)
        local size = element.size
        local tooltip = Filger.config.general.gametooltip

        return function(button)
            button:SetSize(size, size)
            Filger:StyleButton(button)

            button:SetIcon(button.Icon)
            button:SetDurationCooldown(button.Cooldown)
            button:SetApplicationCount(button.Count)
            button:SetDurationText(button.Time, Filger.timeTextOptions)

            if tooltip then
                button:SetTooltipAnchorPoint("ANCHOR_RIGHT")
            else
                button:SetMouseMotionEnabled(false)
            end
        end
    end

    function container_proto:CreateContainer(data)
        if not C_XMLUtil.GetTemplateInfo(TEMPLATE) then
            Filger:warn(TEMPLATE .. " not found, " .. self:GetName() .. " is disabled.")
            return
        end

        local container = CreateFrame("AuraContainer", self:GetName() .. "Container", self, TEMPLATE)
        container:SetPoint(self.initialAnchor, self, self.initialAnchor)
        container:SetFlowLayoutAnchorPoint(self.initialAnchor)
        container:SetFlowLayoutGrowthDirection(
            (self["growth-x"] == "LEFT") and AnchorUtil.FlowDirection.Left or AnchorUtil.FlowDirection.Right,
            (self["growth-y"] == "DOWN") and AnchorUtil.FlowDirection.Down or AnchorUtil.FlowDirection.Up)
        container:SetUnit(self.unit)

        local initializeFrame = CreateInitializer(self)
        local layout = {
            elementSpacing = self.spacing,
            lineSpacing = self.spacing,
            elementWidth = self.size,
            elementHeight = self.size
        }

        for i, group in ipairs(data.groups) do
            local key = self:GetName() .. "Group" .. i
            container:AddAuraGroup(key, group.filter, {
                maxFrameCount = self.limit,
                candidateFilters = group.candidateFilters,
                sortMethod = AuraContainerSortMethod.ExpirationOnly,
                layout = layout,
                initializeFrame = initializeFrame
            })

            -- groups with `hostile` are only enabled while the unit's reaction matches
            if group.hostile ~= nil then
                self.reactionGroups = self.reactionGroups or {}
                self.reactionGroups[key] = group.hostile
            end
        end

        -- private auras (boss mechanics) never reach C_UnitAuras; Blizzard draws them into these anchors
        local growthx = (self["growth-x"] == "LEFT") and -1 or 1
        for i = 1, data.privateAuras or 0 do
            local anchor = CreateFrame("Frame", nil, self)
            anchor:SetSize(self.size, self.size)
            anchor:SetPoint(self.initialAnchor, self, self.initialAnchor, (self.limit + i - 1) * (self.size + self.spacing) * growthx, 0)
            C_UnitAuras.AddPrivateAuraAnchor({
                unitToken = self.unit,
                auraIndex = i,
                parent = anchor,
                showCooldownFrame = true,
                showCountdownNumbers = true,
                iconInfo = {
                    iconAnchor = { point = "CENTER", relativeTo = anchor, relativePoint = "CENTER", offsetX = 0, offsetY = 0 },
                    iconWidth = self.size,
                    iconHeight = self.size
                }
            })
        end

        self.container = container

        -- the container doesn't follow unit token changes by itself
        if (self.unit == "target") then
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
        elseif (self.unit == "focus") then
            self:RegisterEvent("PLAYER_FOCUS_CHANGED")
        end
    end

    function container_proto:ForceUpdate()
        local container = self.container
        if not container then return end

        if self.reactionGroups then
            local hostile = UnitCanAttack(self.unit, "player")
            for key, groupHostile in next, self.reactionGroups do
                container:SetAuraGroupEnabled(key, groupHostile == hostile)
            end
        end

        container:UpdateAllAuras()
    end

    function container_proto:PLAYER_TARGET_CHANGED()
        self:ForceUpdate()
    end

    function container_proto:PLAYER_FOCUS_CHANGED()
        self:ForceUpdate()
    end
end

ns.container_proto = container_proto

--------------------------------------------------
-- FRAMES
--------------------------------------------------
local class = Filger.class
local spells = Filger.spells or {}

local layout = Filger.config.layout
local size, spacing = layout.size, layout.spacing
local xOffset, yOffset = layout.xOffset, layout.yOffset

-- container candidate filters take { [spellId] = true }; name keys can't be matched
local function ToSpellIDs(list)
    local ids = {}
    for spellId, value in next, list do
        if type(spellId) == "number" and (value == true or (type(value) == "table" and value.enabled)) then
            ids[spellId] = true
        end
    end
    return ids
end

Mixin(Filger.config.frames, {
        -- LEFT
        ["PLAYER_DEBUFFS"] = {
            enabled = true,
            unit = "player",
            anchor = { "RIGHT", UIParent, "CENTER", -xOffset, yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMRIGHT",
            ["growth-x"] = "LEFT",
            ["growth-y"] = "DOWN",
            -- debuffs on the player can't be filtered by spell ID (Stagger is contextually secret);
            -- only the important ones, one group each
            groups = {
                { filter = "HARMFUL|RAID_PLAYER_DISPELLABLE" },
                { filter = "HARMFUL|CROWD_CONTROL" },
                {
                    filter = "HARMFUL",
                    candidateFilters = { isBossAura = true }
                }
            }
        },
        ["PLAYER_AURAS"] = {
            enabled = true,
            unit = "player",
            anchor = { "RIGHT", UIParent, "CENTER", -xOffset, 0 },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMRIGHT",
            ["growth-x"] = "LEFT",
            ["growth-y"] = "DOWN",
            groups = {
                {
                    filter = "HELPFUL|PLAYER",
                    candidateFilters = {
                        includeSpellIDs = ToSpellIDs(Mixin(spells[class] or {}, spells["ALL"] or {}))
                    }
                }
            }
        },
        ["PLAYER_BUFFS"] = {
            enabled = true,
            unit = "player",
            anchor = { "RIGHT", UIParent, "CENTER", -xOffset, -yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMRIGHT",
            ["growth-x"] = "LEFT",
            ["growth-y"] = "DOWN",
            groups = {
                {
                    filter = "HELPFUL|!PLAYER",
                    candidateFilters = {
                        excludeSpellIDs = ToSpellIDs(blacklist)
                    }
                }
            }
        },
        ["TARGET_DEBUFFS"] = {
            enabled = true,
            unit = "target",
            anchor = { "LEFT", UIParent, "CENTER", xOffset, yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            groups = {
                { filter = "HARMFUL|PLAYER", hostile = true },
                { filter = "HARMFUL|!PLAYER", hostile = false }
            }
        },
        ["TARGET_AURAS"] = {
            enabled = true,
            unit = "target",
            anchor = { "LEFT", UIParent, "CENTER", xOffset, 0 },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            groups = {
                {
                    filter = "HELPFUL",
                    hostile = false,
                    candidateFilters = {
                        excludeSpellIDs = ToSpellIDs(blacklist)
                    }
                },
                -- buffs on hostile units can't be filtered by spell ID; keep the groups to show
                { filter = "HELPFUL|IMPORTANT", hostile = true },
                { filter = "HELPFUL|DISPELLABLE", hostile = true },
                -- { filter = "HELPFUL", hostile = true, candidateFilters = { isStealable = true } },
                -- { filter = "HELPFUL", hostile = true },
            }
        },
        ["FOCUS_DEBUFFS"] = {
            enabled = true,
            unit = "focus",
            anchor = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            groups = {
                {
                    filter = "HARMFUL",
                    candidateFilters = { isBossAura = true }
                }
            }
        },
        ["BOSS_DEBUFFS"] = {
            enabled = true,
            unit = "player",
            anchor = { "CENTER", UIParent, "CENTER", 0, 160 },
            limit = 1,
            size = math.floor(1.5 * size),
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            groups = {
                {
                    filter = "HARMFUL",
                    candidateFilters = { isBossAura = true }
                }
            },
            privateAuras = 2
        },
})
