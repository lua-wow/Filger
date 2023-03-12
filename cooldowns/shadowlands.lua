local _, ns = ...
local Config = ns.Config

------------------------------------------------------------
-- Shadowlands
------------------------------------------------------------
if (not ns.Filger.isShadowlands) then return end

local Cooldowns = {
    ["ALL"] = {
        -- Kyrian
        { spellID = 324739, check = false },            -- Summon Steward

        -- Ventyr
        { spellID = 323673, check = true },             -- Mindgames
        { spellID = 300728, check = true },             -- Door of Shadows

        -- Necrolords
        { spellID = 324143, check = true },             -- Conqueror's Banner
        { spellID = 324631, check = true },             -- Fleshcraft
    }
}

Config.Cooldowns:import(Cooldowns)
