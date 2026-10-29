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
        CreateSpellCooldown(183752),        -- Disrupt
        CreateSpellCooldown(179057),        -- Chaos Nova
        CreateSpellCooldown(217832),        -- Imprison

        -- Havoc
        CreateSpellCooldown(198589),        -- Blur
        CreateSpellCooldown(258925),        -- Fel Barrage
        CreateSpellCooldown(191427),        -- Metamorphosis (Havoc)
        CreateSpellCooldown(198013),        -- Eye Beam

        -- Vengeance
        CreateSpellCooldown(202137),        -- Sigil of Silence
        CreateSpellCooldown(202138),        -- Sigil of Chains
        CreateSpellCooldown(204021),        -- Fiery Brand
        CreateSpellCooldown(207407),        -- Soul Carver
        CreateSpellCooldown(263648),        -- Soul Barrier
        CreateSpellCooldown(320341),        -- Bulk Extraction
        CreateSpellCooldown(212084),        -- Fel Devastation

        CreateSpellCooldown(258860),        -- Essence Break
        CreateSpellCooldown(1234441),       -- Power Siphon
        CreateSpellCooldown(1241937),       -- Soul Immolation
        CreateSpellCooldown(1226339),       -- Spinning Death
        CreateSpellCooldown(1235552),       -- Sunder
        CreateSpellCooldown(1234195),       -- Void Nova
    },
    ["DEATHKNIGHT"] = {
        -- General
        CreateSpellCooldown(48707),         -- Anti-Magic Shell
        CreateSpellCooldown(61999),         -- Raise Ally
        CreateSpellCooldown(47528),         -- Mind Freeze
        CreateSpellCooldown(49576),         -- Death Grip
        CreateSpellCooldown(48265),         -- Death's Advance
        CreateSpellCooldown(49039),         -- Lichborne

        -- Talents
        CreateSpellCooldown(51052),         -- Anti-Magic Zone
        CreateSpellCooldown(108199),        -- Gorefiend's Grasp
        CreateSpellCooldown(221562),        -- Asphyxiate

        -- Blood
        CreateSpellCooldown(48743),         -- Death Pact
        CreateSpellCooldown(48792),         -- Icebound Fortitude
        CreateSpellCooldown(49028),         -- Dancing Rune Weapon
        CreateSpellCooldown(55233),         -- Vampiric Blood
        CreateSpellCooldown(219809),        -- Tombstone
        CreateSpellCooldown(1263569),       -- Abomination Limb

        -- Frost
        CreateSpellCooldown(47568),         -- Empower Rune Weapon
        CreateSpellCooldown(51271),         -- Pillar of Frost
        CreateSpellCooldown(152279),        -- Breath of Sindragosa
        CreateSpellCooldown(196770),        -- Remorseless Winter
        CreateSpellCooldown(279302),        -- Forstwyrm's  Fury

        -- Unholy
        CreateSpellCooldown(42650),         -- Army of the Dead
        CreateSpellCooldown(207289),        -- Unholy Assault
        CreateSpellCooldown(275699),        -- Apocalypse
        CreateSpellCooldown(1233448),       -- Dark Transformation
        -- CreateSpellCooldown(455395),        -- Rise Abomination

        CreateSpellCooldown(207167),        -- Blinding Sleet
        CreateSpellCooldown(205223),        -- Consumption
        CreateSpellCooldown(1263824),       -- Consumption
        CreateSpellCooldown(50977),         -- Death Gate
        CreateSpellCooldown(46585),         -- Raise Dead
        CreateSpellCooldown(439843),        -- Reaper's Mark
        CreateSpellCooldown(327574),        -- Sacrificial Pact
        CreateSpellCooldown(190778),        -- Sindragosa's Fury
        CreateSpellCooldown(390279),        -- Vile Contagion
        CreateSpellCooldown(212552),        -- Wraith Walk
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
        CreateSpellCooldown(106839),        -- Skull Bash
        CreateSpellCooldown(99),            -- Incapacitating Roar
        CreateSpellCooldown(132469),        -- Typhoon
        CreateSpellCooldown(106898),        -- Stampeding Roar

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
        CreateSpellCooldown(5217),          -- Tiger's Fury
        CreateSpellCooldown(106951),        -- Berserk
        CreateSpellCooldown(102543),        -- Incarnation: Avatar of Ashamane

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

        CreateSpellCooldown(155835),        -- Bristling Fur
        CreateSpellCooldown(274837),        -- Feral Frenzy
        CreateSpellCooldown(1243807),       -- Frantic Frenzy
        CreateSpellCooldown(22842),         -- Frenzied Regeneration
        CreateSpellCooldown(1261867),       -- Heart of the Wild
        CreateSpellCooldown(5211),          -- Mighty Bash
        CreateSpellCooldown(1253799),       -- Sundering Roar
        CreateSpellCooldown(252216),        -- Tiger Dash
    },
    ["EVOKER"] = {
        -- General
        CreateSpellCooldown(351338),        -- Quell
        CreateSpellCooldown(363916),        -- Obsidian Scales
        CreateSpellCooldown(370665),        -- Rescue
        CreateSpellCooldown(374227),        -- Zephyr
        CreateSpellCooldown(358385),        -- Landslide
        CreateSpellCooldown(374968),        -- Time Spiral
        CreateSpellCooldown(370553),        -- Tip the Scales

        -- Devastation
        CreateSpellCooldown(375087),        -- Dragonrage
        CreateSpellCooldown(357210),        -- Deep Breath

        -- Preservation
        CreateSpellCooldown(363534),        -- Rewind
        CreateSpellCooldown(359816),        -- Dream Flight
        CreateSpellCooldown(370960),        -- Emerald Communion
        CreateSpellCooldown(357170),        -- Time Dilation

        -- Augmentation
        CreateSpellCooldown(403631),        -- Breath of Eons
        CreateSpellCooldown(360827),        -- Blistering Scales

        CreateSpellCooldown(408233),        -- Bestow Weyrnstone
        CreateSpellCooldown(374251),        -- Cauterizing Flame
        CreateSpellCooldown(1259173),       -- Duplicate
        CreateSpellCooldown(1259174),       -- Duplicate
        CreateSpellCooldown(1259175),       -- Duplicate
        CreateSpellCooldown(390386),        -- Fury of the Aspects
        CreateSpellCooldown(358267),        -- Hover
        CreateSpellCooldown(372048),        -- Oppressing Roar
        CreateSpellCooldown(406732),        -- Spatial Paradox
        CreateSpellCooldown(370537),        -- Stasis
        CreateSpellCooldown(368970),        -- Tail Swipe
        CreateSpellCooldown(404977),        -- Time Skip
        CreateSpellCooldown(368412),        -- Time of Need
        CreateSpellCooldown(396286),        -- Upheaval
    },
    ["HUNTER"] = {
        -- General
        CreateSpellCooldown(186265),        -- Aspect of the Turtle
        CreateSpellCooldown(109304),        -- Exhilaration
        CreateSpellCooldown(264735),        -- Survival of the Fittest
        CreateSpellCooldown(5384),          -- Feign Death
        CreateSpellCooldown(186257),        -- Aspect of the Cheetah
        CreateSpellCooldown(147362),        -- Counter Shot
        CreateSpellCooldown(187707),        -- Muzzle
        CreateSpellCooldown(187650),        -- Freezing Trap
        CreateSpellCooldown(109248),        -- Binding Shot
        CreateSpellCooldown(19577),         -- Intimidation

        -- Beast Mastery
        CreateSpellCooldown(19574),         -- Bestial Wrath
        CreateSpellCooldown(359844),        -- Call of the Wild

        -- Marksmanship
        CreateSpellCooldown(288613),        -- Trueshot

        -- Survival
        CreateSpellCooldown(360952),        -- Coordinated Assault

        CreateSpellCooldown(131894),        -- A Murder of Crows
        CreateSpellCooldown(186289),        -- Aspect of the Eagle
        CreateSpellCooldown(321530),        -- Bloodshed
        CreateSpellCooldown(1261193),       -- Boomstick
        CreateSpellCooldown(186387),        -- Bursting Shot
        CreateSpellCooldown(199483),        -- Camouflage
        CreateSpellCooldown(375891),        -- Chakram
        CreateSpellCooldown(203415),        -- Fury of the Eagle
        CreateSpellCooldown(466904),        -- Harrier's Cry
        CreateSpellCooldown(236776),        -- High Explosive Trap
        CreateSpellCooldown(462031),        -- Implosive Trap
        CreateSpellCooldown(53271),         -- Master's Call
        CreateSpellCooldown(264667),        -- Primal Rage
        CreateSpellCooldown(53480),         -- Roar of Sacrifice
        CreateSpellCooldown(360966),        -- Spearhead
        CreateSpellCooldown(1250646),       -- Takedown
        CreateSpellCooldown(260243),        -- Volley
    },
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
        CreateSpellCooldown(2139),          -- Counterspell
        CreateSpellCooldown(342245),        -- Alter Time
        CreateSpellCooldown(113724),        -- Ring of Frost

        -- Arcane
        CreateSpellCooldown(365350),        -- Arcane Surge
        CreateSpellCooldown(321507),        -- Touch of the Magi
        CreateSpellCooldown(12051),         -- Evocation
        CreateSpellCooldown(205025),        -- Presence of Mind

        -- Fire
        CreateSpellCooldown(190319),        -- Combustion

        -- Frost
        CreateSpellCooldown(12472),         -- Icy Veins
        CreateSpellCooldown(84714),         -- Frozen Orb
        CreateSpellCooldown(235219),        -- Cold Snap

        CreateSpellCooldown(235870),        -- Alexstrasza's Fury
        CreateSpellCooldown(214634),        -- Ebonbolt
        CreateSpellCooldown(414658),        -- Ice Cold
        CreateSpellCooldown(66),            -- Invisibility
        CreateSpellCooldown(224968),        -- Mark of Aluneth
        CreateSpellCooldown(414664),        -- Mass Invisibility
        CreateSpellCooldown(383121),        -- Mass Polymorph
        CreateSpellCooldown(153561),        -- Meteor
        CreateSpellCooldown(205021),        -- Ray of Frost
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
        CreateSpellCooldown(115078),        -- Paralysis
        CreateSpellCooldown(119381),        -- Leg Sweep

        -- Mistweaver
        CreateSpellCooldown(115310),        -- Revival
        CreateSpellCooldown(116849),        -- Life Cocoon
        CreateSpellCooldown(197908),        -- Mana Tea
        CreateSpellCooldown(322118),        -- Invoke Yu'lon, the Jade Serpent
        CreateSpellCooldown(325197),        -- Invoke Chi-ji, The Red Crane
        CreateSpellCooldown(388193),        -- Faeline Stomp
        CreateSpellCooldown(388615),        -- Restoral
        CreateSpellCooldown(116680),        -- Thunder Focus Tea

        -- Brewmaster
        CreateSpellCooldown(119582, false), -- Purifiying Brew
        CreateSpellCooldown(132578),        -- Invoke Niuzao, the Black Ox
        CreateSpellCooldown(115399),        -- Black Ox Brew
        CreateSpellCooldown(322507),        -- Celestial Brew
        CreateSpellCooldown(115176),        -- Zen Meditation
        CreateSpellCooldown(325153),        -- Exploding Keg
        CreateSpellCooldown(387184),        -- Weapons of Order
        CreateSpellCooldown(1241059),       -- Celestial Infusion

        -- Windwalker
        CreateSpellCooldown(137639),        -- Storm, Earth, and Fire
        CreateSpellCooldown(123904),        -- Invoke Xuen, the White Tiger
        CreateSpellCooldown(122470),        -- Touch of Karma

        CreateSpellCooldown(325216),        -- Bonedust Brew
        CreateSpellCooldown(386276),        -- Bonedust Brew
        CreateSpellCooldown(443028),        -- Celestial Conduit
        CreateSpellCooldown(326860),        -- Fallen Order
        CreateSpellCooldown(196725),        -- Refreshing Jade Wind
        CreateSpellCooldown(392983),        -- Strike of the Windlord
        CreateSpellCooldown(152175),        -- Whirling Dragon Punch
        CreateSpellCooldown(1249625),       -- Zenith
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
        CreateSpellCooldown(31884),         -- Avenging Wrath
        CreateSpellCooldown(96231, false),  -- Rebuke
        CreateSpellCooldown(115750),        -- Blinding Light
        CreateSpellCooldown(375576),        -- Divine Toll

        -- Holy
        CreateSpellCooldown(498),           -- Divine Protection
        CreateSpellCooldown(31821),         -- Aura Mastery
        CreateSpellCooldown(114165, false), -- Holy Prism
        CreateSpellCooldown(148039, false), -- Barrier of Faith
        CreateSpellCooldown(200025, false), -- Beacon of Virtue
        CreateSpellCooldown(388007),        -- Blessim of Summer
        CreateSpellCooldown(216331),        -- Avenging Crusader

        -- Protection
        CreateSpellCooldown(31850),         -- Ardent Defender
        CreateSpellCooldown(86659),         -- Guardian of Ancient Kings
        CreateSpellCooldown(204018),        -- Blessing of Spellwarding
        CreateSpellCooldown(327193),        -- Moment of Glory
        CreateSpellCooldown(378974),        -- Bastion of Light
        CreateSpellCooldown(389539),        -- Sentinel
        CreateSpellCooldown(387174),        -- Eye of Tyr

        -- Retribution
        CreateSpellCooldown(403876),        -- Divine Protection
        CreateSpellCooldown(255937, false), -- Wake of Ashes
        CreateSpellCooldown(343721),        -- Final Reckoning
        CreateSpellCooldown(343527, false), -- Execution Sentence

        CreateSpellCooldown(190784),        -- Divine Steed
        CreateSpellCooldown(405397),        -- Hammer of Retribution
        CreateSpellCooldown(105809),        -- Holy Avenger
        CreateSpellCooldown(432459),        -- Holy Bulwark
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
        CreateSpellCooldown(73325),         -- Leap of Faith
        -- CreateSpellCooldown(108920),        -- Void Tendrils
        CreateSpellCooldown(108968),        -- Void Shift
        CreateSpellCooldown(120517),        -- Halo (Disciple / Holy)
        CreateSpellCooldown(120644),        -- Halo (Shadow)
        CreateSpellCooldown(205364),        -- Dominate Mind
        CreateSpellCooldown(373481, false), -- Power Word: Life
        CreateSpellCooldown(375901),        -- Mindgames

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
        CreateSpellCooldown(391109),        -- Dark Ascension
        CreateSpellCooldown(263165),        -- Void Torrent

        CreateSpellCooldown(472433),        -- Evangelism
        CreateSpellCooldown(265202),        -- Holy Word: Salvation
        CreateSpellCooldown(421453),        -- Ultimate Penitence
        CreateSpellCooldown(228260),        -- Voidform
    },
    ["ROGUE"] = {
        -- General
        CreateSpellCooldown(1766),          -- Kick
        CreateSpellCooldown(31224),         -- Cloak of Shadows
        CreateSpellCooldown(5277),          -- Evasion
        CreateSpellCooldown(1856),          -- Vanish
        CreateSpellCooldown(2094),          -- Blind
        CreateSpellCooldown(2983),          -- Sprint
        CreateSpellCooldown(114018),        -- Shroud of Concealment
        CreateSpellCooldown(57934),         -- Tricks of the Trade
        CreateSpellCooldown(36554),         -- Shadowstep

        -- Assassination
        CreateSpellCooldown(360194),        -- Deathmark

        -- Outlaw
        CreateSpellCooldown(13750),         -- Adrenaline Rush
        CreateSpellCooldown(51690),         -- Killing Spree

        -- Subtlety
        CreateSpellCooldown(121471),        -- Shadow Blades
        CreateSpellCooldown(185313),        -- Shadow Dance

        CreateSpellCooldown(315341),        -- Between the Eyes
        CreateSpellCooldown(271877),        -- Blade Rush
        CreateSpellCooldown(426591),        -- Goremaw's Bite
        CreateSpellCooldown(195457),        -- Grappling Hook
        CreateSpellCooldown(381989),        -- Keep It Rolling
        CreateSpellCooldown(385627),        -- Kingsbane
        CreateSpellCooldown(137619),        -- Marked for Death
        CreateSpellCooldown(1277933),       -- Preparation
        CreateSpellCooldown(107079),        -- Quaking Palm
        CreateSpellCooldown(315508),        -- Roll the Bones
        CreateSpellCooldown(1214909),       -- Roll the Bones
        CreateSpellCooldown(385408),        -- Sepsis
        CreateSpellCooldown(1298826),       -- Thistle Tea
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
        CreateSpellCooldown(57994),         -- Wind Shear
        CreateSpellCooldown(51514),         -- Hex
        CreateSpellCooldown(2825),          -- Bloodlust
        CreateSpellCooldown(32182),         -- Heroism
        CreateSpellCooldown(51490),         -- Thunderstorm

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
        CreateSpellCooldown(198838),        -- Eartheb Wall Totem
        CreateSpellCooldown(207399),        -- Ancestral Protection Totem

        -- Enhancement
        CreateSpellCooldown(51533),         -- Feral Spirit
        CreateSpellCooldown(114051),        -- Ascendance
        CreateSpellCooldown(197214),        -- Sundering
        CreateSpellCooldown(384352),        -- Doom Winds

        CreateSpellCooldown(556),           -- Astral Recall
        CreateSpellCooldown(305483),        -- Lightning Lasso
        CreateSpellCooldown(378081),        -- Nature's Swiftness
        CreateSpellCooldown(20608),         -- Reincarnation
        CreateSpellCooldown(58875),         -- Spirit Walk
        CreateSpellCooldown(383019),        -- Tranquil Air Totem
    },
    ["WARLOCK"] = {
        -- General
        CreateSpellCooldown(5484),          -- Howl of Terror
        CreateSpellCooldown(6789),          -- Mortal Coil
        CreateSpellCooldown(20707),         -- Soulstone
        CreateSpellCooldown(30283),         -- Shadowfury
        CreateSpellCooldown(48020),         -- Demonic Circle: Teleport
        CreateSpellCooldown(104773),        -- Unending Resolve
        CreateSpellCooldown(108416),        -- Dark Pact
        CreateSpellCooldown(333889),        -- Fel Domination

        -- Affliction
        CreateSpellCooldown(205180),        -- Summon Darkglare

        -- Demonology
        CreateSpellCooldown(265187),        -- Summon Demonic Tyrant
        CreateSpellCooldown(111898),        -- Grimoire: Felguard

        -- Destruction
        CreateSpellCooldown(1122),          -- Summon Infernal

        CreateSpellCooldown(698),           -- Ritual of Summoning
        CreateSpellCooldown(6353),          -- Soul Fire
        CreateSpellCooldown(29893),         -- Create Soulwell
        CreateSpellCooldown(205179),        -- Phantom Singularity
        CreateSpellCooldown(267171),        -- Demonic Strength
        CreateSpellCooldown(267217),        -- Nether Portal
        CreateSpellCooldown(328774),        -- Amplify Curse
        CreateSpellCooldown(342601),        -- Ritual of Doom
        CreateSpellCooldown(386696),        -- Decimating Bolt
        CreateSpellCooldown(386833),        -- Guillotine
        CreateSpellCooldown(386997),        -- Soul Rot
        CreateSpellCooldown(387976),        -- Dimensional Rift
        CreateSpellCooldown(417537),        -- Oblivion
        CreateSpellCooldown(1257052),       -- Dark Harvest
        CreateSpellCooldown(1271802),       -- Blight of Tongues
        CreateSpellCooldown(1276452),       -- Grimoire: Imp Lord
        CreateSpellCooldown(1276467),       -- Grimoire: Fel Ravager
        CreateSpellCooldown(1276672),       -- Summon Doomguard
    },
    ["WARRIOR"] = {
        -- Talent
        CreateSpellCooldown(3411),          -- Intervene
        CreateSpellCooldown(5246),          -- Intimidating Shout
        CreateSpellCooldown(6552),          -- Pummel
        CreateSpellCooldown(18499),         -- Berserker Rage
        CreateSpellCooldown(23920),         -- Spell Reflection
        CreateSpellCooldown(46968),         -- Shockwave
        CreateSpellCooldown(97462),         -- Rallying Cry
        CreateSpellCooldown(107570),        -- Storm Bolt
        CreateSpellCooldown(107574),        -- Avatar
        CreateSpellCooldown(376079),        -- Champion's Spear
        CreateSpellCooldown(383762),        -- Bitter Immunity
        CreateSpellCooldown(384318),        -- Thunderous Roar

        -- Arms
        CreateSpellCooldown(118038),        -- Die by the Sword
        CreateSpellCooldown(167105),        -- Colossus Smash
        CreateSpellCooldown(227847),        -- Bladestorm

        -- Fury
        CreateSpellCooldown(1719),          -- Recklessness
        CreateSpellCooldown(184364),        -- Enraged Regeneration

        -- Protection
        CreateSpellCooldown(871),           -- Shield Wall
        CreateSpellCooldown(12975),         -- Last Stand
        CreateSpellCooldown(228920),        -- Ravager
        CreateSpellCooldown(1160),          -- Demoralizing Shout

        CreateSpellCooldown(1161),          -- Challenging Shout
        CreateSpellCooldown(6544),          -- Heroic Leap
        CreateSpellCooldown(12323),         -- Piercing Howl
        CreateSpellCooldown(64382),         -- Shattering Throw
        CreateSpellCooldown(262161),        -- Warbreaker
        CreateSpellCooldown(384100),        -- Berserker Shout
        CreateSpellCooldown(384110),        -- Wrecking Throw
        CreateSpellCooldown(385059),        -- Odyn's Fury
        CreateSpellCooldown(385952),        -- Shield Charge
        CreateSpellCooldown(386071),        -- Disrupting Shout
        CreateSpellCooldown(392966),        -- Spell Block
        CreateSpellCooldown(1223268),       -- Neltharion's Fury
    }
}

AddCooldowns(data)
