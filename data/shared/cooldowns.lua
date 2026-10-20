local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local CreateSlotCooldown = ns.data.CreateSlotCooldown
local AddCooldowns = ns.data.AddCooldowns

local expansion = _G.LE_EXPANSION_LEVEL_CURRENT
local LE_EXPANSION_CLASSIC = _G.LE_EXPANSION_CLASSIC or 0
local LE_EXPANSION_BURNING_CRUSADE = _G.LE_EXPANSION_BURNING_CRUSADE or 1
local LE_EXPANSION_WRATH_OF_THE_LICH_KING = _G.LE_EXPANSION_WRATH_OF_THE_LICH_KING or 2
local LE_EXPANSION_CATACLYSM = _G.LE_EXPANSION_CATACLYSM or 3
local LE_EXPANSION_MISTS_OF_PANDARIA = _G.LE_EXPANSION_MISTS_OF_PANDARIA or 4
local LE_EXPANSION_WARLORDS_OF_DRAENOR = _G.LE_EXPANSION_WARLORDS_OF_DRAENOR or 5
local LE_EXPANSION_LEGION = _G.LE_EXPANSION_LEGION or 6
local LE_EXPANSION_BATTLE_FOR_AZEROTH = _G.LE_EXPANSION_BATTLE_FOR_AZEROTH or 7
local LE_EXPANSION_SHADOWLANDS = _G.LE_EXPANSION_SHADOWLANDS or 8
local LE_EXPANSION_DRAGONFLIGHT = _G.LE_EXPANSION_DRAGONFLIGHT or 9
local LE_EXPANSION_WAR_WITHIN = _G.LE_EXPANSION_WAR_WITHIN or 10
local LE_EXPANSION_MIDNIGHT = _G.LE_EXPANSION_MIDNIGHT or 11

local racials = {
    -- Horde
    CreateSpellCooldown(7744),          -- Will of the Forsaken (Undead)
    CreateSpellCooldown(20549),         -- War Stomp (Tauren)
    CreateSpellCooldown(20572),         -- Blood Fury (Orc)
    CreateSpellCooldown(26297),         -- Berserking (Troll)
    CreateSpellCooldown(28730, expansion >= LE_EXPANSION_BURNING_CRUSADE),  -- Arcane Torrent (Blood Elf)
    CreateSpellCooldown(255654, expansion >= LE_EXPANSION_LEGION),          -- Bull Rush (Highmountain Tauren)

    -- Alliance
    CreateSpellCooldown(20594),         -- Stoneform (Dwarf)
    CreateSpellCooldown(265221, expansion >= LE_EXPANSION_BATTLE_FOR_AZEROTH),  -- Fireblood Fury (Dark Iron Dwarf)
}

local gear = {
   CreateSlotCooldown(2),    -- Neck
   CreateSlotCooldown(6),    -- Waist
   CreateSlotCooldown(13),   -- Trinket 1
   CreateSlotCooldown(14),   -- Trinket 2 
}

-- racials and gear slots go after the player class cooldowns
AddCooldowns({ ["ALL"] = racials })
AddCooldowns({ ["ALL"] = gear })
