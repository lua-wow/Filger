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
    } -- [5]
}

-- List of spells that do not need to be displayed
Config["BlackList"] = {

    ----------------------------------------------------------------
    -- Mage
    ----------------------------------------------------------------
    [1459] = true,              -- Arcane Intellect

    ----------------------------------------------------------------
    -- Priest
    ----------------------------------------------------------------
    [21562] = true,             -- Power Word: Fortitude

    ----------------------------------------------------------------
    -- Paladin
    ----------------------------------------------------------------
    [465] = true,               -- Power Word: Fortitude

    ----------------------------------------------------------------
    -- General
    ----------------------------------------------------------------
    [186406] = true,            -- Sign of the Critter
    [160331] = true,            -- Blood Elf Illusion
    [257427] = true,            -- Food & Drink
    [257410] = true,            -- Well Fed
    [288075] = true,            -- Well Fed
    [335151] = true,            -- Sign of the Mists
}
