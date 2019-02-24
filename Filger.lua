local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList
local Instances = ns.Instances

----------------------------------------------------------------
-- Filger
----------------------------------------------------------------
-- player info
local class = select(2, UnitClass("player"))
local color = RAID_CLASS_COLORS[class]

-- import
local tinsert, tremove, tsort, wipe = table.insert, table.remove, table.sort, table.wipe
local FormatTime =  Filger.FormatTime

-- resources
local BlankTex = Config["Medias"].Blank
local Font, FontSize, FontStyle = Config["Medias"].PixelFont, 12, "MONOCHROMEOUTLINE"

-- updates aura timer
local function UpdateAuraTimer(self, elapsed)
    local parent = self:GetParent()
    self.elapsed = (self.elapsed or 0) + elapsed

    if (self.elapsed >= 0.1) then
        if (not self.first) then
            self.timeleft = self.timerleft - self.elapsed
        else
            self.timeleft = (self.expirationTime) - GetTime()
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
            tremove(parent.actives, self.index)
            self:SetScript("OnUpdate", nil)
            Filger.DisplayActives(parent)
        end

        self.elapsed = 0
    end
end

-- search for an aura that matches specified spell (spellID or spellName)
function Filger:UnitAura(unit, spell, filter)
    for index = 1, 40 do
        local name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
		timeMod, effect1, effect2, effect3 = UnitAura(unit or "player", index, filter or "HELPFUL")

        if (not spellID) then
            -- no auras left
            break
        elseif (type(spell) == "number"and spell == spellID) or
            (type(spell) == "string" and spell == name) then
            return name, texture, count, debuffType, duration, expiration, caster, isStealable,
            nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
            timeMod, effect1, effect2, effect3
        end
    end
end

-- display active auras/cooldowns
function Filger:DisplayActives(...)
    if (not self.actives) then return end
    if (not self.auras) then self.auras = {} end

    for index, data in ipairs(self.actives) do
        local aura = self.auras[index]

        if (not aura) then
            -- create aura
            aura = CreateFrame("Frame", self:GetName() .. "Aura" .. index, self)
            aura:SetWidth(self.size)
            aura:SetHeight(self.size)
            aura:CreateBackdrop("Default")

            -- anchor
            if (index == 1) then
                if (self.mode == "ICON") then
                    aura:SetPoint(unpack(self.anchor))
                elseif (self.mode == "BAR") then
                    aura:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
                end
            else
                local previous = self.auras[index - 1]
                if (self.direction == "UP") then
                    aura:SetPoint("BOTTOM", previous, "TOP", 0, self.spacing)
                elseif (self.direction == "RIGHT") then
                    aura:SetPoint("LEFT", previous, "RIGHT", self.spacing, 0)
                elseif (self.direction == "LEFT") then
                    aura:SetPoint("RIGHT", previous, "LEFT", -self.spacing, 0)
                elseif (self.direction == "DOWN") then
                    aura:SetPoint("TOP", previous, "BOTTOM", 0, -self.spacing)
                end
            end

            if (self.mode == "ICON") then
                -- icon
                if (aura.icon) then
                    aura.icon = _G[aura.icon:GetName()]
                else
                    aura.icon = aura:CreateTexture("$parentIcon", "ARTWORK")
                    aura.icon:SetAllPoints()
                    aura.icon:SetTexCoord(unpack(Filger.IconCoord))
                end

                -- cooldown
                if (aura.cooldown) then
                    aura.cooldown = _G[aura.cooldown:GetName()]
                else
                    aura.cooldown = CreateFrame("Cooldown", "$parentCD", aura, "CooldownFrameTemplate")
                    aura.cooldown:SetAllPoints(aura.icon)
                    aura.cooldown:SetReverse(true)
                    aura.cooldown:SetDrawEdge(false)
                    aura.cooldown.noOCC = true
                    aura.cooldown.noCooldownCount = true
                    aura.cooldown:SetHideCountdownNumbers(true)
                end

                -- time left
                if (aura.time) then
                    aura.time = _G[aura.count:GetName()]
                else
                    aura.time = aura:CreateFontString("$parentTime", "OVERLAY")
                    aura.time:SetPoint("CENTER", aura, "CENTER", 2, 2)
                    aura.time:SetFont(Font, 24, FontStyle)
                    aura.time:SetJustifyH("CENTER")
                    aura.time:SetTextColor(0.84, 0.75, 0.65)
                end

                -- count
                if (aura.count) then
                    aura.count = _G[aura.count:GetName()]
                else
                    aura.count = aura:CreateFontString("$parentCount", "OVERLAY")
                    aura.count:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 1, -1)
                    aura.count:SetFont(Font, FontSize, FontStyle)
                    aura.count:SetJustifyH("RIGHT")
                    aura.count:SetTextColor(0.84, 0.75, 0.65)
                end

                -- overlay
                if (aura.overlay) then
                    aura.overlay = _G[aura.overlay:GetName()]
                else
                    aura.overlay = CreateFrame("Frame", "$parentOverlay", aura, nil)
                    aura.overlay:SetAllPoints()
                    aura.overlay:SetFrameLevel(aura.cooldown:GetFrameLevel() + 1)
                    aura.time:SetParent(aura.overlay)
                    aura.count:SetParent(aura.overlay)
                end

                -- animation
                if (aura.animation) then
                    aura.animation = _G[aura.animation:GetName()]
                else
                    aura.animation = aura:CreateAnimationGroup()
                    aura.animation:SetLooping("BOUNCE")

                    aura.animation.fadeout = aura.animation:CreateAnimation("Alpha")
                    aura.animation.fadeout:SetFromAlpha(1)
                    aura.animation.fadeout:SetToAlpha(.1)
                    aura.animation.fadeout:SetDuration(.5)
                    aura.animation.fadeout:SetSmoothing("IN_OUT")
                end
                
            elseif (self.mode == "BAR") then
                -- aura
                aura:SetWidth(self.width)
                aura:SetHeight(self:GetHeight())
                aura.Backdrop:Kill()

                -- statusbar
                if (aura.statusbar) then
                    aura.statusbar = _G[aura.statusbar:GetName()]
                else
                    aura.statusbar = CreateFrame("StatusBar", "$parentStatusBar", aura)
                    aura.statusbar:SetAllPoints()
                    aura.statusbar:SetStatusBarTexture(BlankTex)

                    if (Config["General"].ClassColor) then
                        aura.statusbar:SetStatusBarColor(color.r, color.g, color.b)
                    else
                        aura.statusbar:SetStatusBarColor(unpack(Config["General"].BorderColor))
                    end

                    aura.statusbar:SetMinMaxValues(0, 1)
                    aura.statusbar:SetValue(0)
                    aura.statusbar:CreateBackdrop("Default")
                end

                -- button
                if (aura.button) then
                    aura.button = _G[aura.button:GetName()]
                else
                    aura.button = CreateFrame("Frame", aura:GetName() .. "Button", aura)
                    aura.button:SetPoint("RIGHT", aura, "LEFT", -self.spacing, 0)
                    aura.button:SetWidth(self.size)
                    aura.button:SetHeight(self.size)
                    aura.button:CreateBackdrop("Default")
                end

                -- icon
                if (aura.icon) then
                    aura.icon = _G[aura.icon:GetName()]
                else
                    aura.icon = aura:CreateTexture("$parentIcon", "ARTWORK")
                    aura.icon:SetAllPoints(aura.button)
                    aura.icon:SetTexCoord(unpack(Filger.IconCoord))
                end

                -- time left
                if (aura.time) then
                    aura.time = _G[aura.count:GetName()]
                else
                    aura.time = aura.statusbar:CreateFontString("$parentTime", "OVERLAY")
                    aura.time:SetPoint("RIGHT", aura.statusbar, "RIGHT", -5, 0)
                    aura.time:SetFont(Font, FontSize, FontStyle)
                    aura.time:SetJustifyH("RIGHT")
                    aura.time:SetTextColor(0.84, 0.75, 0.65)
                end

                -- count
                if (aura.count) then
                    aura.count = _G[aura.count:GetName()]
                else
                    aura.count = aura:CreateFontString("$parentCount", "OVERLAY")
                    aura.count:SetPoint("BOTTOMRIGHT", aura.icon, "BOTTOMRIGHT", 1, -1)
                    aura.count:SetFont(Font, FontSize, FontStyle)
                    aura.count:SetJustifyH("RIGHT")
                    aura.count:SetTextColor(0.84, 0.75, 0.65)
                end

                -- name
                if (aura.text) then
                    aura.text = _G[aura.text:GetName()]
                else
                    aura.text = aura.statusbar:CreateFontString("$parentName", "OVERLAY")
                    aura.text:SetPoint("LEFT", aura.statusbar, "LEFT", 5, 0)
                    aura.text:SetFont(Font, FontSize, FontStyle)
                    aura.text:SetJustifyH("LEFT")
                    aura.text:SetTextColor(0.84, 0.75, 0.65)
                end
            end

            tinsert(self.auras, aura)
        end

        aura:SetAlpha(self.alpha)
        if (aura.icon) then aura.icon:SetTexture(data.icon) end
        if (aura.count) then aura.count:SetText(data.count > 0 and data.count or "") end
        if (aura.text) then aura.text:SetText(data.name) end
        if (aura.time) then aura.time:SetText(data.duration > 0 and FormatTime(data.duration) or "") end

        -- aura border colored by debuff type
        if (data.filter == "DEBUFF") then
            local color = DebuffTypeColor[data.debuffType] or DebuffTypeColor.none
            aura.Backdrop:SetBackdropBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)    
        elseif (data.filter == "BUFF") and (self.unit == "player") and (not data.isPlayer) then
            aura.Backdrop:SetBackdropBorderColor(.31, .99, .31)
        else
            aura.Backdrop:SetBackdropBorderColor(unpack(Config["General"].BorderColor))
        end

        -- play aura animation
        if (aura.animation) then
            if (self.unit == "player") and (data.isBossDebuff) or
                (self.unit == "target") and (data.isStealable) then
                aura.animation:Play()
                aura.animation.Playing = true
            else
                aura.animation:Stop()
                aura.animation.Playing = false
            end
        end

        -- update timer
        if (aura.time) then
            if (data.duration and data.duration > 0) then
                aura.index = index
                aura.name = data.name
                aura.expirationTime = data.expirationTime
                aura.duration = data.duration
                aura.start = data.start
                aura.first = true

                if (aura.statusbar) then aura.statusbar:SetMinMaxValues(0, data.duration) end
                if (aura.cooldown) then aura.cooldown:SetCooldown(data.start, data.duration, 1) end

                aura:SetScript("OnUpdate", UpdateAuraTimer)
            else
                if (aura.text) then aura.text:Hide() end
                if (aura.cooldown) then aura.cooldown:Hide() end
                if (aura.statusbar) then
                    aura.statusbar:SetMinMaxValues(0, 1)
                    aura.statusbar:SetValue(0)
                end
                aura:SetScript("OnUpdate", nil)
            end

            -- limit the number of frames showing
            if (index > self.num) then
                aura:Hide()
            else
                aura:Show()
            end
        end
    end

    -- hide remaining auras
    for index, aura in ipairs(self.auras) do
        if (index > #self.actives) then
            aura:Hide()
        end
    end
end

-- handles events and update active spells
function Filger:OnEvent(event, ...)
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

    -- clear active spells table
    wipe(self.actives)
    
    -- scan unit auras and search for spell in the spell list.
    -- for index, data in ipairs(SpellList[class][self.id]) do
    for index, data in ipairs(self.spells) do
        local name, icon, count, debuffType, duration, expirationTime, caster, isStealable,
        nameplateShowSelf, spellID, canApply, isBossDebuff, isPlayer, nameplateShowAll,
        timeMod, effect1, effect2, effect3
        local start, enabled

        if (data.filter == "CD") then
            if (data.spellID) then
                name, _, icon, _, _, _, spellID = GetSpellInfo(data.spellID)
                if (name) then
                    start, duration, enabled = GetSpellCooldown(data.spellID)
                end
            elseif (data.slotID) then
                local slotLink = GetInventoryItemLink("player", data.slotID)
                if (slotLink) then
                    name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink)
                    start, duration, enabled = GetInventoryItemCooldown("player", data.slotID)
                end
            end

            count = 0
            caster = "player"
            isPlayer = true

            if (duration) and (start) then
                expirationTime = start + duration
            end
        elseif (data.filter == "BUFF") then
            name, icon, count, debuffType, duration, expirationTime, caster, isStealable,
            nameplateShowSelf, spellID, canApply, isBossDebuff, isPlayer, nameplateShowAll,
            timeMod, effect1, effect2, effect3 = Filger:UnitAura(self.unit, data.spellID, "HELPFUL")

            if (duration) and (expirationTime) then
                start = expirationTime - duration
            end
        elseif (data.filter == "DEBUFF") then
            name, icon, count, debuffType, duration, expirationTime, caster, isStealable,
            nameplateShowSelf, spellID, canApply, isBossDebuff, isPlayer, nameplateShowAll,
            timeMod, effect1, effect2, effect3 = Filger:UnitAura(self.unit, data.spellID, "HARMFUL")

            if (duration) and (expirationTime) then
                start = expirationTime - duration
            end
        end

        -- check if frame active table exists
        if (not self.actives) then
            self.actives = {}
        end

        -- remove repeated spells
            for i, v in ipairs(self.actives) do
            if (v.name == name) then
                tremove(self.actives, i)
                break
            end
        end
    
        if (name) and (data.caster == "all" or data.caster == caster or caster == "vehicle" or caster == "pet") and
        (duration and duration > 1.5) or (count and count > 0) then

            -- insert spell into activies spells
            tinsert(self.actives, {
                spellID = data.spellID,
                slotID = data.slotID,
                caster = data.caster,
                filter = data.filter,
                name = name,
                icon = icon,
                count = count,
                debuffType = debuffType,
                isStealable = isStealable,
                isBossDebuff = isBossDebuff,
                isPlayer = isPlayer,
                start = start,
                duration = duration,
                expirationTime = expirationTime, 
            })

            -- sort by expiration time
            tsort(self.actives, function(a, b)
                if (a.expirationTime == b.expirationTime) then
                    return a.name < b.name
                end
                return a.expirationTime < b.expirationTime
            end)
        end
    end

    Filger.DisplayActives(self)
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

-- create panels for each one defined at class table
function Filger:CreatePanels()
    
    for index, data in pairs(SpellList[class]) do

        local frame = CreateFrame("Frame", self:GetName() .. index, self)
        frame.id = index
        frame.name = data.name
        frame.anchor = data.anchor
        frame.direction = data.direction or "LEFT"
        frame.mode = data.mode or "ICON"
        frame.num = data.num or 7
        frame.size = data.size or 32
        frame.width = data.width or 200
        frame.spacing = data.spacing or 7
        frame.alpha = data.alpha or 1
        frame.unit = data.unit or "player"
        frame.filter = data.filter
        frame.instance = data.instance or false

        -- active spell tacked by the frame
        frame.actives = {}

        frame.spells = {}
        for _, value in ipairs(data) do
            tinsert(frame.spells, value)
        end

        frame:SetPoint(unpack(frame.anchor))
        frame:SetAlpha(frame.alpha)

        if (frame.mode == "ICON") then
            frame:SetWidth(frame.num * frame.size + (frame.num - 1) * frame.spacing)
            frame:SetHeight(frame.size)
        elseif (frame.mode == "BAR") then
            frame:SetWidth(frame.size + frame.width + frame.spacing)
            frame:SetHeight(frame.size)
        end

        if (true) then
            -- frame
            frame:CreateBackdrop("Transparent")
            frame.Backdrop:Hide()

            -- name
            frame.text = frame:CreateFontString(nil, "OVERLAY")
            frame.text:SetPoint("CENTER", frame, "CENTER", 0, 1)
            frame.text:SetFont(Font, FontSize, FontStyle)
            frame.text:SetText(index .. " - " .. frame.name)
            frame.text:SetJustifyH("CENTER")
            frame.text:Hide()
        end

        -- check if there is any cooldown filter
        for _, spell in ipairs(data) do
            if (spell.filter == "CD") then
                -- frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
                break
            end
        end

        -- register events
        if (frame.unit == "player") then
            -- check if any spell filter
            for _, value in ipairs(data) do
                if (value.filter == "CD") then
                    frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
                    break
                end
            end
        end
        
        frame:RegisterEvent("UNIT_AURA")
        frame:RegisterEvent("PLAYER_ENTERING_WORLD")
        if (frame.unit == "focus") then frame:RegisterEvent("PLAYER_FOCUS_CHANGED") end
        if (frame.unit == "target") then frame:RegisterEvent("PLAYER_TARGET_CHANGED") end

        frame:SetScript("OnEvent", self.OnEvent)

        self[index] = frame
    end
end

Filger:RegisterEvent("ADDON_LOADED")
Filger:RegisterEvent("PLAYER_LOGIN")
Filger:RegisterEvent("PLAYER_ENTERING_WORLD")
Filger:SetScript("OnEvent", function(self, event, ...)
    -- call one of the function below
    self[event](self, ...)
end)

function Filger:ADDON_LOADED(addon)
    if (addon ~= "Filger") then return end
    print(Filger.WelcomeMessage)
end

function Filger:PLAYER_LOGIN()
    
    -- filter classes and remove invalid spells
    self:BuildSpellList()

    -- create panels based on spell list
    self:CreatePanels()
end

function Filger:PLAYER_ENTERING_WORLD()
    -- get instance/continent information
    local inInstance, instanceType = IsInInstance()
    local instanceName, _, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize = GetInstanceInfo()
    
    -- import instance spell table
    local Zone = Instances[instanceID]
    
    if (Zone and #Zone > 0) then
        for _, frame in ipairs(Filger) do
            if (frame.instance) then
                
                -- clear frame spell table
                if (frame.spells) and (#frame.spells > 0) then wipe(frame.spells) end
                if (frame.actives) then wipe(frame.actives) end
                if (frame.auras) then wipe(frame.auras) end

                -- copy frame defualt spell table
                for _, data in ipairs(SpellList[class][frame.id]) do
                    tinsert(frame.spells, data)
                end

                -- add zone spell table into frame
                for index, data in ipairs(Zone) do

                    -- check if spells are valid
                    local name = GetSpellInfo(data.spellID)
                    if (not name) then
                        Filger.Debug("instance[" .. instanceID .. "] spellID (" .. data.spellID .. ") is invalid.")
                        tremove(Zone, index)
                    else
                        if (frame.unit == data.unit) or (frame.unit == "focus") or (data.unit == "all") then
                            tinsert(frame.spells, { spellID = data.spellID, caster = data.caster, filter = data.filter })
                        end
                    end
                end
            end
        end
    end
end