local _, ns = ...
local Config = ns.Config

----------------------------------------------------------------
-- Config
----------------------------------------------------------------
local xOffset = 200
local yOffset = 39

Config["General"] = {

    ["ConfigMode"] = false,                         -- enables config mode for help on position frames.

    ["IconSize"] = 35,                              -- sets icons size.
    ["IconSpacing"] = 3,                            -- sets space between icons.

    ["BarWidth"] = 200,                             -- sets bar width.
    ["BarHeight"] = 18,                             -- sets bar height.
    ["BarSpacing"] = 7,                             -- sets space between bars.
    ["ClassColor"] = true,                          -- sets status bar color by class.

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
    [331079] = true,                -- Trainee
    [335151] = true,                -- Sign of the Mists
    [335148] = true,                -- Sign of the Twisting Nether
    [186406] = true,                -- Sign of the Critter
    [186401] = true,                -- Sign of the Skirmisher

    -- Food
    [257427] = true,                -- Food & Drink
    [257410] = true,                -- Well Fed
    [288075] = true,                -- Well Fed

    -- Costumes
    [93095] = true,                 -- Burgy Blackheart's Handsome Hat
    [160331] = true,                -- Blood Elf Illusion
    [331462] = true,                -- Stinky
}

Config["Cooldowns"] = {
    ["PRIEST"] = {
        -- All
        [10060] = true,             -- Power Infusion
        [73325] = true,             -- Leap of Faith

        -- Shadow
        [15286] = true,             -- Vampiric Embrace
        [34433] = true,             -- Shadowfiend
        [47585] = true,             -- Dispersion
        [205369] = true             -- Mind Bomb
    },
    ["MONK"] = {
        -- All
        [116841] = true,            -- Tiger Lust
        [322101] = false,           -- Expel Harm

        -- Brewmaster
        [322507] = true,            -- Celestial Brew
        [115203] = true,            -- Fortifying Brew
        [119582] = true,            -- Purifiying Brew
        [122278] = true,            -- Dumpen Harm
        [132578] = true,            -- Invoke Niuzao, the Black Ox

        -- Kyrian
        [310454] = true             -- Weapons of Order
    },
    ["ALL"] = {
        -- Horde Racials
        [122] = true,               -- Berserking (Troll)
        [28730] = true,             -- Arcane Torrent (Blood Elf)
        [20549] = true,             -- War Stomp (Tauren)
        [20572] = true,             -- Blood Fury (Orc)
        [33697] = true,             -- Blood Fury (Orc)
        [255654] = true,            -- Bull Rush (Highmountain Tauren)

        -- Alliance Racials
        [20594] = true,             -- Stoneform (Dwarf)
        [265221] = true,            -- Fireblood Fury (Dark Iron Dwarf)

        -- Kyrian
        [324739] = false            -- Summon Steward
    }
}
