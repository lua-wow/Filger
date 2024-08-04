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

function Filger.GetSpellInfo(spellID)
	if C_Spell and C_Spell.GetSpellInfo then
		return C_Spell.GetSpellInfo(spellID)
	else
		local name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = _G.GetSpellInfo(spellID)
		if name then
			return {
				name = name,
				iconID = icon,
				originalIconID = originalIcon,
				castTime = castTime,
				minRange = minRange,
				maxRange = maxRange,
				spellID = spellID,
				rank = rank
			}
		end
	end
end

function Filger.GetSpellCooldown(spellID)
	if C_Spell and C_Spell.GetSpellCooldown then
		return C_Spell.GetSpellCooldown(spellID)
	else
		local start, duration, enabled, modRate = _G.GetSpellCooldown(spellID)
		return {
			startTime = start,
			duration = duration,
			isEnabled = enabled,
			modRate = modRate
		}
	end
end
