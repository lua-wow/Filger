local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList
local Instances = ns.Instances

local LCD = Filger.LCD

local VISIBLE = 1
local HIDDEN = 0

local UnitAura = UnitAura
local UnitIsEnemy = UnitIsEnemy
local IsSpellKnown = IsSpellKnown

----------------------------------------------------------------
-- Filger
----------------------------------------------------------------
-- player info
local class = select(2, UnitClass("player"))
local color = RAID_CLASS_COLORS[class]

local debuffTypes = {
    ["Curse"]   = { 0.60, 0.00, 1.00 },
    ["Disease"] = { 0.60, 0.40, 0.00 },
    ["Magic"]   = { 0.20, 0.60, 1.00 },
    ["Poison"]  = { 0.00, 0.60, 0.00 },
    ["Unknown"]  = { 0.80, 0.00, 0.00 }
}

-- import
local tinsert, tremove, tsort, wipe = table.insert, table.remove, table.sort, table.wipe
local FormatTime =  Filger.FormatTime

-- resources
local BlankTex = Config["Medias"].Blank
local Font, FontSize, FontStyle = Config["Medias"].PixelFont, 12, "MONOCHROMEOUTLINE"
local BorderColor = Config["General"].BorderColor

-- Tooltips
local function onEnter(self)
	if (not self:IsVisible()) then return end
    
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddDoubleLine(self.name, self.spellID)
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local function onLeave()
	GameTooltip:Hide()
end

-- Aura Timer
local function UpdateAuraTimer(self, elapsed)
    local parent = self:GetParent()
    self.elapsed = (self.elapsed or 0) + elapsed

    if (self.elapsed >= 0.1) then
        if (not self.first) then
            self.timeleft = self.timerleft - self.elapsed
        else
            self.timeleft = (self.expiration) - GetTime()
        end

        if (self.timeleft > 0) then
            if (self.time) then self.time:SetText(FormatTime(self.timeleft)) end
            if (self.statusbar) then self.statusbar:SetValue(self.timeleft) end

            if (self.timeleft <= 5) then
                self.time:SetTextColor(.99, .31, .31)
            else
                self.time:SetTextColor(0.84, 0.75, 0.65)
            end

        else
            self.time:SetText("")
            self.start = 0
            self.duration = 0
            self.expiration = 0
            -- tremove(parent.actives, self.index)
            self:SetScript("OnUpdate", nil)
            -- Filger.DisplayActives(parent)
        end

        self.elapsed = 0
    end
end

function Filger:SetPosition(element, aura, index)
    if (index == 1) then
        aura:SetPoint(unpack(element.anchor))
    else
        local previous = element[index - 1]
        if (element.direction == "UP") then
            aura:SetPoint("BOTTOM", previous, "TOP", 0, element.spacing)
        elseif (element.direction == "RIGHT") then
            aura:SetPoint("LEFT", previous, "RIGHT", element.spacing, 0)
        elseif (element.direction == "LEFT") then
            aura:SetPoint("RIGHT", previous, "LEFT", -element.spacing, 0)
        elseif (element.direction == "DOWN") then
            aura:SetPoint("TOP", previous, "BOTTOM", 0, -element.spacing)
        end
    end
end

-- Create Aura Icon
function Filger:CreateAura(element, index)

    local aura = CreateFrame("Frame", element:GetName() .. "Aura" .. index, element)
    aura:SetWidth(element.size)
    aura:SetHeight(element.size)
    aura:CreateBackdrop()
    aura:SetTemplate(nil, nil, "Triple")
    Filger:SetPosition(element, aura, index)
    
    aura.icon = aura:CreateTexture("$parentIcon", "ARTWORK")
    -- aura.icon:SetAllPoints()
    aura.icon:SetPoint("TOPLEFT", aura, "TOPLEFT", 2, -2)
    aura.icon:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", -2, 2)
    aura.icon:SetTexCoord(unpack(Filger.IconCoord))

    aura.cooldown = CreateFrame("Cooldown", "$parentCD", aura, "CooldownFrameTemplate")
    aura.cooldown:SetAllPoints(aura.icon)
    aura.cooldown:SetReverse(true)
    aura.cooldown:SetDrawEdge(false)
    aura.cooldown.noOCC = true
    aura.cooldown.noCooldownCount = true
    aura.cooldown:SetHideCountdownNumbers(true)

    -- time left
    aura.time = aura:CreateFontString("$parentTime", "OVERLAY")
    aura.time:SetPoint("CENTER", aura, "CENTER", 2, 2)
    aura.time:SetFont(Font, 24, FontStyle)
    aura.time:SetJustifyH("CENTER")
    aura.time:SetTextColor(0.84, 0.75, 0.65)

    -- count
    aura.count = aura:CreateFontString("$parentCount", "OVERLAY")
    aura.count:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 0, 0)
    aura.count:SetFont(Font, FontSize, FontStyle)
    aura.count:SetJustifyH("RIGHT")
    aura.count:SetTextColor(0.84, 0.75, 0.65)

    -- overlay
    aura.overlay = CreateFrame("Frame", "$parentOverlay", aura, nil)
    aura.overlay:SetAllPoints()
    aura.overlay:SetFrameLevel(aura.cooldown:GetFrameLevel() + 1)
    aura.time:SetParent(aura.overlay)
    aura.count:SetParent(aura.overlay)

    -- animation
    aura.animation = aura:CreateAnimationGroup()
    aura.animation:SetLooping("BOUNCE")

    aura.animation.fadeout = aura.animation:CreateAnimation("Alpha")
    aura.animation.fadeout:SetFromAlpha(1)
    aura.animation.fadeout:SetToAlpha(.1)
    aura.animation.fadeout:SetDuration(.5)
    aura.animation.fadeout:SetSmoothing("IN_OUT")

    -- aura.UpdateTooltip = UpdateTooltip
	aura:SetScript('OnEnter', onEnter)
	aura:SetScript('OnLeave', onLeave)

    return aura
end

-- check if aura is dispelable by the player
local function IsDispelable(debuffType)
    if (not debuffType) then return end

    if (class == "DRUID") then
        -- Abolish Poison (Poison) = 2893
        -- Cure Poison (Poison) = 8946
        -- Remove Curse (Curse) = 2782
        -- Soothe Animal (Enrage) = 2908
        return (
            (debuffType == "Poison" and (IsSpellKnown(2893) or IsSpellKnown(8946))) or
            (debuffType == "Curse" and (IsSpellKnown(2782))) or
            (debuffType == "Enrage" and IsSpellKnown(2908))
        )
    elseif (class == "HUNTER") then
        -- Tranquilizing Shot (Frenzy) = 19801
        return (
            (debuffType == "Enrage" and IsSpellKnown(19801))
        )
    elseif (class == "PALADIN") then
        -- Cleanse (Poison, Disease, Magic) = 4987
        -- Purify (Disease, Poison) = 1152
        return (
            ((debuffType == "Poison" or debuffType == "Disease" or debuffType == "Magic") and IsSpellKnown(4987)) or
            ((debuffType == "Poison" or debuffType == "Disease") and IsSpellKnown(1152))
        )
    elseif (class == "PRIEST") then
        -- Dispel Magic Rank 1 (Magic) = 527
        -- Dispel Magic Rank 2 (Magic) = 988
        -- Cure Disease (Disease) = 528
        -- Abolish Disease (Disease) = 552
        return (
            (debuffType == "Magic" and (IsSpellKnown(527) or IsSpellKnown(988))) or
            (debuffType == "Disease" and (IsSpellKnown(528) or IsSpellKnown(552)))
        )
    elseif (class == "SHAMAN") then
        -- Purge Rank 1 (Magic) = 370
        -- Purge Rank 2 (Magic) = 8012
        -- Cure Poison (Poison) = 526
        -- Poison Cleansing Totem (Poison) = 8166
        -- Cure Disease (Disease) = 2870
        return (
            (debuffType == "Magic" and (IsSpellKnown(370) or IsSpellKnown(8012))) or
            (debuffType == "Poison" and (IsSpellKnown(526) or IsSpellKnown(8166))) or
            (debuffType == "Disease" and IsSpellKnown(2870))
        )
    elseif (class == "WARLOCK") then
        -- Felhunter
        -- Devour Magic Rank 1 (Magic) = 19505
        -- Devour Magic Rank 2 (Magic) = 19731
        -- Devour Magic Rank 3 (Magic) = 19734
        -- Devour Magic Rank 4 (Magic) = 19736
        local hasDevourMagic = (
            IsSpellKnown(19505, true) or
            IsSpellKnown(19731, true) or
            IsSpellKnown(19734, true) or
            IsSpellKnown(19736, true)
        )
        return (
            (debuffType == "Magic" and hasDevourMagic)
        )
    end
end

function Filger:CustomFilter(element, unit, ...)
    local name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
        timeMod, effect1, effect2, effect3 = ...
    
    if (element.caster ~= caster) then
        return false
    end
    return true
end

local function UpdateAuraBorderType(element, unit, aura, isDebuff, name, debuffType, caster, isStealable, spellID, isBossDebuff, casterIsPlayer)
    local isEnemy = (type(caster) == "string") and UnitIsEnemy(caster, "player") or false
    if (caster ~= "player" and (isDebuff)) then
        local color = debuffTypes[debuffType or "Unknown"]
        if (not color) then color = BorderColor end
        aura:SetBorderColor(unpack(color))
    else
        aura:SetBorderColor(unpack(BorderColor))
    end
end

function Filger:UpdateAura(element, unit, index, offset, filter, isDebuff, visible)
    local name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
        timeMod, effect1, effect2, effect3 = UnitAura(unit, index, filter)
    
    if (not name) then return end

    if (debuffType ~= "Magic" and debuffType ~= "Curse" and debuffType ~= "Poison" and debuffType ~= "Disease") then
        print("TYPE:", name, texture, count, debuffType, duration, expiration, caster, isStealable,
            nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
            timeMod, effect1, effect2, effect3)
    end

    if (not duration or duration == 0) and (not expiration or expiration == 0) then
        local duration_lcd, expiration_lcd = LCD:GetAuraDurationByUnit(unit, spellID, caster, name)
        if (duration_lcd and duration_lcd > 0) then
            duration, expiration = duration_lcd, expiration_lcd
        end
    end
    
    local position = visible + offset + 1
    local aura = element[index]

    if (not aura) then
        aura = Filger:CreateAura(element, position)
        tinsert(element, aura)
    end

    aura.caster = caster
    aura.filter = filter
    aura.isDebuff = isDebuff
    aura.isPlayer = (caster == "player" or caster == "vehicle")

    aura.name = name
    aura.type = debuffType
    aura.spellID = spellID
    aura.isBossDebuff = isBossDebuff
    aura.casterIsPlayer = casterIsPlayer

    aura.expiration = expiration or expiration2
    aura.duration = duration or duration2
    aura.start = expiration - duration
    aura.first = true

    local show = Filger:CustomFilter(element, unit, name, texture, count, debuffType, duration, expiration,
    caster, isStealable, nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
    timeMod, effect1, effect2, effect3)

    if (show) then
        if (aura.icon) then
            aura.icon:SetTexture(texture)
        end

        if (aura.cooldown) then
            if (duration and duration > 0) then
                aura.cooldown:SetCooldown(expiration - duration, duration)
                aura.cooldown:Show()
            else
                aura.cooldown:Hide()
            end
        end

        if (aura.time) then
            if (duration and duration > 0) then
                aura:SetScript("OnUpdate", UpdateAuraTimer)
            else
                aura:SetScript("OnUpdate", nil)
            end
        end

        if (aura.count) then
            aura.count:SetText(count > 1 and count)
        end

        -- play aura animation
        if (aura.animation) then
            if (element.unit == "player") and (isBossDebuff) or
                (element.unit == "target") and (isStealable) then
                aura.animation:Play()
                aura.animation.Playing = true
            else
                aura.animation:Stop()
                aura.animation.Playing = false
            end
        end

        UpdateAuraBorderType(element, unit, aura, isDebuff, name, debuffType, caster, isStealable, spellID, isBossDebuff, casterIsPlayer)
        aura:Show()

        return VISIBLE
    end
    return HIDDEN
end

function Filger:FilterAuras(element, unit, filter, limit, isDebuff, offset, dontHide)
    if (not offset) then offset = 0 end
    local index = 1
    local visible = 0
    local hidden = 0
    while (visible < limit) do
        local result = Filger:UpdateAura(element, unit, index, offset, filter, isDebuff, visible)
        if (not result) then
            break
        elseif (result == VISIBLE) then
            visible = visible + 1
        elseif (result == HIDDEN) then
            hidden = hidden + 1
        end
        index = index + 1
    end

    if (not dontHide) then
        for i = visible + offset + 1, #element do
            element[i]:Hide()
        end
    end

    return visible, hidden
end

-- handles events and update active spells
--[[ Callback: handle spell events
* self  -- current frame
]]
local OnEvent = function(self, event, ...)
    local unit = nil
    
    if (event == "UNIT_AURA") then
        unit = ... 
    elseif (event == "SPELL_UPDATE_COOLDOWN") then
        unit = "player"
    elseif (event == "PLAYER_TARGET_CHANGED") then
        unit = "target"
    elseif (event == "PLAYER_FOCUS_CHANGED") then
        unit = "focus"
    end

    if (self.unit ~= unit) then return end
    
    --[[
        * unit      -- unit whose auras to query. ("player", "target", "focus", etc.)
        * index     -- aura index (from 1 to 40)
        * filter    -- list of filters, separated by spaces or pipes. "HELPFUL" by default.
        
        The following filters are available:
        HELPFUL - buffs.
        HARMFUL - debuffs.
        PLAYER - auras that were applied by the player.
        RAID - auras that can be applied (if HELPFUL) or dispelled (if HARMFUL) by the player.
        CANCELABLE - buffs that can be removed (such as by right-clicking or using the /cancelaura command)
        NOT_CANCELABLE - buffs that cannot be removed

        PLAYER | HELPFUL
        PLAYER | HARMFUL
    ]]
    local visibleBuffs, hiddenBuffs, visibleDebuffs, hiddenDebuffs

    if (self.buffs) then
        local filter = "HELPFUL"
        if (self.caster == "player") then
            filter = "PLAYER" .. "|" .. filter
        end

        local visible, hidden = Filger:FilterAuras(self, unit, filter, self.limit, nil, 0, false)
    end

    if (self.debuffs) then
        local filter = "HARMFUL"
        if (self.caster == "player") then
            filter = "PLAYER" .. "|" .. filter
        end
        
        local visible, hidden = Filger:FilterAuras(self, unit, filter, self.limit, true, 0, false)
    end
end

-- remove invalid spells or empty section and merge extra tables
function Filger:BuildSpellList()
    -- generate an empty class table if it doesn't exists
    if (not SpellList[class]) then
        SpellList[class] = {}
    end

    -- insert all class table into player class table
    if (SpellList["ALL"]) then
        for index, value in ipairs(SpellList["ALL"]) do
            tinsert(SpellList[class], value)
        end
    end

    -- remove all the other classes tables
    for key in pairs(SpellList) do
        if (key ~= class) then
            SpellList[key] = nil
        end
    end

    -- filter spell tables
    local idx = {}                                  -- save index of empty sections
    for i, data in ipairs(SpellList[class]) do
        local jdx = {}                              -- save index of non-existent spellID
        for j, obj in ipairs(data) do
            if (obj.spellID) then
                obj.name = GetSpellInfo(obj.spellID)
            else
                local slotLink = GetInventoryItemLink("player", obj.slotID)
                if (slotLink) then
                    obj.name = GetItemInfo(slotLink)
                end
            end

            -- check if there is any bad spellID/slotID
            if (not obj.name) then
                if (obj.spellID) then
                    Filger.Debug("spellID (" .. obj.spellID .. ") is INVALID at section " .. data.name)
                elseif (obj.slotID) then
                    Filger.Debug("slotID (" .. obj.slotID .. ") is INVALID at section " .. data.name)
                end
                tinsert(jdx, j)
            end
        end

        -- remove the non-existents spells (this need to be done from bottom to the top)
        for j = #jdx, 1, -1 do
            tremove(data, jdx[j])
        end

        -- check if there is any empty sections
        -- skip sections set as instance
		if (#data == 0) and (not data.instance) then
            Filger.Debug(data.name .. " section is EMPTY.")
            tinsert(idx, i)
        end
        
    end

    -- remove the empty sections (need to be done backwards)
	for i = #idx, 1, -1 do
    	tremove(SpellList[class], idx[i])
	end
end

Filger:RegisterEvent("ADDON_LOADED")
Filger:RegisterEvent("PLAYER_LOGIN")
-- Filger:RegisterEvent("PLAYER_ENTERING_WORLD")
Filger:SetScript("OnEvent", function(self, event, ...)
    -- call one of the function below
    self[event](self, ...)
end)

function Filger:ADDON_LOADED(addon)
    if (addon ~= "Filger") then return end
    print(Filger.WelcomeMessage)
    self.unit = "player"
end

function Filger:PLAYER_LOGIN()
    
    -- filter classes and remove invalid spells
    -- self:BuildSpellList()

    -- create panels based on spell list
    for index, data in pairs(SpellList[class]) do
        self:Spawn(index, data)
    end
end

--[[ Create a new frame
    * index                         -- position.
    * data                          -- frame configuration.
--]]
function Filger:Spawn(index, data)
    
    local frame = CreateFrame("Frame", self:GetName() .. index, self)
    frame.id = index
    frame.name = data.name
    frame.anchor = data.anchor
    frame.direction = data.direction or "LEFT"
    frame.mode = data.mode or "ICON"
    frame.limit = data.limit or 8

    frame.size = data.size or 32
    frame.width = data.width or 200
    frame.spacing = data.spacing or 3
    frame.alpha = data.alpha or 1

    frame.filter = data.filter
    frame.unit = data.unit or "player"
    frame.caster = data.caster or "player"
    frame.buffs = data.buffs or false
    frame.debuffs = data.debuffs or false

    frame.instance = data.instance or false

    frame:SetAttribute("unit", data.unit)
    frame:SetAttribute("caster", data.caster)

    frame:SetPoint(unpack(frame.anchor))
    frame:SetAlpha(frame.alpha)

    if (frame.mode == "ICON") then
        frame:SetWidth(frame.limit * frame.size + (frame.limit - 1) * frame.spacing)
        frame:SetHeight(frame.size)
    elseif (frame.mode == "BAR") then
        frame:SetWidth(frame.size + frame.width + frame.spacing)
        frame:SetHeight(frame.size)
    end

    do
        -- frame
        frame:CreateBackdrop()
        frame.Backdrop:SetTemplate("Transparent", nil, "Triple")
        frame.Backdrop:Hide()

        -- name
        frame.text = frame:CreateFontString(nil, "OVERLAY")
        frame.text:SetPoint("CENTER", frame, "CENTER", 0, 1)
        frame.text:SetFont(Font, FontSize, FontStyle)
        frame.text:SetText(index .. " - " .. frame.name)
        frame.text:SetJustifyH("CENTER")
        frame.text:Hide()
    end

    frame:RegisterEvent("UNIT_AURA")
    -- frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    if (frame.unit == "focus") then
        frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
    end
    if (frame.unit == "target") then
        frame:RegisterEvent("PLAYER_TARGET_CHANGED")
    end

    frame:SetScript("OnEvent", OnEvent)

    return frame
end
