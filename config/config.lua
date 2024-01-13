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
    ["Gametoolip"] = true,                          -- enabled tooltips

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
            local isMine = ((caster == "player") or (caster == "vehicle") or (caster == "pet"))
            return (isMine) or (isBossDebuff) or (caster == nil and not casterIsPlayer)
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
    -- RIGHT
    {
        enabled = true,
        name = "FOCUS_DEBUFFS",
        anchor = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        initialAnchor = "BOTTOMLEFT",
        ["growth-x"] = "RIGHT",
        ["growth-y"] = "DOWN",

        filter = "HARMFUL",
        unit = "focus",
        CustomFilter = function(element, ...)
            local unit, aura, name, texture,
            count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
            canApply, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, effect1, effect2, effect3 = ...
            return not UnitIsPlayer(caster or "none")
        end
    }, 

    -- CENTRAL
    {
        enabled = false,
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
            return isBossDebuff or (not casterIsPlayer) or (caster == nil)
        end
    }, -- [6]
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
    } -- [7]
}
