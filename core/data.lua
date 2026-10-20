local _, ns = ...

------------------------------------------------------------
-- Data
------------------------------------------------------------
-- Loaded before core\init.xml: data files only collect tables here.
-- Validation runs in Finalize(), once ns.Filger exists.
local data = {}

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

local buildBlacklist = function(Filger)
    local blacklist = {}
    for _, source in ipairs(blacklistSources) do
        for spellId, enabled in next, source do
            if enabled then
                if type(spellId) == "string" or Filger.GetSpellInfo(spellId) then
                    blacklist[spellId] = true
                else
                    Filger:warn("Blacklist", "Spell " .. spellId .. " do not exists.")
                end
            end
        end
    end
    return blacklist
end

local buildSpells = function(Filger)
    local spells = {}
    for _, source in ipairs(spellSources) do
        for class, list in next, source do
            if not spells[class] then
                spells[class] = {}
            end

            for spellId, info in next, list do
                if Filger.GetSpellInfo(spellId) then
                    spells[class][spellId] = info
                else
                    Filger:warn("SPELLS", "Spell " .. spellId .. " do not exists.")
                end
            end
        end
    end
    return spells
end

-- player class rows first, then "ALL" rows (racials, gear), each in source order
local buildCooldowns = function(Filger)
    local cooldowns = {}
    for _, key in ipairs({ Filger.class, "ALL" }) do
        for _, source in ipairs(cooldownSources) do
            for _, row in ipairs(source[key] or {}) do
                if row.enabled then
                    if row.slotId or Filger.GetSpellInfo(row.spellId) then
                        table.insert(cooldowns, row)
                    else
                        Filger:warn("COOLDOWN", "Spell " .. row.spellId .. " do not exists.")
                    end
                end
            end
        end
    end
    return cooldowns
end

function data.Finalize()
    local Filger = ns.Filger

    Filger.blacklist = buildBlacklist(Filger)
    Filger.spells = buildSpells(Filger)
    Filger.cooldowns = buildCooldowns(Filger)

    Filger.all = {}
    for _, list in next, Filger.spells do
        Filger.all = Mixin(Filger.all, list)
    end

    blacklistSources, spellSources, cooldownSources = nil, nil, nil
end

ns.data = data
