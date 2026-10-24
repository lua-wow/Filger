local _, ns = ...
local Filger = ns.Filger

ns.data.Finalize()

local cooldowns = Filger.cooldowns or {}

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

-- aura frame layout; elements/<Family>/auras.lua adds what each frame shows
local size, spacing = 35, 5
local xOffset, yOffset = 239, 39

local left = { limit = 8, size = size, spacing = spacing, initialAnchor = "BOTTOMRIGHT", ["growth-x"] = "LEFT", ["growth-y"] = "DOWN" }
local right = { limit = 8, size = size, spacing = spacing, initialAnchor = "BOTTOMLEFT", ["growth-x"] = "RIGHT", ["growth-y"] = "DOWN" }

local function Frame(defaults, data)
    return Mixin({ enabled = true }, defaults, data)
end

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
        ["PLAYER_COOLDOWNS"] = {
            enabled = true,
            type = "cooldowns",
            unit = "player",
            caster = "player",
            anchor = { "CENTER", UIParent, "BOTTOM", 0, 175 },
            limit = 8,
            size = 38,
            max_size = 40,
            spacing = 3,
            initialAnchor = "CENTER",
            ["growth-x"] = "CENTER",
            ["growth-y"] = "CENTER",
            spells = cooldowns
        },
        -- LEFT
        ["PLAYER_DEBUFFS"] = Frame(left, { unit = "player", anchor = { "RIGHT", UIParent, "CENTER", -xOffset, yOffset } }),
        ["PLAYER_AURAS"] = Frame(left, { unit = "player", anchor = { "RIGHT", UIParent, "CENTER", -xOffset, 0 } }),
        ["PLAYER_BUFFS"] = Frame(left, { unit = "player", anchor = { "RIGHT", UIParent, "CENTER", -xOffset, -yOffset } }),
        -- RIGHT
        ["TARGET_DEBUFFS"] = Frame(right, { unit = "target", anchor = { "LEFT", UIParent, "CENTER", xOffset, yOffset } }),
        ["TARGET_AURAS"] = Frame(right, { unit = "target", anchor = { "LEFT", UIParent, "CENTER", xOffset, 0 } }),
        ["FOCUS_DEBUFFS"] = Frame(right, { unit = "focus", anchor = { "LEFT", UIParent, "CENTER", xOffset, -yOffset } }),
        -- CENTER
        ["BOSS_DEBUFFS"] = Frame(right, { unit = "player", anchor = { "CENTER", UIParent, "CENTER", 0, 160 }, limit = 1, size = math.floor(1.5 * size) })
    }
}
