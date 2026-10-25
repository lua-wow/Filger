local _, ns = ...

------------------------------------------------------------
-- Data
------------------------------------------------------------
-- Loaded before core\init.xml: data files only collect tables here.
-- Validation runs in Finalize() at ADDON_LOADED; it fills data.blacklist/spells/cooldowns,
-- and records unresolved or duplicated IDs in data.invalid as { kind, class, id }.
local data = {}

-- Compat
local GetSpellInfo = ns.compat.GetSpellInfo

local warn = ns.util.warn

local blacklistSources = {}
local spellSources = {}
local cooldownSources = {}

function data.CreateSpellPriority(arg1, arg2)
    local enabled, priority, stackThreshold = true, 0, 0

    if type(arg1) == "boolean" then
        enabled = arg1
    elseif type(arg1) == "number" then
        priority = arg1
    end

    if type(arg2) == "number" then
        stackThreshold = arg2
    end

    return { enabled = enabled, priority = priority, stackThreshold = stackThreshold }
end

function data.CreateSpellCooldown(spellId, enabled)
    assert(type(spellId) == "number", "Filger: Invalid cooldown spellId")
    if (enabled == nil) then
        enabled = true
    end
    return { spellId = spellId, enabled = enabled }
end

function data.CreateSlotCooldown(slotId, enabled)
    assert(tonumber(slotId), "Filger: Invalid slotId")
    if (enabled == nil) then
        enabled = true
    end
    return { slotId = slotId, enabled = enabled }
end

function data.AddBlacklist(source)
    table.insert(blacklistSources, source)
end

function data.AddSpells(source)
    table.insert(spellSources, source)
end

function data.AddCooldowns(source)
    table.insert(cooldownSources, source)
end

local buildBlacklist = function(invalid)
    local blacklist = {}
    for _, source in ipairs(blacklistSources) do
        for spellId, enabled in next, source do
            if enabled then
                if type(spellId) == "string" or GetSpellInfo(spellId) then
                    blacklist[spellId] = true
                else
                    table.insert(invalid, { kind = "blacklist", id = spellId })
                end
            end
        end
    end
    return blacklist
end

local buildSpells = function(invalid)
    local spells = {}
    for _, source in ipairs(spellSources) do
        for class, list in next, source do
            if not spells[class] then
                spells[class] = {}
            end

            for spellId, info in next, list do
                if GetSpellInfo(spellId) then
                    spells[class][spellId] = info
                else
                    table.insert(invalid, { kind = "spell", class = class, id = spellId })
                end
            end
        end
    end
    return spells
end

-- validates the enabled rows of `class`; appends the valid ones to `out` when given
local collectCooldowns = function(class, seen, out, invalid)
    for _, source in ipairs(cooldownSources) do
        for _, row in ipairs(source[class] or {}) do
            if row.spellId and seen[row.spellId] then
                table.insert(invalid, { kind = "duplicate", class = class, id = row.spellId })
            elseif row.enabled then
                if row.spellId then seen[row.spellId] = true end
                if row.slotId or GetSpellInfo(row.spellId) then
                    if out then table.insert(out, row) end
                else
                    table.insert(invalid, { kind = "cooldown", class = class, id = row.spellId })
                end
            end
        end
    end
end

-- player class rows first, then "ALL" rows (racials, gear), each in source order;
-- other classes are only validated
local buildCooldowns = function(invalid)
    local cooldowns = {}
    local seen = {}
    collectCooldowns(ns.player.class, seen, cooldowns, invalid)
    collectCooldowns("ALL", seen, cooldowns, invalid)

    local others = {}
    for _, source in ipairs(cooldownSources) do
        for class in next, source do
            if class ~= ns.player.class and class ~= "ALL" then
                others[class] = true
            end
        end
    end
    for class in next, others do
        collectCooldowns(class, {}, nil, invalid)
    end
    return cooldowns
end

function data.Finalize()
    local invalid = {}
    data.blacklist = buildBlacklist(invalid)
    data.spells = buildSpells(invalid)
    data.cooldowns = buildCooldowns(invalid)
    data.invalid = invalid

    blacklistSources, spellSources, cooldownSources = nil, nil, nil

    if ns.config.general.dev then
        for _, entry in ipairs(invalid) do
            warn(entry.kind .. (entry.class and ("/" .. entry.class) or ""), entry.id)
        end
    end
end

ns.data = data
