local _, ns = ...
local Filger = ns.Filger

-- Blizzard
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo

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

-- Mine
local interface = Filger.interface
local isClassic = Filger.isClassic
local isBCC = Filger.isBCC
local isWrath = Filger.isWrath
local isCata = Filger.isCata

local import = function(source, dest)
    for spellId, enabled in next, source do
        if enabled then
            if type(spellId) == "string" then
                dest[spellId] = true
            else
                local data = GetSpellInfo(spellId)
                if data then
                    dest[spellId] = true
                else
                    Filger:warn("Blacklist", "Spell " .. spellId .. " do not exists.")
                end
            end
        end
    end
end

--------------------------------------------------
-- Black List
--------------------------------------------------
local blacklist = {}

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

import(general, blacklist)

--------------------------------------------------
-- Classic
--------------------------------------------------
do
    local data = {
        -- DRUID
        [1126] = true,                                      -- Mark of the Wild (Rank 1)
        [5232] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 2)
        [6756] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 3)
        [5234] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 4)
        [8907] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 5)
        [9884] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 6)
        [9885] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 7)
        [26990] = isBCC or isWrath,                         -- Mark of the Wild (Rank 8)
        [48469] = isWrath,                                  -- Mark of the Wild (Rank 9)

        [467] = (EXPANSION < LE_EXPANSION_DRAGONFLIGHT),    -- Thorns (Rank 1)
        [782] = isClassic or isBCC or isWrath,              -- Thorns (Rank 2)
        [1075] = isClassic or isBCC or isWrath,             -- Thorns (Rank 3)
        [8914] = isClassic or isBCC or isWrath,             -- Thorns (Rank 4)
        [9756] = isClassic or isBCC or isWrath,             -- Thorns (Rank 5)
        [9910] = isClassic or isBCC or isWrath,             -- Thorns (Rank 6)
        [26992] = isBCC or isWrath,                         -- Thorns (Rank 7)
        [53307] = isWrath,                                  -- Thorns (Rank 8)

        -- MAGE
        [1459] = true,                                      -- Arcane Intellect (Rank 1)
        [1460] = isClassic or isBCC or isWrath,             -- Arcane Intellect (Rank 2)
        [1461] = isClassic or isBCC or isWrath,             -- Arcane Intellect (Rank 3)
        [10156] = isClassic or isBCC or isWrath,            -- Arcane Intellect (Rank 4)
        [10157] = isClassic or isBCC or isWrath,            -- Arcane Intellect (Rank 5)
        [27126] = isBCC or isWrath,                         -- Arcane Intellect (Rank 6)
        [42995] = isWrath,                                  -- Arcane Intellect (Rank 7)

        -- PRIEST
        [1243] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 1)
        [1244] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 2)
        [1245] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 3)
        [2791] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 4)
        [10937] = isClassic or isBCC or isWrath,            -- Power Word: Fortitude (Rank 5)
        [10938] = isClassic or isBCC or isWrath,            -- Power Word: Fortitude (Rank 6)
        [25389] = isBCC or isWrath,                         -- Power Word: Fortitude (Rank 7)
        [48161] = isWrath,                                  -- Power Word: Fortitude (Rank 8)
        
        [21562] = isClassic,                                -- Prayer of Fortitude (Rank 1)
        [21564] = isClassic,                                -- Prayer of Fortitude (Rank 2)
        
        [27681] = isClassic,                                -- Prayer of Spirit

        -- WARLOCK
        [687] = isClassic or isBCC or isWrath or isCata,    -- Demon Skin (Rank 1)
        [696] = isClassic or isBCC or isWrath,              -- Demon Skin (Rank 2)

        [6307] = isClassic or isBCC or isWrath or isCata,   -- Blood Pact (Rank 1)
        [7804] = isClassic or isBCC or isWrath,             -- Blood Pact (Rank 2)
        [7805] = isClassic or isBCC or isWrath,             -- Blood Pact (Rank 3)
        [11766] = isClassic or isBCC or isWrath,            -- Blood Pact (Rank 4)
        [11787] = isClassic or isBCC or isWrath,            -- Blood Pact (Rank 5)
        [27267] = isBCC or isWrath,                         -- Blood Pact (Rank 6)
        [47982] = isWrath,                                  -- Blood Pact (Rank 7)

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
        [17629] = true,                                     -- Flask of Chromatic Resistance

        -- Scrolls
        [8091] = isClassic,                                 -- Armor (Scroll of Protection)
        [8094] = isClassic,                                 -- Armor (Scroll of Protection II)
        [8095] = isClassic,                                 -- Armor (Scroll of Protection III) 
        [12175] = isClassic,                                -- Armor (Scroll of Protection IV)
        [33079] = isBCC,                                    -- Armor (Scroll of Protection V)
        
        [8096] = isClassic,                                 -- Intellect (Scroll of Intellect)
        [8097] = isClassic,                                 -- Intellect (Scroll of Intellect II)
        [8098] = isClassic,                                 -- Intellect (Scroll of Intellect III)
        [12176] = isClassic,                                -- Intellect (Scroll of Intellect IV)
        [33078] = isBCC,                                    -- Intellect (Scroll of Intellect V)
        
        [8099] = isClassic,                                 -- Stamina (Scroll of Stamina)
        [8100] = isClassic,                                 -- Stamina (Scroll of Stamina II)
        [8101] = isClassic,                                 -- Stamina (Scroll of Stamina III)
        [12178] = isClassic,                                -- Stamina (Scroll of Stamina IV)
        [33081] = isBCC,                                    -- Stamina (Scroll of Stamina V)
        
        [8112] = isClassic,                                 -- Spirit Magic (Scroll of Spirit)
        [8113] = isClassic,                                 -- Spirit Magic (Scroll of Spirit II)
        [8114] = isClassic,                                 -- Spirit Magic (Scroll of Spirit III)
        [12177] = isClassic,                                -- Spirit Magic (Scroll of Spirit IV)
        [33080] = isBCC,                                    -- Spirit Magic (Scroll of Spirit V)
        
        [8115] = isClassic,                                 -- Agility (Scroll of Agility)
        [8116] = isClassic,                                 -- Agility (Scroll of Agility II)
        [8117] = isClassic,                                 -- Agility (Scroll of Agility III)
        [12174] = isClassic,                                -- Agility (Scroll of Agility IV)
        [33077] = isBCC,                                    -- Agility (Scroll of Agility V)
        
        [8118] = isClassic,                                 -- Strength (Scroll of Strength)
        [8119] = isClassic,                                 -- Strength (Scroll of Strength II)
        [8120] = isClassic,                                 -- Strength (Scroll of Strength III)
        [12179] = isClassic,                                -- Strength (Scroll of Strength IV)
        [33082] = isBCC,                                    -- Strength (Scroll of Strength V)

        -- Christimas
        [26218] = isClassic,                                -- Mistletoe

        --------------------------------------------------
        -- Season of Discovery
        --------------------------------------------------
        [349981] = isClassic,                           -- Supercharged Chronoboon
        [410935] = isClassic,                           -- Meditation on the Light
        [417316] = isClassic,                           -- Meditation on the Loa
        [418459] = isClassic,                           -- Meditation on Undeath
        [419307] = isClassic,                           -- Meditation on Elune
        [430947] = isClassic,                           -- Boon of Blackfathom (World Buff)
        [436412] = isClassic,                           -- Discoverer's Delight
    }

    import(data, blacklist)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
do
    local isBCC = Filger.isBCC
    local exists = (interface >= 20000)

    local data = {
        -- PRIEST
        [25431] = isBCC,                    -- Inner Fire (Rank 7)
        [32999] = isBCC,                    -- Prayer of Spirit (Rank 2)
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if Filger.isWrath then
    local data  = {
        -- PRIEST
        [48040] = isWrath,                  -- Inner Fire (Rank 8)
        [48168] = isWrath,                  -- Inner Fire (Rank 9)
        [48074] = isWrath,                  -- Prayer of Spirit (Rank 3)
    }

    import(data, blacklist)
end

if EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING then
    local data = {
        -- Items
        [72968] = true, -- Precious's Ribbon
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if Filger.isCata then
    local data = {
        -- PALADIN
        [79102] = true,                     -- Blessing of Might
        [20165] = true,                     -- Seal of Insight

        -- PRIEST
        [588] = true,                       -- Inner Fire
        [79107] = true,                     -- Shadow Protection
        [73413] = true,                     -- Inner Will
    }

    import(data, blacklist)
end

if EXPANSION >= LE_EXPANSION_CATACLYSM then
    local data = {
        [17619] = true, -- Alchemist Stone
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA then
    local data = {
        [297871] = true,                -- Anglers' Water Striders
    }
    import(data, blacklist)
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
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Legion
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_LEGION then
    local data = {
        -- Items
        [203533] = true, -- Black Icey Bling
        [227723] = true, -- Mana Diving Stone

        -- World Buffs
        [225787] = true, -- Sign of of Warrior
        [225788] = true, -- Sign of the Emissary
    }
    import(data, blacklist)
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
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Shadowlands
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_SHADOWLANDS then
    local data = {
        -- World Buffs
        [347600] = true, -- Infused Ruby Tracking
        [359082] = true, -- Sign of the Legion
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Dragonflight
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_DRAGONFLIGHT then
    local data = {
        -- DEATHKNIGHT
        
        -- MONK
        [166646] = true,                -- Windwalking

        -- PALADIN
        [465] = true,                   -- Devotion Aura
        [32223] = true,                 -- Crusader Aura

        -- PRIEST
        [21562] = true,                 -- Power Word: Fortitude
        [280398] = true,                -- Sins of the Many

        -- SHAMAN
        [395197] = true,                -- Mana Spring

        -- WARRIOR
        [6673] = true,                  -- Battle Shout
        [202602] = true,                -- Into the Fray

        -- Dragons Island
        [385081] = true,                -- Unstable Blink
        [390493] = true,                -- Cobalt Boost
        [394258] = true,                -- Cobalt Cutthroat

        -- Forbiden Reach
        [405261] = true,                -- Dragonscale's Favor
        [405263] = true,                -- Iskaara's Favor
        [405264] = true,                -- Maruukai's Favor
        [405265] = true,                -- Valdrakken's Favor

        -- Zaralek Cavern
        [411060] = true,                -- New Niffen No-Sniffin' Tonic

        -- Rifts
        [415603] = true,                -- Encapsulated Destiny

        -- Dreamsourge
        [415216] = true,                -- Dreamsurge Heartbloom
        [415275] = true,                -- Dreamsurge Hibernation
        [416101] = true,                -- Dreamsurge Dreamfall
        [418630] = true,                -- Dreamsurge Thunderbounce
        [418652] = true,                -- Dreamsurge Wrathbloom
        [418656] = true,                -- Dreamsurge Magpies
        [418694] = true,                -- Dreamsurge Helpers
        [418744] = true,                -- Dreamsurge Learnings
        [418769] = true,                -- Dreamsurge Greenwalker
        [418810] = true,                -- Dreamsurge Lone Wolves
        [418813] = true,                -- Self Sufficient
        [418842] = true,                -- Dreamsurge Pack Hunters
        [419079] = true,                -- Dreamsurge Defenders
        [419081] = true,                -- Dreamsurge Defenders
        [419239] = true,                -- Dreaming Winds
        [419530] = true,                -- Dreamsurge Thorncloak
        [426647] = true,                -- Best Friends with Pip
        [426672] = true,                -- Best Friends with Urctos
        [426676] = true,                -- Best Friends with Aerwynn
        [430666] = true,                -- Sign of Awakened Storms
        [430668] = true,                -- Sign of Awakened Embers
        [430669] = true,                -- Sign of Awakened Dreams

        -- World Buffs
        [397734] = true,                -- Word of a Worthy Ally
        [420511] = true,                -- Going Green

        -- Professions
        [382093] = true,                -- Alchemically Inspired

        -- Items
        [399502] = true,                -- Automically Recalibrated
        [401518] = true,                -- Bronze Resonance (Ominous Chromatic Essence)
        [410762] = true,                -- The Silent Star (Voice of the Silent Star)

        -- Tier Set
        [426262] = true,                -- Larodar's Fiery Reverie (Priest Discipline / Holy)
        [426341] = true,                -- Tindral's Fowl Fantasia (Priest Shadow)
        [426288] = true,                -- Smolderon's Delusions of Gradeour

        -- Extras
        [182422] = true,                -- Training Gear
        [391594] = true,                -- Lemon Silverleaf Tea

        -- WoW Remix
        [424143] = true,                -- WoW Remix: Mists of Pandaria
        [440393] = true,                -- Timerunner's Advantage
        [459337] = true,                -- Timerunner's Mastery

        -- Mythic+
        [206151] = true,                -- Challenger's Burden
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Retail
--------------------------------------------------
if Filger.isRetail then
    local data = {
        -- Classes
        -- DEMONHUNTER
        [452550] = true,                -- Monster Rising
        [453314] = true,                -- Enduring Torment

        -- EVOKER
        [369459] = true,                -- Source of Magic
        [381753] = true,                -- Blessing of the Bronze
        [372014] = true,                -- Visage

        -- DRUID
        [400734] = true,                -- After the Wildfire

        -- MONK
        [383733] = true,                -- Training of Niuzao
        [450552] = true,                -- Jade Walk
        [450572] = true,                -- Flow of Chi
        [450574] = true,                -- Flow of Chi

        -- PRIEST
        [21562] = true,                 -- Power Word: Fortitude

        -- SHAMAN
        [462854] = true,                -- Skyfury

        -- WARRIOR
        [386196] = true,                -- Berserker Stance

        -- Mount
        [404464] = true,                -- Flight Style: Skyriding
        [404468] = true,                -- Flight Style: Steady
        [456820] = true,                -- Ride Along

        -- Mythic+
        [206150] = true,                -- Challenger's Might

        -- Items
        [452226] = true,                -- Spiderling (Ara-Kara Sacbrood)
        [450699] = true,                -- "The 50 Verses of Radiance" (Tome of Light's Devotion)
        [450696] = true,                -- "The 50 Verses of Radiance" (Tome of Light's Devotion)
        [450720] = true,                -- Inner Radiance (Tome of Light's Devotion)
        [450706] = false,               -- Inner Radiance (Tome of Light's Devotion)
        [457925] = true,                -- Venomous Potential (Seal of the Poisoned Pact)
        [447962] = true,                -- Stance - Surekian Flourish
        [448036] = true,                -- Stance - Surekian Barrage
        [447978] = true,                -- Stance - Surekian Decimation
        [448433] = true,                -- Surekian Grace
        [345545] = true,                -- Flayedwing Toxin

        -- World Buffs
        [306600] = true,                -- Experience Eliminated
        [417275] = true,                -- Greater Encapsulated Destiny
        [452307] = true,                -- Sign of the Past
        [455020] = true,                -- WoW's Anniversary
        [471521] = true,                -- Sign of the Explorer
        
        -- Events
        [44185] = true,                 -- Jack-o'-Lanterned!
        [455050] = true,                -- Blessing of the brozen Drgonflight

        -- Warband
        [430191] = true,                -- Warband Mentored Leveling

        -- Costumes
        [8220] = true,                  -- Flip Out!
        [8222] = true,                  -- Yaaarrrr
        [16739] = true,                 -- Orb of Deception
        [74589] = true,                 -- Identity Crisis
        [96312] = true,                 -- Kalytha's Haunted Locket
        [147728] = true,                -- Severed Crimsonscale Head
        [245686] = true,                -- Fashionable!

        -- Professions
        [442981] = true,                -- Weaver's Tutelage
        [462810] = true,                -- Weaver's Prodigy

        -- Factions
        [442983] = true,                -- Vizier's Savvy
        [462806] = true,                -- Vizier's Supremacy
        [440645] = true,                -- Fire Flies
        [443248] = true,                -- Azj-Kahet Pheromones
        [462821] = true,                -- General's Bulwark

        -- Consumables
        ["Well Fed"] = true,
        ["Hearty Well Fed"] = true,
        [462210] = true,                -- Hearty Well Fed
        [431973] = true,                -- Flask of Tempered Versatility

        -- Delves
        [459254] = true,                -- Loader Signal
        [448868] = true,                -- Lucky Cursed Potion
        [459058] = true,                -- Miniature
        [459059] = true,                -- Massive
        [423852] = true,                -- Dormouse Ecila
    }

    import(data, blacklist)
end

Filger.blacklist = blacklist
