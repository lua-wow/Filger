local _, ns = ...
local Config = ns.Config

------------------------------------------------------------
-- Config
------------------------------------------------------------
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

    ------------------------------------------------------------
    -- Mage
    ------------------------------------------------------------
    [1459] = true,                  -- Arcane Intellect

    ------------------------------------------------------------
    -- Monk
    ------------------------------------------------------------
    [389684] = true,                -- Close to Heart

    ------------------------------------------------------------
    -- Priest
    ------------------------------------------------------------
    [21562] = true,                 -- Power Word: Fortitude

    ------------------------------------------------------------
    -- Paladin
    ------------------------------------------------------------
    [465] = true,                   -- Power Word: Fortitude

    ------------------------------------------------------------
    -- General
    ------------------------------------------------------------
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
    [360954] = true,                -- Ride Along
    [388598] = true,                -- Ride Along
    [388588] = true,                -- Ride Along
    [388600] = true,                -- Ride Along
    [397734] = true,                -- Word of a Worthy Ally

    [245686] = true,                -- Fashionable!

    -- Shrine of two Moons
    [131526] = true,                -- Cyclonic Inspiration

    -- Food
    [257427] = true,                -- Food & Drink

    -- Costumes
    [93095] = true,                 -- Burgy Blackheart's Handsome Hat
    [160331] = true,                -- Blood Elf Illusion
    [331462] = true,                -- Stinky
    [134522] = true,                -- Dressed to Kill
    [96312] = true,                 -- Kalytha's Haunted Locked
    [16739] = true,                 -- Orb of Deception
    [8219] = true,                  -- Flip Out

    -- Mounts
    [297871] = true,                -- Anglers' Water Striders

    -- Toys
    [355462] = true,                -- Reliquary Sight
    [329289] = true                 -- Music of Bastion
}

Config["Cooldowns"] = {
    ["ALL"] = {
        -- Horde Racials
        { spellID = 7744, check = true },               -- Will of the Forsaken (Undead)
        { spellID = 20549, check = true },              -- War Stomp (Tauren)
        { spellID = 20572, check = true },              -- Blood Fury (Orc)
        { spellID = 26297, check = true },              -- Berserking (Troll)
        { spellID = 28730, check = true },              -- Arcane Torrent (Blood Elf)
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
        -- { itemID = 76089, check = true },               -- Virmen's Bite
        -- { itemID = 127834, check = true },              -- Acient Healing Potion
        -- { itemID = 163225, check = true },              -- Battle Potion of Stamina
        -- { itemID = 180318, check = true },              -- Soulful Mana Potion
    }
}

function ns.Config.importCooldowns(tbl)
    for class, spells in pairs(tbl) do
        if (not Config["Cooldowns"][class]) then
            Config["Cooldowns"][class] = spells
        elseif (#spells > 0) then
            for i, spell in ipairs(spells) do
                table.insert(Config["Cooldowns"][class], spell)
            end
        end
    end
end

-- function ns.Config.BlackList:import(spells)
--     for spellID, check in pairs(spells) do
--         print(spellID, check)
--         -- self[spellID] = check
--     end
-- end
