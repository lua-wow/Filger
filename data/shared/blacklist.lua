local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist
local In = ns.data.In

local EXPANSION = ns.client.expansion
local LE = ns.expansions

--------------------------------------------------
-- Black List
--------------------------------------------------
-- "name": also hide every aura sharing this spell's localized name (all ranks, new food buffs)
local general = {
    [430] = "name",                                                                 -- Drink
    [433] = "name",                                                                 -- Food
    [19705] = "name",                                                               -- Well Fed

    -- Lust
    [57723] = In(LE.Wrath),                                                         -- Exhaustion (Heroism)
    [57724] = In(LE.Wrath),                                                         -- Sated (Bloodlust)
    [80354] = In(LE.Mists),                                                         -- Temporal Displacement (Mage)
    [264689] = In(LE.Shadowlands),                                                  -- Fatigued (Hunter)
    [390435] = In(LE.Dragonflight),                                                 -- Exhaustion (Evoker - Fury of the Aspects)

    -- DEATHKNIGHT
    [48263] = In(LE.Wrath, LE.Mists),                                               -- Frost Presence (Blood Presence on Cata, Mists)
    [48265] = In(LE.Wrath, LE.Mists),                                               -- Unholy Presence
    [48266] = In(LE.Wrath, LE.Mists),                                               -- Blood Presence (Frost Presence on Cata, Mists)
    [55610] = In(LE.Wrath, LE.Mists),                                               -- Improved Icy Talons
    [57330] = In(LE.Wrath, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),          -- Horn of Winter

    -- DRUID
    [1126] = "name",                                                                -- Mark of the Wild
    [768] = true,                                                                   -- Cat Form
    [5487] = true,                                                                  -- Bear Form
    [24858] = true,                                                                 -- Moonkin Form
    [114282] = In(LE.Mists),                                                        -- Treant Form

    [5232] = In(LE.Classic, LE.Wrath),                                              -- Mark of the Wild (Rank 2)
    [6756] = In(LE.Classic, LE.Wrath),                                              -- Mark of the Wild (Rank 3)
    [5234] = In(LE.Classic, LE.Wrath),                                              -- Mark of the Wild (Rank 4)
    [8907] = In(LE.Classic, LE.Wrath),                                              -- Mark of the Wild (Rank 5)
    [9884] = In(LE.Classic, LE.Wrath),                                              -- Mark of the Wild (Rank 6)
    [9885] = In(LE.Classic, LE.Wrath),                                              -- Mark of the Wild (Rank 7)
    [26990] = In(LE.BurningCrusade, LE.Wrath),                                      -- Mark of the Wild (Rank 8)

    [782] = In(LE.Classic, LE.Wrath),                                               -- Thorns (Rank 2)
    [1075] = In(LE.Classic, LE.Wrath),                                              -- Thorns (Rank 3)
    [8914] = In(LE.Classic, LE.Wrath),                                              -- Thorns (Rank 4)
    [9756] = In(LE.Classic, LE.Wrath),                                              -- Thorns (Rank 5)
    [9910] = In(LE.Classic, LE.Wrath),                                              -- Thorns (Rank 6)
    [26992] = In(LE.BurningCrusade, LE.Wrath),                                      -- Thorns (Rank 7)

    [783] = true,                                                                   -- Travel Form
    [1066] = In(LE.Classic, LE.Mists),                                              -- Aquatic Form
    [9634] = In(LE.Classic, LE.Wrath),                                              -- Dire Bear Form
    [33943] = In(LE.BurningCrusade, LE.Mists),                                      -- Flight Form
    [40120] = In(LE.BurningCrusade, LE.Mists),                                      -- Swift Flight Form

    [21849] = In(LE.Classic, LE.Wrath) and "name",                                  -- Gift of the Wild
    [21850] = In(LE.Classic, LE.Classic),                                           -- Gift of the Wild (Rank 2)

    -- HUNTER
    [13165] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),        -- Aspect of the Hawk
    [13163] = In(LE.Classic, LE.Wrath),                                             -- Aspect of the Monkey

    -- MAGE
    [1459] = "name",                                                                -- Arcane Intellect

    [1460] = In(LE.Classic, LE.Wrath),                                              -- Arcane Intellect (Rank 2)
    [1461] = In(LE.Classic, LE.Wrath),                                              -- Arcane Intellect (Rank 3)
    [10156] = In(LE.Classic, LE.Wrath),                                             -- Arcane Intellect (Rank 4)
    [10157] = In(LE.Classic, LE.Wrath),                                             -- Arcane Intellect (Rank 5)
    [27126] = In(LE.BurningCrusade, LE.Wrath),                                      -- Arcane Intellect (Rank 6)

    [30482] = In(LE.BurningCrusade, LE.Wrath) and "name" or In(LE.Mists, LE.Mists), -- Molten Armor

    [61316] = In(LE.Wrath, LE.Mists),                                               -- Dalaran Brilliance

    [23028] = In(LE.Classic, LE.Wrath) and "name",                                  -- Arcane Brilliance

    [168] = In(LE.Classic, LE.Wrath) and "name",                                    -- Frost Armor
    [7300] = In(LE.Classic, LE.Classic),                                            -- Frost Armor (Rank 2)
    [7301] = In(LE.Classic, LE.Classic),                                            -- Frost Armor (Rank 3)

    [7302] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),         -- Ice Armor
    [7320] = In(LE.Classic, LE.Classic),                                            -- Ice Armor (Rank 2)
    [10219] = In(LE.Classic, LE.Classic),                                           -- Ice Armor (Rank 3)
    [10220] = In(LE.Classic, LE.Classic),                                           -- Ice Armor (Rank 4)

    [6117] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),         -- Mage Armor
    [22782] = In(LE.Classic, LE.Classic),                                           -- Mage Armor (Rank 2)
    [22783] = In(LE.Classic, LE.Classic),                                           -- Mage Armor (Rank 3)

    -- PALADIN
    [7294] = In(LE.Classic, LE.Cataclysm),                                          -- Retribution Aura
    [19746] = In(LE.Classic, LE.Cataclysm),                                         -- Concentration Aura
    [19891] = In(LE.Classic, LE.Cataclysm),                                         -- Resistance Aura
    [32223] = In(LE.BurningCrusade),                                                -- Crusader Aura

    [465] = In(LE.Classic, LE.Wrath) and "name",                                    -- Devotion Aura
    [25780] = In(LE.Classic, LE.Mists),                                             -- Righteous Fury
    [20217] = In(LE.Classic, LE.Mists),                                             -- Blessing of Kings
    [19740] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Cataclysm, LE.Mists),    -- Blessing of Might
    [19742] = In(LE.Classic, LE.Wrath) and "name",                                  -- Blessing of Wisdom
    [25782] = In(LE.Classic, LE.Wrath) and "name",                                  -- Greater Blessing of Might
    [25916] = In(LE.Classic, LE.Classic),                                           -- Greater Blessing of Might (Rank 2)
    [25894] = In(LE.Classic, LE.Wrath) and "name",                                  -- Greater Blessing of Wisdom
    [25918] = In(LE.Classic, LE.Classic),                                           -- Greater Blessing of Wisdom (Rank 2)
    [25898] = In(LE.Classic, LE.Wrath),                                             -- Greater Blessing of Kings
    [19899] = In(LE.Classic, LE.BurningCrusade),                                    -- Fire Resistance Aura (Rank 2)
    [19900] = In(LE.Classic, LE.BurningCrusade),                                    -- Fire Resistance Aura (Rank 3)
    [21084] = In(LE.Classic, LE.Wrath) and "name",                                  -- Seal of Righteousness

    -- PRIEST
    [1243] = In(LE.Classic, LE.Cataclysm) and "name",                               -- Power Word: Fortitude (Retail uses 21562)

    [25389] = In(LE.BurningCrusade, LE.Wrath),                                      -- Power Word: Fortitude (Rank 7)

    [21562] = In(LE.Classic, LE.Wrath) and "name" or true,                          -- Prayer of Fortitude (Power Word: Fortitude from Cata)
    [21564] = In(LE.Classic, LE.BurningCrusade),                                    -- Prayer of Fortitude (Rank 2)

    [976] = In(LE.Classic, LE.BurningCrusade),                                      -- Shadow Protection (Rank 1)
    [10957] = In(LE.Classic, LE.BurningCrusade),                                    -- Shadow Protection (Rank 2)

    [27683] = In(LE.Classic, LE.BurningCrusade),                                    -- Prayer of Shadow Protection

    [14819] = In(LE.Classic, LE.BurningCrusade),                                    -- Divine Spirit
    [27681] = In(LE.Classic, LE.BurningCrusade),                                    -- Prayer of Spirit (Rank 1)
    [32999] = In(LE.BurningCrusade, LE.Wrath),                                      -- Prayer of Spirit (Rank 2)
    [588] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),          -- Inner Fire
    [15473] = In(LE.Classic, LE.Mists),                                             -- Shadowform

    [1244] = In(LE.Classic, LE.Wrath),                                              -- Power Word: Fortitude (Rank 2)
    [1245] = In(LE.Classic, LE.Wrath),                                              -- Power Word: Fortitude (Rank 3)
    [2791] = In(LE.Classic, LE.Wrath),                                              -- Power Word: Fortitude (Rank 4)
    [10937] = In(LE.Classic, LE.Wrath),                                             -- Power Word: Fortitude (Rank 5)
    [10938] = In(LE.Classic, LE.Wrath),                                             -- Power Word: Fortitude (Rank 6)

    -- ROGUE
    [8679] = In(LE.Mists),                                                          -- Wound Poison
    [5761] = In(LE.Mists),                                                          -- Mind-numbing Poison

    -- SHAMAN
    [324] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),          -- Lightning Shield
    [24398] = In(LE.BurningCrusade, LE.Wrath) and "name",                           -- Water Shield

    -- Windfury Weapon has 3 IDs per rank on Era: cast, effect, and one with no class
    -- (R1 8232/8233/8234, R2 8235/8236/8237, R3 10486/10484/10488, R4 16362/16361/16363)
    [8232] = In(LE.Classic, LE.Classic) and "name",                                 -- Windfury Weapon

    [30809] = In(LE.Wrath, LE.Mists),                                               -- Unleashed Rage
    [51470] = In(LE.Wrath, LE.Mists),                                               -- Elemental Oath

    [52127] = In(LE.Mists),                                                         -- Water Shield

    -- WARLOCK
    [687] = In(LE.Classic, LE.Wrath),                                               -- Demon Skin (Rank 1)
    [696] = In(LE.Classic, LE.Wrath),                                               -- Demon Skin (Rank 2)

    [6307] = In(LE.Classic, LE.Wrath),                                              -- Blood Pact (Rank 1)
    [7804] = In(LE.Classic, LE.Wrath),                                              -- Blood Pact (Rank 2)
    [7805] = In(LE.Classic, LE.Wrath),                                              -- Blood Pact (Rank 3)
    [11766] = In(LE.Classic, LE.Wrath),                                             -- Blood Pact (Rank 4)
    [11767] = In(LE.Classic, LE.Wrath),                                             -- Blood Pact (Rank 5)
    [27268] = In(LE.BurningCrusade, LE.Wrath),                                      -- Blood Pact (Rank 6)

    [706] = In(LE.Classic, LE.Wrath) and "name",                                    -- Demon Armor
    [28176] = In(LE.BurningCrusade, LE.Wrath) and "name",                           -- Fel Armor

    -- WARRIOR
    [2457] = In(LE.Classic, LE.Mists),                                              -- Battle Stance
    [71] = In(LE.Classic, LE.Mists),                                                -- Defensive Stance
    [2458] = In(LE.Classic, LE.Mists),                                              -- Berserker Stance
    [6673] = In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),         -- Battle Shout
    [469] = In(LE.BurningCrusade, LE.Wrath) and "name" or In(LE.Mists, LE.Mists),   -- Commanding Shout

    -- Scrolls
    [8091] = In(LE.Classic, LE.BurningCrusade),                                     -- Armor (Scroll of Protection)
    [8094] = In(LE.Classic, LE.BurningCrusade),                                     -- Armor (Scroll of Protection II)
    [8095] = In(LE.Classic, LE.BurningCrusade),                                     -- Armor (Scroll of Protection III)
    [12175] = In(LE.Classic, LE.BurningCrusade),                                    -- Armor (Scroll of Protection IV)
    [33079] = In(LE.BurningCrusade, LE.Wrath),                                      -- Armor (Scroll of Protection V)

    [8096] = In(LE.Classic, LE.BurningCrusade),                                     -- Intellect (Scroll of Intellect)
    [8097] = In(LE.Classic, LE.BurningCrusade),                                     -- Intellect (Scroll of Intellect II)
    [8098] = In(LE.Classic, LE.BurningCrusade),                                     -- Intellect (Scroll of Intellect III)
    [12176] = In(LE.Classic, LE.BurningCrusade),                                    -- Intellect (Scroll of Intellect IV)
    [33078] = In(LE.BurningCrusade, LE.Wrath),                                      -- Intellect (Scroll of Intellect V)

    [8099] = In(LE.Classic, LE.BurningCrusade),                                     -- Stamina (Scroll of Stamina)
    [8100] = In(LE.Classic, LE.BurningCrusade),                                     -- Stamina (Scroll of Stamina II)
    [8101] = In(LE.Classic, LE.BurningCrusade),                                     -- Stamina (Scroll of Stamina III)
    [12178] = In(LE.Classic, LE.BurningCrusade),                                    -- Stamina (Scroll of Stamina IV)
    [33081] = In(LE.BurningCrusade, LE.Wrath),                                      -- Stamina (Scroll of Stamina V)

    [8112] = In(LE.Classic, LE.BurningCrusade),                                     -- Spirit Magic (Scroll of Spirit)
    [8113] = In(LE.Classic, LE.BurningCrusade),                                     -- Spirit Magic (Scroll of Spirit II)
    [8114] = In(LE.Classic, LE.BurningCrusade),                                     -- Spirit Magic (Scroll of Spirit III)
    [12177] = In(LE.Classic, LE.BurningCrusade),                                    -- Spirit Magic (Scroll of Spirit IV)
    [33080] = In(LE.BurningCrusade, LE.Wrath),                                      -- Spirit Magic (Scroll of Spirit V)

    [8115] = In(LE.Classic, LE.BurningCrusade),                                     -- Agility (Scroll of Agility)
    [8116] = In(LE.Classic, LE.BurningCrusade),                                     -- Agility (Scroll of Agility II)
    [8117] = In(LE.Classic, LE.BurningCrusade),                                     -- Agility (Scroll of Agility III)
    [12174] = In(LE.Classic, LE.BurningCrusade),                                    -- Agility (Scroll of Agility IV)
    [33077] = In(LE.BurningCrusade, LE.Wrath),                                      -- Agility (Scroll of Agility V)

    [8118] = In(LE.Classic, LE.BurningCrusade),                                     -- Strength (Scroll of Strength)
    [8119] = In(LE.Classic, LE.BurningCrusade),                                     -- Strength (Scroll of Strength II)
    [8120] = In(LE.Classic, LE.BurningCrusade),                                     -- Strength (Scroll of Strength III)
    [12179] = In(LE.Classic, LE.BurningCrusade),                                    -- Strength (Scroll of Strength IV)
    [33082] = In(LE.BurningCrusade, LE.Wrath),                                      -- Strength (Scroll of Strength V)

    -- Consumables
    [17629] = In(LE.Classic, LE.BurningCrusade),                                    -- Flask of Chromatic Resistance

    -- Reputation
    [17670] = In(LE.Classic, LE.BurningCrusade),                                    -- Agent Dawn Commission

    -- Christimas
    [26218] = In(LE.Classic, LE.BurningCrusade),                                    -- Mistletoe

    -- Hallowen
    [24755] = In(LE.Classic, LE.BurningCrusade),                                    -- Tricked or Treated

    -- Booms
    [15366] = In(LE.Classic, LE.Classic),                                           -- Songflower Serenade
    [22817] = In(LE.Classic, LE.Classic),                                           -- Fengus' Ferocity
    [22818] = In(LE.Classic, LE.Classic),                                           -- Mol'dar's Moxie
    [22820] = In(LE.Classic, LE.Classic),                                           -- Slip'kik's Savvy
    [22888] = In(LE.Classic, LE.Classic),                                           -- Rallying Cry of the Dragonslayer
    [355363] = In(LE.Classic, LE.Classic),                                          -- Rallying Cry of the Dragonslayer
    [23768] = In(LE.Classic, LE.Classic),                                           -- Sayge's Dark Fortune of Damage
    [24425] = In(LE.Classic, LE.Classic),                                           -- Spirit of Zandalar
    [11371] = In(LE.Classic, LE.Classic),                                           -- Gift of Arthas
    [355365] = In(LE.Classic, LE.Classic),                                          -- Spirit of Zandalar
    [16323] = In(LE.Classic, LE.Classic),                                           -- Juju Power
}

AddBlacklist(general)

--------------------------------------------------
-- Classic
--------------------------------------------------
local classic = {
    -- DRUID
    [1126] = true,                                           -- Mark of the Wild (Rank 1)

    [467] = In(LE.Classic, LE.Wrath),                        -- Thorns (Rank 1)

    [24907] = In(LE.Classic, LE.Mists),                      -- Moonkin Aura

    -- HUNTER
    [19506] = In(LE.Classic, LE.Mists),                      -- Trueshot Aura

    -- MAGE
    [1459] = true,                                           -- Arcane Intellect (Rank 1)

    -- ROGUE
    [1784] = false,                                          -- Stealth
    [2823] = true,                                           -- Deadly Poison
    [3408] = true,                                           -- Crippling Poison

    -- Consumables
    [673] = true,                                            -- Elixir of Minor Defense
    [2367] = true,                                           -- Elixir of Lion's Strength
    [2374] = true,                                           -- Elixir of Minor Agility
    [2378] = true,                                           -- Elixir of Minor Fortitude
    [3160] = true,                                           -- Elixir of Lesser Agility
    [3164] = true,                                           -- Elixir of Ogre's Strength
    [3166] = true,                                           -- Elixir of Wisdom
    [3220] = true,                                           -- Elixir of Defense
    [3593] = true,                                           -- Elixir of Fortitude
    [6512] = true,                                           -- Elixir of Detect Lesser Invisibility
    [7178] = true,                                           -- Elixir of Water Breathing
    [7844] = true,                                           -- Elixir of Fire Power
    [8212] = true,                                           -- Elixir of Giant Growth
    [11319] = true,                                          -- Elixir of Water Walking
    [11328] = true,                                          -- Elixir of Agility
    [11334] = true,                                          -- Elixir of Greater Agility
    [11348] = true,                                          -- Elixir of Superior Defense
    [11349] = true,                                          -- Elixir of Greater Defense
    [11389] = true,                                          -- Elixir of Detect Undead
    [11390] = true,                                          -- Arcane Elixir
    [11396] = true,                                          -- Elixir of Greater Intellect
    [11403] = true,                                          -- Elixir of Dream Vision
    [11405] = true,                                          -- Elixir of the Giants
    [11406] = true,                                          -- Elixir of Demonslaying
    [11407] = true,                                          -- Elixir of Detect Demon
    [11474] = true,                                          -- Elixir of Shadow Power
    [12608] = true,                                          -- Catseye Elixir
    [17535] = true,                                          -- Elixir of the Sages
    [17537] = true,                                          -- Elixir of Brute Force
    [17538] = true,                                          -- Elixir of the Mongoose
    [17539] = true,                                          -- Greater Arcane Elixir
    [21920] = true,                                          -- Elixir of Frost Power
    [22807] = false,                                         -- Elixir Greater Water Breathing
    [26276] = true,                                          -- Elixir of Greater Firepower
    [26677] = true,                                          -- Elixir of Poison Resistance

    [17624] = false,                                         -- Flask of Petrification
    [17626] = true,                                          -- Flask of the Titans
    [17627] = true,                                          -- Flask of Distilled Wisdom
    [17628] = true,                                          -- Flask od Supreme Power

    -- Costumes
    [8220] = true,                                           -- Flip Out!
    [8222] = true,                                           -- Yaaarrrr
    [16739] = true,                                          -- Orb of Deception

    -- Items
    [17619] = true,                                          -- Alchemist Stone
}

AddBlacklist(classic)

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
if EXPANSION >= LE.BurningCrusade then
    local data = {
        -- Events
        [44185] = true, -- Jack-o'-Lanterned!
    }

    AddBlacklist(data)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if EXPANSION >= LE.Wrath then
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
if EXPANSION >= LE.Cataclysm then
    local data = {
        -- WARLOCK
        [108503] = true, -- Grimoire of Sacrifice

        -- Items
        [93337] = true,  -- Champion of Ramkahen
        [93795] = true,  -- Stormwind Champion
        [93806] = true,  -- Darnassus Champion
        [93825] = true,  -- Orgrimmar Champion
        [93828] = true,  -- Silvermoon Champion
        [97341] = true,  -- Guild Champion

        -- Customes
        [74589] = true,  -- Identity Crisis (Faded Wizard Hat)
        [96312] = true,  -- Kalytha's Haunted Locket
    }

    AddBlacklist(data)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if EXPANSION >= LE.Mists then
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
if EXPANSION >= LE.Warlords then
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
if EXPANSION >= LE.Legion then
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
if EXPANSION >= LE.BattleForAzeroth then
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
if EXPANSION >= LE.Shadowlands then
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
if EXPANSION >= LE.Dragonflight then
    local data = {
        -- DEATHKNIGHT

        -- MONK
        [166646] = true, -- Windwalking

        -- PALADIN
        [465] = true,    -- Devotion Aura
        [32223] = true,  -- Crusader Aura

        -- PRIEST
        [280398] = true, -- Sins of the Many

        -- SHAMAN
        [395197] = true, -- Mana Spring

        -- WARRIOR
        [6673] = true,   -- Battle Shout
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
