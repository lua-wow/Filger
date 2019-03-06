local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Battle for Azeroth Raids
----------------------------------------------------------------
-- Uldir
Instances[1861] = {
    --[[ Taloc ]]--
    { spellID = 270290, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blood Storm
}

Instances[2070] = {}    -- Battle of Dazar'alor