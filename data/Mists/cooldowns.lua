local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Mists of Pandaria Classic
--------------------------------------------------
local data = {
    ["DRUID"] = {
        -- General
        CreateSpellCooldown(740),    -- Tranquility
        CreateSpellCooldown(20484),  -- Rebirth
        CreateSpellCooldown(22812),  -- Barkskin
        CreateSpellCooldown(29166),  -- Innervate
        CreateSpellCooldown(106898), -- Stampeding Roar

        -- Talents
        CreateSpellCooldown(102351), -- Cenarion Ward
        CreateSpellCooldown(108238), -- Renewal
        CreateSpellCooldown(132158), -- Nature's Swiftness
        CreateSpellCooldown(99),     -- Disorienting Roar
        CreateSpellCooldown(102359), -- Mass Entanglement
        CreateSpellCooldown(102793), -- Ursol's Vortex
        CreateSpellCooldown(132469), -- Typhoon
        CreateSpellCooldown(124974), -- Nature's Vigil

        -- Balance
        CreateSpellCooldown(78675),  -- Solar Beam
        CreateSpellCooldown(112071), -- Celestial Alignment
        CreateSpellCooldown(102560), -- Incarnation: Chosen of Elune
        CreateSpellCooldown(48505),  -- Starfall

        -- Guardian / Feral
        CreateSpellCooldown(61336),  -- Survival Instincts
        CreateSpellCooldown(102795), -- Bear Hug
        CreateSpellCooldown(106922), -- Might of Ursoc
        CreateSpellCooldown(106952), -- Berkserk
        CreateSpellCooldown(106839), -- Skull Bash
        CreateSpellCooldown(5217),   -- Tiger's Fury
        CreateSpellCooldown(102543), -- Incarnation: King of the Jungle
        CreateSpellCooldown(102558), -- Incarnation: Son of Ursoc

        -- Restoration
        CreateSpellCooldown(102342), -- Ironbark
        CreateSpellCooldown(33891),  -- Incarnation: Tree of Life

        CreateSpellCooldown(1850),   -- Dash
        CreateSpellCooldown(5229),   -- Enrage
        CreateSpellCooldown(108288), -- Heart of the Wild
        CreateSpellCooldown(106731), -- Incarnation
        CreateSpellCooldown(5211),   -- Mighty Bash
        CreateSpellCooldown(16689),  -- Nature's Grasp
    },
    ["DEATHKNIGHT"] = {
        CreateSpellCooldown(57330),  -- Horn of Winter
        CreateSpellCooldown(48792),  -- Icebound Fortitude
        CreateSpellCooldown(48707),  -- Anti-Magic Shell
        CreateSpellCooldown(49028),  -- Dancing Rune Weapon
        CreateSpellCooldown(49039),  -- Lichborne
        CreateSpellCooldown(55233),  -- Vampiric Blood
        CreateSpellCooldown(42650),  -- Army of the Dead
        CreateSpellCooldown(108200), -- Remorseless Winter
        CreateSpellCooldown(47528),  -- Mind Freeze
        CreateSpellCooldown(49576),  -- Death Grip
        CreateSpellCooldown(47476),  -- Strangulate
        CreateSpellCooldown(61999),  -- Raise Ally
        CreateSpellCooldown(47568),  -- Empower Rune Weapon
        CreateSpellCooldown(48743),  -- Death Pact
        CreateSpellCooldown(51052),  -- Anti-Magic Zone
        CreateSpellCooldown(108199), -- Gorefiend's Grasp
        CreateSpellCooldown(96268),  -- Death's Advance
        CreateSpellCooldown(49222),  -- Bone Shield
        CreateSpellCooldown(51271),  -- Pillar of Frost
        CreateSpellCooldown(49206),  -- Summon Gargoyle
        CreateSpellCooldown(77575),  -- Outbreak

        CreateSpellCooldown(50034),  -- Blood Rites
        CreateSpellCooldown(77606),  -- Dark Simulacrum
        CreateSpellCooldown(50977),  -- Death Gate
        CreateSpellCooldown(108201), -- Desecrated Ground
        CreateSpellCooldown(47481),  -- Gnaw
        CreateSpellCooldown(91800),  -- Gnaw
        CreateSpellCooldown(91797),  -- Monstrous Blow
        CreateSpellCooldown(46584),  -- Raise Dead
        CreateSpellCooldown(115989), -- Unholy Blight
        CreateSpellCooldown(49016),  -- Unholy Frenzy
    },
    ["HUNTER"] = {
        CreateSpellCooldown(19263),  -- Deterrence
        CreateSpellCooldown(5384),   -- Feign Death
        CreateSpellCooldown(1499),   -- Freezing Trap
        CreateSpellCooldown(34477),  -- Misdirection
        CreateSpellCooldown(147362), -- Counter Shot
        CreateSpellCooldown(3045),   -- Rapid Fire
        CreateSpellCooldown(19574),  -- Bestial Wrath

        -- Talents
        CreateSpellCooldown(34490),  -- Silencing Shot
        CreateSpellCooldown(19386),  -- Wyvern Sting
        CreateSpellCooldown(109248), -- Binding Shot
        CreateSpellCooldown(120679), -- Dire Beast
        CreateSpellCooldown(131894), -- A Murder of Crows
        CreateSpellCooldown(121818), -- Stampede

        CreateSpellCooldown(1742),   -- Cower
        CreateSpellCooldown(4167),   -- Web
        CreateSpellCooldown(19577),  -- Intimidation
        CreateSpellCooldown(24604),  -- Furious Howl
        CreateSpellCooldown(26064),  -- Shell Shield
        CreateSpellCooldown(50245),  -- Pin
        CreateSpellCooldown(50318),  -- Serenity Dust
        CreateSpellCooldown(50479),  -- Nether Shock
        CreateSpellCooldown(50519),  -- Sonic Blast
        CreateSpellCooldown(50541),  -- Clench
        CreateSpellCooldown(51753),  -- Camouflage
        CreateSpellCooldown(53271),  -- Master's Call
        CreateSpellCooldown(53401),  -- Rabid
        CreateSpellCooldown(53478),  -- Last Stand
        CreateSpellCooldown(53480),  -- Roar of Sacrifice
        CreateSpellCooldown(53490),  -- Bullheaded
        CreateSpellCooldown(54706),  -- Venom Web Spray
        CreateSpellCooldown(55709),  -- Heart of the Phoenix
        CreateSpellCooldown(56626),  -- Sting
        CreateSpellCooldown(61684),  -- Dash
        CreateSpellCooldown(90309),  -- Terrifying Roar
        CreateSpellCooldown(90327),  -- Lock Jaw
        CreateSpellCooldown(90337),  -- Bad Manner
        CreateSpellCooldown(90339),  -- Harden Carapace
        CreateSpellCooldown(90355),  -- Primal Rage
        CreateSpellCooldown(91644),  -- Snatch
        CreateSpellCooldown(93434),  -- Horn Toss
        CreateSpellCooldown(93435),  -- Roar of Courage
        CreateSpellCooldown(96201),  -- Web Wrap
        CreateSpellCooldown(97229),  -- Bellowing Roar
        CreateSpellCooldown(109259), -- Powershot
        CreateSpellCooldown(109304), -- Exhilaration
        CreateSpellCooldown(120697), -- Lynx Rush
        CreateSpellCooldown(126246), -- Lullaby
        CreateSpellCooldown(126355), -- Paralyzing Quill
        CreateSpellCooldown(126373), -- Fearless Roar
        CreateSpellCooldown(126393), -- Eternal Guardian
        CreateSpellCooldown(126423), -- Petrifying Gaze
        CreateSpellCooldown(128997), -- Spirit Beast Blessing
    },
    ["MAGE"] = {
        CreateSpellCooldown(2139),   -- Counterspell
        CreateSpellCooldown(45438),  -- Ice Block
        CreateSpellCooldown(55342),  -- Mirror Image
        CreateSpellCooldown(66),     -- Invisibility
        CreateSpellCooldown(80353),  -- Time Warp
        CreateSpellCooldown(12051),  -- Evocation
        CreateSpellCooldown(108978), -- Alter Time

        -- Talents
        CreateSpellCooldown(12043),  -- Presence of Mind
        CreateSpellCooldown(11958),  -- Cold Snap
        CreateSpellCooldown(110959), -- Greater Invisibility
        CreateSpellCooldown(113724), -- Ring of Frost

        -- Arcane
        CreateSpellCooldown(12042),  -- Arcane Power

        -- Fire
        CreateSpellCooldown(11129),  -- Combustion
        CreateSpellCooldown(31661),  -- Dragon's Breath

        -- Frost
        CreateSpellCooldown(12472),  -- Icy Veins
        CreateSpellCooldown(44572),  -- Deep Freeze
        CreateSpellCooldown(84714),  -- Frozen Orb
        CreateSpellCooldown(31687),  -- Summon Water Elemental
        -- CreateSpellCooldown(43987),  -- Conjure Refreshment Table

        -- CreateSpellCooldown(120146), -- Ancient Portal: Dalaran
        -- CreateSpellCooldown(53142),  -- Portal: Dalaran
        -- CreateSpellCooldown(11419),  -- Portal: Darnassus
        -- CreateSpellCooldown(32266),  -- Portal: Exodar
        -- CreateSpellCooldown(11416),  -- Portal: Ironforge
        -- CreateSpellCooldown(11417),  -- Portal: Orgrimmar
        -- CreateSpellCooldown(33691),  -- Portal: Shattrath
        -- CreateSpellCooldown(35717),  -- Portal: Shattrath
        -- CreateSpellCooldown(32267),  -- Portal: Silvermoon
        -- CreateSpellCooldown(49361),  -- Portal: Stonard
        -- CreateSpellCooldown(10059),  -- Portal: Stormwind
        -- CreateSpellCooldown(49360),  -- Portal: Theramore
        -- CreateSpellCooldown(11420),  -- Portal: Thunder Bluff
        -- CreateSpellCooldown(88345),  -- Portal: Tol Barad
        -- CreateSpellCooldown(88346),  -- Portal: Tol Barad
        -- CreateSpellCooldown(11418),  -- Portal: Undercity
        -- CreateSpellCooldown(132620), -- Portal: Vale of Eternal Blossoms
        -- CreateSpellCooldown(132626), -- Portal: Vale of Eternal Blossoms
    },
    ["MONK"] = {
        -- General
        CreateSpellCooldown(115078), -- Paralysis
        CreateSpellCooldown(115176), -- Zen Meditation
        CreateSpellCooldown(117368), -- Grapple Weapon
        CreateSpellCooldown(137562), -- Nimble Brew
        CreateSpellCooldown(116705), -- Spear Hand Strike
        CreateSpellCooldown(115080), -- Touch of Death

        -- Talents
        CreateSpellCooldown(116844), -- Ring of Peace
        CreateSpellCooldown(119392), -- Charging Ox Wave
        CreateSpellCooldown(119381), -- Leg Sweep
        CreateSpellCooldown(122278), -- Dampen Harm
        CreateSpellCooldown(122783), -- Diffuse Magic
        CreateSpellCooldown(123904), -- Invoke Xuen, the White Tiger

        -- Brewmaster
        CreateSpellCooldown(115203), -- Fortifying Brew
        CreateSpellCooldown(115213), -- Avert Harm
        CreateSpellCooldown(115315), -- Summon Black Ox Statue
        CreateSpellCooldown(115399), -- Chi Brew
        CreateSpellCooldown(122057), -- Clash
        CreateSpellCooldown(123402), -- Guard

        -- Mistweaver
        CreateSpellCooldown(115310), -- Revival
        CreateSpellCooldown(116849), -- Life Cocoon
        CreateSpellCooldown(116680), -- Thunder Focus Tea

        -- Windwaker
        CreateSpellCooldown(122470), -- Touch of Karma
        CreateSpellCooldown(115288), -- Energizing Brew

        CreateSpellCooldown(101643), -- Transcendence
        CreateSpellCooldown(126892), -- Zen Pilgrimage
    },
    ["PALADIN"] = {
        -- General
        CreateSpellCooldown(498),    -- Divine Protection
        CreateSpellCooldown(642),    -- Divine Shield
        CreateSpellCooldown(633),    -- Lay on Hands
        CreateSpellCooldown(853),    -- Hammer of Justice
        CreateSpellCooldown(1022),   -- Blessing of Protection
        CreateSpellCooldown(1044),   -- Blessing of Freedom
        CreateSpellCooldown(6940),   -- Blessing of Sacrifice

        -- Talents
        CreateSpellCooldown(31821),  -- Devotion Mastery
        CreateSpellCooldown(31842),  -- Divine Favor
        CreateSpellCooldown(31850),  -- Ardent Defender
        CreateSpellCooldown(31884),  -- Avenging Wrath (Holy)
        CreateSpellCooldown(86659),  -- Guardian of Ancient Kings
        CreateSpellCooldown(54428),  -- Divine Plea
        CreateSpellCooldown(20066),  -- Repentance
        CreateSpellCooldown(115750), -- Blinding Light
        CreateSpellCooldown(85499),  -- Speed of Light
        CreateSpellCooldown(114039), -- Hand of Purity
        CreateSpellCooldown(105809), -- Holy Avenger
        CreateSpellCooldown(114158), -- Light's Hammer
        CreateSpellCooldown(114157), -- Execution Sentence

        -- Retribution
        CreateSpellCooldown(96231),  -- Rebuke

        CreateSpellCooldown(1038),   -- Hand of Salvation
    },
    ["PRIEST"] = {
        -- General
        CreateSpellCooldown(586),    -- Fade
        CreateSpellCooldown(6346),   -- Fear Ward
        CreateSpellCooldown(8122),   -- Psychic Scream
        CreateSpellCooldown(34433),  -- Shadowfiend
        CreateSpellCooldown(73325),  -- Leap of Faith
        CreateSpellCooldown(64901),  -- Hymn of Hope

        -- Talents
        CreateSpellCooldown(10060),  -- Power Infusion
        CreateSpellCooldown(19236),  -- Desperate Prayer
        CreateSpellCooldown(108920), -- Void Tendrils
        CreateSpellCooldown(112833), -- Spectral Guise
        CreateSpellCooldown(121135), -- Cascade
        CreateSpellCooldown(120517), -- Halo
        CreateSpellCooldown(32375),  -- Mass Dispel
        CreateSpellCooldown(108968), -- Void Shift

        -- Discipline
        CreateSpellCooldown(33206),  -- Pain Suppression
        CreateSpellCooldown(62618),  -- Power Word: Barrier
        CreateSpellCooldown(81700),  -- Archangel
        CreateSpellCooldown(89485),  -- Inner Focus
        CreateSpellCooldown(109964), -- Spirit Shell

        -- Holy
        CreateSpellCooldown(64843),  -- Divine Hymn
        CreateSpellCooldown(47788),  -- Guardian Spirit
        CreateSpellCooldown(724),    -- Lightwell
        CreateSpellCooldown(88625),  -- Holy Word: Chastise

        -- Shadow
        CreateSpellCooldown(15487),  -- Silence
        CreateSpellCooldown(15286),  -- Vampiric Embrace
        CreateSpellCooldown(47585),  -- Dispersion
        CreateSpellCooldown(64044),  -- Psychic Horror
        CreateSpellCooldown(123040), -- Mind Bender

        CreateSpellCooldown(121093), -- Gift of the Naaru
        CreateSpellCooldown(108921), -- Psyfiend
    },
    ["ROGUE"] = {
        -- General
        CreateSpellCooldown(1766),   -- Kick
        CreateSpellCooldown(31224),  -- Cloak of Shadows
        CreateSpellCooldown(5277),   -- Evasion
        CreateSpellCooldown(1856),   -- Vanish
        CreateSpellCooldown(2094),   -- Blind
        CreateSpellCooldown(2983),   -- Sprint
        CreateSpellCooldown(74001),  -- Combat Readiness
        CreateSpellCooldown(76577),  -- Smoke Bomb
        CreateSpellCooldown(121471), -- Shadow Blades
        CreateSpellCooldown(114018), -- Shroud of Concealment
        CreateSpellCooldown(57934),  -- Tricks of the Trade

        -- Talents
        CreateSpellCooldown(14185),  -- Preparation
        CreateSpellCooldown(36554),  -- Shadowstep

        -- Assassination
        CreateSpellCooldown(79140),  -- Vendetta

        -- Combat
        CreateSpellCooldown(13750),  -- Adrenaline Rush
        CreateSpellCooldown(51690),  -- Killing Spree

        -- Subtlety
        CreateSpellCooldown(51713),  -- Shadow Dance

        CreateSpellCooldown(51722),  -- Dismantle
        CreateSpellCooldown(137619), -- Marked for Death
        CreateSpellCooldown(107079), -- Quaking Palm
        CreateSpellCooldown(73981),  -- Redirect
        CreateSpellCooldown(114842), -- Shadow Walk
    },
    ["SHAMAN"] = {
        -- General
        CreateSpellCooldown(8143),   -- Tremor Totem
        CreateSpellCooldown(32182),  -- Heroism
        CreateSpellCooldown(79206),  -- Spiritwalker's Grace
        CreateSpellCooldown(108269), -- Capacitor Totem
        CreateSpellCooldown(108280), -- Healing Tide Totem
        CreateSpellCooldown(114049), -- Ascendance
        CreateSpellCooldown(120668), -- Stormlash Totem
        CreateSpellCooldown(57994),  -- Wind Shear
        CreateSpellCooldown(51514),  -- Hex
        CreateSpellCooldown(2825),   -- Bloodlust
        CreateSpellCooldown(2062),   -- Earth Elemental Totem
        CreateSpellCooldown(2894),   -- Fire Elemental Totem

        -- Talents
        CreateSpellCooldown(108271), -- Astral Shift
        CreateSpellCooldown(108270), -- Stone Bulwark Totem
        CreateSpellCooldown(108273), -- Windwalk Totem
        CreateSpellCooldown(108285), -- Call of the Elements
        CreateSpellCooldown(16166),  -- Elemental Mastery
        CreateSpellCooldown(16188),  -- Ancestral Swiftness
        CreateSpellCooldown(108281), -- Ancestral Guidance

        -- Elemental
        CreateSpellCooldown(51490),  -- Thunderstorm

        -- Enhancement
        CreateSpellCooldown(30823),  -- Shamanistic Rage
        CreateSpellCooldown(51533),  -- Feral Spirit

        -- Restoration
        CreateSpellCooldown(98008),  -- Spirit Link Totem
        CreateSpellCooldown(16190),  -- Mana Tide Totem

        CreateSpellCooldown(556),    -- Astral Recall
        CreateSpellCooldown(20608),  -- Reincarnation
        CreateSpellCooldown(58875),  -- Spirit Walk
    },
    ["WARLOCK"] = {
        -- General
        CreateSpellCooldown(104773), -- Unending Resolve
        CreateSpellCooldown(48020),  -- Demonic Circle: Teleport
        CreateSpellCooldown(20707),  -- Soulstone
        CreateSpellCooldown(1122),   -- Summon Infernal
        CreateSpellCooldown(18540),  -- Summon Doomguard

        -- Talents
        CreateSpellCooldown(108359), -- Dark Regeneration
        CreateSpellCooldown(5484),   -- Howl of Terror
        CreateSpellCooldown(6789),   -- Mortal Coil
        CreateSpellCooldown(30283),  -- Shadowfury
        CreateSpellCooldown(108416), -- Sacrificial Pact
        CreateSpellCooldown(110913), -- Dark Bargain
        CreateSpellCooldown(108482), -- Unbound Will

        -- Specializations
        CreateSpellCooldown(113860), -- Dark Soul: Misery
        CreateSpellCooldown(113861), -- Dark Soul: Knowledge
        CreateSpellCooldown(113858), -- Dark Soul: Instability

        CreateSpellCooldown(29893),  -- Create Soulwell
        CreateSpellCooldown(120451), -- Flames of Xoroth
        CreateSpellCooldown(108501), -- Grimoire of Service
        CreateSpellCooldown(108508), -- Mannoroth's Fury
        CreateSpellCooldown(698),    -- Ritual of Summoning
        CreateSpellCooldown(87385),  -- Seed of Corruption
        CreateSpellCooldown(29858),  -- Soulshatter
    },
    ["WARRIOR"] = {
        -- General
        CreateSpellCooldown(871),    -- Shield Wall
        CreateSpellCooldown(1719),   -- Recklessness
        CreateSpellCooldown(3411),   -- Intervene
        CreateSpellCooldown(5246),   -- Intimidating Shout
        CreateSpellCooldown(23920),  -- Spell Reflection
        CreateSpellCooldown(64382),  -- Shattering Throw
        CreateSpellCooldown(97462),  -- Rallying Cry
        CreateSpellCooldown(114192), -- Mocking Banner
        CreateSpellCooldown(114203), -- Demoralizing Banner
        CreateSpellCooldown(114207), -- Skull Banner
        CreateSpellCooldown(6552),   -- Pummel
        CreateSpellCooldown(102060), -- Disrupting Shout
        CreateSpellCooldown(12975),  -- Last Stand
        CreateSpellCooldown(118038), -- Die by the Sword
        CreateSpellCooldown(18499),  -- Berserker Rage
        CreateSpellCooldown(6544),   -- Heroic Leap
        CreateSpellCooldown(1160),   -- Demoralizing Shout
        CreateSpellCooldown(676),    -- Disarm

        -- Talents
        CreateSpellCooldown(12292),  -- Bloodbath
        CreateSpellCooldown(46924),  -- Bladestorm
        CreateSpellCooldown(46968),  -- Shockwave
        CreateSpellCooldown(55694),  -- Enraged Regeneration
        CreateSpellCooldown(107570), -- Storm Bolt
        CreateSpellCooldown(107574), -- Avatar
        CreateSpellCooldown(114028), -- Mass Spell Reflection
        CreateSpellCooldown(114030), -- Vigilance
        CreateSpellCooldown(118000), -- Dragon Roar
        CreateSpellCooldown(112873), -- War Banner

        CreateSpellCooldown(6673),   -- Battle Shout
        CreateSpellCooldown(469),    -- Commanding Shout
        CreateSpellCooldown(107566), -- Staggering Shout
    }
}

AddCooldowns(data)
