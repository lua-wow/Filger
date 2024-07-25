local _, ns = ...
local Filger = ns.Filger

local class = Filger.class
local cooldowns = Filger.cooldowns or {}
local spells = Filger.spells or {}

------------------------------------------------------------
-- Config
------------------------------------------------------------
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

local size = 35
local spacing = 5
local xOffset, yOffset = 200, 39

Filger.config = {
    ["general"] = {
        ["backdrop"] = {
            ["color"] = Filger:CreateColor(0.15, 0.15, 0.15)
        },
        ["border"] = {
            ["color"] = Filger:CreateColor(0.00, 0.00, 0.00),
            ["size"] = 1
        },
        ["well_fed"] = false,                                   -- enabled filter to hide well fed buff (too many spells with this name)
        ["gametooltip"] = true,                                 -- enabled tooltips
    },
    ["frames"] = {
        -- LEFT
        ["PLAYER_DEBUFFS"] = {
            enabled = true,
            unit = "player",
            filter = "HARMFUL",
            anchor = { "RIGHT", UIParent, "CENTER", -xOffset, yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMRIGHT",
            ["growth-x"] = "LEFT",
            ["growth-y"] = "DOWN"
        },
        ["PLAYER_AURAS"] = {
            enabled = true,
            unit = "player",
            filter = "PLAYER|HELPFUL",
            anchor = { "RIGHT", UIParent, "CENTER", -xOffset, 0 },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMRIGHT",
            ["growth-x"] = "LEFT",
            ["growth-y"] = "DOWN",
            spells = spells[class]
        },
        ["PLAYER_BUFFS"] = {
            enabled = false,
            unit = "player",
            filter = "HELPFUL",
            caster = "all",
            hidePlayer = true,
            anchor = { "RIGHT", UIParent, "CENTER", -xOffset, -yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMRIGHT",
            ["growth-x"] = "LEFT",
            ["growth-y"] = "DOWN",
            FilterAura = function(element, unit, data)
                return not data.isPlayerAura
            end
        },
        ["TARGET_DEBUFFS"] = {
            enabled = true,
            unit = "target",
            filter = "HARMFUL",
            anchor = { "LEFT", UIParent, "CENTER", xOffset, yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            FilterAura = function(element, unit, data)
                return data.isPlayerAura
            end,
            SortAuras = function(a, b)
                if (a.expirationTime ~= b.expirationTime) then
                    return a.expirationTime < b.expirationTime
                end
        
                if (a.isPlayerAura ~= b.isPlayerAura) then
                    return a.isPlayerAura
                end
            
                return a.auraInstanceID < b.auraInstanceID
            end
        },
        ["TARGET_AURAS"] = {
            enabled = false,
            unit = "target",
            filter = "HELPFUL",
            anchor = { "LEFT", UIParent, "CENTER", xOffset, 0 },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN"
        },
        ["FOCUS_DEBUFFS"] = {
            enabled = false,
            unit = "focus",
            filter = "HARMFUL",
            anchor = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
            limit = 8,
            size = size,
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            FilterAura = function(element, unit, data)
                return data.isBossAura or (data.sourceUnit == nil) or not data.isFromPlayerOrPlayerPet
            end
        }, 
        ["BOSS_DEBUFFS"] = {
            enabled = false,
            unit = "player",
            filter = "HARMFUL",
            anchor = { "CENTER", UIParent, "CENTER", 0, 160 },
            limit = 1,
            size = (2 * size),
            spacing = spacing,
            initialAnchor = "BOTTOMLEFT",
            ["growth-x"] = "RIGHT",
            ["growth-y"] = "DOWN",
            FilterAura = function(element, unit, data)
                return data.isBossAura or (data.sourceUnit == nil) or not data.isFromPlayerOrPlayerPet
            end
        },
        ["PLAYER_COOLDOWNS"] = {
            enabled = true,
            unit = "player",
            filter = "COOLDOWN",
            caster = "player",
            anchor = { "CENTER", UIParent, "BOTTOM", 0, 259 },
            limit = 8,
            size = 38,
            max_size = 40,
            spacing = 3,
            initialAnchor = "CENTER",
            ["growth-x"] = "CENTER",
            ["growth-y"] = "CENTER",
            spells = cooldowns
        }
    }
}
