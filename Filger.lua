local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList
local Panels = Config.Panels
local BlackList = Config.BlackList

local VISIBLE = 1
local HIDDEN = 0

local UnitAura = UnitAura
local UnitIsEnemy = UnitIsEnemy
local IsSpellKnown = IsSpellKnown
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip

local GetSpellInfo, GetItemInfo, GetInventoryItemLink = GetSpellInfo, GetItemInfo, GetInventoryItemLink
local GetSpellCooldown, GetSpellBaseCooldown = GetSpellCooldown, GetSpellBaseCooldown

----------------------------------------------------------------
-- Filger
----------------------------------------------------------------
-- player info
local class = Filger.MyClass
local classColor = RAID_CLASS_COLORS[class]

local DebuffTypeColors = {
    ["Curse"]   = { 0.60, 0.00, 1.00 },
    ["Disease"] = { 0.60, 0.40, 0.00 },
    ["Magic"]   = { 0.20, 0.60, 1.00 },
    ["Poison"]  = { 0.00, 0.60, 0.00 },
    ["Unknown"]  = { 0.80, 0.00, 0.00 }
}

-- import
local tinsert, tremove, tsort, wipe = table.insert, table.remove, table.sort, table.wipe
local UpdateAuraTimer = Filger.UpdateAuraTimer

-- resources
local BlankTex = Config["Medias"].Blank
local Font, FontSize, FontStyle = Config["Medias"].Font, 12, "OUTLINE"
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

local function onMouseDown(self)
    print(self.spellID, " - ", self.name)
end

function Filger:SetPosition(element, from, to)
    local sizex = (element.size) + (element["spacing-x"] or element.spacing or 0)
	local sizey = (element.size) + (element["spacing-y"] or element.spacing or 0)
	local anchor = element.initialAnchor or "BOTTOMLEFT"
	local growthx = (element['growth-x'] == 'LEFT' and -1) or 1
	local growthy = (element['growth-y'] == 'DOWN' and -1) or 1
	local cols = math.floor(element:GetWidth() / sizex + 0.5)

	for i = from, to do
		local aura = element[i]

		-- Bail out if the to range is out of scope.
		if (not aura) then break end
		local col = (i - 1) % cols
		local row = math.floor((i - 1) / cols)

		aura:ClearAllPoints()
		aura:SetPoint(anchor, element, anchor, col * sizex * growthx, row * sizey * growthy)
	end
end

function Filger:SetCooldownPosition(element, from, to)
    local sizex = (element.size) + (element["spacing-x"] or element.spacing or 0)
	local sizey = (element.size) + (element["spacing-y"] or element.spacing or 0)
	local anchor = element.initialAnchor or "BOTTOMLEFT"
	local growthx = (element['growth-x'] == 'LEFT' and -1) or 1
	local growthy = (element['growth-y'] == 'DOWN' and -1) or 1
	local cols = math.floor(element:GetWidth() / sizex + 0.5)

	for i = from, to do
		local aura = element[i]

		-- Bail out if the to range is out of scope.
		if (not aura) then break end

        aura:ClearAllPoints()

        if (i == 1) then
            if (to % 2 == 1) then
                aura:SetPoint("CENTER", element, "CENTER", 0, 0)
            else
                aura:SetPoint("RIGHT", element, "CENTER", -math.ceil(element.spacing/2), 0)
            end
        elseif (i == 2) then
            aura:SetPoint("LEFT", element[1], "RIGHT", element.spacing, 0)
        elseif (i % 2 == 0) then
            aura:SetPoint("LEFT", element[i - 2], "RIGHT", element.spacing, 0)
        else
            aura:SetPoint("RIGHT", element[i - 2], "LEFT", -element.spacing, 0)
        end
	end
end

-- Create Aura Icon
function Filger:CreateAura(element, index)

    local aura = CreateFrame("Frame", element:GetName() .. "Aura" .. index, element)
    aura:SetWidth(element.size)
    aura:SetHeight(element.size)
    aura:CreateBackdrop()
    aura.Backdrop:SetOutside()

    aura.icon = aura:CreateTexture("$parentIcon", "ARTWORK")
    aura.icon:SetInside(aura)
    aura.icon:SetTexCoord(unpack(Filger.IconCoord))

    aura.cooldown = CreateFrame("Cooldown", "$parentCD", aura, "CooldownFrameTemplate")
    aura.cooldown:SetAllPoints(aura.icon)
    aura.cooldown:SetReverse(true)
    aura.cooldown:SetDrawEdge(false)
    aura.cooldown.noOCC = true
    aura.cooldown.noCooldownCount = true
    aura.cooldown:SetHideCountdownNumbers(true)

    aura.time = aura:CreateFontString("$parentTime", "OVERLAY")
    aura.time:SetPoint("CENTER", aura, "CENTER", 0, 0)
    aura.time:SetFont(Font, 24, FontStyle)
    aura.time:SetJustifyH("CENTER")
    aura.time:SetTextColor(0.84, 0.75, 0.65)

    aura.count = aura:CreateFontString("$parentCount", "OVERLAY")
    aura.count:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 0, 0)
    aura.count:SetFont(Font, FontSize, FontStyle)
    aura.count:SetJustifyH("RIGHT")
    aura.count:SetTextColor(0.84, 0.75, 0.65)

    aura.overlay = CreateFrame("Frame", "$parentOverlay", aura, nil)
    aura.overlay:SetAllPoints()
    aura.overlay:SetFrameLevel(aura.cooldown:GetFrameLevel() + 1)
    aura.time:SetParent(aura.overlay)
    aura.count:SetParent(aura.overlay)

    aura.animation = aura:CreateAnimationGroup()
    aura.animation:SetLooping("BOUNCE")

    aura.animation.fadeout = aura.animation:CreateAnimation("Alpha")
    aura.animation.fadeout:SetFromAlpha(1)
    aura.animation.fadeout:SetToAlpha(.1)
    aura.animation.fadeout:SetDuration(.5)
    aura.animation.fadeout:SetSmoothing("IN_OUT")

    aura:SetScript("OnEnter", onEnter)
    aura:SetScript("OnLeave", onLeave)
    aura:SetScript("OnMouseDown", onMouseDown)

    tinsert(element, aura)

    element.createdAuras = element.createdAuras + 1

    return aura
end

-- check if aura is dispelable by the player
local function IsDispelable(DebuffType, TargetIsPlayer, TargetIsEnemy, isDebuff)
    if (not DebuffType) then return false end

    local TargetIsFriendly = not TargetIsEnemy

    if (TargetIsEnemy and isDebuff) or (TargetIsFriendly and (not isDebuff)) then return false end

    -- Blood Elf: Arcane Torrent (155145): removes 1 beneficial magic effect from enemy target.
    -- Dark Iron Dwarf: Fireblood (265221): removes all magic, disease, curse, poison and bleed from player.
    -- Dwarf: Stoneform (20594): removes all magic, disease, curse, poison and bleed effects from player.
    local RacialAbility = (IsSpellKnown(155145) and (DebuffType == "Magic") and TargetIsEnemy) or
        (IsSpellKnown(20594) or IsSpellKnown(265221) and  (
            DebuffType == "Magic" or
            DebuffType == "Disease" or
            DebuffType == "Curse" or
            DebuffType == "Poison" or
            DebuffType == "Bleed"
        ) and TargetIsPlayer)

    local Ability = nil
    if (class == "DEMONHUNTER") then
        -- Consume Magic (278326): remove 1 beneficial magic effect from enemy target.
        Ability = (DebuffType == "Magic") and IsSpellKnown(278326) and TargetIsEnemy and (not isDebuff)
    elseif (class == "DRUID") then
        -- Soothe (2908): removes enrage from enemy target.
        -- Remove Corruption (2782): removes harmful curse and poison effects from friendly target.
        -- Nature's Cure (88423): removes harmful magic, curse and poison effects from friendly targets.
        Ability =  TargetIsFriendly and (
            ((DebuffType == "Magic") and IsSpellKnown(88423)) or
            ((DebuffType == "Curse") and (IsSpellKnown(2782) or IsSpellKnown(88423)))) or
            ((DebuffType == "Poison") and (IsSpellKnown(2782) or IsSpellKnown(88423))) or
            (TargetIsEnemy and (DebuffType == "Enrage") and IsSpellKnown(88423))
    elseif (class == "HUNTER") then
        -- Tranquilizing Shot (19801): removes enrage and 1 magic effect from enemy target.
        -- Mending Bandage (212640 - PvP): removes bleed, poison and disease effects from friendly target.
        Ability =  (TargetIsEnemy and ((DebuffType == "Enrage") or (DebuffType == "Magic")) and IsSpellKnown(19801)) or
            (TargetIsFriendly and ((DebuffType == "Bleed") or (DebuffType == "Poison") or (DebuffType == "Disease")) and IsSpellKnown(212640))
    elseif (class == "MAGE") then
        -- Remove Curse (475): removes all curses from friendly target.
        Ability = (DebuffType == "Curse") and IsSpellKnown(475) and TargetIsFriendly
    elseif (class == "MONK") then
        -- Detox (218164): removes all magic, poison and disease effects from friendly target.
        local Detox = 218164
        Ability = IsSpellKnown(Detox) and (
            (DebuffType == "Poison") or
            (DebuffType == "Disease")
        ) and IsSpellKnown(Detox) and TargetIsFriendly
    elseif (class == "PALADIN") then
        -- Cleanse (4987): removes magic, disease and poison effects from friendly target.
        -- Cleanse Toxins (213644): removes disease and poison effects from friendly target.
        Ability = TargetIsFriendly and
            ((DebuffType == "Magic") and IsSpellKnown(4987)) or
            ((DebuffType == "Disease") and (IsSpellKnown(4987) or IsSpellKnown(213644))) or
            ((DebuffType == "Poison") and (IsSpellKnown(4987) or IsSpellKnown(213644)))
    elseif (class == "PRIEST") then
        -- Purify (527): removes magic and disease effects from friendly/enemy target.
        -- Dispel Magic (528): removes one magic effect from enemy target.
        -- Mass Dispel (32375): removes all magic effects from 5 friendly targets and 1 beneficial magic spell from enemy target
        -- Purify Disease (213634): removes all disease effects from friendly target.
        local Purify = 527
        local DispelMagic = 528
        local MassDispel = 32375
        local PurifyDisease = 213634
        Ability = ((DebuffType == "Magic" or DebuffType == "Disease") and IsSpellKnown(Purify)) or
            ((DebuffType == "Magic") and IsSpellKnown(DispelMagic) and TargetIsEnemy) or
            ((DebuffType == "Magic") and IsSpellKnown(MassDispel) and ((TargetIsFriendly and isDebuff) or (TargetIsEnemy and (not isDebuff)))) or
            ((DebuffType == "Disease") and IsSpellKnown(PurifyDisease) and TargetIsFriendly)
    elseif (class == "SHAMAN") then
        -- Purge (370): removes 1 beneficial magic effect from enemy target.
        -- Purify Spirit (77130): removes all curses and magic from friendly target.
        -- Cleanse Spirit (51886): removes all curses from friendly target.
        Ability = ((DebuffType == "Magic") and IsSpellKnown(370) and TargetIsEnemy and (not isDebuff)) or
            ((DebuffType == "Magic") and IsSpellKnown(77130) and TargetIsFriendly) or
            ((DebuffType == "Curse") and (IsSpellKnown(77130) or IsSpellKnown(51886)) and TargetIsFriendly)
    elseif (class == "WARLOCK") then
        -- Devour Magic - Felhunter (19505): removes 1 beneficial magic effect from enemy target.
        -- Singe Magic - Imp (89808): removes harmful magic effects from friendly target.
        Ability = ((DebuffType == "Magic") and IsSpellKnown(19505, true) and TargetIsEnemy and (not isDebuff)) or
            ((DebuffType == "Magic") and IsSpellKnown(89808, true) and TargetIsFriendly and (isDebuff))
    end
    return RacialAbility or Ability
end

local function CustomFilter(element, unit, aura, ...)
    local name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
        timeMod, effect1, effect2, effect3 = ...

    -- hide unecessary auras (Fortitude, Intellect, etc.)
    if (BlackList[spellID]) then return end

    -- show only auras casted by the player
    if (element.showOnlyPlayer and (not aura.isPlayer)) then return end

    -- show only auras not casted by the player
    if (element.hidePlayer and aura.isPlayer) then return end

    return true
end

function Filger:PostUpdateAura(element, unit, aura, index, position, duration, expiration, debuffType, isDebuff, isStealable)

    local targetIsEnemy = UnitIsEnemy(unit or "player", "player")
    local casterIsEnemy = UnitIsEnemy(caster or "player", "player")
    local casterIsFriendly = not casterIsEnemy

    -- return true or false if aura can be dispeled by the player
    -- 1. dispel harmful effects from friendly target.
    -- 2. dispell beneficial effects from enemy target.
    local isDispelable = (not aura.casterIsPlayer) and IsDispelable(debuffType, aura.isPlayer, targetIsEnemy, isDebuff)

    -- set border color by aura type, if it's dispelable.
    if (isDispelable or isStealable) then
        aura.Backdrop:SetBorderColor(unpack(DebuffTypeColors[debuffType or "Unknown"]))
    else
        aura.Backdrop:SetBorderColor(unpack(BorderColor))
    end

    -- aura animation to show each aura is dispelable/stealable
    if (aura.animation) then
        if (isDispelable or isStealable) then
            aura.animation:Play()
            aura.animation.Playing = true
        else
            aura.animation:Stop()
            aura.animation.Playing = false
        end
    end

    -- bebuffs on enemy target, but not casted by player should be desaturated.
    if (aura.icon) then
        aura.icon:SetDesaturated(isDebuff and (not aura.isPlayer) and (casterIsFriendly) and (targetIsEnemy))
    end
end

local function UpdateAura(element, unit, index, offset, filter, isDebuff, visible)
    local name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
        timeMod, effect1, effect2, effect3 = UnitAura(unit, index, filter)

    if (not name) then return end

    local position = visible + offset + 1
    local aura = element[position]

    if (not aura) then
        aura = Filger:CreateAura(element, position)
        aura.filter = filter
        aura.isDebuff = isDebuff
    end

    aura.caster = caster
    aura.isPlayer = (caster == "player" or caster == "vehicle" or caster == "pet")
    aura.isBossDebuff = isBossDebuff
    aura.casterIsPlayer = casterIsPlayer

    aura.name = name
    aura.spellID = spellID
    aura.debuffType = debuffType

    aura.expiration = expiration or 0
    aura.duration = duration
    aura.start = expiration - duration
    aura.first = true

    --[[ CustomFilter(unit, button, ...)
        Defines a custom filter that controls if the aura should be shown.

        * self      -- the widget holding the aura.
        * unit      -- the unit on whcih the aura is cast (string)
        * aura      -- the frame displaying the aura (Frame)
        * ...       -- the return values from [UnitAura](http://wowprogramming.com/docs/api/UnitAura.html)
    --]]
    local show = (element.CustomFilter or CustomFilter) (element, unit, aura, name, texture,
        count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
        canApply, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, effect1, effect2, effect3)

    if (not show) then
        return HIDDEN
    end

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
            aura.time:Show()
        else
            aura:SetScript("OnUpdate", nil)
            aura.time:Hide()
        end
    end

    if (aura.count) then
        aura.count:SetText(count > 1 and count)
    end

    aura:Show()

    Filger:PostUpdateAura(element, unit, aura, index, position, duration, expiration, debuffType, isDebuff, isStealable)

    return VISIBLE
end

local function UpdateCooldown(element, unit, index, spellID, offset, visible)
    local name, rank, icon, castTime, minRange, maxRange, _ = GetSpellInfo(spellID)
    local start, duration, enabled, modRate = GetSpellCooldown(spellID)
    local cooldownMS, gcdMS = GetSpellBaseCooldown(spellID)
    local expiration = start + duration

    if (not name) or (not duration) or (duration <= 1.5) then
        return HIDDEN
    end

    local position = visible + offset + 1
    local aura = element[position]

    if (not aura) then
        aura = Filger:CreateAura(element, position)
        aura.filter = element.filter
    end

    aura.name = name
    aura.spellID = spellID

    aura.expiration = expiration
    aura.duration = duration
    aura.start = start
    aura.first = true

    if (aura.icon) then
        aura.icon:SetTexture(icon)
    end

    if (aura.cooldown) then
        if (duration and duration > 0) then
            aura.cooldown:SetCooldown(start, duration)
            aura.cooldown:Show()
        else
            aura.cooldown:Hide()
        end
    end

    if (aura.time) then
        if (duration and duration > 0) then
            aura:SetScript("OnUpdate", UpdateAuraTimer)
            aura.time:Show()
        else
            aura:SetScript("OnUpdate", nil)
            aura.time:Hide()
        end
    end

    if (aura.count) then
        aura.count:Hide()
    end

    aura:Show()

    return VISIBLE
end

function Filger:FilterAuras(element, unit, filter, limit, isDebuff, offset, dontHide)
    if (not offset) then offset = 0 end
    local index = 1
    local visible = 0
    local hidden = 0
    while (visible < limit) do
        local result = UpdateAura(element, unit, index, offset, filter, isDebuff, visible)
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

function Filger:FilterCooldowns(element, unit, filter, limit, offset, dontHide)
    if (not offset) then offset = 0 end
    local index = 1
    local visible = 0
    local hidden = 0
    for spellID, _ in pairs(element.spells) do
        if (visible >= limit) then
            break
        end

        local result = UpdateCooldown(element, unit, index, spellID, offset, visible)
        if (result == VISIBLE) then
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
    elseif (event == "PLAYER_ENTERING_WORLD") then
        unit = self.unit
    end

    if (self.unit ~= unit) then return end

    if (self.filter == "COOLDOWN") then
        local visible, hidden = Filger:FilterCooldowns(self, unit, self.filter, self.limit, 0, false)

        Filger:SetCooldownPosition(self, 1, #self)
    else
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
        local visible, hidden = Filger:FilterAuras(self, unit, self.filter, self.limit, self.isDebuff, 0, false)

        Filger:SetPosition(self, 1, #self)
    end
end

Filger:RegisterEvent("ADDON_LOADED")
Filger:RegisterEvent("PLAYER_LOGIN")
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
    Filger.BuildBlackList()

    -- create panels based on spell list
    for index, data in pairs(Panels) do
        if (data.enabled) then
            self:Spawn(index, data)
        end
    end
end

function Filger:Spawn(index, data)

    local frame = CreateFrame("Frame", self:GetName() .. index, self)
    frame.name = data.name
    frame.anchor = data.anchor

    frame.limit = data.limit or 32
    frame.size = data.size or 32
    frame.spacing = data.spacing or 3

    frame.initialAnchor = data.initialAnchor or "BOTTOMLEFT"
    frame["growth-x"] = data["growth-x"] or "LEFT"
    frame["growth-y"] = data["growth-y"] or "DOWN"

    frame.unit = data.unit or "player"
    frame.caster = data.caster
    frame.showOnlyPlayer = data.showOnlyPlayer or false
    frame.hidePlayer = data.hidePlayer or false

    frame.filter = data.filter
    frame.isDebuff = data.isDebuff or false

    frame.createdAuras = 0

    frame:SetPoint(unpack(frame.anchor))
    frame:SetWidth((frame.limit * frame.size) + (frame.limit - 1) * frame.spacing)
    frame:SetHeight(frame.size)
    frame:SetAlpha(data.alpha or 1)

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

    frame:SetAttribute("unit", data.unit)
    frame:SetAttribute("caster", data.caster)

    if (frame.filter == "COOLDOWN") then
        frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        frame.spells = Filger.BuildCooldownList()
    else
        frame:RegisterEvent("UNIT_AURA")
        if (frame.unit == "player") then
            frame:RegisterEvent("PLAYER_ENTERING_WORLD")
        end
        if (frame.unit == "focus") then
            frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
        end
        if (frame.unit == "target") then
            frame:RegisterEvent("PLAYER_TARGET_CHANGED")
        end
    end

    frame:SetScript("OnEvent", OnEvent)

    return frame
end
