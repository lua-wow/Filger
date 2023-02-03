local _, ns = ...
local Config = ns.Config

----------------------------------------------------------------
-- Config
----------------------------------------------------------------
local xOffset, yOffset = 200, 39

Config["General"] = {

    ["ConfigMode"] = false,                         -- enables config mode for help on position frames.

    ["IconSize"] = 35,                              -- sets icons size.
    ["IconSpacing"] = 3,                            -- sets space between icons.

    ["BarWidth"] = 200,                             -- sets bar width.
    ["BarHeight"] = 18,                             -- sets bar height.
    ["BarSpacing"] = 7,                             -- sets space between bars.
    ["ClassColor"] = true,                          -- sets status bar color by class.

    ["HideWellFed"] = true,                         -- enabled filter to hide well fed buff (too many spells with this name)

    ["BackdropColor"] = { .05, .05, .05 },
    ["BorderColor"] = { .125, .125, .125 },
}

Config["Plugins"] = {
    ["Tracer"] = false,                              -- enables aura tracer plugins.
}

Config["Panels"] = {
    -- LEFT
    {
        enabled = true,
        name = "PLAYER_AURAS",
        anchor = { "RIGHT", UIParent, "CENTER", -xOffset, 0 },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = 'BOTTOMRIGHT',
        ['growth-x'] = "LEFT",
        ['growth-y'] = "DOWN",

        filter = "PLAYER|HELPFUL",
        unit = "player",
        caster = "player",
        showOnlyPlayer = true
    }, -- [1]
    {
        enabled = true,
        name = "PLAYER_DEBUFFS",
        anchor = { "RIGHT", UIParent, "CENTER", -xOffset, -yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = 'BOTTOMRIGHT',
        ['growth-x'] = "LEFT",
        ['growth-y'] = "DOWN",

        filter = "HARMFUL",
        unit = "player",
        caster = "all",
        isDebuff = true
    }, -- [2]
    {
        enabled = true,
        name = "PLAYER_BUFFS",
        anchor = { "RIGHT", UIParent, "CENTER", -xOffset, yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = 'BOTTOMRIGHT',
        ['growth-x'] = "LEFT",
        ['growth-y'] = "DOWN",

        filter = "HELPFUL",
        unit = "player",
        caster = "all",
        hidePlayer = true
    }, -- [3]

    -- RIGHT
    {
        enabled = true,
        name = "TARGET_AURAS",
        anchor = { "LEFT", UIParent, "CENTER", xOffset, 0 },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = 'BOTTOMLEFT',
        ['growth-x'] = "RIGHT",
        ['growth-y'] = "DOWN",

        filter = "HELPFUL",
        unit = "target",
        caster = "player",
        showOnlyPlayer = false
    }, -- [4]
    {
        enabled = true,
        name = "TARGET_DEBUFFS",
        anchor = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = 'BOTTOMLEFT',
        ['growth-x'] = "RIGHT",
        ['growth-y'] = "DOWN",

        filter = "HARMFUL",
        unit = "target",
        caster = "player",
        isDebuff = true
    }, -- [5]
    {
        enabled = true,
        name = "PLAYER_COOLDOWNS",
        anchor = { "CENTER", UIParent, "BOTTOM", 0, 259 },
        limit = 8,
        size = 38,
        max_size = 40,
        spacing = 3,
        initialAnchor = "CENTER",
        ['growth-x'] = "CENTER",
        ['growth-y'] = "CENTER",

        filter = "COOLDOWN",
        unit = "player",
        caster = "player"
    } -- [6]
}

-- List of spells that do not need to be displayed
Config["BlackList"] = {

    ----------------------------------------------------------------
    -- Mage
    ----------------------------------------------------------------
    [1459] = true,                  -- Arcane Intellect

    ----------------------------------------------------------------
    -- Monk
    ----------------------------------------------------------------
    [389684] = true,                -- Close to Heart

    ----------------------------------------------------------------
    -- Priest
    ----------------------------------------------------------------
    [21562] = true,                 -- Power Word: Fortitude

    ----------------------------------------------------------------
    -- Paladin
    ----------------------------------------------------------------
    [465] = true,                   -- Power Word: Fortitude

    ----------------------------------------------------------------
    -- General
    ----------------------------------------------------------------
    -- World Buffs
    [72221] = true,                 -- Luck of the Draw

    [186401] = true,                -- Sign of the Skirmisher
    [186403] = true,                -- Sign of Battle
    [186406] = true,                -- Sign of the Critter
    [225787] = true,                -- Sign of the Warrior
    [225788] = true,                -- Sign of the Emissary
    [331079] = true,                -- Trainee
    [335148] = true,                -- Sign of the Twisting Nether
    [335149] = true,                -- Sign of the Scourge
    [335150] = true,                -- Sign of the Destroyer
    [335151] = true,                -- Sign of the Mists
    [335152] = true,                -- Sign of Iron
    [359082] = true,                -- Sign of the Legion
    [347600] = true,                -- Infused Ruby Tracking
    [388598] = true,                -- Ride Along
    [388588] = true,                -- Ride Along
    [388600] = true,                -- Ride Along

    [245686] = true,                -- Fashionable!

    -- Shrine of two Moons
    [131526] = true,                -- Cyclonic Inspiration

    -- Food
    [257427] = true,                -- Food & Drink
    -- [257410] = true,                -- Well Fed
    -- [288075] = true,                -- Well Fed
    -- [308525] = true,                -- Well Fed
    -- [308434] = true,                -- Well Fed

    -- Costumes
    [93095] = true,                 -- Burgy Blackheart's Handsome Hat
    [160331] = true,                -- Blood Elf Illusion
    [331462] = true,                -- Stinky
    [134522] = true,                -- Dressed to Kill
    [96312] = true,                 -- Kalytha's Haunted Locked
    [16739] = true,                 -- Orb of Deception

    -- Mounts
    [297871] = true,                -- Anglers' Water Striders

    -- Toys
    [355462] = true,                -- Reliquary Sight
    [329289] = true                 -- Music of Bastion
}

Config["Cooldowns"] = {
    ["MONK"] = {
        -- All
        { spellID = 116841, check = true },            -- Tiger Lust
        { spellID = 322101, check = false },           -- Expel Harm

        -- Brewmaster
        { spellID = 322507, check = true },            -- Celestial Brew
        { spellID = 115203, check = true },            -- Fortifying Brew
        { spellID = 119582, check = true },            -- Purifiying Brew
        { spellID = 122278, check = true },            -- Dumpen Harm
        { spellID = 122783, check = true },            -- Diffuse Magic
        { spellID = 132578, check = true },            -- Invoke Niuzao, the Black Ox
        { spellID = 386276, check = true },            -- Bonedust Brew
        -- Kyrian
        { spellID = 387184, check = true },             -- Weapons of Order
    },
    ["PALADIN"] = {
        -- All
        { spellID = 498, check = true },                -- Divine Protection
        { spellID = 642, check = true },                -- Divine Shield
        { spellID = 633, check = true },                -- Lay on Hands
        { spellID = 1022, check = true },               -- Blessing of Protection
        { spellID = 1044, check = true },               -- Blessing of Freedom
        { spellID = 6940, check = true },               -- Blessing of Sacrifice

        -- Protection
        { spellID = 31850, check = true },              -- Ardent Defender
        { spellID = 86659, check = true },              -- Guardian of Ancient Kings
        { spellID = 152262, check = true },             -- Seraphim
    },
    ["PRIEST"] = {
        -- All
        { spellID = 10060, check = true },              -- Power Infusion
        { spellID = 19236, check = true },              -- Desperate Prayer
        { spellID = 34433, check = true },              -- Shadowfiend
        { spellID = 73325, check = true },              -- Leap of Faith

        -- Disciplie
        { spellID = 33206, check = true },              -- Pain Suppression
        { spellID = 47536, check = true },              -- Rapture
        { spellID = 62618, check = true },              -- Power Word: Barrier
        { spellID = 109964, check = true },             -- Spirit Shell
        { spellID = 120517, check = true },             -- Halo
        { spellID = 194509, check = true },             -- Power Word: Radiance
        { spellID = 246287, check = true },             -- Evangelism

        -- Holy
        { spellID = 2050, check = true },               -- Holy Word: Serenity
        { spellID = 64901, check = true },              -- Symbol of Hope
        { spellID = 34861, check = true },              -- Holy Word: Sanctify
        { spellID = 33076, check = true },              -- Prayer of Mending
        { spellID = 47788, check = true },              -- Guardian Spirit
        { spellID = 64843, check = true },              -- Divine Hymn
        { spellID = 200183, check = true },             -- Apotheosis
        { spellID = 204883, check = false },            -- Circle of Healing

        -- Shadow
        { spellID = 15286, check = true },              -- Vampiric Embrace
        { spellID = 47585, check = true },              -- Dispersion
        { spellID = 205369, check = true },             -- Mind Bomb
    },
    ["WARRIOR"] = {
        -- All
        { spellID = 1161, check = true },               -- Challenging Shout
        { spellID = 2565, check = true },               -- Shield Block (Rank 1)
        { spellID = 3411, check = true },               -- Intervene
        { spellID = 6544, check = true },               -- Heroic Leap
        { spellID = 18499, check = true },              -- Berserker Rage
        { spellID = 97462, check = true },              -- Rallying Cry (Rank 1)
        { spellID = 190456, check = true },             -- Ignore Pain
        { spellID = 231847, check = true },             -- Shield Block (Rank 2)
        { spellID = 316825, check = true },             -- Rallying Cry (Rank 2)

        -- Protection
        { spellID = 871, check = true },                -- Shield Wall
        { spellID = 12975, check = true },              -- Last Stand
        { spellID = 23920, check = true },              -- Spell Reflection
        { spellID = 107574, check = true },             -- Avatar
        { spellID = 316438, check = true },             -- Avatar (Rank 2)
        { spellID = 316778, check = true },             -- Ignore Pain (Rank 2)
        { spellID = 316834, check = true },             -- Shield Wall
        { spellID = 107570, check = true },             -- Storm Bolt
    },
    ["ALL"] = {
        -- Horde Racials
        { spellID = 20549, check = true },              -- War Stomp (Tauren)
        { spellID = 20572, check = true },              -- Blood Fury (Orc)
        { spellID = 26297, check = true },              -- Berserking (Troll)
        { spellID = 28730, check = true },              -- Arcane Torrent (Blood Elf)
        { spellID = 33697, check = true },              -- Blood Fury (Orc)
        { spellID = 255654, check = true },             -- Bull Rush (Highmountain Tauren)

        -- Alliance Racials
        { spellID = 20594, check = true },              -- Stoneform (Dwarf)
        { spellID = 265221, check = true },             -- Fireblood Fury (Dark Iron Dwarf)

        -- Kyrian
        { spellID = 324739, check = false },            -- Summon Steward

        -- Ventyr
        { spellID = 323673, check = true },             -- Mindgames
        { spellID = 300728, check = true },             -- Door of Shadows

        -- Necrolords
        { spellID = 324143, check = true },             -- Conqueror's Banner
        { spellID = 324631, check = true },             -- Fleshcraft

        -- Gear
        { slotID = 2, check = true },                   -- Neck
        { slotID = 6, check = true },                   -- Waist
        { slotID = 13, check = true },                  -- Trinket 1
        { slotID = 14, check = true },                  -- Trinket 2

        -- Potions
        { itemID = 76089, check = true },               -- Virmen's Bite
        { itemID = 127834, check = true },              -- Acient Healing Potion
        { itemID = 163225, check = true },              -- Battle Potion of Stamina
        { itemID = 180318, check = true },              -- Soulful Mana Potion
    }
}
