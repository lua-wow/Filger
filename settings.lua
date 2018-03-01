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

-- Examples: Equipped Items
--{ slotID =  2, caster = "player", filter = "CD" },			-- Neck
--{ slotID = 13, caster = "player", filter = "CD" },			-- Trinket 1
--{ slotID = 14, caster = "player", filter = "CD" },			-- Trinket 2

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
			-- Priest
			{ spellID =    586, caster = "player", filter = "BUFF" },		-- Fade
			{ spellID =  65081, caster = "player", filter = "BUFF" },		-- Body and Soul
			{ spellID = 121557, caster = "player", filter = "BUFF" },		-- Angelic Feather
			-- Discipline
			{ spellID =     17, caster = "player", filter = "BUFF" },		-- Power Word: Shield
			{ spellID =  10060, caster = "player", filter = "BUFF" },		-- Power Infusion
			{ spellID =  33206, caster = "player", filter = "BUFF" },		-- Pain Suppression
			{ spellID =  45252, caster = "player", filter = "BUFF" },		-- Focused Will
			{ spellID =  47536, caster = "player", filter = "BUFF" },		-- Rapture
			{ spellID =  62618, caster = "player", filter = "BUFF" },		-- Power Word: Barrier
			{ spellID = 152118, caster = "player", filter = "BUFF" },		-- Clarity of Will
			{ spellID = 194384, caster = "player", filter = "BUFF" },		-- Atonement
			{ spellID = 193065, caster = "player", filter = "BUFF" },		-- Masochism
			-- Holy
			{ spellID =    139, caster = "player", filter = "BUFF" },		-- Renew
			{ spellID =  19236, caster = "player", filter = "BUFF" },		-- Desperate Prayer
			{ spellID =  27827, caster = "player", filter = "BUFF" },		-- Spirit of Redemption
			{ spellID =  41635, caster = "player", filter = "BUFF" },		-- Player of Mending
			{ spellID =  45242, caster = "player", filter = "BUFF" },		-- Focused Will
			{ spellID =  47788, caster = "player", filter = "BUFF" },		-- Guardian Spirit
			{ spellID =  64843, caster = "player", filter = "BUFF" },		-- Divine Hymn (64843 or 64844)
			{ spellID =  64901, caster = "player", filter = "BUFF" },		-- Symbol of Hope
			{ spellID =  77489, caster = "player", filter = "BUFF" },		-- Echo of Light
			{ spellID = 114255, caster = "player", filter = "BUFF" },		-- Surge of Light
			{ spellID = 197030, caster = "player", filter = "BUFF" },		-- Divinity
			{ spellID = 200183, caster = "player", filter = "BUFF" },		-- Apotheosis
			{ spellID = 214121, caster = "player", filter = "BUFF" },		-- Atonement
			-- Shadow
			{ spellID =  15286, caster = "player", filter = "BUFF" },		-- Vampiric Embrace
			{ spellID =  47585, caster = "player", filter = "BUFF" },		-- Dispersion
			{ spellID = 123254, caster = "player", filter = "BUFF" },		-- Twist of Fate
			{ spellID = 124430, caster = "player", filter = "BUFF" },		-- Shadowy Insight
			{ spellID = 193223, caster = "player", filter = "BUFF" },		-- Surrender to Madness
			{ spellID = 194249, caster = "player", filter = "BUFF" },		-- Voidform
			{ spellID = 197937, caster = "player", filter = "BUFF" },		-- Lingering Insanity
			{ spellID = 205372, caster = "player", filter = "BUFF" },		-- Void Ray
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 2,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Priest
			{ spellID =  10060, caster = "player", filter = "CD" },			-- Power Infusion
			{ spellID =  34433, caster = "player", filter = "CD" },			-- Shadowfiend
			{ spellID = 120517, caster = "player", filter = "CD" },			-- Halo
			{ spellID = 123040, caster = "player", filter = "CD" },			-- Mindbender
			-- Discipline
			{ spellID =  33206, caster = "player", filter = "CD" },			-- Pain Suppression
			{ spellID =  47536, caster = "player", filter = "CD" },			-- Rapture
			{ spellID =  62618, caster = "player", filter = "CD" },			-- Power World: Barrier
			-- Holy
			{ spellID =  47788, caster = "player", filter = "CD" },			-- Guardian Spirit
			{ spellID =  64843, caster = "player", filter = "CD" },			-- Divine Hymn
			{ spellID =  64901, caster = "player", filter = "CD" },			-- Symbol of Hope
			{ spellID = 200183, caster = "player", filter = "CD" },			-- Apotheosis
			-- Shadow
			{ spellID =  15286, caster = "player", filter = "CD" },			-- Vampiric Embrace
			{ spellID =  47585, caster = "player", filter = "CD" },			-- Dispersion
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
			-- Priest
			-- Discipline
			{ spellID =     17, caster = "player", filter = "BUFF" },		-- Power Word: Shield
			{ spellID =  33206, caster = "player", filter = "BUFF" },		-- Pain Suppression
			{ spellID =  62618, caster = "player", filter = "BUFF" },		-- Power Word: Barrier
			{ spellID =  65081, caster = "player", filter = "BUFF" },		-- Body and Soul
			{ spellID = 121557, caster = "player", filter = "BUFF" },		-- Angelic Feather
			{ spellID = 152118, caster = "player", filter = "BUFF" },		-- Clarity of Will
			{ spellID = 194384, caster = "player", filter = "BUFF" },		-- Atonement
			-- Holy
			{ spellID =    139, caster = "player", filter = "BUFF" },		-- Renew
			{ spellID =  41635, caster = "player", filter = "BUFF" },		-- Player of Mending
			{ spellID =  64843, caster = "player", filter = "BUFF" },		-- Divine Hymn (64843 or 64844)
			{ spellID =  77489, caster = "player", filter = "BUFF" },		-- Echo of Light
			{ spellID = 214121, caster = "player", filter = "BUFF" },		-- Atonement
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
			-- Priest
			{ spellID =   8122, caster = "player", filter = "DEBUFF" },			-- Psychic Scream
			{ spellID = 205364, caster = "player", filter = "DEBUFF" },			-- Mind Control
			-- Discipline
			{ spellID = 208772, caster = "player", filter = "DEBUFF" },			-- Smite
			{ spellID = 204213, caster = "player", filter = "DEBUFF" },			-- Purge the Wicked
			{ spellID = 204263, caster = "player", filter = "DEBUFF" },			-- Shining Force
			{ spellID = 214621, caster = "player", filter = "DEBUFF" },			-- Schism
			-- Holy
			{ spellID =  14914, caster = "player", filter = "DEBUFF" },			-- Holy Fire
			{ spellID = 200196, caster = "player", filter = "DEBUFF" },			-- Power Word: Chastise
			{ spellID = 200200, caster = "player", filter = "DEBUFF" },			-- Power Word: Chastise (talent)
			-- Shadow
			{ spellID =    589, caster = "player", filter = "DEBUFF" },			-- Shadow Word: Pain
			{ spellID =  34914, caster = "player", filter = "DEBUFF" },			-- Vampiric Touch
			{ spellID =  15407, caster = "player", filter = "DEBUFF" },			-- Mind Flay
			{ spellID =  15487, caster = "player", filter = "DEBUFF" },			-- Silence
			{ spellID = 226943, caster = "player", filter = "DEBUFF" },			-- Mind Bomb
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
			-- Monk
			{ spellID = 119085, caster = "player", filter = "BUFF" },			-- Chi Torpedo
			{ spellID = 116841, caster = "player", filter = "BUFF" },			-- Tiger's Lust
			{ spellID = 122278, caster = "player", filter = "BUFF" },			-- Dampen Harm
			{ spellID = 122783, caster = "player", filter = "BUFF" },			-- Diffuse Magic
			{ spellID = 196608, caster = "player", filter = "BUFF" },			-- Eye of the Tiger
			-- Brewmaster
			{ spellID = 101643, caster = "player", filter = "BUFF" },			-- Transcendence
			{ spellID = 115176, caster = "player", filter = "BUFF" },			-- Zen Meditation
			{ spellID = 116847, caster = "player", filter = "BUFF" },			-- Rushing Jade Wind
			{ spellID = 120954, caster = "player", filter = "BUFF" },			-- Fortifying Brew
			{ spellID = 195630, caster = "player", filter = "BUFF" },			-- Elusive Brawler
			{ spellID = 215479, caster = "player", filter = "BUFF" },			-- Ironskin Brew
			{ spellID = 228563, caster = "player", filter = "BUFF" },			-- Blackout Combo
			-- Mistweaver
			{ spellID = 202090, caster = "player", filter = "BUFF" },			-- Teaching of the Monastery
			{ spellID = 116680, caster = "player", filter = "BUFF" },			-- Thunder Focus Tea
			{ spellID = 116849, caster = "player", filter = "BUFF" },			-- Life Cocoon
			{ spellID = 191840, caster = "player", filter = "BUFF" },			-- Essence Font
			{ spellID = 196725, caster = "player", filter = "BUFF" },			-- Refreshing Jade Wind
			{ spellID = 197206, caster = "player", filter = "BUFF" },			-- Uplifting Trance
			{ spellID = 197908, caster = "player", filter = "BUFF" },			-- Mana Tea
			{ spellID = 197916, caster = "player", filter = "BUFF" },			-- Lifecycles (Vivify)
			{ spellID = 197919, caster = "player", filter = "BUFF" },			-- Lifecycles (Enveloping Mist)
				-- HoTs
				{ spellID = 115175, caster = "player", filter = "BUFF" },		-- Soothing Mist
				{ spellID = 119611, caster = "player", filter = "BUFF" },		-- Renewing Mist
				{ spellID = 124682, caster = "player", filter = "BUFF" },		-- Enveloping Mist
			-- Windwalker
			{ spellID = 116768, caster = "player", filter = "BUFF" },			-- Blackout Kick!
			{ spellID = 122470, caster = "player", filter = "BUFF" },			-- Touch of Karma
			-- { spellID = 129914, caster = "player", filter = "BUFF" },			-- Power Strike
			{ spellID = 137639, caster = "player", filter = "BUFF" },			-- Storm, Earth and Fire
			{ spellID = 196741, caster = "player", filter = "BUFF" },			-- Hit Combo
			
			-- { spellID = 243435, caster = "player", filter = "BUFF" },			-- Fortifying Brew (Mistweaver)
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 2,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Monk
			{ spellID = 122278, caster = "player", filter = "CD" },				-- Dampen Harm
			{ spellID = 122783, caster = "player", filter = "CD" },				-- Diffuse Magic
			-- Brewmaster
			{ spellID = 115203, caster = "player", filter = "CD" },				-- Fortifying Brew
			{ spellID = 115176, caster = "player", filter = "CD" },				-- Zen Meditation
			{ spellID = 115399, caster = "player", filter = "CD" },				-- Black Ox Brew
			{ spellID = 132578, caster = "player", filter = "CD" },				-- Invoke Niuzao, the Black Ox
			-- Mistweaver
			{ spellID = 116849, caster = "player", filter = "CD" },				-- Life Cocoon
			{ spellID = 124081, caster = "player", filter = "CD" },				-- Zen Pulse
			-- MindWalker
			{ spellID = 123904, caster = "player", filter = "CD" },				-- Invoke Xuen, the White Tiger
			{ spellID = 152175, caster = "player", filter = "CD" },				-- Whirling Dragon Punch
			
			-- { spellID = 243435, caster = "player", filter = "CD" },				-- Fortifying Brew (Mistweaver)
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
			-- Monk
			{ spellID = 116841, caster = "player", filter = "BUFF" },			-- Tiger's Lust
			-- Brewmaster
			-- Mistweaver
			{ spellID = 115175, caster = "player", filter = "BUFF" },			-- Soothing Mist
			{ spellID = 116849, caster = "player", filter = "BUFF" },			-- Life Cocoon
			{ spellID = 119611, caster = "player", filter = "BUFF" },			-- Renewing Mist
			{ spellID = 124682, caster = "player", filter = "BUFF" },			-- Enveloping Mist
			{ spellID = 191840, caster = "player", filter = "BUFF" },			-- Essence Font
			-- Windwalker
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
			-- Monk
			{ spellID = 115078, caster = "player", filter = "DEBUFF" },			-- Elusive Brawler
			{ spellID = 119381, caster = "player", filter = "DEBUFF" },			-- Leg Sweep
			{ spellID = 196608, caster = "player", filter = "DEBUFF" },			-- Eye of the Tiger
			-- Brewmaster
			{ spellID = 121253, caster = "player", filter = "DEBUFF" },			-- Keg Smash
			{ spellID = 123725, caster = "player", filter = "DEBUFF" },			-- Breath of Fire
			{ spellID = 116189, caster = "player", filter = "DEBUFF" },			-- Provoke
			{ spellID = 117952, caster = "player", filter = "DEBUFF" },			-- Crackling Jade Lightning
			-- Mistweaver
			{ spellID = 198909, caster = "player", filter = "DEBUFF" },			-- Song of Chi-Ji
			-- Windwalker
			{ spellID = 113656, caster = "player", filter = "DEBUFF" },			-- Fist of Fury
			{ spellID = 115080, caster = "player", filter = "DEBUFF" },			-- Touch of Death
			{ spellID = 115804, caster = "player", filter = "DEBUFF" },			-- Mortal Wounds
			{ spellID = 116095, caster = "player", filter = "DEBUFF" },			-- Disable
			{ spellID = 122470, caster = "player", filter = "DEBUFF" },			-- Touch of Karma
			{ spellID = 228287, caster = "player", filter = "DEBUFF" },			-- Mark of the Crane
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
			-- Druid
			{ spellID =   1850, caster = "player", filter = "BUFF" },			-- Dash
			{ spellID =   5215, caster = "player", filter = "BUFF" },			-- Prowl
			{ spellID =  22812, caster = "player", filter = "BUFF" },			-- Barkskin
			{ spellID = 137452, caster = "player", filter = "BUFF" },			-- Displacer Beast
			-- Balance
			{ spellID =  29166, caster = "player", filter = "BUFF" },			-- Innervate
			{ spellID = 164545, caster = "player", filter = "BUFF" },			-- Solar Empowerment
			{ spellID = 164547, caster = "player", filter = "BUFF" },			-- Lunar Empowerment
			{ spellID = 194223, caster = "player", filter = "BUFF" },			-- Celestial Alignment
			{ spellID = 191034, caster = "player", filter = "BUFF" },			-- Starfall
			{ spellID = 202425, caster = "player", filter = "BUFF" },			-- Warrior of Elune
			{ spellID = 202461, caster = "player", filter = "BUFF" },			-- Stellar Drift
			{ spellID = 202770, caster = "player", filter = "BUFF" },			-- Fury of Elune
			{ spellID = 202737, caster = "player", filter = "BUFF" },			-- Blessing of Elune
			{ spellID = 202739, caster = "player", filter = "BUFF" },			-- Blessing of An'she
			-- Feral
			{ spellID =   5217, caster = "player", filter = "BUFF" },			-- Tiger's Fury
			{ spellID =  52610, caster = "player", filter = "BUFF" },			-- Savage Roar
			{ spellID =  69369, caster = "player", filter = "BUFF" },			-- Predatory Swiftness
			{ spellID =  77764, caster = "player", filter = "BUFF" },			-- Stampeding Roar (Cat Form)
			{ spellID = 102543, caster = "player", filter = "BUFF" },			-- Incarnation: King of the Jungle
			{ spellID = 135700, caster = "player", filter = "BUFF" },			-- Clearcasting
			{ spellID = 145152, caster = "player", filter = "BUFF" },			-- Bloodtalons
			{ spellID = 202060, caster = "player", filter = "BUFF" },			-- Elune's Guidance
			{ spellID = 252071, caster = "player", filter = "BUFF" },			-- Jungle Stalker
			-- Guardian
			{ spellID =  22842, caster = "player", filter = "BUFF" },			-- Frenzied Regeneration
			{ spellID =  61336, caster = "player", filter = "BUFF" },			-- Survival Instincts
			{ spellID =  93622, caster = "player", filter = "BUFF" },			-- Gore
			{ spellID = 102558, caster = "player", filter = "BUFF" },			-- Incarnation: Guardian of Ursoc
			{ spellID = 155835, caster = "player", filter = "BUFF" },			-- Bristling Fur
			{ spellID = 158792, caster = "player", filter = "BUFF" },			-- Pulverize
			{ spellID = 192081, caster = "player", filter = "BUFF" },			-- Ironfur
			{ spellID = 203975, caster = "player", filter = "BUFF" },			-- Earthwarden
			{ spellID = 213680, caster = "player", filter = "BUFF" },			-- Guardian of Elune
			{ spellID = 213708, caster = "player", filter = "BUFF" },			-- Galatic Guardian
			-- Restoration
			{ spellID =    774, caster = "player", filter = "BUFF" },			-- Rejuvenation
			{ spellID =   8936, caster = "player", filter = "BUFF" },			-- Regrowth
			{ spellID =  33763, caster = "player", filter = "BUFF" },			-- Lifebloom
			{ spellID =  33891, caster = "player", filter = "BUFF" },			-- Incarnation: Tree of Life
			{ spellID =  48438, caster = "player", filter = "BUFF" },			-- Wild Growth
			{ spellID =  48504, caster = "player", filter = "BUFF" },			-- Living Seed
			{ spellID = 102342, caster = "player", filter = "BUFF" },			-- Ironbark
			{ spellID = 102351, caster = "player", filter = "BUFF" },			-- Cenarion Ward
			{ spellID = 114108, caster = "player", filter = "BUFF" },			-- Soul of the Forest
			{ spellID = 117679, caster = "player", filter = "BUFF" },			-- Incarnation
			{ spellID = 200389, caster = "player", filter = "BUFF" },			-- Cultivation
			{ spellID = 207640, caster = "player", filter = "BUFF" },			-- Abundance
			
			-- { spellID =  16780, caster = "player", filter = "BUFF" },			-- Clearcasting (Restoration)
			-- { spellID =  77761, caster = "player", filter = "BUFF" },			-- Stampeding Roar (Bear)
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 2,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Druid
			{ spellID =  22812, caster = "player", filter = "CD" },				-- Barkskin
			-- Balance
			{ spellID =  29166, caster = "player", filter = "CD" },				-- Innervate
			{ spellID =  78675, caster = "player", filter = "CD" },				-- Solar Beam
			{ spellID = 194223, caster = "player", filter = "CD" },				-- Celestial Alignment
			{ spellID = 202359, caster = "player", filter = "CD" },				-- Astral Communion
			{ spellID = 202360, caster = "player", filter = "CD" },				-- Blessing of the Ancients
			{ spellID = 202770, caster = "player", filter = "CD" },				-- Fury of Elune
			{ spellID = 248280, caster = "player", filter = "CD" },				-- Force of Nature
			-- Feral
			{ spellID = 102543, caster = "player", filter = "CD" },				-- Incarnation: King of the Jungle
			-- Guardian
			{ spellID =  61336, caster = "player", filter = "CD" },				-- Survival Instincts
			{ spellID = 102558, caster = "player", filter = "CD" },				-- Incarnation: Guardian of Ursoc
			{ spellID = 204069, caster = "player", filter = "CD" },				-- Lunar Beam
			-- Restoration
			{ spellID =    740, caster = "player", filter = "CD" },				-- Tranquility
			{ spellID =  33891, caster = "player", filter = "CD" },				-- Incarnation: Tree of Life
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
			{ spellID =  33763, caster = "player", filter = "BUFF" },			-- Lifebloom
			{ spellID =  48438, caster = "player", filter = "BUFF" },			-- Wild Growth
			{ spellID =  48504, caster = "player", filter = "BUFF" },			-- Living Seed
			{ spellID = 102342, caster = "player", filter = "BUFF" },			-- Ironbark
			{ spellID = 102351, caster = "player", filter = "BUFF" },			-- Cenarion Ward
			{ spellID = 200389, caster = "player", filter = "BUFF" },			-- Cultivation
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
			-- Druid
			{ spellID =    339, caster = "player", filter = "DEBUFF" },			-- Entangling Roots
			{ spellID =  61391, caster = "player", filter = "DEBUFF" },			-- Typhoon
			{ spellID = 102359, caster = "player", filter = "DEBUFF" },			-- Mass Entanglement
			{ spellID =   5211, caster = "player", filter = "DEBUFF" },			-- Mighty Bash
			-- Balance
			{ spellID =  78675, caster = "player", filter = "DEBUFF" },			-- Solar Beam
			{ spellID = 164812, caster = "player", filter = "DEBUFF" },			-- Moonfire
			{ spellID = 164815, caster = "player", filter = "DEBUFF" },			-- Sunfire
			{ spellID = 197637, caster = "player", filter = "DEBUFF" },			-- Stellar Empowerment
			{ spellID = 202347, caster = "player", filter = "DEBUFF" },			-- Stellar Flare
			-- Feral
			{ spellID =   1079, caster = "player", filter = "DEBUFF" },			-- Rip
			{ spellID = 155722, caster = "player", filter = "DEBUFF" },			-- Rake
			{ spellID =  58180, caster = "player", filter = "DEBUFF" },			-- Infected Wounds
			{ spellID = 106830, caster = "player", filter = "DEBUFF" },			-- Thrash
			{ spellID = 203123, caster = "player", filter = "DEBUFF" },			-- Maims
			-- Guardian
			{ spellID =     99, caster = "player", filter = "DEBUFF" },			-- Incapacitating Roar
			{ spellID =   6795, caster = "player", filter = "DEBUFF" },			-- Growl
			{ spellID = 236748, caster = "player", filter = "DEBUFF" },			-- Intimidating Roar
			-- Regeneration
			{ spellID = 127797, caster = "player", filter = "DEBUFF" },			-- Ursol's Vortex
			
			-- { spellID = 192090, caster = "player", filter = "DEBUFF" },			-- Thrash (Bear)
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
			-- Shaman
			{ spellID =   2645, caster = "player", filter = "BUFF" },			-- Ghost Wolf
			{ spellID =  77762, caster = "player", filter = "BUFF" },			-- Lava Surge
			{ spellID = 108271, caster = "player", filter = "BUFF" },			-- Astral Shift
			{ spellID = 114050, caster = "player", filter = "BUFF" },			-- Ascendance
			{ spellID = 192082, caster = "player", filter = "BUFF" },			-- Wind Rush Totem
			-- Elemental
			{ spellID =  16166, caster = "player", filter = "BUFF" },			-- Elemental Mastery
			{ spellID =  16246, caster = "player", filter = "BUFF" },			-- Elemental Focus
			{ spellID = 108281, caster = "player", filter = "BUFF" },			-- Ancestral Guidance
			{ spellID = 118522, caster = "player", filter = "BUFF" },			-- Elemental Blast: Critical Strike
			{ spellID = 173183, caster = "player", filter = "BUFF" },			-- Elemental Blast: Haste
			{ spellID = 173184, caster = "player", filter = "BUFF" },			-- Elemental Blast: Mastery
			{ spellID = 210714, caster = "player", filter = "BUFF" },			-- Icefury
			-- Enhancement
			{ spellID = 195256, caster = "player", filter = "BUFF" },			-- Stormslash
			-- Restoration
			{ spellID =  16196, caster = "player", filter = "BUFF" },			-- Resurgence
			{ spellID =  53390, caster = "player", filter = "BUFF" },			-- Tidal Waves
			{ spellID =  61295, caster = "player", filter = "BUFF" },			-- Riptide
			{ spellID =  73685, caster = "player", filter = "BUFF" },			-- Unleash Life
			{ spellID =  79206, caster = "player", filter = "BUFF" },			-- Spiritwalker's Grace
			{ spellID = 207495, caster = "player", filter = "BUFF" },			-- Ancestral Protection Totem
			{ spellID = 216251, caster = "player", filter = "BUFF" },			-- Undulation
			{ spellID = 201633, caster = "all", filter = "BUFF" },				-- Earthen Shield
			{ spellID = 207400, caster = "player", filter = "BUFF" },			-- Ancestral Vigor
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 2,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Shaman
			{ spellID =   2825, caster = "player", filter = "CD" },				-- Bloodlust
			{ spellID = 108271, caster = "player", filter = "CD" },				-- Astral Shift
			{ spellID = 108281, caster = "player", filter = "CD" },				-- Ancestral Guidance
			-- Elemental
			{ spellID =  16166, caster = "player", filter = "BUFF" },			-- Elemental Mastery
			{ spellID =  51490, caster = "player", filter = "CD" },				-- Thunderstorm
			{ spellID = 114050, caster = "player", filter = "CD" },				-- Ascendance
			{ spellID = 117014, caster = "player", filter = "CD" },				-- Elemental Blast
			-- Enhancement
			-- Restoration
			{ spellID =  98008, caster = "player", filter = "CD" },				-- Spirit Link Totem
			{ spellID = 108280, caster = "player", filter = "CD" },				-- Healing Tide Totem
			{ spellID = 157153, caster = "player", filter = "CD" },				-- Cloudburst Totem
			{ spellID = 198838, caster = "player", filter = "CD" },				-- Earthen Shield Totem
			{ spellID = 207399, caster = "player", filter = "CD" },				-- Ancestral Protection Totem
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
			-- Shaman
			{ spellID = 192082, caster = "player", filter = "BUFF" },			-- Wind Rush Totem
			-- Elemental
			-- Enhancement
			-- Restoration
			{ spellID =  61295, caster = "player", filter = "BUFF" },			-- Riptide
			{ spellID =  73921, caster = "player", filter = "BUFF" },			-- Healing Rain
			{ spellID = 207400, caster = "player", filter = "BUFF" },			-- Ancestral Vigor
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
			-- Shaman
			-- Elemental
			{ spellID = 118905, caster = "player", filter = "DEBUFF" },			-- Lighting Surge Totem
			{ spellID = 182387, caster = "player", filter = "DEBUFF" },			-- Earthquake
			{ spellID = 188389, caster = "player", filter = "DEBUFF" },			-- Flame Stock
			{ spellID = 196840, caster = "player", filter = "DEBUFF" },			-- Frost Shock
			{ spellID = 197209, caster = "player", filter = "DEBUFF" },			-- Lighting Rod
			-- Enhancement
			-- Restoration
			-- { spellID = 188388, caster = "player", filter = "DEBUFF" },			-- Flame Stock
		},
	},
	PALADIN = {
		{
			name = "PLAYER_BUFFS",
			anchor = { "RIGHT", UIParent, "CENTER", -160, 0 },
			direction = "LEFT",
			mode = "ICON",
			num = 6,
			size = 32,
			spacing = 7,
			unit = "player",
			-- Paladin
			{ spellID =    642, caster = "player", filter = "BUFF" },			-- Divine Shield
			{ spellID =  31842, caster = "player", filter = "BUFF" },			-- Avenging Wrath
			{ spellID =   1044, caster = "player", filter = "BUFF" },			-- Blessing of Freedom
			{ spellID =   1022, caster = "player", filter = "BUFF" },			-- Blessing of Protection
			{ spellID = 221885, caster = "player", filter = "BUFF" },			-- Divine Steed
			-- Holy
			{ spellID =    498, caster = "player", filter = "BUFF" },			-- Divine Protection
			{ spellID =  31821, caster = "player", filter = "BUFF" },			-- Aura Mastery
			{ spellID =  53563, caster = "player", filter = "BUFF" },			-- Beacon of Light
			{ spellID = 156910, caster = "player", filter = "BUFF" },			-- Beacon of Faith
			{ spellID = 200025, caster = "player", filter = "BUFF" },			-- Beacon of Virtue
			{ spellID = 214202, caster = "player", filter = "BUFF" },			-- Rule of Law
			{ spellID = 223306, caster = "player", filter = "BUFF" },			-- Bestow Faith
			{ spellID = 105809, caster = "player", filter = "BUFF" },			-- Holy Avenger
			{ spellID =  54149, caster = "player", filter = "BUFF" },			-- Infusion of Light
			-- Protection
			{ spellID =  31850, caster = "player", filter = "BUFF" },			-- Ardent Defender
			{ spellID =  86659, caster = "player", filter = "BUFF" },			-- Guardian of Ancient Kings
			{ spellID = 132403, caster = "player", filter = "BUFF" },			-- Shield of Righteous
			{ spellID = 152262, caster = "player", filter = "BUFF" },			-- Seraphim
			{ spellID = 188370, caster = "player", filter = "BUFF" },			-- Consecration
			{ spellID = 204018, caster = "player", filter = "BUFF" },			-- Blessing of Spellwarding
			{ spellID = 204335, caster = "player", filter = "BUFF" },			-- Aegis of Light (or 204150)
			-- Retribution
			{ spellID = 184662, caster = "player", filter = "BUFF" },			-- Shield of Vengeance
			{ spellID = 205191, caster = "player", filter = "BUFF" },			-- Eye for a Eye
			{ spellID = 217020, caster = "player", filter = "BUFF" },			-- Zeal
			{ spellID = 223819, caster = "player", filter = "BUFF" },			-- Divine Purpose
			{ spellID = 231895, caster = "player", filter = "BUFF" },			-- Crusade
			{ spellID = 209785, caster = "player", filter = "BUFF" },			-- The Fires of Justice
			
			-- { spellID =  31884, caster = "player", filter = "BUFF" },		-- Avenging Wrath (Prot and Retri)
		},
		{
			name = "PLAYER_COOLDOWN",
			anchor = { "CENTER", UIParent, "CENTER", 0, -156 },
			direction = "DOWN",
			mode = "BAR",
			num = 2,
			size = Filger.Options.barheight,
			width = Filger.Options.barwidth,
			spacing = 7,
			unit = "player",
			-- Paladin
			{ spellID =    642, caster = "player", filter = "CD" },				-- Divine Shield
			{ spellID =  31842, caster = "player", filter = "CD" },				-- Avenging Wrath
			-- Holy
			{ spellID =    498, caster = "player", filter = "CD" },				-- Divine Protection
			{ spellID =  31821, caster = "player", filter = "CD" },				-- Aura Mastery
			{ spellID = 105809, caster = "player", filter = "CD" },				-- Holy Avenger
			{ spellID = 114158, caster = "player", filter = "CD" },				-- Light's Hammer
			-- Protection
			{ spellID =    633, caster = "player", filter = "CD" },				-- Lay on Hands
			{ spellID =  31850, caster = "player", filter = "CD" },				-- Ardent Defender
			{ spellID =  86659, caster = "player", filter = "CD" },				-- Guardian of Ancient Kings
			{ spellID = 152262, caster = "player", filter = "CD" },				-- Seraphim
			-- Retribution
			{ spellID = 184662, caster = "player", filter = "CD" },				-- Shield of Vengeance
			{ spellID = 205191, caster = "player", filter = "cD" },				-- Eye for a Eye
			{ spellID = 210220, caster = "player", filter = "CD" },				-- Holy Wrath
			{ spellID = 231895, caster = "player", filter = "CD" },				-- Crusade
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
			-- Paladin
			{ spellID =   1044, caster = "player", filter = "BUFF" },			-- Blessing of Freedom
			{ spellID =   1022, caster = "player", filter = "BUFF" },			-- Blessing of Protection
			-- Holy
			{ spellID =    498, caster = "player", filter = "BUFF" },			-- Divine Protection
			{ spellID =  31821, caster = "player", filter = "BUFF" },			-- Aura Mastery
			{ spellID =  53563, caster = "player", filter = "BUFF" },			-- Beacon of Light
			{ spellID = 156910, caster = "player", filter = "BUFF" },			-- Beacon of Faith
			{ spellID = 200025, caster = "player", filter = "BUFF" },			-- Beacon of Virtue
			{ spellID = 214202, caster = "player", filter = "BUFF" },			-- Rule of Law
			{ spellID = 223306, caster = "player", filter = "BUFF" },			-- Bestow Faith
			{ spellID = 105809, caster = "player", filter = "BUFF" },			-- Holy Avenger
			-- Protection
			{ spellID = 204018, caster = "player", filter = "BUFF" },			-- Blessing of Spellwarding
			-- Retribution
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
			-- Paladin
			{ spellID =    853, caster = "player", filter = "DEBUFF" },			-- Hammer of Justice
			{ spellID =  20066, caster = "player", filter = "DEBUFF" },			-- Repentance
			{ spellID =  62124, caster = "player", filter = "DEBUFF" },			-- Hand of Reckoning
			{ spellID = 105421, caster = "player", filter = "DEBUFF" },			-- Blinding Light
			{ spellID = 204242, caster = "player", filter = "DEBUFF" },			-- Consecration
			{ spellID = 196941, caster = "player", filter = "DEBUFF" },			-- Judgment of Light
			-- Holy
			{ spellID = 214222, caster = "player", filter = "DEBUFF" },			-- Judgment
			-- Protection
			{ spellID =  31935, caster = "player", filter = "DEBUFF" },			-- Avenger's Shield
			{ spellID = 204301, caster = "player", filter = "DEBUFF" },			-- Blessed Hammer
			-- Retribution
			{ spellID = 183218, caster = "player", filter = "DEBUFF" },			-- Hand of Hindrance
			{ spellID = 213757, caster = "player", filter = "DEBUFF" },			-- Execution Sentence
			-- { spellID = 197277, caster = "player", filter = "DEBUFF" },			-- Judgment (Retribution)
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
			{ spellID =   2825, caster = "all", filter = "BUFF" },				-- Bloodlust (Shaman Horde)
			{ spellID =  32182, caster = "all", filter = "BUFF" },				-- Heroism (Shaman Alliance)
			{ spellID =  80353, caster = "all", filter = "BUFF" },				-- Time Warp (Mage)
			{ spellID =  90355, caster = "all", filter = "BUFF" },				-- Ancient Hysteria	(Core Hound)
			{ spellID = 160452, caster = "all", filter = "BUFF" },				-- Netherwinds (Nether Ray)
			
			{ spellID =  97463, caster = "all", filter = "BUFF" },				-- Commanding Shout (Warrior)
			{ spellID =  57934, caster = "all", filter = "BUFF" },				-- Tricks of the Trade (Rogue)
			
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