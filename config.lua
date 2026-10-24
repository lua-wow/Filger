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
    -- shared by the aura frames in core/<Family>/auras.lua
    ["layout"] = {
        size = 35,
        spacing = 5,
        xOffset = 239,
        yOffset = 39
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
        }
    }
}
