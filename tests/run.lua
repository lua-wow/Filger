-- Plain Lua 5.1 tests for Filger's pure logic. Run from the repository root: make test

local passed, failed = 0, 0

local function test(name, fn)
    local ok, err = pcall(fn)
    if ok then
        passed = passed + 1
    else
        failed = failed + 1
        print("FAIL " .. name .. ": " .. tostring(err))
    end
end

local function eq(actual, expected, msg)
    if actual ~= expected then
        error(string.format("%s: expected %s (%s), got %s (%s)", msg or "value",
            tostring(expected), type(expected), tostring(actual), type(actual)), 2)
    end
end

-- addon files receive (addonName, ns) as `...`, like in WoW
local function loadAddonFile(ns, path)
    assert(loadfile(path))("Filger", ns)
end

-- fresh namespace per test: data.lua captures GetSpellInfo at load and Finalize drops its sources
local function newData(known, class)
    local ns = {
        config = { general = { dev = false } },
        player = { class = class or "MAGE" },
        client = { expansion = 2 },
        compat = {
            GetSpellInfo = function(id)
                return known and known[id] and { name = known[id] } or nil
            end,
        },
    }
    loadAddonFile(ns, "core/util.lua")
    loadAddonFile(ns, "core/data.lua")
    return ns.data
end

local function hasInvalid(invalid, kind, class, id)
    for _, entry in ipairs(invalid) do
        if entry.kind == kind and entry.class == class and entry.id == id then
            return true
        end
    end
    return false
end

------------------------------------------------------------
-- util.FormatTime
------------------------------------------------------------
test("FormatTime", function()
    local ns = {}
    loadAddonFile(ns, "core/util.lua")
    local FormatTime = ns.util.FormatTime

    eq(FormatTime(nil), "0.0", "nil")
    eq(FormatTime(0), "0.0", "0")
    eq(FormatTime(4.99), "5.0", "4.99")
    eq(FormatTime(5), 5, "5")
    eq(FormatTime(59.9), 59, "59.9")
    eq(FormatTime(60), "1m", "60")
    eq(FormatTime(61), "2m", "61")
    eq(FormatTime(3600), "1h", "3600")
    eq(FormatTime(86400), "1d", "86400")
    eq(FormatTime("12"), 12, "\"12\"")
end)

------------------------------------------------------------
-- data constructors
------------------------------------------------------------
test("CreateSpellPriority", function()
    local data = newData()

    local p = data.CreateSpellPriority()
    eq(p.enabled, true, "default enabled")
    eq(p.priority, 0, "default priority")
    eq(p.stackThreshold, 0, "default stackThreshold")

    eq(data.CreateSpellPriority(false).enabled, false, "disabled")

    p = data.CreateSpellPriority(5, 3)
    eq(p.enabled, true, "enabled")
    eq(p.priority, 5, "priority")
    eq(p.stackThreshold, 3, "stackThreshold")
end)

test("CreateSpellCooldown", function()
    local data = newData()
    eq(data.CreateSpellCooldown(1).enabled, true, "default enabled")
    eq(data.CreateSpellCooldown(1, false).enabled, false, "disabled")
    eq(pcall(data.CreateSpellCooldown, "1"), false, "non-number spellId errors")
end)

test("CreateSlotCooldown", function()
    local data = newData()
    eq(data.CreateSlotCooldown("13").slotId, "13", "numeric string slotId")
    eq(data.CreateSlotCooldown(13, false).enabled, false, "disabled")
    eq(pcall(data.CreateSlotCooldown, "x"), false, "non-numeric slotId errors")
end)

test("In", function()
    local data = newData() -- expansion 2

    eq(data.In(0), true, "from below")
    eq(data.In(2), true, "from equal")
    eq(data.In(3), false, "from above")
    eq(data.In(0, 2), true, "to equal")
    eq(data.In(0, 1), false, "to below")
    eq(data.In(2, 2), true, "single")
    eq(data.In(3, 4), false, "range above")
end)

------------------------------------------------------------
-- data.Finalize
------------------------------------------------------------
test("Finalize blacklist", function()
    local data = newData({ [10] = "Ten", [11] = "Food", [12] = "Twelve" })
    data.AddBlacklist({ [10] = true, [11] = "name", [12] = false, [97] = true })
    data.Finalize()

    eq(data.blacklist[10], true, "id")
    eq(data.blacklist["Ten"], nil, "name of an id-only entry")
    eq(data.blacklist[11], true, "id of a name entry")
    eq(data.blacklist["Food"], true, "name of a name entry")
    eq(data.blacklist[12], nil, "disabled")
    eq(data.blacklist[97], nil, "unknown")
    eq(#data.invalid, 1, "invalid count")
    eq(hasInvalid(data.invalid, "blacklist", nil, 97), true, "unknown reported")
end)

test("Finalize spells", function()
    local data = newData({ [10] = "Ten" })
    local info = data.CreateSpellPriority(1)
    data.AddSpells({ MAGE = { [10] = info, [96] = info } })
    data.Finalize()

    eq(data.spells.MAGE[10], info, "known")
    eq(data.spells.MAGE[96], nil, "unknown")
    eq(#data.invalid, 1, "invalid count")
    eq(hasInvalid(data.invalid, "spell", "MAGE", 96), true, "unknown reported")
end)

test("Finalize cooldowns", function()
    local data = newData({ [1] = "A", [2] = "B", [3] = "C", [4] = "D" }, "MAGE")
    local spell, slot = data.CreateSpellCooldown, data.CreateSlotCooldown
    data.AddCooldowns({
        MAGE = { spell(1), spell(99), spell(2, false) },
        ALL = { slot(13), spell(3) },
        PRIEST = { spell(98), spell(1) },
    })
    data.AddCooldowns({
        MAGE = { spell(4) },
        ALL = { spell(1) },
    })
    data.Finalize()

    -- player class first, then ALL, each in source order
    local expected = { 1, 4, "slot13", 3 }
    eq(#data.cooldowns, #expected, "active count")
    for i, key in ipairs(expected) do
        local row = data.cooldowns[i]
        eq(row.spellId or ("slot" .. row.slotId), key, "row " .. i)
    end

    eq(#data.invalid, 3, "invalid count")
    eq(hasInvalid(data.invalid, "cooldown", "MAGE", 99), true, "unknown player row")
    eq(hasInvalid(data.invalid, "duplicate", "ALL", 1), true, "duplicate across class and ALL")
    eq(hasInvalid(data.invalid, "cooldown", "PRIEST", 98), true, "unknown other-class row")
end)

test("Finalize drops sources", function()
    local data = newData()
    data.Finalize()
    eq(pcall(data.AddSpells, {}), false, "AddSpells after Finalize errors")
end)

print(string.format("%d passed, %d failed", passed, failed))
os.exit(failed > 0 and 1 or 0)
