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
    [72221] = true,                 -- Luck of the Draw

    [186401] = true,                -- Sign of the Skirmisher
    [186403] = true,                -- Sign of Battle
    [186406] = true,                -- Sign of the Critter
    [225788] = true,                -- Sign of the Emissary
    [331079] = true,                -- Trainee
    [335148] = true,                -- Sign of the Twisting Nether
    [335149] = true,                -- Sign of the Scourge
    [335150] = true,                -- Sign of the Destroyer
    [335151] = true,                -- Sign of the Mists
    [335152] = true,                -- Sign of Iron

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
    ["PALADIN"] = {
        -- All
        [498] = true,               -- Divine Protection
        [642] = true,               -- Divine Shield
        [633] = true,               -- Lay on Hands
        [1022] = true,              -- Blessing of Protection
        [1044] = true,              -- Blessing of Freedom
        [6940] = true,              -- Blessing of Sacrifice

        -- Protection
        [31850] = true,             -- Ardent Defender
        [86659] = true,             -- Guardian of Ancient Kings
        [152262] = true,            -- Seraphim
    },
    ["PRIEST"] = {
        -- All
        [10060] = true,             -- Power Infusion
        [19236] = true,             -- Desperate Prayer
        [34433] = true,             -- Shadowfiend
        [73325] = true,             -- Leap of Faith

        -- Disciplie
        [33206] = true,             -- Pain Suppression
        [47536] = true,             -- Rapture
        [62618] = true,             -- Power Word: Barrier
        [109964] = true,            -- Spirit Shell
        [120517] = true,            -- Halo
        [194509] = true,            -- Power Word: Radiance
        [246287] = true,            -- Evangelism

        -- Holy
        [2050] = true,              -- Holy Word: Serenity
        [64901] = true,             -- Symbol of Hope
        [34861] = true,             -- Holy Word: Sanctify
        [33076] = true,             -- Prayer of Mending
        [47788] = true,             -- Guardian Spirit
        [64843] = true,             -- Divine Hymn
        [200183] = true,            -- Apotheosis
        [204883] = false,           -- Circle of Healing

        -- Shadow
        [15286] = true,             -- Vampiric Embrace
        [47585] = true,             -- Dispersion
        [205369] = true             -- Mind Bomb
    },
    ["WARRIOR"] = {
        -- All
        [1161] = true,              -- Challenging Shout
        [2565] = true,              -- Shield Block (Rank 1)
        [3411] = true,              -- Intervene
        [6544] = true,              -- Heroic Leap
        [18499] = true,             -- Berserker Rage
        [97462] = true,             -- Rallying Cry (Rank 1)
        [190456] = true,            -- Ignore Pain
        [231847] = true,            -- Shield Block (Rank 2)
        [316825] = true,            -- Rallying Cry (Rank 2)

        -- Protection
        [871] = true,               -- Shield Wall
        [12975] = true,             -- Last Stand
        [107574] = true,            -- Avatar
        [316438] = true,            -- Avatar (Rank 2)
        [316778] = true,            -- Ignore Pain (Rank 2)
        [316834] = true             -- Shield Wall
    },
    ["ALL"] = {
        -- Horde Racials
        [20549] = true,             -- War Stomp (Tauren)
        [20572] = true,             -- Blood Fury (Orc)
        [26297] = true,             -- Berserking (Troll)
        [28730] = true,             -- Arcane Torrent (Blood Elf)
        [33697] = true,             -- Blood Fury (Orc)
        [255654] = true,            -- Bull Rush (Highmountain Tauren)

        -- Alliance Racials
        [20594] = true,             -- Stoneform (Dwarf)
        [265221] = true,            -- Fireblood Fury (Dark Iron Dwarf)

        -- Kyrian
        [324739] = false,           -- Summon Steward

        -- Ventyr
        [323673] = true,            -- Mindgames
    }
}
