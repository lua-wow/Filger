local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

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
