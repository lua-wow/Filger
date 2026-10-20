local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Retail
--------------------------------------------------
local data = {
    ["DEMONHUNTER"] = {
        -- General
        CreateSpellCooldown(187827),        -- Metamorphosis
        CreateSpellCooldown(196718),        -- Darkness
        CreateSpellCooldown(204596),        -- Sigil of Flames
        CreateSpellCooldown(207684),        -- Sigil of Misery
        CreateSpellCooldown(370965),        -- The Hunt
        CreateSpellCooldown(390163),        -- Sigil of Spite

        -- Havoc
        CreateSpellCooldown(196555),        -- Netherwalk
        CreateSpellCooldown(198589),        -- Blur
        CreateSpellCooldown(258925),        -- Fel Barrage
        
        -- Vengeance
        CreateSpellCooldown(202137),        -- Sigil of Silence
        CreateSpellCooldown(202138),        -- Sigil of Chains
        CreateSpellCooldown(204021),        -- Fiery Brand
        CreateSpellCooldown(207407),        -- Soul Carver
        CreateSpellCooldown(263648),        -- Soul Barrier
        CreateSpellCooldown(320341),        -- Bulk Extraction
    },
    ["DEATHKNIGHT"] = {
        -- General
        CreateSpellCooldown(48707),         -- Anti-Magic Shell
        CreateSpellCooldown(61999),         -- Raise Ally

        -- Talents
        CreateSpellCooldown(51052),         -- Anti-Magic Zone
        
        -- Blood
        CreateSpellCooldown(48743),         -- Death Pact
        CreateSpellCooldown(48792),         -- Icebound Fortitude
        CreateSpellCooldown(49028),         -- Dancing Rune Weapon
        CreateSpellCooldown(55233),         -- Vampiric Blood
        CreateSpellCooldown(219809),        -- Tombstone
        CreateSpellCooldown(383269),        -- Abomination Limb
        
        -- Frost
        CreateSpellCooldown(47568),         -- Empower Rune Weapon
        CreateSpellCooldown(51271),         -- Pillar of Frost
        CreateSpellCooldown(152279),        -- Breath of Sindragosa
        CreateSpellCooldown(196770),        -- Remorseless Winter
        CreateSpellCooldown(279302),        -- Forstwyrm's  Fury
        
        -- Unholy
        CreateSpellCooldown(42650),         -- Army of the Dead
        CreateSpellCooldown(49206),         -- Summon Gargoyle
        CreateSpellCooldown(455395),        -- Rise Abomination
    },
    ["DRUID"] = {
        -- General
        CreateSpellCooldown(20484),         -- Rebirth
        CreateSpellCooldown(22812),         -- Barkskin
        
        -- Talents
        CreateSpellCooldown(29166),         -- Innervate
        CreateSpellCooldown(102359),        -- Mass Entanglement
        CreateSpellCooldown(102793),        -- Ursol's Vortex
        CreateSpellCooldown(108238),        -- Renewal
        CreateSpellCooldown(124974),        -- Mature's Vigil

        -- All
        CreateSpellCooldown(391528),        -- Convoke the Spirits

        -- Balance
        CreateSpellCooldown(78675),         -- Solar Beam
        CreateSpellCooldown(102560),        -- Incarnation: Chosen of Elune
        CreateSpellCooldown(194223),        -- Celestial Alignment
        CreateSpellCooldown(202425, false), -- Warrior of Elune
        CreateSpellCooldown(202770),        -- Fury of Elune
        CreateSpellCooldown(205636),        -- Force of Nature
        
        -- Feral
        
        -- Guardian
        CreateSpellCooldown(50334),         -- Berserkl: Ravage
        CreateSpellCooldown(61336),         -- Survival Instincts
        CreateSpellCooldown(80313),         -- Pulverize
        CreateSpellCooldown(102558),        -- Incarnation: Guardian of Ursoc
        CreateSpellCooldown(200851),        -- Rage of the Sleeper
        CreateSpellCooldown(204066),        -- Lunar Beam
        
        -- Restoration
        CreateSpellCooldown(740),           -- Tranquility
        CreateSpellCooldown(33891),         -- Incarnation: Tree of Life
        CreateSpellCooldown(102342),        -- Ironbark
        CreateSpellCooldown(132158),        -- Nature's Swiftness
        CreateSpellCooldown(203651),        -- Overgrowth
    },
    ["EVOKER"] = {},
    ["MAGE"] = {
        -- Talents
        CreateSpellCooldown(31661),         -- Dragon's Breath
        CreateSpellCooldown(45438),         -- Ice Block
        CreateSpellCooldown(55342),         -- Mirror Image
        CreateSpellCooldown(80353),         -- Time Warp
        CreateSpellCooldown(110959),        -- Greater Invisibilty
        CreateSpellCooldown(157980),        -- Supernova
        CreateSpellCooldown(382440),        -- Shifting Power
        CreateSpellCooldown(414660),        -- Mass Barrier
        
        -- Frost
        CreateSpellCooldown(12472),         -- Icy Veins
        CreateSpellCooldown(84714),         -- Frozen Orb
        CreateSpellCooldown(235219),        -- Cold Snap
    },
    ["MONK"] = {
        -- Talents
        CreateSpellCooldown(115203),        -- Fortifying Brew
        CreateSpellCooldown(116705),        -- Spear Hand Strike
        CreateSpellCooldown(116841, false), -- Tiger Lust
        CreateSpellCooldown(116844),        -- Ring of Peace
        CreateSpellCooldown(122278),        -- Dumpen Harm
        CreateSpellCooldown(122783),        -- Diffuse Magic
        CreateSpellCooldown(123986, false), -- Chi Burst
        CreateSpellCooldown(322109),        -- Touch of Death
        CreateSpellCooldown(324312, false), -- Clash

        -- Mistweaver
        CreateSpellCooldown(115310),         -- Revival
        CreateSpellCooldown(116849),         -- Life Cocoon
        CreateSpellCooldown(197908),         -- Mana Tea
        CreateSpellCooldown(322118),         -- Invoke Yu'lon, the Jade Serpent
        CreateSpellCooldown(325197),         -- Invoke Chi-ji, The Red Crane
        CreateSpellCooldown(388193),         -- Faeline Stomp
        CreateSpellCooldown(388615),         -- Restoral

        -- Brewmaster
        CreateSpellCooldown(119582, false), -- Purifiying Brew
        CreateSpellCooldown(132578),        -- Invoke Niuzao, the Black Ox
        CreateSpellCooldown(115399),        -- Black Ox Brew
        CreateSpellCooldown(322507),        -- Celestial Brew
        CreateSpellCooldown(115176),        -- Zen Meditation
        CreateSpellCooldown(325153),        -- Exploding Keg
        CreateSpellCooldown(387184),        -- Weapons of Order
        CreateSpellCooldown(1241059),       -- Celestial Infusion
    },
    ["PALADIN"] = {
        CreateSpellCooldown(633),           -- Lay on Hands
        CreateSpellCooldown(642),           -- Divine Shield
        CreateSpellCooldown(853),           -- Hammer of Justice
        CreateSpellCooldown(391054),        -- Intercession

        -- Talents
        CreateSpellCooldown(1022),          -- Blessing of Protection
        CreateSpellCooldown(1044),          -- Blessing of Freedom
        CreateSpellCooldown(6940),          -- Blessing of Sacrifice
        CreateSpellCooldown(31884),         -- Avenging Wrath (Holy)
        CreateSpellCooldown(96231, false),  -- Rebuke
        CreateSpellCooldown(115750),        -- Blinding Light
        CreateSpellCooldown(375576),        -- Divine Toll
        
        -- Holy
        CreateSpellCooldown(498),           -- Divine Protection
        CreateSpellCooldown(85222),         -- Aura Mastery
        CreateSpellCooldown(114165, false), -- Holy Prism
        CreateSpellCooldown(148039, false), -- Barrier of Faith
        CreateSpellCooldown(200025, false), -- Beacon of Virtue
        CreateSpellCooldown(200672),        -- Tyr's Deliverance
        CreateSpellCooldown(388007),        -- Blessim of Summer
        CreateSpellCooldown(414273),        -- Hand of Divinity
        
        -- Protection
        CreateSpellCooldown(31850),         -- Ardent Defender
        CreateSpellCooldown(86659),         -- Guardian of Ancient Kings
        CreateSpellCooldown(204018),        -- Blessing of Spellwarding
        CreateSpellCooldown(327193),        -- Moment of Glory
        CreateSpellCooldown(378974),        -- Bastion of Light
        CreateSpellCooldown(31884),         -- Sanctified Wrath
        CreateSpellCooldown(389539),        -- Sentinel
        CreateSpellCooldown(387174),        -- Eye of Tyr
        
        -- Retribution
        CreateSpellCooldown(403876),        -- Divine Protection
        CreateSpellCooldown(31884),         -- Avenging Wrath: Might
        CreateSpellCooldown(255937, false), -- Wake of Ashes
        CreateSpellCooldown(343721),        -- Final Reckoning
        CreateSpellCooldown(343527, false), -- Execution Sentence
    },
    ["PRIEST"] = {
        -- All
        CreateSpellCooldown(586, false),    -- Fade
        CreateSpellCooldown(8122, false),   -- Psychic Scream
        CreateSpellCooldown(19236),         -- Desperate Prayer

        -- Talents
        CreateSpellCooldown(10060),         -- Power Infusion
        CreateSpellCooldown(15286),         -- Vampiric Embrace
        CreateSpellCooldown(32375),         -- Mass Dispel
        CreateSpellCooldown(34433),         -- Shadowfiennd
        CreateSpellCooldown(73325),         -- Leap of Faith
        CreateSpellCooldown(108920),        -- Void Tendrils
        CreateSpellCooldown(108968),        -- Void Shift
        CreateSpellCooldown(120517),        -- Halo (Disciple / Holy)
        CreateSpellCooldown(120644),        -- Halo (Shadow)
        CreateSpellCooldown(205364),        -- Dominate Mind
        CreateSpellCooldown(373481, false), -- Power Word: Life

        -- Discipline
        CreateSpellCooldown(33206),         -- Pain Suppression
        CreateSpellCooldown(47536),         -- Rapture
        CreateSpellCooldown(62618),         -- Power Word: Barrier
        CreateSpellCooldown(271466),        -- Luminous Barrier
        CreateSpellCooldown(123040),        -- Mind Bender
        -- CreateSpellCooldown(246287),        -- Evangelism

        -- Holy
        CreateSpellCooldown(2050),          -- Holy Word: Serenity
        CreateSpellCooldown(34861),         -- Holy Word: Sanctify
        CreateSpellCooldown(47788),         -- Guardian Spirit
        CreateSpellCooldown(64843),         -- Divine Hymn
        CreateSpellCooldown(64901),         -- Symbol of Hope
        CreateSpellCooldown(88625),         -- Holy Word: Chastise
        CreateSpellCooldown(200183),        -- Apotheosis
        CreateSpellCooldown(372760),        -- Divine Word
        CreateSpellCooldown(372835),        -- Light Well

        -- Shadow
        CreateSpellCooldown(15487),         -- Silence
        CreateSpellCooldown(47585),         -- Dispersion
        CreateSpellCooldown(64044),         -- Psychic Horror
        CreateSpellCooldown(200174),        -- Mindbender
        CreateSpellCooldown(228260),        -- Void Eruption
        CreateSpellCooldown(391109),        -- Dark Ascension
    },
    ["SHAMAN"] = {
        -- General
        CreateSpellCooldown(8143),          -- Tremor Totem
        CreateSpellCooldown(79206),         -- Spiritwalker's Grace
        CreateSpellCooldown(108270),        -- Stone Bulwark Totem
        CreateSpellCooldown(108271),        -- Astral Shift
        CreateSpellCooldown(108281),        -- Ancestral Guidance
        CreateSpellCooldown(108285),        -- Totemic Recall
        CreateSpellCooldown(192058),        -- Capacitator Totem
        CreateSpellCooldown(192077),        -- Wind Rush Totem
        CreateSpellCooldown(198103),        -- Earth Elemental
        CreateSpellCooldown(383013),        -- Poison Cleansing Totem

        -- Elemental
        CreateSpellCooldown(114050),        -- Ascendance
        CreateSpellCooldown(191634),        -- Stormkeeper
        CreateSpellCooldown(192249),        -- Storm Elemental
        CreateSpellCooldown(198067),        -- Fire Elemental

        -- Restoration
        CreateSpellCooldown(16191),         -- Mana Tide Totem
        CreateSpellCooldown(98008),         -- Spirit Link Totem
        CreateSpellCooldown(108280),        -- Healing Tide Totem
        CreateSpellCooldown(114052),        -- Ascendance
        CreateSpellCooldown(157153),        -- Cloudburst Totem
        CreateSpellCooldown(198838),        -- Eartheb Wall Totem
        CreateSpellCooldown(207399),        -- Ancestral Protection Totem

        -- Enhancement
        CreateSpellCooldown(51533),         -- Feral Spirit
        CreateSpellCooldown(114051),        -- Ascendance
        CreateSpellCooldown(197214),        -- Sundering
        CreateSpellCooldown(384352),        -- Doom Winds
    },
    ["WARRIOR"] = {
        -- Talent
        CreateSpellCooldown(97462),         -- Rallying Cry
        -- CreateSpellCooldown(401150),        -- Avatar
        CreateSpellCooldown(384318),        -- Thunderous Roar
        CreateSpellCooldown(376079),        -- Champion's Spear
        
        -- Arms
        -- Fury
        -- Protection
        CreateSpellCooldown(871),           -- Shield Wall
        CreateSpellCooldown(12975),         -- Last Stand
        CreateSpellCooldown(228920),        -- Ravager
    }
}

AddCooldowns(data)
