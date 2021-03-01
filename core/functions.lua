local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local Cooldowns = Config.Cooldowns
local BlackList = Config.BlackList

local GetTime = GetTime
local GetSpellInfo = GetSpellInfo

table.remove_key = function(table, key)
    local value = table[key]
    table[key] = nil
    return value
end

local format = string.format
local floor, ceil = math.floor, math.ceil

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
Filger.IconCoord = { .08, .92, .08, .92 }

function Filger.Print(...)
    print(format("|cff00ff96Filger:|r"), ...)
end

function Filger.Debug(...)
    print(format("|cffff330fFilger WARNING:|r"), ...)
end

-- format seconds to min/hour/day
function Filger.FormatTime(s)
	local Day, Hour, Minute = 86400, 3600, 60

	if (s >= Day) then
		return format("%dd", ceil(s / Day))
	elseif (s >= Hour) then
		return format("%dh", ceil(s / Hour))
	elseif (s >= Minute) then
		return format("%dm", ceil(s / Minute))
	elseif (s >= Minute / 12) then
		return floor(s)
	end

	return format("%.1f", s)
end

function Filger.UpdateAuraTimer(self, elapsed)
    self.timeleft = self.timeleft or 0
    self.elapsed = (self.elapsed or 0) + elapsed
    if (self.elapsed >= 0.1) then
        if (not self.first) then
            self.timeleft = self.timeleft - self.elapsed
        else
            self.timeleft = (self.expiration) - GetTime()
        end

        if (self.timeleft > 0) then
            if (self.time) then self.time:SetText(Filger.FormatTime(self.timeleft)) end
            if (self.statusbar) then self.statusbar:SetValue(self.timeleft) end

			if (self.time) then
				if (self.timeleft <= 5) then
					self.time:SetTextColor(0.99, 0.31, 0.31)
				else
					self.time:SetTextColor(0.84, 0.75, 0.65)
				end
			end
        else
            if (self.time) then self.time:SetText("") end
            self.start = 0
            self.duration = 0
            self.expiration = 0
            self:SetScript("OnUpdate", nil)
			self:Hide()
        end

        self.elapsed = 0
    end
end

function Filger.TableLength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

function Filger.BuildCooldownList()
    local cooldowns = {}
    local class = Filger.MyClass

    if (not Cooldowns) then Cooldowns = {} end
    if (not Cooldowns[class]) then Cooldowns[class] = {} end
    if (not Cooldowns["ALL"]) then Cooldowns["ALL"] = {} end

    for spellID, check in pairs(Cooldowns[class]) do
        if (check) then
            local name = GetSpellInfo(spellID)
            if (name) then
                cooldowns[spellID] = true
            else
                Filger.Debug("spellID (" .. spellID .. ") is invalid.")
            end
        end
    end

    for spellID, check in pairs(Cooldowns["ALL"]) do
        if (check) then
            local name = GetSpellInfo(spellID)
            if (name) then
                cooldowns[spellID] = true
            else
                Filger.Debug("spellID (" .. spellID .. ") is invalid.")
            end
        end
    end

    return cooldowns
end

function Filger.BuildBlackList()
    local index = 1
    for spellID, check in pairs(BlackList) do
        local name = GetSpellInfo(spellID)
        if (not check or not name) then
            if (not name) then
                Filger.Debug("spellID (" .. spellID .. ") is invalid.")
            end
            table.remove_key(BlackList, spellID)
        end
        index = index + 1
    end
end
