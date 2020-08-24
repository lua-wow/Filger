local _, ns = ...
local Config = ns.Config

----------------------------------------------------------------
-- Config
----------------------------------------------------------------
local xOffset = 200
local yOffset = 39

Config["General"] = {

    ["ConfigMode"] = false,                         -- enables config mode for help on position frames.

    ["IconSize"] = 32,                              -- sets icons size.
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

    -- Left
    ["PlayerAllAuras"] = { "RIGHT", UIParent, "CENTER", -xOffset, -yOffset },

    ["PlayerAuras"] = { "RIGHT", UIParent, "CENTER", -xOffset, 0 },

    ["PlayerRaidAuras"] = { "RIGHT", UIParent, "CENTER", -xOffset, -2 * yOffset },
    ["BossDebuffs"] = { "RIGHT", UIParent, "CENTER", -xOffset, yOffset },
    ["PvPDebuffs"] = { "RIGHT", UIParent, "CENTER", -xOffset, -3 * yOffset },
    ["PlayerCooldowns"] = { "CENTER", UIParent, "CENTER", 0, -7 * yOffset },

    -- Right
    ["TargetAuras"] = { "LEFT", UIParent, "CENTER", xOffset, 0 },
    ["TargetDebuffs"] = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
    -- ["FocusAuras"] = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
    ["BossBuffs"] = { "LEFT", UIParent, "CENTER", xOffset, yOffset },
}

Config["BlackList"] = {
    ----------------------------------------------------------------
    -- Druid
    ----------------------------------------------------------------
    [1126] = true,              -- Mark of the Wild (Rank 1)
    [5232] = true,              -- Mark of the Wild (Rank 2)
    [6756] = true,              -- Mark of the Wild (Rank 3)
    [5234] = true,              -- Mark of the Wild (Rank 4)
    [8907] = true,              -- Mark of the Wild (Rank 5)
    [9884] = true,              -- Mark of the Wild (Rank 6)
    [9885] = true,              -- Mark of the Wild (Rank 7)

    [21849] = true,             -- Gift of the Wild (Rank 1)
    [21850] = true,             -- Gift of the Wild (Rank 2)

    ----------------------------------------------------------------
    -- Mage
    ----------------------------------------------------------------
    [1459] = true,              -- Arcane Intellect (Rank 1)
    [1460] = true,              -- Arcane Intellect (Rank 2)
    [1461] = true,              -- Arcane Intellect (Rank 3)
    [10156] = true,             -- Arcane Intellect (Rank 4)
    [10157] = true,             -- Arcane Intellect (Rank 5)

    ----------------------------------------------------------------
    -- Priest
    ----------------------------------------------------------------
    [1243] = true,              -- Power Word: Fortitude (Rank 1)
    [1244] = true,              -- Power Word: Fortitude (Rank 2)
    [1245] = true,              -- Power Word: Fortitude (Rank 3)
    [2791] = true,              -- Power Word: Fortitude (Rank 4)
    [10937] = true,             -- Power Word: Fortitude (Rank 5)
    [10938] = true,             -- Power Word: Fortitude (Rank 6)

    [976] = true,               -- Shadow Protection (Rank 1)
    [10957] = true,             -- Shadow Protection (Rank 2)
    [10958] = true,             -- Shadow Protection (Rank 3)

    [27681] = true,             -- Prayer of Spirit (Rank 1)
    [14818] = true,             -- Prayer of Spirit (Rank 2)
    [14819] = true,             -- Prayer of Spirit (Rank 3)
    [27841] = true,             -- Prayer of Spirit (Rank 4)
    
    [21562] = true,             -- Prayer of Fortitude (Rank 1)
}