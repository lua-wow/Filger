local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
local data = {
    -- DRUID
    [48469] = true,   -- Mark of the Wild (Rank 9)

    [53307] = true,   -- Thorns (Rank 8)

    -- HUNTER
    [61846] = "name", -- Aspect of the Dragonhawk

    -- MAGE
    [42995] = true,   -- Arcane Intellect (Rank 7)

    -- PALADIN
    [20911] = true,   -- Blessing of Sanctuary
    [25899] = true,   -- Greater Blessing of Sanctuary

    -- PRIEST
    [48161] = true,   -- Power Word: Fortitude (Rank 8)

    [48040] = true,   -- Inner Fire (Rank 8)
    [48168] = true,   -- Inner Fire (Rank 9)
    [48074] = true,   -- Prayer of Spirit (Rank 3)
    [23723] = true,   -- Mind Quickening

    -- WARLOCK
    [27267] = true,   -- Blood Pact (Rank 6)
    [47982] = true,   -- Blood Pact (Rank 7)
}

AddBlacklist(data)
