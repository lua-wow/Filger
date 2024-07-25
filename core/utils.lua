local _, ns = ...
local Filger = ns.Filger

local format = string.format
local floor, ceil = math.floor, math.ceil

------------------------------------------------------------
-- Functions
------------------------------------------------------------
function Filger.print(...)
    print("|cffff8000Filger|r", ...)
end

function Filger.warn(...)
    print("|cffffd100Filger WARNING|r", ...)
end

function Filger.error(...)
    print("|cffffa1a1Filger ERROR|r", ...)
end

-- format seconds to min/hour/day
local day, hour, minute = 86400, 3600, 60

function Filger.FormatTime(s)
    local v = tonumber(s) or 0

	if (v >= day) then
		return format("%dd", ceil(v / day))
	elseif (v >= hour) then
		return format("%dh", ceil(v / hour))
	elseif (v >= minute) then
		return format("%dm", ceil(v / minute))
	elseif (v >= minute / 12) then
		return floor(v)
	end

	return format("%.1f", v)
end
