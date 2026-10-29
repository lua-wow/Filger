local _, ns = ...
local CreateColor = ns.media.CreateColor

------------------------------------------------------------
-- Config
------------------------------------------------------------
ns.config = {
    ["general"] = {
        ["backdrop"] = {
            ["color"] = CreateColor(0.15, 0.15, 0.15)
        },
        ["border"] = {
            ["color"] = CreateColor(0.00, 0.00, 0.00),
            ["size"] = 1
        },
        ["gametooltip"] = true,                                 -- enabled tooltips
        ["dev"] = true,                                        -- enables dev/development.lua commands
    }
}

-- aura frame layout; ns.elements.Auras.Frames adds what each frame shows
local size, spacing = 35, 5
local xOffset, yOffset = 239, 39

local left = { limit = 8, size = size, spacing = spacing, initialAnchor = "BOTTOMRIGHT", ["growth-x"] = "LEFT", ["growth-y"] = "DOWN" }
local right = { limit = 8, size = size, spacing = spacing, initialAnchor = "BOTTOMLEFT", ["growth-x"] = "RIGHT", ["growth-y"] = "DOWN" }

local function Frame(defaults, data)
    return Mixin({ enabled = true, type = "Auras" }, defaults, data)
end

-- runs at ADDON_LOADED, after ns.data.Finalize()
function ns.BuildConfig()
    local frames = {
        ["PLAYER_COOLDOWNS"] = {
            enabled = true,
            type = "Cooldowns",
            unit = "player",
            anchor = { "CENTER", UIParent, "BOTTOM", 0, 175 },
            limit = 8,
            size = 38,
            max_size = 40,
            spacing = 3,
            initialAnchor = "CENTER",
            ["growth-x"] = "CENTER",
            ["growth-y"] = "CENTER",
            spells = ns.data.cooldowns
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

    for key, data in next, ns.elements.Auras.Frames(ns.data) do
        Mixin(frames[key], data)
    end

    ns.config.frames = frames
end
