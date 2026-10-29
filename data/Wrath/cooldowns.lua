local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Wrath of the Lich King Classic (Titan)
--------------------------------------------------
local data = {
    ["DEATHKNIGHT"] = {
        -- General
        CreateSpellCooldown(47528),   -- Mind Freeze
        CreateSpellCooldown(49576),   -- Death Grip
        CreateSpellCooldown(47476),   -- Strangulate
        CreateSpellCooldown(48707),   -- Anti-Magic Shell
        CreateSpellCooldown(48792),   -- Icebound Fortitude
        CreateSpellCooldown(47568),   -- Empower Rune Weapon
        CreateSpellCooldown(42650),   -- Army of the Dead
        CreateSpellCooldown(61999),   -- Raise Ally
        CreateSpellCooldown(48743),   -- Death Pact

        -- Blood
        CreateSpellCooldown(49028),   -- Dancing Rune Weapon
        CreateSpellCooldown(55233),   -- Vampiric Blood
        CreateSpellCooldown(48982),   -- Rune Tap

        -- Frost
        CreateSpellCooldown(49039),   -- Lichborne
        CreateSpellCooldown(51271),   -- Unbreakable Armor
        CreateSpellCooldown(49203),   -- Hungering Cold

        -- Unholy
        CreateSpellCooldown(49206),   -- Summon Gargoyle
        CreateSpellCooldown(49222),   -- Bone Shield
        CreateSpellCooldown(51052),   -- Anti-Magic Zone

        CreateSpellCooldown(45529),   -- Blood Tap
        CreateSpellCooldown(1314847), -- Death From Above
        CreateSpellCooldown(50033),   -- Death Rune Mastery (Rank 2)
        CreateSpellCooldown(50034),   -- Death Rune Mastery (Rank 3)
        CreateSpellCooldown(49796),   -- Deathchill
        CreateSpellCooldown(49005),   -- Mark of Blood
        CreateSpellCooldown(46584),   -- Raise Dead
        CreateSpellCooldown(49016),   -- Unholy Frenzy
    },
    ["DRUID"] = {
        -- General
        CreateSpellCooldown(20484),   -- Rebirth (Rank 1)
        CreateSpellCooldown(740),     -- Tranquility (Rank 1)
        CreateSpellCooldown(22812),   -- Barkskin
        CreateSpellCooldown(29166),   -- Innervate
        CreateSpellCooldown(1850),    -- Dash (Rank 1)
        CreateSpellCooldown(5229),    -- Enrage
        CreateSpellCooldown(5209),    -- Challenging Roar
        CreateSpellCooldown(22842),   -- Frenzied Regeneration

        -- Talents
        CreateSpellCooldown(17116),   -- Nature's Swiftness
        CreateSpellCooldown(16979),   -- Feral Charge - Bear
        CreateSpellCooldown(49376),   -- Feral Charge - Cat
        CreateSpellCooldown(61336),   -- Survival Instincts
        CreateSpellCooldown(50334),   -- Berserk
        CreateSpellCooldown(33831),   -- Force of Nature
        CreateSpellCooldown(48505),   -- Starfall (Rank 1)

        CreateSpellCooldown(5211),    -- Bash (Rank 1)
        CreateSpellCooldown(6798),    -- Bash (Rank 2)
        CreateSpellCooldown(8983),    -- Bash (Rank 3)
        CreateSpellCooldown(1309397), -- Elune's Orbital Cannon
        CreateSpellCooldown(16689),   -- Nature's Grasp (Rank 1)
        CreateSpellCooldown(16810),   -- Nature's Grasp (Rank 2)
        CreateSpellCooldown(16811),   -- Nature's Grasp (Rank 3)
        CreateSpellCooldown(16812),   -- Nature's Grasp (Rank 4)
        CreateSpellCooldown(16813),   -- Nature's Grasp (Rank 5)
        CreateSpellCooldown(17329),   -- Nature's Grasp (Rank 6)
        CreateSpellCooldown(27009),   -- Nature's Grasp (Rank 7)
        CreateSpellCooldown(53312),   -- Nature's Grasp (Rank 8)
    },
    ["HUNTER"] = {
        -- General
        CreateSpellCooldown(3045),    -- Rapid Fire
        CreateSpellCooldown(5384),    -- Feign Death
        CreateSpellCooldown(19263),   -- Deterrence
        CreateSpellCooldown(1499),    -- Freezing Trap (Rank 1)
        CreateSpellCooldown(34477),   -- Misdirection
        CreateSpellCooldown(53271),   -- Master's Call

        -- Talents
        CreateSpellCooldown(19574),   -- Bestial Wrath
        CreateSpellCooldown(19577),   -- Intimidation
        CreateSpellCooldown(23989),   -- Readiness
        CreateSpellCooldown(34490),   -- Silencing Shot
        CreateSpellCooldown(19386),   -- Wyvern Sting (Rank 1)

        CreateSpellCooldown(50433),   -- Bad Attitude (Rank 1)
        CreateSpellCooldown(52395),   -- Bad Attitude (Rank 2)
        CreateSpellCooldown(52396),   -- Bad Attitude (Rank 3)
        CreateSpellCooldown(52397),   -- Bad Attitude (Rank 4)
        CreateSpellCooldown(52398),   -- Bad Attitude (Rank 5)
        CreateSpellCooldown(52399),   -- Bad Attitude (Rank 6)
        CreateSpellCooldown(53490),   -- Bullheaded
        CreateSpellCooldown(62757),   -- Call Stabled Pet
        CreateSpellCooldown(53434),   -- Call of the Wild
        CreateSpellCooldown(1742),    -- Cower
        CreateSpellCooldown(61684),   -- Dash
        CreateSpellCooldown(23145),   -- Dive
        CreateSpellCooldown(50285),   -- Dust Cloud
        CreateSpellCooldown(24604),   -- Furious Howl (Rank 1)
        CreateSpellCooldown(64491),   -- Furious Howl (Rank 2)
        CreateSpellCooldown(64492),   -- Furious Howl (Rank 3)
        CreateSpellCooldown(64493),   -- Furious Howl (Rank 4)
        CreateSpellCooldown(64494),   -- Furious Howl (Rank 5)
        CreateSpellCooldown(64495),   -- Furious Howl (Rank 6)
        CreateSpellCooldown(55709),   -- Heart of the Phoenix
        CreateSpellCooldown(34026),   -- Kill Command
        CreateSpellCooldown(53478),   -- Last Stand
        CreateSpellCooldown(53426),   -- Lick Your Wounds
        CreateSpellCooldown(50479),   -- Nether Shock (Rank 1)
        CreateSpellCooldown(53584),   -- Nether Shock (Rank 2)
        CreateSpellCooldown(53586),   -- Nether Shock (Rank 3)
        CreateSpellCooldown(53587),   -- Nether Shock (Rank 4)
        CreateSpellCooldown(53588),   -- Nether Shock (Rank 5)
        CreateSpellCooldown(53589),   -- Nether Shock (Rank 6)
        CreateSpellCooldown(50245),   -- Pin (Rank 1)
        CreateSpellCooldown(53544),   -- Pin (Rank 2)
        CreateSpellCooldown(53545),   -- Pin (Rank 3)
        CreateSpellCooldown(53546),   -- Pin (Rank 4)
        CreateSpellCooldown(53547),   -- Pin (Rank 5)
        CreateSpellCooldown(53548),   -- Pin (Rank 6)
        CreateSpellCooldown(53401),   -- Rabid
        CreateSpellCooldown(50518),   -- Ravage (Rank 1)
        CreateSpellCooldown(53558),   -- Ravage (Rank 2)
        CreateSpellCooldown(53559),   -- Ravage (Rank 3)
        CreateSpellCooldown(53560),   -- Ravage (Rank 4)
        CreateSpellCooldown(53561),   -- Ravage (Rank 5)
        CreateSpellCooldown(53562),   -- Ravage (Rank 6)
        CreateSpellCooldown(53517),   -- Roar of Recovery
        CreateSpellCooldown(53480),   -- Roar of Sacrifice
        CreateSpellCooldown(50498),   -- Savage Rend (Rank 1)
        CreateSpellCooldown(53578),   -- Savage Rend (Rank 2)
        CreateSpellCooldown(53579),   -- Savage Rend (Rank 3)
        CreateSpellCooldown(53580),   -- Savage Rend (Rank 4)
        CreateSpellCooldown(53581),   -- Savage Rend (Rank 5)
        CreateSpellCooldown(53582),   -- Savage Rend (Rank 6)
        CreateSpellCooldown(50318),   -- Serenity Dust (Rank 1)
        CreateSpellCooldown(52012),   -- Serenity Dust (Rank 2)
        CreateSpellCooldown(52013),   -- Serenity Dust (Rank 3)
        CreateSpellCooldown(52014),   -- Serenity Dust (Rank 4)
        CreateSpellCooldown(52015),   -- Serenity Dust (Rank 5)
        CreateSpellCooldown(52016),   -- Serenity Dust (Rank 6)
        CreateSpellCooldown(26064),   -- Shell Shield
        CreateSpellCooldown(50541),   -- Snatch (Rank 1)
        CreateSpellCooldown(53537),   -- Snatch (Rank 2)
        CreateSpellCooldown(53538),   -- Snatch (Rank 3)
        CreateSpellCooldown(53540),   -- Snatch (Rank 4)
        CreateSpellCooldown(53542),   -- Snatch (Rank 5)
        CreateSpellCooldown(53543),   -- Snatch (Rank 6)
        CreateSpellCooldown(50519),   -- Sonic Blast (Rank 1)
        CreateSpellCooldown(53564),   -- Sonic Blast (Rank 2)
        CreateSpellCooldown(53565),   -- Sonic Blast (Rank 3)
        CreateSpellCooldown(53566),   -- Sonic Blast (Rank 4)
        CreateSpellCooldown(53567),   -- Sonic Blast (Rank 5)
        CreateSpellCooldown(53568),   -- Sonic Blast (Rank 6)
        CreateSpellCooldown(57386),   -- Stampede (Rank 1)
        CreateSpellCooldown(57389),   -- Stampede (Rank 2)
        CreateSpellCooldown(57390),   -- Stampede (Rank 3)
        CreateSpellCooldown(57391),   -- Stampede (Rank 4)
        CreateSpellCooldown(57392),   -- Stampede (Rank 5)
        CreateSpellCooldown(57393),   -- Stampede (Rank 6)
        CreateSpellCooldown(53477),   -- Taunt
        CreateSpellCooldown(54706),   -- Venom Web Spray (Rank 1)
        CreateSpellCooldown(55505),   -- Venom Web Spray (Rank 2)
        CreateSpellCooldown(55506),   -- Venom Web Spray (Rank 3)
        CreateSpellCooldown(55507),   -- Venom Web Spray (Rank 4)
        CreateSpellCooldown(55508),   -- Venom Web Spray (Rank 5)
        CreateSpellCooldown(55509),   -- Venom Web Spray (Rank 6)
        CreateSpellCooldown(4167),    -- Web
    },
    ["MAGE"] = {
        -- General
        CreateSpellCooldown(2139),    -- Counterspell
        CreateSpellCooldown(45438),   -- Ice Block
        CreateSpellCooldown(66),      -- Invisibility
        CreateSpellCooldown(12051),   -- Evocation
        CreateSpellCooldown(55342),   -- Mirror Image

        -- Arcane
        CreateSpellCooldown(12042),   -- Arcane Power
        CreateSpellCooldown(12043),   -- Presence of Mind

        -- Fire
        CreateSpellCooldown(11129),   -- Combustion

        -- Frost
        CreateSpellCooldown(12472),   -- Icy Veins
        CreateSpellCooldown(11958),   -- Cold Snap
        CreateSpellCooldown(31687),   -- Summon Water Elemental
        CreateSpellCooldown(44572),   -- Deep Freeze

        CreateSpellCooldown(53142),   -- Portal: Dalaran
        CreateSpellCooldown(43987),   -- Ritual of Refreshment (Rank 1)
        CreateSpellCooldown(58659),   -- Ritual of Refreshment (Rank 2)
        CreateSpellCooldown(70909),   -- Summon Water Elemental (Prototype)
    },
    ["PALADIN"] = {
        -- General
        CreateSpellCooldown(498),     -- Divine Protection
        CreateSpellCooldown(642),     -- Divine Shield
        CreateSpellCooldown(633),     -- Lay on Hands (Rank 1)
        CreateSpellCooldown(1022),    -- Hand of Protection (Rank 1)
        CreateSpellCooldown(1044),    -- Hand of Freedom
        CreateSpellCooldown(6940),    -- Hand of Sacrifice
        CreateSpellCooldown(853),     -- Hammer of Justice (Rank 1)
        CreateSpellCooldown(31884),   -- Avenging Wrath
        CreateSpellCooldown(54428),   -- Divine Plea

        -- Talents
        CreateSpellCooldown(20216),   -- Divine Favor
        CreateSpellCooldown(31842),   -- Divine Illumination
        CreateSpellCooldown(31821),   -- Aura Mastery
        CreateSpellCooldown(64205),   -- Divine Sacrifice
        CreateSpellCooldown(20066),   -- Repentance

        CreateSpellCooldown(19752),   -- Divine Intervention
        CreateSpellCooldown(1038),    -- Hand of Salvation
    },
    ["PRIEST"] = {
        -- Discipline
        CreateSpellCooldown(10060),   -- Power Infusion
        CreateSpellCooldown(14751),   -- Inner Focus

        -- Holy
        CreateSpellCooldown(724),     -- Lightwell (Rank 1)
        CreateSpellCooldown(27870),   -- Lightwell (Rank 2)
        CreateSpellCooldown(27871),   -- Lightwell (Rank 3)

        -- Shadow
        CreateSpellCooldown(15487),   -- Silence

        CreateSpellCooldown(586),     -- Fade (Rank 1)
        CreateSpellCooldown(9578),    -- Fade (Rank 2)
        CreateSpellCooldown(9579),    -- Fade (Rank 3)
        CreateSpellCooldown(9592),    -- Fade (Rank 4)
        CreateSpellCooldown(10941),   -- Fade (Rank 5)
        CreateSpellCooldown(10942),   -- Fade (Rank 6)

        CreateSpellCooldown(8122),    -- Psychic Scream (Rank 1)
        CreateSpellCooldown(8124),    -- Psychic Scream (Rank 2)
        CreateSpellCooldown(10888),   -- Psychic Scream (Rank 3)
        CreateSpellCooldown(10890),   -- Psychic Scream (Rank 4)

        CreateSpellCooldown(6346),    -- Fear Ward (Rank 1)

        CreateSpellCooldown(13908),   -- Desperate Prayer (Rank 1)
        CreateSpellCooldown(19236),   -- Desperate Prayer (Rank 2)
        CreateSpellCooldown(19238),   -- Desperate Prayer (Rank 3)
        CreateSpellCooldown(19240),   -- Desperate Prayer (Rank 4)
        CreateSpellCooldown(19241),   -- Desperate Prayer (Rank 5)
        CreateSpellCooldown(19242),   -- Desperate Prayer (Rank 6)
        CreateSpellCooldown(19243),   -- Desperate Prayer (Rank 7)
        CreateSpellCooldown(25437),   -- Desperate Prayer (Rank 8)
        CreateSpellCooldown(48173),   -- Desperate Prayer (Rank 9)

        -- Talents
        CreateSpellCooldown(47585),   -- Dispersion
        CreateSpellCooldown(33206),   -- Pain Suppression
        CreateSpellCooldown(47788),   -- Guardian Spirit
        CreateSpellCooldown(64843),   -- Divine Hymn
        CreateSpellCooldown(64901),   -- Hymn of Hope
        CreateSpellCooldown(34433),   -- Shadowfiend

        CreateSpellCooldown(64044),   -- Psychic Horror
    },
    ["ROGUE"] = {
        -- General
        CreateSpellCooldown(1766),    -- Kick (Rank 1)
        CreateSpellCooldown(2094),    -- Blind
        CreateSpellCooldown(5277),    -- Evasion (Rank 1)
        CreateSpellCooldown(1856),    -- Vanish (Rank 1)
        CreateSpellCooldown(2983),    -- Sprint (Rank 1)
        CreateSpellCooldown(31224),   -- Cloak of Shadows
        CreateSpellCooldown(57934),   -- Tricks of the Trade

        -- Talents
        CreateSpellCooldown(13750),   -- Adrenaline Rush
        CreateSpellCooldown(13877),   -- Blade Flurry
        CreateSpellCooldown(51690),   -- Killing Spree
        CreateSpellCooldown(14177),   -- Cold Blood
        CreateSpellCooldown(14185),   -- Preparation
        CreateSpellCooldown(14183),   -- Premeditation
        CreateSpellCooldown(36554),   -- Shadowstep
        CreateSpellCooldown(51713),   -- Shadow Dance

        CreateSpellCooldown(51722),   -- Dismantle
    },
    ["SHAMAN"] = {
        -- General
        CreateSpellCooldown(57994),   -- Wind Shear
        CreateSpellCooldown(51514),   -- Hex
        CreateSpellCooldown(8177),    -- Grounding Totem
        CreateSpellCooldown(20608),   -- Reincarnation
        CreateSpellCooldown(2825),    -- Bloodlust
        CreateSpellCooldown(32182),   -- Heroism
        CreateSpellCooldown(2062),    -- Earth Elemental Totem
        CreateSpellCooldown(2894),    -- Fire Elemental Totem

        -- Talents
        CreateSpellCooldown(16166),   -- Elemental Mastery
        CreateSpellCooldown(16188),   -- Nature's Swiftness
        CreateSpellCooldown(30823),   -- Shamanistic Rage
        CreateSpellCooldown(51533),   -- Feral Spirit
        CreateSpellCooldown(16190),   -- Mana Tide Totem
        CreateSpellCooldown(55198),   -- Tidal Force

        CreateSpellCooldown(556),     -- Astral Recall
        CreateSpellCooldown(51490),   -- Thunderstorm (Rank 1)
        CreateSpellCooldown(59156),   -- Thunderstorm (Rank 2)
        CreateSpellCooldown(59158),   -- Thunderstorm (Rank 3)
        CreateSpellCooldown(59159),   -- Thunderstorm (Rank 4)
        CreateSpellCooldown(1320276), -- Volcano
    },
    ["WARLOCK"] = {
        -- General
        CreateSpellCooldown(1122),    -- Inferno
        CreateSpellCooldown(6789),    -- Death Coil (Rank 1)
        CreateSpellCooldown(5484),    -- Howl of Terror (Rank 1)
        CreateSpellCooldown(29858),   -- Soulshatter
        CreateSpellCooldown(48020),   -- Demonic Circle: Teleport

        -- Talents
        CreateSpellCooldown(18708),   -- Fel Domination
        CreateSpellCooldown(47193),   -- Demonic Empowerment
        CreateSpellCooldown(47241),   -- Metamorphosis

        CreateSpellCooldown(603),     -- Curse of Doom (Rank 1)
        CreateSpellCooldown(30910),   -- Curse of Doom (Rank 2)
        CreateSpellCooldown(47867),   -- Curse of Doom (Rank 3)
        CreateSpellCooldown(18540),   -- Ritual of Doom
        CreateSpellCooldown(29893),   -- Ritual of Souls (Rank 1)
        CreateSpellCooldown(58887),   -- Ritual of Souls (Rank 2)
        CreateSpellCooldown(698),     -- Ritual of Summoning
        CreateSpellCooldown(7812),    -- Sacrifice (Rank 1)
        CreateSpellCooldown(19438),   -- Sacrifice (Rank 2)
        CreateSpellCooldown(19440),   -- Sacrifice (Rank 3)
        CreateSpellCooldown(19441),   -- Sacrifice (Rank 4)
        CreateSpellCooldown(19442),   -- Sacrifice (Rank 5)
        CreateSpellCooldown(19443),   -- Sacrifice (Rank 6)
        CreateSpellCooldown(27273),   -- Sacrifice (Rank 7)
        CreateSpellCooldown(47985),   -- Sacrifice (Rank 8)
        CreateSpellCooldown(47986),   -- Sacrifice (Rank 9)
        CreateSpellCooldown(17735),   -- Suffering (Rank 1)
        CreateSpellCooldown(17750),   -- Suffering (Rank 2)
        CreateSpellCooldown(17751),   -- Suffering (Rank 3)
        CreateSpellCooldown(17752),   -- Suffering (Rank 4)
        CreateSpellCooldown(27271),   -- Suffering (Rank 5)
        CreateSpellCooldown(33701),   -- Suffering (Rank 6)
        CreateSpellCooldown(47989),   -- Suffering (Rank 7)
        CreateSpellCooldown(47990),   -- Suffering (Rank 8)
    },
    ["WARRIOR"] = {
        -- General
        CreateSpellCooldown(871),     -- Shield Wall
        CreateSpellCooldown(1719),    -- Recklessness
        CreateSpellCooldown(20230),   -- Retaliation
        CreateSpellCooldown(18499),   -- Berserker Rage
        CreateSpellCooldown(3411),    -- Intervene
        CreateSpellCooldown(5246),    -- Intimidating Shout
        CreateSpellCooldown(1161),    -- Challenging Shout
        CreateSpellCooldown(676),     -- Disarm
        CreateSpellCooldown(2687),    -- Bloodrage
        CreateSpellCooldown(6552),    -- Pummel
        CreateSpellCooldown(20252),   -- Intercept
        CreateSpellCooldown(64382),   -- Shattering Throw

        -- Talents
        CreateSpellCooldown(12292),   -- Death Wish
        CreateSpellCooldown(12328),   -- Sweeping Strikes
        CreateSpellCooldown(12809),   -- Concussion Blow
        CreateSpellCooldown(12975),   -- Last Stand
        CreateSpellCooldown(46924),   -- Bladestorm
        CreateSpellCooldown(46968),   -- Shockwave
        CreateSpellCooldown(55694),   -- Enraged Regeneration

        CreateSpellCooldown(57755),   -- Heroic Throw
        CreateSpellCooldown(694),     -- Mocking Blow
        CreateSpellCooldown(1282056), -- Rallying Cry
        CreateSpellCooldown(2565),    -- Shield Block
    }
}

AddCooldowns(data)
