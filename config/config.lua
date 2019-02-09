local _, ns = ...
local Config = ns.Config

----------------------------------------------------------------
-- Config
----------------------------------------------------------------
local xOffset = 200
local yOffset = 39

Config["General"] = {

    ["ConfigMode"] = false,

    ["IconSize"] = 32,
    ["IconSpacing"] = 7,

    ["BarWidth"] = 200,
    ["BarHeight"] = 18,
    ["BarSpacing"] = 7,
    ["ClassColor"] = true,

    ["BackdropColor"] = { .05, .05, .05 },
    ["BorderColor"] = { .125, .125, .125 },
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
    ["FocusAuras"] = { "LEFT", UIParent, "CENTER", xOffset, -yOffset },
    ["BossBuffs"] = { "LEFT", UIParent, "CENTER", xOffset, yOffset },
}