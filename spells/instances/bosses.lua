local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- World Bosses
----------------------------------------------------------------

----------------------------------------------------------------
-- Pandaria
----------------------------------------------------------------
Instances[870] = {
    -- Kun-Lai Summit Summinit
        -- Sha of Anger
        { spellID = 134916, unit = "player", caster = "all", filter = "DEBUFF" },   -- Seethe
        { spellID = 119601, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bitter Thoughts
        { spellID = 119626, unit = "player", caster = "all", filter = "DEBUFF" },   -- Aggressive Behavior
        { spellID = 119488, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unleashed Wrath
    
    -- Valley of the Four Winds
        -- Salyis's Warband - Galleon
        { spellID = 121787, unit = "player", caster = "all", filter = "DEBUFF" },   -- Stomp
    
    -- Isle of Giants
        -- Oondasta
        { spellID = 137504, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crush
        { spellID = 138390, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tank Threat Multiplier
        { spellID = 138391, unit = "target", caster = "all", filter = "BUFF" },     -- Alpha Male
        { spellID = 137502, unit = "target", caster = "all", filter = "BUFF" },     -- Growing Fury
    
    -- Timeless Isle
        -- Chi-ji, The Red Crane
        { spellID = 144475, unit = "player", caster = "all", filter = "BUFF" },     -- Beacon of Hope
        -- Yu'lon, The Jade Serpent
        { spellID = 144630, unit = "player", caster = "all", filter = "BUFF" },     -- Jadeflame Buffet
        -- Niuzao, The Black Ox
        { spellID = 144611, unit = "target", caster = "all", filter = "BUFF" },     -- Massive Quake
        { spellID = 144606, unit = "target", caster = "all", filter = "BUFF" },     -- Oxen Fortitude
        -- Xuen, The White Tiger
        { spellID = 144631, unit = "target", caster = "all", filter = "BUFF" },     -- Agility
        { spellID = 144635, unit = "target", caster = "all", filter = "BUFF" },     -- Crackling Lightning
        -- Ordos, Fire-God of the Yaungol
        { spellID = 144689, unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Soul
        { spellID = 144699, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ancient Flame
        { spellID = 144693, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pool of Fire
}

----------------------------------------------------------------
-- Isle of Thunder
----------------------------------------------------------------
Instances[1064] = {
    -- Nalak, The Storm Lord
    { spellID = 136339, unit = "player", caster = "all", filter = "BUFF" },   -- Lightning Tether
    { spellID = 136340, unit = "player", caster = "all", filter = "BUFF" },   -- Stormcloud

    -- Champions
    { spellID = 138017, unit = "player", caster = "all", filter = "BUFF" },     -- Mogu Power
    { spellID = 138073, unit = "target", caster = "all", filter = "BUFF" },     -- Mantle of the Thunder King
    { spellID = 138079, unit = "target", caster = "all", filter = "BUFF" },     -- Mantle of the Thunder King
}

--[[ Warlords of Draenor ]]--
Instances[1116] = {}    -- Draenor
Instances[1191] = {}    -- Ashran
Instances[1464] = {}    -- Tanaan Jungle

--[[ Legion ]]--
Instances[1220] = {}    -- Broken Isles
Instances[1669] = {}    -- Argus
    
--[[ Battle for Azeroth ]]--
Instances[1642] = {}    -- Zandalar
Instances[1643] = {}    -- Kul Tiras