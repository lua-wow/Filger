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

--[[
    * filter    -- list of filters, separated by spaces or pipes. "HELPFUL" by default.
        -- "HELPFUL"                    : Buffs
        -- "HARMFUL"                    : Debuffs
        -- "PLAYER"                     : Auras Debuffs applied by the player
        -- "RAID"                       : Buffs the player can apply and debuffs the player can dispell
        -- "CANCELABLE"                 : Buffs that can be cancelled with /cancelaura or CancelUnitBuff()
        -- "NOT_CANCELABLE"             : Buffs that cannot be cancelled
        -- "INCLUDE_NAME_PLATE_ONLY"    : Auras that should be shown on nameplates
        -- "MAW"                        : Torghast Anima Powers
    * unit              -- unit whose auras to query. ("player", "target", "focus", etc.)
    * caster            -- aura caster.
    * showOnlyPlayer    --
    * isDebuff          -- 
    * hidePlayer        --
]]
Config["Panels"] = {
    -- LEFT
    -- displays all debuffs on player
    {
        enabled = true,
        name = "PLAYER_DEBUFFS",
        anchor = { "RIGHT", UIParent, "CENTER", -xOffset, yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMRIGHT",
        ["growth-x"] = "LEFT",
        ["growth-y"] = "DOWN",

        filter = "HARMFUL",
        unit = "player",
        caster = nil
    }, -- [1]

    -- displays all buffs casted by the player on itself.
    {
        enabled = true,
        name = "PLAYER_AURAS",
        anchor = { "RIGHT", UIParent, "CENTER", -xOffset, 0 },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMRIGHT",
        ["growth-x"] = "LEFT",
        ["growth-y"] = "DOWN",

        filter = "PLAYER|HELPFUL",
        unit = "player",
        CustomFilter = function(element, ...)
            local unit, aura, name, texture,
            count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
            canApply, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, effect1, effect2, effect3 = ...

            -- print(element.name, unit, name, spellID, caster, canApply, isBossDebuff, casterIsPlayer)
            return (caster == "player" or caster == "vehicle" or caster == "pet")
        end
    }, -- [2]
    {
        enabled = true,
        name = "PLAYER_BUFFS",
        anchor = { "RIGHT", UIParent, "CENTER", -xOffset, -yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMRIGHT",
        ["growth-x"] = "LEFT",
        ["growth-y"] = "DOWN",

        filter = "HELPFUL",
        unit = "player",
        caster = "all",
        hidePlayer = true,
        CustomFilter = function(element, ...)
            local unit, aura, name, texture,
            count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
            canApply, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, effect1, effect2, effect3 = ...

            -- return (not canApply)
            if (aura.isPlayer) then
                return false
            end
            
            return true
        end
    }, -- [3]

    -- RIGHT
    {
        enabled = true,
        name = "TARGET_DEBUFFS",
        anchor = { "LEFT", UIParent, "CENTER", xOffset, yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMLEFT",
        ["growth-x"] = "RIGHT",
        ["growth-y"] = "DOWN",

        filter = "HARMFUL",
        unit = "target",
        CustomFilter = function(element, ...)
            local unit, aura, name, texture,
            count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
            canApply, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, effect1, effect2, effect3 = ...
            -- if target is player itself
            -- local targetIsPlayer = (UnitGUID(unit) == UnitGUID("player"))
            local isPlayerDebuff = ((caster == "player") or (caster == "vehicle") or (caster == "pet"))
            return (isPlayerDebuff) or (isBossDebuff)
        end
    }, -- [4]
    {
        enabled = true,
        name = "TARGET_AURAS",
        anchor = { "LEFT", UIParent, "CENTER", xOffset, 0 },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMLEFT",
        ["growth-x"] = "RIGHT",
        ["growth-y"] = "DOWN",

        filter = "HELPFUL",
        unit = "target",
        caster = nil
    }, -- [5]

    {
        enabled = true,
        name = "BOSS_DEBUFFS",
        anchor = { "CENTER", UIParent, "CENTER", 0, 160 },
        limit = 1,
        size = (2 * Config["General"].IconSize),
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMLEFT",
        ["growth-x"] = "RIGHT",
        ["growth-y"] = "DOWN",

        filter = "HARMFUL",
        unit = "player",
        CustomFilter = function(element, ...)
            local unit, aura, name, texture,
            count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
            canApply, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, effect1, effect2, effect3 = ...
            return isBossDebuff
        end
    },

    -- CENTRAL
    {
        enabled = true,
        name = "PLAYER_COOLDOWNS",
        anchor = { "CENTER", UIParent, "BOTTOM", 0, 259 },
        limit = 8,
        size = 38,
        max_size = 40,
        spacing = 3,
        initialAnchor = "CENTER",
        ["growth-x"] = "CENTER",
        ["growth-y"] = "CENTER",

        filter = "COOLDOWN",
        unit = "player",
        caster = "player"
    } -- [6]
}

-- List of spells that do not need to be displayed
Config["BlackList"] = {

    -- Druid
    [1126] = true,                  -- Mark of the Wild

    -- Mage
    [1459] = true,                  -- Arcane Intellect

    -- -- Monk
    -- [389684] = true,                -- Close to Heart

    -- Priest
    [21562] = true,                 -- Power Word: Fortitude
    [232698] = true,                -- Shadowform

    -- -- Paladin
    [465] = true,                   -- Devotion Aura
    [32223] = true,                 -- Crusader Aura
    [183435] = true,                -- Retribution Aura
    [317920] = true,                -- Concentration Aura

    -- World Buffs
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
    [397734] = true,                -- Word of a Worthy Ally
    [394006] = true,                -- Rockin' Mining Gear
    
    -- Mounts
    ["Ride Along"] = true,
    [297871] = true,                -- Anglers' Water Stiders
    [388376] = true,                -- Dragonrider's Compassion

    -- Food
    ["Well Fed"] = true,

    -- Costumes
    [8219] = true,                  -- Flip Out
    [16739] = true,                 -- Orb of Deception
    [58501] = true,                 -- Iron Boot Flask
    [61340] = true,                 -- Frenzyheart Brew
    [75532] = true,                 -- Darkspear Pride
    [74589] = true,                 -- Identity Crisis
    [93095] = true,                 -- Burgy Blackheart's Handsome Hat
    [96312] = true,                 -- Kalytha's Haunted Locked
    [101185] = true,                -- Levara's Locket
    [127315] = true,                -- Skymirror Image
    [129023] = true,                -- Surgical Alterations
    [134522] = true,                -- Dressed to Kill
    [149229] = true,                -- Celestial Defender
    [160331] = true,                -- Blood Elf Illusion
    [165185] = true,                -- Bloodclaw Charm
    [289184] = true,                -- Dark Banner's Spare Cowl
    [399502] = true,                -- Atomically Recalibrated
    [328906] = true,                -- Envious Glimmer

    -- Gear
    [331462] = true,                -- Stinky

    -- War Mode
    [269083] = true,                -- Enlisted
    [282559] = true                 -- Enlisted
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

function ns.Config.importBlackList(tbl)
    for spellID, check in pairs(tbl) do
        table.insert(Config["BlackList"], { [spellID] = check })
    end
end
