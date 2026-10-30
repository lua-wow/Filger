local _, ns = ...

local CreateSpellPriority = ns.data.CreateSpellPriority
local AddSpells = ns.data.AddSpells

--------------------------------------------------
-- Retail
--------------------------------------------------
local data = {
    ["DEMONHUNTER"] = {
        -- Havoc
        [162264] = CreateSpellPriority(9),     -- Metamorphosis
        [212800] = CreateSpellPriority(8),     -- Blur

        -- Vengeance
        [187827] = CreateSpellPriority(9),     -- Metamorphosis
        [203720] = CreateSpellPriority(6),     -- Demon Spikes
        [212988] = CreateSpellPriority(8),     -- Painbringer
        [258920] = CreateSpellPriority(8),     -- Immolation Aura
        [263648] = CreateSpellPriority(7),     -- Soul Barrier
        [391234] = CreateSpellPriority(8),     -- Soulmonger
    },
    ["DEATHKNIGHT"] = {
        -- Blood
        [48743] = CreateSpellPriority(5),      -- Death Pact
        [195181] = CreateSpellPriority(8),     -- Bone Shield
        [219809] = CreateSpellPriority(8),     -- Tombstone
        [194679] = CreateSpellPriority(8),     -- Rune Tap
        [81256] = CreateSpellPriority(9),      -- Dancing Rune Weapon
        [55233] = CreateSpellPriority(9),      -- Vampiric Blood

        -- All
        [48707] = CreateSpellPriority(9),      -- Anti-Magic Shell
        [48792] = CreateSpellPriority(9),      -- Icebound Fortitude

        -- Frost
        [51271] = CreateSpellPriority(9),      -- Pillar of Frost
        [152279] = CreateSpellPriority(9),     -- Breath of Sindragosa
        [47568] = CreateSpellPriority(8),      -- Empower Rune Weapon
        [51124] = CreateSpellPriority(7),      -- Killing Machine
        [59052] = CreateSpellPriority(7),      -- Rime
    },
    ["DRUID"] = {
        -- All
        [22812] = CreateSpellPriority(2),      -- Barkskin
        [61336] = CreateSpellPriority(9),      -- Survival Instincts

        -- Balance
        [48517] = CreateSpellPriority(5),      -- Elipse (Solar)
        [48518] = CreateSpellPriority(5),      -- Elipse (Lunar)
        [191034] = CreateSpellPriority(2),     -- Starfall
        [102560] = CreateSpellPriority(8),     -- Incarnation: Chosen of Elune
        [194223] = CreateSpellPriority(8),     -- Celestial Alignment

        -- Feral
        [106951] = CreateSpellPriority(8),     -- Berserk
        [5217] = CreateSpellPriority(7),       -- Tiger's Fury
        [135700] = CreateSpellPriority(6),     -- Clearcasting

        -- Guardian
        [192081] = CreateSpellPriority(6),     -- Ironfur
        [50334] = CreateSpellPriority(8),      -- Berserk

        -- Restoration
        [16870] = CreateSpellPriority(6),      -- Clearcasting
        [117679] = CreateSpellPriority(8),     -- Incarnetion
        [102342] = CreateSpellPriority(3),     -- Ironbark
        [102351] = CreateSpellPriority(2),     -- Cenarion Ward
    },
    ["EVOKER"] = {
        [359618] = CreateSpellPriority(6),     -- Essence Burst
        [363916] = CreateSpellPriority(9),     -- Obsidian Scales
        [370553] = CreateSpellPriority(7),     -- Tip the Scales
        [374349] = CreateSpellPriority(9),     -- Renewing Blaze
        [375087] = CreateSpellPriority(8),     -- Dragonrage
    },
    ["HUNTER"] = {
        -- All
        [186265] = CreateSpellPriority(10),    -- Aspect of the Turtle
        [264735] = CreateSpellPriority(9),     -- Survival of the Fittest

        -- Beast Mastery
        [19574] = CreateSpellPriority(8),      -- Bestial Wrath
        [268877] = CreateSpellPriority(6),     -- Beast Cleave

        -- Marksmanship
        [260242] = CreateSpellPriority(7),     -- Precise Shot
        [342076] = CreateSpellPriority(7),     -- Streamline
        [288613] = CreateSpellPriority(8),     -- Trueshot

        -- Survival
        [360952] = CreateSpellPriority(8),     -- Coordinated Assault
    },
    ["MAGE"] = {
        [384267] = CreateSpellPriority(3),     -- Siphon Storm
        [45438] = CreateSpellPriority(10),     -- Ice Block
        [342246] = CreateSpellPriority(8),     -- Alter Time

        -- Arcane
        [365362] = CreateSpellPriority(8),     -- Arcane Surge
        [263725] = CreateSpellPriority(6),     -- Clearcasting

        -- Fire
        [190319] = CreateSpellPriority(8),     -- Combustion
        [48108] = CreateSpellPriority(7),      -- Hot Streak!
        [48107] = CreateSpellPriority(6),      -- Heating Up

        -- Frost
        [12472] = CreateSpellPriority(8),      -- Icy Veins
        [44544] = CreateSpellPriority(7),      -- Fingers of Frost
        [190446] = CreateSpellPriority(7),     -- Brain Freeze
    },
    ["MONK"] = {
        -- All
        [101643] = CreateSpellPriority(1),     -- Transcendence

        -- Mistweaver
        [432180] = CreateSpellPriority(false), -- Dance of the Wind
        [388193] = CreateSpellPriority(10),    -- Jadefire Stomp

        -- Brewmaster
        [120954] = CreateSpellPriority(1),     -- Fortifying Brew
        [122278] = CreateSpellPriority(1),     -- Dampen Harm
        [122783] = CreateSpellPriority(1),     -- Diffuse Magic
        [322507] = CreateSpellPriority(3),     -- Celestial Brew
        [1260619] = CreateSpellPriority(3),    -- Elevated Stagger
        [325092] = CreateSpellPriority(10),    -- Purified Chi
        [1241059] = CreateSpellPriority(3),    -- Celestial Infusion

        -- Windwalker
        [137639] = CreateSpellPriority(8),     -- Storm, Earth, and Fire
        [125174] = CreateSpellPriority(9),     -- Touch of Karma
        [116768] = CreateSpellPriority(6),     -- Blackout Kick!
    },
    ["PALADIN"] = {
        -- Holy
        [216331] = CreateSpellPriority(1),     -- Avenging Crusader
        [388007] = CreateSpellPriority(1),     -- Blessing of Summer
        [388010] = CreateSpellPriority(1),     -- Blessing of Autumn
        [388011] = CreateSpellPriority(1),     -- Blessing of Winter
        [388013] = CreateSpellPriority(1),     -- Blessing of Spring
        [414204] = CreateSpellPriority(1),     -- Rising Sunlight
        [414273] = CreateSpellPriority(1),     -- Hand of Divinity

        -- Protection
        [642] = CreateSpellPriority(9),        -- Divine Shield
        [31850] = CreateSpellPriority(9),      -- Ardent Defender
        [86659] = CreateSpellPriority(9),      -- Guardian of Ancient Kings
        [31884] = CreateSpellPriority(8),      -- Avenging Wrath
        [132403] = CreateSpellPriority(8),     -- Shield of Righteous
        [432502] = CreateSpellPriority(7),     -- Sacred Weapon
        [432496] = CreateSpellPriority(7),     -- Holy Bulwark
        [432607] = CreateSpellPriority(7),     -- Holy Bulwark
        [400745] = CreateSpellPriority(false), -- Afterimage

        [387174] = CreateSpellPriority(7),     -- Eye of Tyr (target)

        -- Retribution
        [403876] = CreateSpellPriority(9),     -- Divine Protection
        [184662] = CreateSpellPriority(8),     -- Shield of Vengeance
        [223819] = CreateSpellPriority(6),     -- Divine Purpose
    },
    ["PRIEST"] = {
        -- All
        [586] = CreateSpellPriority(10),       -- Fade
        [10060] = CreateSpellPriority(7),      -- Power Infusion
        [19236] = CreateSpellPriority(9),      -- Desperate Prayer

        -- Discipline
        [33206] = CreateSpellPriority(10),     -- Pain Suppression
        [322105] = CreateSpellPriority(9),     -- Shadow Covenant
        [424509] = CreateSpellPriority(8),     -- Schism (Debuff)
        [455033] = CreateSpellPriority(7),     -- Darkness from Light
        [198069] = CreateSpellPriority(9),     -- Power of the Dark Side

        [428933] = CreateSpellPriority(10),    -- Premonition of Insight (-cooldown)
        -- [428930] = CreateSpellPriority(10),      -- Premonition of Piety (+ healing)
        [428934] = CreateSpellPriority(10),    -- Premonition of Solace (single heal to shield)

        -- Holy
        [47788] = CreateSpellPriority(10),     -- Guardian Spirit
        [200183] = CreateSpellPriority(3),     -- Apotheosis

        -- Shadow
        [47585] = CreateSpellPriority(10),     -- Dispersion
        [15286] = CreateSpellPriority(3),      -- Vampiric Embrace
        [194249] = CreateSpellPriority(10),    -- Voidform
        [391109] = CreateSpellPriority(10),    -- Dark Ascension
        [391401] = CreateSpellPriority(7),     -- Mind Flay: Insanity
        [391099] = CreateSpellPriority(8),     -- Dark Evangelism
        [373204] = CreateSpellPriority(8),     -- Mind Devourer
        [454638] = CreateSpellPriority(8),     -- Devouring Chorus
    },
    ["ROGUE"] = {
        [31224] = CreateSpellPriority(10),     -- Cloak of Shadows
        [5277] = CreateSpellPriority(10),      -- Evasion
        [1966] = CreateSpellPriority(9),       -- Feint
        [11327] = CreateSpellPriority(8),      -- Vanish
        [2983] = CreateSpellPriority(5),       -- Sprint
        [315496] = CreateSpellPriority(4),     -- Slice and Dice

        -- Outlaw
        [13750] = CreateSpellPriority(8),      -- Adrenaline Rush

        -- Subtlety
        [121471] = CreateSpellPriority(8),     -- Shadow Blades
        [185422] = CreateSpellPriority(8),     -- Shadow Dance
    },
    ["SHAMAN"] = {
        -- General
        [108270] = CreateSpellPriority(10),    -- Stone Bulwark Totem
        [108271] = CreateSpellPriority(10),    -- Astral Shift
        [192106] = CreateSpellPriority(false), -- Lightning Shield
        [381684] = CreateSpellPriority(false), -- Brimming with Life

        -- Elemental
        [114050] = CreateSpellPriority(8),     -- Ascendance
        [191634] = CreateSpellPriority(8),     -- Stormkeeper
        [77762] = CreateSpellPriority(7),      -- Lava Surge

        -- Restoration
        [53390] = CreateSpellPriority(5),      -- Tidal Waves

        -- Enhancement
        [344179] = CreateSpellPriority(9),     -- Maelstrom Weapon
        [454015] = CreateSpellPriority(9),     -- Tempest
        [333957] = CreateSpellPriority(8),     -- Feral Spirit
        [466772] = CreateSpellPriority(7),     -- Doom Winds
        [470532] = CreateSpellPriority(7),     -- Arc Discharge
        [375986] = CreateSpellPriority(7),     -- Primordial Wave
        [187878] = CreateSpellPriority(7),     -- Crash Lightning
        -- [470058] = CreateSpellPriority(1),       -- Vulcanic Blaze
        [201900] = CreateSpellPriority(1),     -- Hot Hand
        [384411] = CreateSpellPriority(1),     -- Static Accumulation
        [455110] = CreateSpellPriority(1),     -- Supercharge
        [469344] = CreateSpellPriority(1),     -- Molten Thunder
        [224127] = CreateSpellPriority(false), -- Crackling Surge
    },
    ["WARLOCK"] = {
        [104773] = CreateSpellPriority(10),    -- Unending Resolve
        [108416] = CreateSpellPriority(9),     -- Dark Pact

        -- Demonology
        [264173] = CreateSpellPriority(7),     -- Demonic Core

        -- Destruction
        [117828] = CreateSpellPriority(6),     -- Backdraft
    },
    ["WARRIOR"] = {
        -- All
        [107574] = CreateSpellPriority(8),     -- Avatar
        [18499] = CreateSpellPriority(6),      -- Berserker Rage
        [97463] = CreateSpellPriority(8),      -- Rallying Cry
        [52437] = CreateSpellPriority(7),      -- Sudden Death

        -- Arms
        [118038] = CreateSpellPriority(10),    -- Die by the Sword

        -- Fury
        [1719] = CreateSpellPriority(8),       -- Recklessness
        [184364] = CreateSpellPriority(10),    -- Enraged Regeneration
        [184362] = CreateSpellPriority(5),     -- Enrage

        -- Protection
        [871] = CreateSpellPriority(1),        -- Shield Wall
        [12975] = CreateSpellPriority(1),      -- Last Stand
        [23920] = CreateSpellPriority(7),      -- Spell Reflect
        [132404] = CreateSpellPriority(9),     -- Shield Block
        [190456] = CreateSpellPriority(10),    -- Ignore Pain
    },
    ["ALL"] = {
        -- Items
        [449578] = CreateSpellPriority(false), -- Deliberate Incubation (Ovi'nax Mercurial Egg)
        [449581] = CreateSpellPriority(false), -- Reckless Incubation (Ovi'nax Mercurial Egg)
        [452226] = CreateSpellPriority(false), -- Spiderling (Ara-Kara Sacbrood)
        [457925] = CreateSpellPriority(false), -- Venomous Potential (Seal of the Poisoned Pact)
        [462513] = CreateSpellPriority(8, 1),  -- Severed Strands (Spymaster's Web)
        [449947] = CreateSpellPriority(20),    -- Realigning Nexus Convergence Divergence (Treacherous Transmitter)
        [1219102] = CreateSpellPriority(8),    -- Mudborne (trinket)

        -- Consumables
        [431932] = CreateSpellPriority(5),     -- Tempered Potion
    }
}

AddSpells(data)
