local _, ns = ...

-- Blizzard
local C_Secrets = _G.C_Secrets
local issecretvalue = _G.issecretvalue

------------------------------------------------------------
-- Compat
------------------------------------------------------------
-- spell shims and secret predicates, resolved once at load
local compat = {}

local never = function() return false end

-- Retail: tainted code can't list auras or read updateInfo while this is true
compat.AurasSecret = C_Secrets and C_Secrets.ShouldAurasBeSecret or never
compat.SpellAuraSecret = C_Secrets and C_Secrets.ShouldSpellAuraBeSecret or never
compat.SpellCooldownSecret = C_Secrets and C_Secrets.ShouldSpellCooldownBeSecret or never
compat.IsSecret = issecretvalue or never

function compat.GetSpellInfo(spellID)
	if C_Spell and C_Spell.GetSpellInfo then
		return C_Spell.GetSpellInfo(spellID)
	else
		local name, rank, icon, castTime, minRange, maxRange, id, originalIcon =_G.GetSpellInfo(spellID)
		if name then
			return {
				name = name,
				iconID = icon,
				originalIconID = originalIcon,
				castTime = castTime,
				minRange = minRange,
				maxRange = maxRange,
				spellID = id,
				rank = rank
			}
		end
	end
end

function compat.GetSpellCooldown(spellID)
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

ns.compat = compat
