local _, ns = ...
local Config = ns.Config

------------------------------------------------------------
-- Wrath of the Lich King
------------------------------------------------------------
if (not ns.Filger.isWOTLK) then return end

local Cooldowns = {
    ["PRIEST"] = {
        -- Talents
        { spellID = 6346, check = true },               -- Fear Ward
        { spellID = 32375, check = true },              -- Mass Dispel
        { spellID = 64901, check = true },              -- Hymn of Hope

        -- Disciplie
        { spellID = 10060, check = true },              -- Power Infusion
        { spellID = 14751, check = true },              -- Inner Focus
        { spellID = 33206, check = true },              -- Pain Suppression

        -- Holy
        { spellID = 47788, check = true },              -- Guardian Spirit
        { spellID = 64843, check = true },              -- Divine Hymn (Rank 1)

        -- Shadow
        { spellID = 15487, check = false },             -- Silence
        { spellID = 34433, check = true },              -- Shadowfiend
        { spellID = 47585, check = true }               -- Dispersion
    }
}

ns.Config.importCooldowns(Cooldowns)
