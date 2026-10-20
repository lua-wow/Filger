local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

local EXPANSION = _G.LE_EXPANSION_LEVEL_CURRENT or -1
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

--------------------------------------------------
-- Black List
--------------------------------------------------
local general = {
    ["Well Fed"] = true,
    ["Drink"] = true,
    ["Food"] = true,
 
    -- Lust
    [57723] = (EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING),   -- Exhaustion (Heroism)
    [57724] = (EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING),   -- Sated (Bloodlust)
    [80354] = (EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA),        -- Temporal Displacement (Mage)
    [264689] = (EXPANSION >= LE_EXPANSION_SHADOWLANDS),             -- Fatigued (Hunter)
    [390435] = (EXPANSION >= LE_EXPANSION_DRAGONFLIGHT),            -- Exhaustion (Evoker - Fury of the Aspects)

    -- DRUID
    ["Mark of the Wild"] = true,
    [1126] = true,                                              -- Mark of the Wild
    [768] = true,                                               -- Cat Form
    [5487] = true,                                              -- Bear Form
    [24858] = true,                                             -- Moonkin Form
    [114282] = (EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA),   -- Treant Form

    -- MAGE
    ["Arcane Intellect"] = true,

    -- PALADIN
    [7294] = (EXPANSION <= LE_EXPANSION_CATACLYSM),             -- Retribution Aura
    [19746] = (EXPANSION <= LE_EXPANSION_CATACLYSM),            -- Concentration Aura
    [19891] = (EXPANSION <= LE_EXPANSION_CATACLYSM),            -- Resistance Aura
    [32223] = (EXPANSION >= LE_EXPANSION_BURNING_CRUSADE),      -- Crusader Aura

    -- PRIEST
    ["Power Word: Fortitude"] = true,
}

AddBlacklist(general)

--------------------------------------------------
-- Classic
--------------------------------------------------
do
    local data = {
        -- DRUID
        [1126] = true,                                      -- Mark of the Wild (Rank 1)

        [467] = (EXPANSION < LE_EXPANSION_CATACLYSM),       -- Thorns (Rank 1)

        [24907] = (EXPANSION <= LE_EXPANSION_MISTS_OF_PANDARIA), -- Moonkin Aura

        -- HUNTER
        [19506] = (EXPANSION <= LE_EXPANSION_MISTS_OF_PANDARIA), -- Trueshot Aura

        -- MAGE
        [1459] = true,                                      -- Arcane Intellect (Rank 1)

        -- PALADIN
        [19740] = (EXPANSION <= LE_EXPANSION_MISTS_OF_PANDARIA), -- Blessing of Might

        -- ROGUE
        [1784] = false,                                     -- Stealth
        [2823] = true,                                      -- Deadly Poison
        [3408] = true,                                      -- Crippling Poison

        -- Consumables
        [673] = true,                                       -- Elixir of Minor Defense
        [2367] = true,                                      -- Elixir of Lion's Strength
        [2374] = true,                                      -- Elixir of Minor Agility
        [2378] = true,                                      -- Elixir of Minor Fortitude
        [3160] = true,                                      -- Elixir of Lesser Agility
        [3164] = true,                                      -- Elixir of Ogre's Strength
        [3166] = true,                                      -- Elixir of Wisdom
        [3220] = true,                                      -- Elixir of Defense
        [3593] = true,                                      -- Elixir of Fortitude
        [6512] = true,                                      -- Elixir of Detect Lesser Invisibility
        [7178] = true,                                      -- Elixir of Water Breathing
        [7844] = true,                                      -- Elixir of Fire Power
        [8212] = true,                                      -- Elixir of Giant Growth
        [11319] = true,                                     -- Elixir of Water Walking
        [11328] = true,                                     -- Elixir of Agility
        [11334] = true,                                     -- Elixir of Greater Agility
        [11348] = true,                                     -- Elixir of Superior Defense
        [11349] = true,                                     -- Elixir of Greater Defense
        [11389] = true,                                     -- Elixir of Detect Undead
        [11390] = true,                                     -- Arcane Elixir
        [11396] = true,                                     -- Elixir of Greater Intellect
        [11403] = true,                                     -- Elixir of Dream Vision
        [11405] = true,                                     -- Elixir of the Giants
        [11406] = true,                                     -- Elixir of Demonslaying
        [11407] = true,                                     -- Elixir of Detect Demon
        [11474] = true,                                     -- Elixir of Shadow Power
        [12608] = true,                                     -- Catseye Elixir
        [17535] = true,                                     -- Elixir of the Sages
        [17537] = true,                                     -- Elixir of Brute Force
        [17538] = true,                                     -- Elixir of the Mongoose
        [17539] = true,                                     -- Greater Arcane Elixir
        [21920] = true,                                     -- Elixir of Frost Power
        [22807] = false,                                    -- Elixir Greater Water Breathing
        [26276] = true,                                     -- Elixir of Greater Firepower
        [26677] = true,                                     -- Elixir of Poison Resistance

        [17624] = false,                                    -- Flask of Petrification
        [17626] = true,                                     -- Flask of the Titans
        [17627] = true,                                     -- Flask of Distilled Wisdom
        [17628] = true,                                     -- Flask od Supreme Power

        -- Costumes
        [8220] = true,                                      -- Flip Out!
        [8222] = true,                                      -- Yaaarrrr
        [16739] = true,                                     -- Orb of Deception

        -- Items
        [17619] = true,                                     -- Alchemist Stone
    }

    AddBlacklist(data)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_BURNING_CRUSADE then
    local data = {
        -- Events
        [44185] = true, -- Jack-o'-Lanterned!
    }

    AddBlacklist(data)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING then
    local data = {
        -- Items
        [72968] = true, -- Precious's Ribbon

        -- Dungeons
        [72221] = true, -- Luck of the Draw

        -- World Buffs
        [57940] = true, -- Essence of Wintergrasp
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_CATACLYSM then
    local data = {
        -- WARLOCK
        [108503] = true, -- Grimoire of Sacrifice

        -- Items
        [93337] = true, -- Champion of Ramkahen
        [93795] = true, -- Stormwind Champion
        [93806] = true, -- Darnassus Champion
        [93825] = true, -- Orgrimmar Champion
        [93828] = true, -- Silvermoon Champion
        [97341] = true, -- Guild Champion

        -- Customes
        [74589] = true, -- Identity Crisis (Faded Wizard Hat)
        [96312] = true, -- Kalytha's Haunted Locket
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA then
    local data = {
        -- HUNTER
        [109260] = true, -- Aspect of the Iron Hawk

        -- Items
        [105689] = true, -- Flask of Spring Blossoms
        [105691] = true, -- Flask of the Warn Sun
        [105694] = true, -- Flask of the Earth
        [105696] = true, -- Flask of Winter's Bite
        [126434] = true, -- Tushui Champion
        [127230] = true, -- Visions of Insanity

        -- Factions
        [119966] = true, -- Blessing of the Pearlfin

        -- Klaxxi
        [124529] = true, -- Iron Mantid (Enhancement)
        [123075] = true, -- Angel of Death (Enhancement)
        [127382] = true, -- Silent Lucidity (Enhancement)
        [127794] = true, -- Children of the Grave (Enhancement)
        [127375] = true, -- Speed King (Augmentation)
        [123219] = true, -- Battle Hymn (Augmentation)
        [123211] = true, -- Pain Killer (Augmentation)
        [127351] = true, -- Master of Puppets (Augmentation)

        -- World Buff
        [130609] = true, -- Valor of the Ancients

        -- Others
        [131493] = true, -- B.F.F
        [134522] = true, -- Dressed to Kill
        [114800] = true, -- Polyformic Acid Potion
        [110880] = true, -- 1st Place
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Warlords of Draenor
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_WARLORDS_OF_DRAENOR then
    local data = {
        -- World Buffs
        [186401] = true, -- Sign of the Skirmisher
        [186403] = true, -- Sign of Battle
        [186406] = true, -- Sign of the Critter

        -- ???
        [182422] = true, -- Training Gear
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Legion
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_LEGION then
    local data = {
        -- PvP
        [282559] = true, -- Enlisted

        -- Items
        [203533] = true, -- Black Icey Bling
        [227723] = true, -- Mana Diving Stone
        [245686] = true, -- Fashionable!
        [297871] = true, -- Anglers' Water Striders

        -- World Buffs
        [225787] = true, -- Sign of of Warrior
        [225788] = true, -- Sign of the Emissary

        -- Mythic+
        [206151] = true, -- Challenger's Burden
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Battle for Azeroth
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_BATTLE_FOR_AZEROTH then
    local data = {
        -- World Buffs
        [335148] = true, -- Sign of the Twisting Nether
        [335149] = true, -- Sign of the Scourge
        [335150] = true, -- Sign of the Destroyer
        [335151] = true, -- Sign of the Mists
        [335152] = true, -- Sign of Iron

        --------------------------------------------------
        -- Patch 8.1.0
        --------------------------------------------------
        [147728] = true, -- Severed Crimsonscale Head

        --------------------------------------------------
        -- Patch 8.2.0
        --------------------------------------------------
        [306600] = true, -- Experience Eliminated

        --------------------------------------------------
        -- Patch 8.3.0
        --------------------------------------------------
        -- Horric Visions
        [291295] = true, -- Mind Protected

        [307518] = true, -- Vision Hunter
        [312583] = true, -- Vision Hunter
        [312585] = true, -- Vision Hunter

        [305380] = true, -- Experimental Destabilization
        [305381] = true, -- Experimental Destabilization
        [305385] = true, -- Experimental Destabilization
        [312620] = true, -- Experimental Destabilization
        [312621] = true, -- Experimental Destabilization

        [304852] = true, -- Singular Sanitation Expertise
        [312545] = true, -- Singular Sanitation Expertise
        [312544] = true, -- Singular Sanitation Expertise
        [304853] = true, -- Singular Sanitation Expertise

        [312629] = true, -- Clear Sight
        [307519] = true, -- Clear Sight
        [312628] = true, -- Clear Sight

        [312456] = true, -- Elite Extermination
        [310720] = true, -- Elite Extermination
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Shadowlands
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_SHADOWLANDS then
    local data = {
        -- World Buffs
        [347600] = true, -- Infused Ruby Tracking
        [359082] = true, -- Sign of the Legion

        -- Items
        [345545] = true, -- Flayedwing Toxin
        [368510] = true, -- So'leash's Secret Technique
        [368512] = true, -- So'leash's Secret Technique
    }
    AddBlacklist(data)
end

--------------------------------------------------
-- Dragonflight
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_DRAGONFLIGHT then
    local data = {
        -- DEATHKNIGHT
        
        -- MONK
        [166646] = true, -- Windwalking

        -- PALADIN
        [465] = true, -- Devotion Aura
        [32223] = true,  -- Crusader Aura

        -- PRIEST
        [21562] = true, -- Power Word: Fortitude
        [280398] = true, -- Sins of the Many

        -- SHAMAN
        [395197] = true, -- Mana Spring

        -- WARRIOR
        [6673] = true, -- Battle Shout
        [202602] = true, -- Into the Fray

        -- Dragons Island
        [385081] = true, -- Unstable Blink
        [390493] = true, -- Cobalt Boost
        [394258] = true, -- Cobalt Cutthroat

        -- Forbiden Reach
        [405261] = true, -- Dragonscale's Favor
        [405263] = true, -- Iskaara's Favor
        [405264] = true, -- Maruukai's Favor
        [405265] = true, -- Valdrakken's Favor

        -- Zaralek Cavern
        [411060] = true, -- New Niffen No-Sniffin' Tonic

        -- Professions
        [382093] = true, -- Alchemically Inspired

        -- Items
        [399502] = true, -- Automically Recalibrated
        [401518] = true, -- Bronze Resonance (Ominous Chromatic Essence)
        [410762] = true, -- The Silent Star (Voice of the Silent Star)
        [391594] = true, -- Lemon Silverleaf Tea

        -- Tier Set
        [426262] = true, -- Larodar's Fiery Reverie (Priest Discipline / Holy)
        [426341] = true, -- Tindral's Fowl Fantasia (Priest Shadow)
        [426288] = true, -- Smolderon's Delusions of Gradeour

        -- WoW Remix
        [424143] = true, -- WoW Remix: Mists of Pandaria
        [440393] = true, -- Timerunner's Advantage
        [459337] = true, -- Timerunner's Mastery

        --------------------------------------------------
        -- Patch 10.0.2
        --------------------------------------------------
        -- World Buffs
        [397734] = true, -- Word of a Worthy Ally

        -- Professions
        [394006] = true, -- Rockin' Mining Gear

        --------------------------------------------------
        -- Patch 10.1.5
        --------------------------------------------------
        -- World Buffs
        [417275] = true, -- Greater Encapsulated Destiny

        -- Rifts
        [415603] = true, -- Encapsulated Destiny

        --------------------------------------------------
        -- Patch 10.1.7
        --------------------------------------------------
        -- Dreamsourge
        [415216] = true, -- Dreamsurge Heartbloom
        [415275] = true, -- Dreamsurge Hibernation
        [416101] = true, -- Dreamsurge Dreamfall
        [418630] = true, -- Dreamsurge Thunderbounce
        [418652] = true, -- Dreamsurge Wrathbloom
        [418656] = true, -- Dreamsurge Magpies
        [418694] = true, -- Dreamsurge Helpers
        [418744] = true, -- Dreamsurge Learnings
        [418769] = true, -- Dreamsurge Greenwalker
        [418810] = true, -- Dreamsurge Lone Wolves
        [418813] = true, -- Self Sufficient
        [418842] = true, -- Dreamsurge Pack Hunters
        [419079] = true, -- Dreamsurge Defenders
        [419081] = true, -- Dreamsurge Defenders
        [419239] = true, -- Dreaming Winds
        [419530] = true, -- Dreamsurge Thorncloak
        [426647] = true, -- Best Friends with Pip
        [426672] = true, -- Best Friends with Urctos
        [426676] = true, -- Best Friends with Aerwynn

        --------------------------------------------------
        -- Patch 10.2.0
        --------------------------------------------------
        -- World Buffs
        [420511] = true, -- Going Green

        --------------------------------------------------
        -- Patch 10.2.6
        --------------------------------------------------
        -- World Buffs
        [430666] = true, -- Sign of Awakened Storms
        [430668] = true, -- Sign of Awakened Embers
        [430669] = true, -- Sign of Awakened Dreams
    }

    AddBlacklist(data)
end
