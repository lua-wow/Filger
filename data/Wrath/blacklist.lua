local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
local data = {
    -- DEATHKNIGHT
    [48263] = true,   -- Frost Presence
    [48265] = true,   -- Unholy Presence
    [48266] = true,   -- Blood Presence
    [55610] = true,   -- Improved Icy Talons
    [57330] = "name", -- Horn of Winter

    -- DRUID
    [5232] = true,    -- Mark of the Wild (Rank 2)
    [6756] = true,    -- Mark of the Wild (Rank 3)
    [5234] = true,    -- Mark of the Wild (Rank 4)
    [8907] = true,    -- Mark of the Wild (Rank 5)
    [9884] = true,    -- Mark of the Wild (Rank 6)
    [9885] = true,    -- Mark of the Wild (Rank 7)
    [26990] = true,   -- Mark of the Wild (Rank 8)
    [48469] = true,   -- Mark of the Wild (Rank 9)

    [782] = true,     -- Thorns (Rank 2)
    [1075] = true,    -- Thorns (Rank 3)
    [8914] = true,    -- Thorns (Rank 4)
    [9756] = true,    -- Thorns (Rank 5)
    [9910] = true,    -- Thorns (Rank 6)
    [26992] = true,   -- Thorns (Rank 7)
    [53307] = true,   -- Thorns (Rank 8)

    [21849] = "name", -- Gift of the Wild
    [783] = true,     -- Travel Form
    [1066] = true,    -- Aquatic Form
    [9634] = true,    -- Dire Bear Form
    [33943] = true,   -- Flight Form
    [40120] = true,   -- Swift Flight Form

    -- HUNTER
    [13165] = "name", -- Aspect of the Hawk
    [61846] = "name", -- Aspect of the Dragonhawk
    [13163] = true,   -- Aspect of the Monkey

    -- MAGE
    [1460] = true,    -- Arcane Intellect (Rank 2)
    [1461] = true,    -- Arcane Intellect (Rank 3)
    [10156] = true,   -- Arcane Intellect (Rank 4)
    [10157] = true,   -- Arcane Intellect (Rank 5)
    [27126] = true,   -- Arcane Intellect (Rank 6)
    [42995] = true,   -- Arcane Intellect (Rank 7)

    [61316] = true,   -- Dalaran Brilliance
    [23028] = "name", -- Arcane Brilliance
    [7302] = "name",  -- Ice Armor
    [6117] = "name",  -- Mage Armor
    [30482] = "name", -- Molten Armor

    -- PALADIN
    [465] = "name",   -- Devotion Aura
    [25780] = true,   -- Righteous Fury
    [20217] = true,   -- Blessing of Kings
    [19742] = "name", -- Blessing of Wisdom
    [19740] = "name", -- Blessing of Might
    [20911] = true,   -- Blessing of Sanctuary
    [25782] = "name", -- Greater Blessing of Might
    [25894] = "name", -- Greater Blessing of Wisdom
    [25898] = true,   -- Greater Blessing of Kings
    [25899] = true,   -- Greater Blessing of Sanctuary
    [21084] = true,   -- Seal of Righteousness

    -- PRIEST
    [1243] = true,    -- Power Word: Fortitude (Rank 1)
    [1244] = true,    -- Power Word: Fortitude (Rank 2)
    [1245] = true,    -- Power Word: Fortitude (Rank 3)
    [2791] = true,    -- Power Word: Fortitude (Rank 4)
    [10937] = true,   -- Power Word: Fortitude (Rank 5)
    [10938] = true,   -- Power Word: Fortitude (Rank 6)
    [25389] = true,   -- Power Word: Fortitude (Rank 7)
    [48161] = true,   -- Power Word: Fortitude (Rank 8)

    [588] = "name",   -- Inner Fire
    [48040] = true,   -- Inner Fire (Rank 8)
    [48168] = true,   -- Inner Fire (Rank 9)
    [48074] = true,   -- Prayer of Spirit (Rank 3)
    [15473] = true,   -- Shadowform
    [23723] = true,   -- Mind Quickening

    -- SHAMAN
    [30809] = true,   -- Unleashed Rage
    [51470] = true,   -- Elemental Oath
    [324] = "name",   -- Lightning Shield
    [24398] = "name", -- Water Shield

    -- WARLOCK
    [687] = true,     -- Demon Skin (Rank 1)
    [696] = true,     -- Demon Skin (Rank 2)

    [6307] = true,    -- Blood Pact (Rank 1)
    [7804] = true,    -- Blood Pact (Rank 2)
    [7805] = true,    -- Blood Pact (Rank 3)
    [11766] = true,   -- Blood Pact (Rank 4)
    [11767] = true,   -- Blood Pact (Rank 5)
    [27267] = true,   -- Blood Pact (Rank 6)
    [47982] = true,   -- Blood Pact (Rank 7)

    [706] = "name",   -- Demon Armor
    [28176] = "name", -- Fel Armor

    -- WARRIOR
    [2457] = true,    -- Battle Stance
    [71] = true,      -- Defensive Stance
    [2458] = true,    -- Berserker Stance

    [469] = "name",   -- Commanding Shout
    [6673] = "name",  -- Battle Shout
}

AddBlacklist(data)
