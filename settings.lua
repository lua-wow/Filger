local _, ns = ...
local Filger = ns.Filger

------------------------------------------------------------
-- Options
------------------------------------------------------------
Filger.Options = {
	-- setup/test options
	["show"] = false,				-- display elements to make easier to position them.
	["configmode"] = false,			-- enable a simulation mode.
	["rec"] = false,				-- enable feature /filger <cmd>.
	
	-- bar
	["barwidth"] = 200,				-- set bar width (default is 200).
	["barheight"] = 18,				-- set bar height and icon size.
	
	-- icon
	["iconsize"] = 32,				-- sei icon size.
	["colordebuff"] = true,			-- enable debuff icon color base on spell type.
}

------------------------------------------------------------
-- Spell List
------------------------------------------------------------
Filger.Spells = {
	PRIEST = {
		{
			name = "PLAYER_BUFFS",
			anchor = { "RIGHT", UIParent, "CENTER", -160, 0 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- Shadow
			{ spellID =    586, caster = "player", filter = "BUFF" },		-- Fade
			{ spellID =  15286, caster = "player", filter = "BUFF" },		-- Vampiric Embrace
			{ spellID =  47585, caster = "player", filter = "BUFF" },		-- Dispersion
			{ spellID = 124430, caster = "player", filter = "BUFF" },		-- Shadowy Insight
			{ spellID = 194249, caster = "player", filter = "BUFF" },		-- Voidform
			{ spellID = 197937, caster = "player", filter = "BUFF" },		-- Lingering Insanity
			{ spellID = 205372, caster = "player", filter = "BUFF" },		-- Void Ray
			-- Discipline
			{ spellID =     17, caster = "player", filter = "BUFF" },		-- Power Word: Shield
			{ spellID =  10060, caster = "player", filter = "BUFF" },		-- Power Infusion
			{ spellID =  33206, caster = "player", filter = "BUFF" },		-- Pain Suppresion
			{ spellID =  45252, caster = "player", filter = "BUFF" },		-- Focused Will
			{ spellID =  47536, caster = "player", filter = "BUFF" },		-- Rapture
			{ spellID =  65081, caster = "player", filter = "BUFF" },		-- Body and Soul
			{ spellID = 121557, caster = "player", filter = "BUFF" },		-- Angelic Feather
			{ spellID = 152118, caster = "player", filter = "BUFF" },		-- Clarity of Will
			{ spellID = 194384, caster = "player", filter = "BUFF" },		-- Atonement
			-- Holy
			{ spellID =    139, caster = "player", filter = "BUFF" },		-- Renew
			{ spellID =  77489, caster = "player", filter = "BUFF" },		-- Echo of Light
			{ spellID = 197030, caster = "player", filter = "BUFF" },		-- Divinity
			{ spellID = 114255, caster = "player", filter = "BUFF" },		-- Surge of Light
			{ spellID =  41635, caster = "player", filter = "BUFF" },		-- Player of Mending
			{ spellID =  64843, caster = "player", filter = "BUFF" },		-- Divine Hymn
			{ spellID =  64844, caster = "player", filter = "BUFF" },		-- Divine Hymn
			{ spellID =  19236, caster = "player", filter = "BUFF" },		-- Desperate Prayer
			{ spellID = 200183, caster = "player", filter = "BUFF" },		-- Apotheosis
			{ spellID =  47788, caster = "player", filter = "BUFF" },		-- Guardian Spirit
			{ spellID =  64901, caster = "player", filter = "BUFF" },		-- Symbol of Hope
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 6,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Shadow
			{ spellID =  15286, caster = "player", filter = "CD" },			-- Vampiric Embrace
			{ spellID =  47585, caster = "player", filter = "CD" },			-- Dispersion
			{ spellID =  34433, caster = "player", filter = "CD" },			-- Shadowfiend
			-- Discipline
			{ spellID =  10060, caster = "player", filter = "CD" },			-- Power Infusion
			{ spellID =  62618, caster = "player", filter = "CD" },			-- Power World: Barrier
			{ spellID =  33206, caster = "player", filter = "CD" },			-- Pain Suppresion
			-- Holy
			{ spellID = 200183, caster = "player", filter = "CD" },			-- Apotheosis
			{ spellID =  47788, caster = "player", filter = "CD" },			-- Guardian Spirit
			{ spellID = 120517, caster = "player", filter = "CD" },			-- Halo
			{ spellID =  64844, caster = "player", filter = "CD" },			-- Divine Hymn
			-- Equipped Items
			--{ slotID =  2, caster = "player", filter = "CD" },			-- Neck (DELETE)cc
			--{ slotID = 13, caster = "player", filter = "CD" },			-- Trinket 1
			--{ slotID = 14, caster = "player", filter = "CD" },			-- Trinket 2
		},
		{
			name = "TARGET_BUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, -39 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Discipline
			{ spellID =     17, caster = "player", filter = "BUFF" },		-- Power Word: Shield
			{ spellID =  33206, caster = "player", filter = "BUFF" },		-- Pain Suppresion
			{ spellID =  41635, caster = "player", filter = "BUFF" },		-- Player of Mending
			{ spellID =  65081, caster = "player", filter = "BUFF" },		-- Body and Soul
			{ spellID = 121557, caster = "player", filter = "BUFF" },		-- Angelic Feather
			{ spellID = 152118, caster = "player", filter = "BUFF" },		-- Clarity of Will
			{ spellID = 194384, caster = "player", filter = "BUFF" },		-- Atonement
			-- Holy
			{ spellID =    139, caster = "player", filter = "BUFF" },		-- Renew
		},
		{
			name = "TARGET_DEBUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, 0 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Shadow
			{ spellID =   589, caster = "player", filter = "DEBUFF" },			-- Shadow Word: Pain
			{ spellID = 34914, caster = "player", filter = "DEBUFF" },			-- Vampiric Touch
			{ spellID = 15407, caster = "player", filter = "DEBUFF" },			-- Mind Flay
			{ spellID = 15487, caster = "player", filter = "DEBUFF" },			-- Silence
			{ spellID =  8122, caster = "player", filter = "DEBUFF" },			-- Psychic Scream
			-- Discipline
			{ spellID = 208772, caster = "player", filter = "DEBUFF" },			-- Smite
			{ spellID = 204213, caster = "player", filter = "DEBUFF" },			-- Purge the Wicked
			-- Holy
			{ spellID =  14914, caster = "player", filter = "DEBUFF" },			-- Holy Fire
			{ spellID = 200196, caster = "player", filter = "DEBUFF" },			-- Power Word: Chastise
			{ spellID = 200200, caster = "player", filter = "DEBUFF" },			-- Power Word: Chastise (talent)
		},
	},
	MONK = {
		{
			name = "PLAYER_BUFFS",
			anchor = { "RIGHT", UIParent, "CENTER", -160, 0 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- Brewmaster
			{ spellID = 195630, caster = "player", filter = "BUFF" },			-- Elusive Brawler
			{ spellID = 115308, caster = "player", filter = "BUFF" },			-- Ironskin Brew
			{ spellID = 115203, caster = "player", filter = "BUFF" },			-- Fortifying Brew
			{ spellID = 115176, caster = "player", filter = "BUFF" },			-- Zen Meditation
			{ spellID = 116847, caster = "player", filter = "BUFF" },			-- Rushing Jade Wind
			-- Mistweaver
			{ spellID = 116849, caster = "player", filter = "BUFF" },			-- Life Cocoon
			{ spellID = 197916, caster = "player", filter = "BUFF" },			-- Lifecycles (Vivify)
			{ spellID = 197919, caster = "player", filter = "BUFF" },			-- Lifecycles (Enveloping Mist)
			{ spellID = 191840, caster = "player", filter = "BUFF" },			-- Essence Font
			{ spellID = 197908, caster = "player", filter = "BUFF" },			-- Mana Tea
			{ spellID = 197206, caster = "player", filter = "BUFF" },			-- Uplifting Trance
			{ spellID = 243435, caster = "player", filter = "BUFF" },			-- Fortifying Brew (Healer)
				-- HoTs
				{ spellID = 119611, caster = "player", filter = "BUFF" },			-- Renewing Mist
				{ spellID = 115175, caster = "player", filter = "BUFF" },			-- Soothing Mist
				{ spellID = 124682, caster = "player", filter = "BUFF" },			-- Enveloping Mist

			-- Windwalker
			{ spellID = 122783, caster = "player", filter = "BUFF" },			-- Diffuse Magic
			{ spellID = 122278, caster = "player", filter = "BUFF" },			-- Danpwm Harm
			{ spellID = 196740, caster = "player", filter = "BUFF" },			-- Hit Combo
			{ spellID = 116768, caster = "player", filter = "BUFF" },			-- Blackout Kick!
			{ spellID = 122470, caster = "player", filter = "BUFF" },			-- Touch of Karma
			-- All
			{ spellID = 116841, caster = "player", filter = "BUFF" },			-- Tiger's Lust
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 6,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Brewmaster
			{ spellID = 115203, caster = "player", filter = "CD" },			-- Fortifying Brew
			{ spellID = 115176, caster = "player", filter = "CD" },			-- Zen Meditation
			{ spellID = 122278, caster = "player", filter = "CD" },			-- Danpem Harm
			{ spellID = 132578, caster = "player", filter = "CD" },			-- Invoke Niuzao, the Black Ox
			-- Mistweaver
			{ spellID = 116849, caster = "player", filter = "CD" },			-- Life Cocoon
			-- MindWalker
			{ spellID = 122783, caster = "player", filter = "CD" },			-- Diffuse Magic
		},
		{
			name = "TARGET_BUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, -39 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Mistweaver
			{ spellID = 116849, caster = "player", filter = "BUFF" },			-- Life Cocoon
			{ spellID = 191840, caster = "player", filter = "BUFF" },			-- Essence Font
			{ spellID = 119611, caster = "player", filter = "BUFF" },			-- Renewing Mist
			{ spellID = 115175, caster = "player", filter = "BUFF" },			-- Soothing Mist
			{ spellID = 124682, caster = "player", filter = "BUFF" },			-- Enveloping Mist
		},
		{
			name = "TARGET_DEBUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, 0 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Brewmaster
			{ spellID = 121253, caster = "player", filter = "DEBUFF" },			-- Keg Smash
			{ spellID = 115181, caster = "player", filter = "DEBUFF" },			-- Breath of Fire
			{ spellID = 115546, caster = "player", filter = "DEBUFF" },			-- Provoke
			{ spellID = 119381, caster = "player", filter = "DEBUFF" },			-- Leg Sweep
			-- Windwalker
			{ spellID = 228287, caster = "player", filter = "DEBUFF" },			-- Mark of the Crane
			{ spellID = 115804, caster = "player", filter = "DEBUFF" },			-- Mortal Wounds
			{ spellID = 116095, caster = "player", filter = "DEBUFF" },			-- Disable
			{ spellID = 122470, caster = "player", filter = "DEBUFF" },			-- Touch of Karma
			{ spellID = 115080, caster = "player", filter = "DEBUFF" },			-- Touch of Death
		},
	},
	DRUID = {
		{
			name = "PLAYER_BUFFS",
			anchor = { "RIGHT", UIParent, "CENTER", -160, 0 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- All
			{ spellID =   1850, caster = "player", filter = "BUFF" },			-- Dash
			-- Balance
			{ spellID =   2479, caster = "player", filter = "BUFF" },			-- Honorless Target
			{ spellID = 194223, caster = "player", filter = "BUFF" },			-- Celestial Alignment
			{ spellID = 164547, caster = "player", filter = "BUFF" },			-- Lunar Empowerment
			{ spellID = 164545, caster = "player", filter = "BUFF" },			-- Solar Empowerment
			{ spellID = 191034, caster = "player", filter = "BUFF" },			-- Starfall
			{ spellID =  22812, caster = "player", filter = "BUFF" },			-- Barkskin
			{ spellID = 202737, caster = "player", filter = "BUFF" },			-- Blessing of Elune
			{ spellID = 202739, caster = "player", filter = "BUFF" },			-- Blessing of An'she
			-- Feral
			{ spellID = 102547, caster = "player", filter = "BUFF" },			-- Incarnation: King of the Jungle
			{ spellID =  77764, caster = "player", filter = "BUFF" },			-- Stampeding Roar
			{ spellID =   5217, caster = "player", filter = "BUFF" },			-- Tiger's Fury
			{ spellID =  61336, caster = "player", filter = "BUFF" },			-- Survival Instincts
			{ spellID =  69369, caster = "player", filter = "BUFF" },			-- Predatory Swiftness
			{ spellID = 135700, caster = "player", filter = "BUFF" },			-- Clearcasting
				-- Stealth
				{ spellID = 252071, caster = "player", filter = "BUFF" },			-- Jungle Stalker
				{ spellID = 102547, caster = "player", filter = "BUFF" },			-- Prowl
			-- Guardian
			{ spellID =  93622, caster = "player", filter = "BUFF" },			-- Gore
			{ spellID = 155835, caster = "player", filter = "BUFF" },			-- Bristling
			--{ spellID =  77761, caster = "player", filter = "BUFF" },			-- Stampeding Roar
			{ spellID = 192081, caster = "player", filter = "BUFF" },			-- Ironfur
			{ spellID =  22842, caster = "player", filter = "BUFF" },			-- Frenzied Regeneration
			{ spellID = 102558, caster = "player", filter = "BUFF" },			-- Incarnation: Guardian of Ursoc
			{ spellID = 158792, caster = "player", filter = "BUFF" },			-- Pulverize
			-- Restoration
			{ spellID =    774, caster = "player", filter = "BUFF" },			-- Rejuvenation
			{ spellID =   8936, caster = "player", filter = "BUFF" },			-- Regrowth
			{ spellID =  48504, caster = "player", filter = "BUFF" },			-- Living Seed
			{ spellID = 102351, caster = "player", filter = "BUFF" },			-- Cenarion Ward
			{ spellID =  29166, caster = "player", filter = "BUFF" },			-- Innervate
			{ spellID =  33763, caster = "player", filter = "BUFF" },			-- Lifebloom
			{ spellID =  48438, caster = "player", filter = "BUFF" },			-- Wild Growth
			{ spellID = 114108, caster = "player", filter = "BUFF" },			-- Soul of the Forest
			{ spellID = 102342, caster = "player", filter = "BUFF" },			-- Ironbark
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 6,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- All
			{ spellID =  22812, caster = "player", filter = "CD" },				-- Barkskin
			-- Balance
			{ spellID = 191034, caster = "player", filter = "CD" },				-- Starfall
			{ spellID = 194223, caster = "player", filter = "CD" },				-- Celestial Alignment
			{ spellID = 202360, caster = "player", filter = "CD" },				-- Blessing of the Ancients
			{ spellID = 78675, caster = "player", filter = "CD" },				-- Solar Beam
			-- Restoration
			{ spellID =    740, caster = "player", filter = "CD" },				-- Tranquility
			{ spellID =  29166, caster = "player", filter = "CD" },				-- Innervate
			{ spellID = 102342, caster = "player", filter = "CD" },				-- Ironbark
			{ spellID = 102351, caster = "player", filter = "CD" },				-- Cenarion Ward
			{ spellID = 197721, caster = "player", filter = "CD" },				-- Flourish
		},
		{
			name = "TARGET_BUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, -39 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Balance
			{ spellID =  29166, caster = "player", filter = "BUFF" },			-- Innervate
			-- Restoration
			{ spellID =    774, caster = "player", filter = "BUFF" },			-- Rejuvenation
			{ spellID =   8936, caster = "player", filter = "BUFF" },			-- Regrowth
			{ spellID =  48504, caster = "player", filter = "BUFF" },			-- Living Seed
			{ spellID = 102351, caster = "player", filter = "BUFF" },			-- Cenarion Ward
			{ spellID =  29166, caster = "player", filter = "BUFF" },			-- Innervate
			{ spellID =  33763, caster = "player", filter = "BUFF" },			-- Lifebloom
			{ spellID =  48438, caster = "player", filter = "BUFF" },			-- Wild Growth
			{ spellID = 102342, caster = "player", filter = "BUFF" },			-- Ironbark
		},
		{
			name = "TARGET_DEBUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, 0 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Balance
			{ spellID = 202347, caster = "player", filter = "DEBUFF" },			-- Stellar Flare
			{ spellID =  81261, caster = "player", filter = "DEBUFF" },			-- Solar Beam
			{ spellID = 197637, caster = "player", filter = "DEBUFF" },			-- Stellar Empowerment
			{ spellID = 164812, caster = "player", filter = "DEBUFF" },			-- Moonfire
			{ spellID = 164815, caster = "player", filter = "DEBUFF" },			-- Sunfire
			-- Feral
			{ spellID =   1079, caster = "player", filter = "DEBUFF" },			-- Rip
			{ spellID = 155722, caster = "player", filter = "DEBUFF" },			-- Rake
			{ spellID = 106830, caster = "player", filter = "DEBUFF" },			-- Thrash
			{ spellID =  58180, caster = "player", filter = "DEBUFF" },			-- Infected Wounds
			{ spellID = 203123, caster = "player", filter = "DEBUFF" },			-- Maim
			-- Guardian
			{ spellID =   6795, caster = "player", filter = "DEBUFF" },			-- Growl
			{ spellID = 236748, caster = "player", filter = "DEBUFF" },			-- Intimidating Roar
			{ spellID = 192090, caster = "player", filter = "DEBUFF" },			-- Thrash
		},
	},
	SHAMAN = {
		{
			name = "PLAYER_BUFFS",
			anchor = { "RIGHT", UIParent, "CENTER", -160, 0 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- Elemental
			{ spellID =  16246, caster = "player", filter = "BUFF" },			-- Elemental Focus
			{ spellID =  77762, caster = "player", filter = "BUFF" },			-- Lava Surge
			{ spellID = 114050, caster = "player", filter = "BUFF" },			-- Ascendance
			{ spellID = 108271, caster = "player", filter = "BUFF" },			-- Astral Shift
			{ spellID = 108281, caster = "player", filter = "BUFF" },			-- Ancestral Guidance
			{ spellID = 118522, caster = "player", filter = "BUFF" },			-- Elemental Blast: Critical Strike
			{ spellID = 173183, caster = "player", filter = "BUFF" },			-- Elemental Blast: Haste
			{ spellID = 173184, caster = "player", filter = "BUFF" },			-- Elemental Blast: Mastery
			{ spellID = 210714, caster = "player", filter = "BUFF" },			-- Icefury
			-- Restoration
			{ spellID =   2645, caster = "player", filter = "BUFF" },			-- Ghost Wolf
			{ spellID =  53390, caster = "player", filter = "BUFF" },			-- Tidal Waves
			{ spellID =  61295, caster = "player", filter = "BUFF" },			-- Riptide
			{ spellID =  73685, caster = "player", filter = "BUFF" },			-- Unleash Life
			{ spellID =  79206, caster = "player", filter = "BUFF" },			-- Spiritwalker's Grace
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 6,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Elemental
			{ spellID =   2825, caster = "player", filter = "CD" },				-- Bloodlust
			{ spellID = 108281, caster = "player", filter = "CD" },				-- Ancestral Guidance
			{ spellID = 114050, caster = "player", filter = "CD" },				-- Ascendance
			{ spellID = 117014, caster = "player", filter = "CD" },				-- Elemental Blast
		},
		{
			name = "TARGET_BUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, -39 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Elemental
			{ spellID =    139, caster = "player", filter = "BUFF" },			-- Renew
		},
		{
			name = "TARGET_DEBUFFS",
			anchor = { "LEFT", UIParent, "CENTER", 160, 0 },
			direction = "RIGHT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "target",
			-- Elemental
			{ spellID = 188389, caster = "player", filter = "DEBUFF" },			-- Flame Stock
			{ spellID = 196840, caster = "player", filter = "DEBUFF" },			-- Frost Shock
		},
	},
	ALL = {
		{
			name = "PLAYER_BUFFS_ALL",
			anchor = { "RIGHT", UIParent, "CENTER", -160, -39 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- Enchants
			
			-- Potions
			{ spellID = 188034, caster = "player", filter = "BUFF" },			-- Flask of the Countless Armies
			
			-- External Buffs
			{ spellID =   2825, caster = "all", filter = "BUFF" },				-- Bloodlust
			{ spellID =  32182, caster = "all", filter = "BUFF" },				-- Heroism
			{ spellID =  80353, caster = "all", filter = "BUFF" },				-- Time Warp
			{ spellID =  90355, caster = "all", filter = "BUFF" },				-- Ancient Hysteria
			
			{ spellID =  57934, caster = "all", filter = "BUFF" },				-- Tricks of the Trade
			
			-- Items (procs/use)
			{ spellID = 207472, caster = "player", filter = "BUFF" },			-- Xavaric's Magnum Opus (Neckless: Prydaz, Xavaric's Magnum Opus)
			{ spellID = 256818, caster = "player", filter = "BUFF" },			-- Glimpse of Enlightenment (Trinket: Aman'Thul's Vision)
		},
		{
			name = "PLAYER_DEBUFFS_PvE/PvP",
			anchor = { "RIGHT", UIParent, "CENTER", -160, -78 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- PvP:
				-- Priest
				{ spellID =   8122, caster = "all", filter = "DEBUFF" },			-- Psychic Scream
				{ spellID =  15487, caster = "all", filter = "DEBUFF" },			-- Silence
				{ spellID = 200196, caster = "all", filter = "DEBUFF" },			-- Power Word: Chastise
				{ spellID = 200200, caster = "all", filter = "DEBUFF" },			-- Power Word: Chastise
			-- PvE:
			--	{ spellID =      0, caster = "all", filter = "DEBUFF" },			-- Any Boss Debuffs
		},
	},
}