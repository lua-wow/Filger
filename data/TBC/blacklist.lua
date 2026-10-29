local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- The Burning Crusade Classic
--------------------------------------------------
local data = {
    -- DRUID
    [5232] = true,    -- Mark of the Wild (Rank 2)
    [6756] = true,    -- Mark of the Wild (Rank 3)
    [5234] = true,    -- Mark of the Wild (Rank 4)
    [8907] = true,    -- Mark of the Wild (Rank 5)
    [9884] = true,    -- Mark of the Wild (Rank 6)
    [9885] = true,    -- Mark of the Wild (Rank 7)
    [26990] = true,   -- Mark of the Wild (Rank 8)

    [782] = true,     -- Thorns (Rank 2)
    [1075] = true,    -- Thorns (Rank 3)
    [8914] = true,    -- Thorns (Rank 4)
    [9756] = true,    -- Thorns (Rank 5)
    [9910] = true,    -- Thorns (Rank 6)
    [26992] = true,   -- Thorns (Rank 7)

    [21849] = "name", -- Gift of the Wild
    [783] = true,     -- Travel Form
    [1066] = true,    -- Aquatic Form
    [9634] = true,    -- Dire Bear Form
    [33943] = true,   -- Flight Form
    [40120] = true,   -- Swift Flight Form

    -- HUNTER
    [13165] = "name", -- Aspect of the Hawk
    [13163] = true,   -- Aspect of the Monkey

    -- MAGE
    [1460] = true,    -- Arcane Intellect (Rank 2)
    [1461] = true,    -- Arcane Intellect (Rank 3)
    [10156] = true,   -- Arcane Intellect (Rank 4)
    [10157] = true,   -- Arcane Intellect (Rank 5)
    [27126] = true,   -- Arcane Intellect (Rank 6)

    [23028] = "name", -- Arcane Brilliance
    [168] = "name",   -- Frost Armor
    [7302] = "name",  -- Ice Armor
    [6117] = "name",  -- Mage Armor
    [30482] = "name", -- Molten Armor

    -- PALADIN
    [465] = "name",   -- Devotion Aura
    [25780] = true,   -- Righteous Fury
    [20217] = true,   -- Blessing of Kings
    [19742] = "name", -- Blessing of Wisdom
    [19740] = "name", -- Blessing of Might
    [25782] = "name", -- Greater Blessing of Might
    [25894] = "name", -- Greater Blessing of Wisdom
    [25898] = true,   -- Greater Blessing of Kings
    [21084] = "name", -- Seal of Righteousness

    -- PRIEST
    [1243] = true,    -- Power Word: Fortitude (Rank 1)
    [1244] = true,    -- Power Word: Fortitude (Rank 2)
    [1245] = true,    -- Power Word: Fortitude (Rank 3)
    [2791] = true,    -- Power Word: Fortitude (Rank 4)
    [10937] = true,   -- Power Word: Fortitude (Rank 5)
    [10938] = true,   -- Power Word: Fortitude (Rank 6)
    [25389] = true,   -- Power Word: Fortitude (Rank 7)

    [25431] = true,   -- Inner Fire (Rank 7)
    [32999] = true,   -- Prayer of Spirit (Rank 2)
    [588] = "name",   -- Inner Fire
    [15473] = true,   -- Shadowform

    -- SHAMAN
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
    [27268] = true,   -- Blood Pact (Rank 6)

    [706] = "name",   -- Demon Armor
    [28176] = "name", -- Fel Armor

    -- WARRIOR
    [2457] = true,    -- Battle Stance
    [71] = true,      -- Defensive Stance
    [2458] = true,    -- Berserker Stance
    [6673] = "name",  -- Battle Shout
    [469] = "name",   -- Commanding Shout

    -- Consumables
    [17629] = true,   -- Flask of Chromatic Resistance

    -- Scrolls
    [33079] = true,   -- Armor (Scroll of Protection V)

    [33078] = true,   -- Intellect (Scroll of Intellect V)

    [33081] = true,   -- Stamina (Scroll of Stamina V)

    [33080] = true,   -- Spirit Magic (Scroll of Spirit V)

    [33077] = true,   -- Agility (Scroll of Agility V)

    [33082] = true,   -- Strength (Scroll of Strength V)
}

AddBlacklist(data)
