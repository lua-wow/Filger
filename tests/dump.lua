-- Prints Filger's final spell data for every game and class, one sorted line per entry, so two
-- data trees can be diffed. Every spell ID counts as valid (no client DB here): /filger validate
-- covers missing IDs in game.
-- Run from the repository root:
--   lua tests/dump.lua [root] > dump.txt      (root defaults to ".")

local root = arg[1] or "."

local classes = {
    "DEATHKNIGHT", "DEMONHUNTER", "DRUID", "EVOKER", "HUNTER", "MAGE", "MONK",
    "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR",
}

-- [Game] folder, WOW_PROJECT_ID, LE_EXPANSION_LEVEL_CURRENT and interface of each client
local games = {
    { name = "Vanilla", project = 2, expansion = 0, interface = 11509 },
    { name = "TBC", project = 5, expansion = 1, interface = 20506 },
    { name = "Wrath", project = 11, expansion = 2, interface = 38002 },
    { name = "Cata", project = 14, expansion = 3, interface = 40000 }, -- not in the TOC; placeholder
    { name = "Mists", project = 19, expansion = 4, interface = 50504 },
    { name = "Camelot", project = 18, expansion = 0, interface = 16001 },
    { name = "Standard", project = 1, expansion = 11, interface = 120105 },
}

local blizzard = {
    WOW_PROJECT_MAINLINE = 1,
    WOW_PROJECT_CLASSIC = 2,
    WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5,
    WOW_PROJECT_WRATH_CLASSIC = 11,
    WOW_PROJECT_CATACLYSM_CLASSIC = 14,
    WOW_PROJECT_CAMELOT = 18,
    WOW_PROJECT_MISTS_CLASSIC = 19,
    LE_EXPANSION_CLASSIC = 0,
    LE_EXPANSION_BURNING_CRUSADE = 1,
    LE_EXPANSION_WRATH_OF_THE_LICH_KING = 2,
    LE_EXPANSION_CATACLYSM = 3,
    LE_EXPANSION_MISTS_OF_PANDARIA = 4,
    LE_EXPANSION_WARLORDS_OF_DRAENOR = 5,
    LE_EXPANSION_LEGION = 6,
    LE_EXPANSION_BATTLE_FOR_AZEROTH = 7,
    LE_EXPANSION_SHADOWLANDS = 8,
    LE_EXPANSION_DRAGONFLIGHT = 9,
    LE_EXPANSION_WAR_WITHIN = 10,
    LE_EXPANSION_MIDNIGHT = 11,
    UIParent = {},
    CreateFrame = function() return {} end,
    C_AddOns = { GetAddOnMetadata = function() return "" end },
    GetPhysicalScreenSize = function() return 1920, 1080 end,
}

local function spellName(id)
    return "spell" .. id
end

local function load(ns, path)
    assert(loadfile(root .. "/" .. path))("Filger", ns)
end

-- loads the addon files that build ns.data, in TOC order, as `game` with player `class`
local function build(game, class)
    for k, v in pairs(blizzard) do _G[k] = v end
    _G.WOW_PROJECT_ID = game.project
    _G.LE_EXPANSION_LEVEL_CURRENT = game.expansion
    _G.GetBuildInfo = function() return "", "", "", game.interface end
    _G.UnitClass = function() return class, class end

    local ns = {
        config = { general = { dev = false } },
        compat = { GetSpellInfo = function(id) return { name = spellName(id) } end },
    }
    load(ns, "core/util.lua")
    load(ns, "core/data.lua")
    load(ns, "core/init.lua")
    for _, file in ipairs({ "blacklist", "cooldowns", "spells" }) do
        load(ns, "data/" .. game.name .. "/" .. file .. ".lua")
    end
    for _, file in ipairs({ "blacklist", "cooldowns" }) do
        load(ns, "data/shared/" .. file .. ".lua")
    end
    ns.data.Finalize()
    return ns.data
end

local function sortedKeys(t, keep)
    local keys = {}
    for k in pairs(t) do
        if not keep or keep(k) then keys[#keys + 1] = k end
    end
    table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
    return keys
end

local function isNumber(k) return type(k) == "number" end

local out = {}
local function emit(...) out[#out + 1] = table.concat({ ... }, " ") end

for _, game in ipairs(games) do
    local tag = "[" .. game.name .. "]"
    local data = build(game, classes[1])

    -- class independent
    for _, id in ipairs(sortedKeys(data.blacklist, isNumber)) do
        emit(tag, "blacklist", id, data.blacklist[spellName(id)] and "name" or "id")
    end
    for _, class in ipairs(sortedKeys(data.spells)) do
        for _, id in ipairs(sortedKeys(data.spells[class])) do
            local s = data.spells[class][id]
            emit(tag, "spell", class, id, tostring(s.enabled), s.priority, s.stackThreshold)
        end
    end

    -- player class dependent
    for _, class in ipairs(classes) do
        if class ~= classes[1] then data = build(game, class) end
        for i, row in ipairs(data.cooldowns) do
            emit(tag, "cooldown", class, i, row.spellId and ("spell " .. row.spellId) or ("slot " .. row.slotId))
        end
        local invalid = {}
        for _, entry in ipairs(data.invalid) do
            invalid[entry.kind .. " " .. (entry.class or "-") .. " " .. entry.id] = true
        end
        for _, key in ipairs(sortedKeys(invalid)) do
            emit(tag, "invalid", class, key)
        end
    end
end

table.sort(out)
print(table.concat(out, "\n"))
