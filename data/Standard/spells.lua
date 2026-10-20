local _, ns = ...

local CreateSpellPriority = ns.data.CreateSpellPriority
local AddSpells = ns.data.AddSpells

--------------------------------------------------
-- Retail
--------------------------------------------------
local data = {
    ["DEMONHUNTER"] = {
        -- Vengeance
        [203719] = CreateSpellPriority(6),       -- Demon Spikes
        [212988] = CreateSpellPriority(8),       -- Painbringer
        [258920] = CreateSpellPriority(8),       -- Immolation Aura
        [263648] = CreateSpellPriority(7),       -- Soul Barrier
        [391234] = CreateSpellPriority(8),       -- Soulmonger
    },
    ["DEATHKNIGHT"] = {
        -- Blood
        [48743] = CreateSpellPriority(5),        -- Death Pact
        [195181] = CreateSpellPriority(8),       -- Bone Shield
        [219809] = CreateSpellPriority(8),       -- Tombstone
        [194679] = CreateSpellPriority(8),       -- Rune Tap
    },
    ["DRUID"] = {
        -- All
        [22812] = CreateSpellPriority(2),       -- Barkskin

        -- Balance
        [48517] = CreateSpellPriority(5),        -- Elipse (Solar)
        [48518] = CreateSpellPriority(5),        -- Elipse (Lunar)
        [191034] = CreateSpellPriority(2),       -- Starfall
        
        -- Feral
        
        -- Guardian
        [192081] = CreateSpellPriority(6),       -- Ironfur
        
        -- Restoration
        [16870] = CreateSpellPriority(6),        -- Clearcasting
        [117679] = CreateSpellPriority(8),       -- Incarnetion
        [102342] = CreateSpellPriority(3),       -- Ironbark
        [102351] = CreateSpellPriority(2),       -- Cenarion Ward
    },
    ["HUNTER"] = {
        -- Marksmanship
        [260242] = CreateSpellPriority(7),       -- Precise Shot
        [342076] = CreateSpellPriority(7),       -- Streamline
    },
    ["MAGE"] = {
        [384267] = CreateSpellPriority(3),       -- Siphon Storm
    },
    ["MONK"] = {
        -- Mistweaver
        [432180] = CreateSpellPriority(false),   -- Dance of the Wind
        [388193] = CreateSpellPriority(10),      -- Jadefire Stomp

        -- Brewmaster
        [120954] = CreateSpellPriority(1),       -- Fortifying Brew
        [122278] = CreateSpellPriority(1),       -- Dampen Harm
        [122783] = CreateSpellPriority(1),       -- Diffuse Magic
        [322507] = CreateSpellPriority(3),       -- Celestial Brew
        [325092] = CreateSpellPriority(10),      -- Purified Chi
    },
    ["PALADIN"] = {
        -- Holy
        [216331] = CreateSpellPriority(1),       -- Avenging Crusader
        [388007] = CreateSpellPriority(1),       -- Blessing of Summer
        [388010] = CreateSpellPriority(1),       -- Blessing of Autumn
        [388011] = CreateSpellPriority(1),       -- Blessing of Winter
        [388013] = CreateSpellPriority(1),       -- Blessing of Spring
        [414204] = CreateSpellPriority(1),       -- Rising Sunlight
        [414273] = CreateSpellPriority(1),       -- Hand of Divinity

        -- Protection
        [642] = CreateSpellPriority(9),          -- Divine Shield
        [31850] = CreateSpellPriority(9),        -- Ardent Defender
        [86659] = CreateSpellPriority(9),        -- Guardian of Ancient Kings
        [31884] = CreateSpellPriority(8),        -- Avenging Wrath
        [132403] = CreateSpellPriority(8),       -- Shield of Righteous
        [432502] = CreateSpellPriority(7),       -- Sacred Weapon
        [432496] = CreateSpellPriority(7),       -- Holy Bulwark
        [432607] = CreateSpellPriority(7),       -- Holy Bulwark
        [400745] = CreateSpellPriority(false),   -- Afterimage
        [433550] = CreateSpellPriority(false),   -- Afterimage

        [387174] = CreateSpellPriority(7),       -- Eye of Tyr (target)
    },
    ["PRIEST"] = {
        -- All
        [586] = CreateSpellPriority(10),         -- Fade
        [10060] = CreateSpellPriority(7),        -- Power Infusion

        -- Discipline
        [33206] = CreateSpellPriority(10),       -- Pain Suppression
        [322105] = CreateSpellPriority(9),       -- Shadow Covenant
        [214621] = CreateSpellPriority(8),       -- Schism (Debuff)
        [455033] = CreateSpellPriority(7),       -- Darkness from Light
        [198069] = CreateSpellPriority(9),       -- Power of the Dark Side

        [428933] = CreateSpellPriority(10),      -- Premonition of Insight (-cooldown)
        [428930] = CreateSpellPriority(10),      -- Premonition of Piety (+ healing)
        [428934] = CreateSpellPriority(10),      -- Premonition of Solace (single heal to shield)

        -- Holy
        [47788] = CreateSpellPriority(10),       -- Guardian Spirit
        [200183] = CreateSpellPriority(3),       -- Apotheosis
        
        -- Shadow
        [47585] = CreateSpellPriority(10),       -- Dispersion
        [15286] = CreateSpellPriority(3),        -- Vampiric Embrace
        [194249] = CreateSpellPriority(10),      -- Voidform
        [391109] = CreateSpellPriority(10),      -- Dark Ascension
        [391401] = CreateSpellPriority(7),       -- Mind Flay: Insanity
        [391099] = CreateSpellPriority(8),       -- Dark Evangelism
        [373204] = CreateSpellPriority(8),       -- Mind Devourer
        [454638] = CreateSpellPriority(8),       -- Devouring Chorus
    },
    ["SHAMAN"] = {
        -- General
        [108270] = CreateSpellPriority(10),      -- Stone Bulwark Totem
        [108271] = CreateSpellPriority(10),      -- Astral Shift
        [192106] = CreateSpellPriority(false),   -- Lightning Shield
        [381684] = CreateSpellPriority(false),   -- Brimming with Life

        -- Enhancement
        [344179] = CreateSpellPriority(9),       -- Maelstrom Weapon
        [454015] = CreateSpellPriority(9),       -- Tempest
        [333957] = CreateSpellPriority(8),       -- Feral Spirit
        [466772] = CreateSpellPriority(7),       -- Doom Winds
        [470532] = CreateSpellPriority(7),       -- Arc Discharge
        [375986] = CreateSpellPriority(7),       -- Primordial Wave
        [187878] = CreateSpellPriority(7),       -- Crash Lightning
        [470058] = CreateSpellPriority(1),       -- Vulcanic Blaze
        [201900] = CreateSpellPriority(1),       -- Hot Hand
        [384411] = CreateSpellPriority(1),       -- Static Accumulation
        [455110] = CreateSpellPriority(1),       -- Supercharge
        [469344] = CreateSpellPriority(1),       -- Molten Thunder
        [224127] = CreateSpellPriority(false),   -- Crackling Surge
    },
    ["WARRIOR"] = {
        -- Protection
        [871] = CreateSpellPriority(1),          -- Shield Wall
        [12975] = CreateSpellPriority(1),        -- Last Stand
        [23920] = CreateSpellPriority(7),        -- Spell Reflect
        [132404] = CreateSpellPriority(9),       -- Shield Block
        [190456] = CreateSpellPriority(10),      -- Ignore Pain
    },
    ["ALL"] = {
        -- Items
        [449578] = CreateSpellPriority(false),   -- Deliberate Incubation (Ovi'nax Mercurial Egg)
        [449581] = CreateSpellPriority(false),   -- Reckless Incubation (Ovi'nax Mercurial Egg)
        [452226] = CreateSpellPriority(false),   -- Spiderling (Ara-Kara Sacbrood)
        [457925] = CreateSpellPriority(false),   -- Venomous Potential (Seal of the Poisoned Pact)
        [462513] = CreateSpellPriority(8, 1),    -- Severed Strands (Spymaster's Web)
        [449947] = CreateSpellPriority(20),      -- Realigning Nexus Convergence Divergence (Treacherous Transmitter)

        -- Consumables
        [431932] = CreateSpellPriority(5),       -- Tempered Potion
    }
}

AddSpells(data)

-- TODO: temporary load marker, remove when [Game] loading is verified
print("|cffff8000Filger|r data: Standard")
