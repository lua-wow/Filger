local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Classic Forever
--------------------------------------------------
local data = {
    -- DRUID
    [5232] = true,    -- Mark of the Wild (Rank 2)
    [6756] = true,    -- Mark of the Wild (Rank 3)
    [5234] = true,    -- Mark of the Wild (Rank 4)
    [8907] = true,    -- Mark of the Wild (Rank 5)
    [9884] = true,    -- Mark of the Wild (Rank 6)
    [9885] = true,    -- Mark of the Wild (Rank 7)

    [782] = true,     -- Thorns (Rank 2)
    [1075] = true,    -- Thorns (Rank 3)
    [8914] = true,    -- Thorns (Rank 4)
    [9756] = true,    -- Thorns (Rank 5)
    [9910] = true,    -- Thorns (Rank 6)

    [21849] = true,   -- Gift of the Wild (Rank 1)
    [21850] = true,   -- Gift of the Wild (Rank 2)

    [783] = true,     -- Travel Form
    [1066] = true,    -- Aquatic Form
    [9634] = true,    -- Dire Bear Form

    -- HUNTER
    [13165] = "name", -- Aspect of the Hawk (Rank 1 - 7)
    [13163] = true,   -- Aspect of the Monkey

    -- MAGE
    [1460] = true,    -- Arcane Intellect (Rank 2)
    [1461] = true,    -- Arcane Intellect (Rank 3)
    [10156] = true,   -- Arcane Intellect (Rank 4)
    [10157] = true,   -- Arcane Intellect (Rank 5)

    [23028] = true,   -- Arcane Brilliance

    [168] = true,     -- Frost Armor (Rank 1)
    [7300] = true,    -- Frost Armor (Rank 2)
    [7301] = true,    -- Frost Armor (Rank 3)

    [7302] = true,    -- Ice Armor (Rank 1)
    [7320] = true,    -- Ice Armor (Rank 2)
    [10219] = true,   -- Ice Armor (Rank 3)
    [10220] = true,   -- Ice Armor (Rank 4)

    [6117] = true,    -- Mage Armor (Rank 1)
    [22782] = true,   -- Mage Armor (Rank 2)
    [22783] = true,   -- Mage Armor (Rank 3)

    -- PALADIN
    [465] = "name",   -- Devotion Aura (Rank 1 - 7)

    [19899] = true,   -- Fire Resistance Aura (Rank 2)
    [19900] = true,   -- Fire Resistance Aura (Rank 3)

    [25780] = true,   -- Righteous Fury
    [20217] = true,   -- Blessing of Kings
    [19742] = "name", -- Blessing of Wisdom (Rank 1 - 6)
    [25782] = true,   -- Greater Blessing of Might (Rank 1)
    [25916] = true,   -- Greater Blessing of Might (Rank 2)
    [25894] = true,   -- Greater Blessing of Wisdom (Rank 1)
    [25918] = true,   -- Greater Blessing of Wisdom (Rank 2)
    [25898] = true,   -- Greater Blessing of Kings
    [21084] = "name", -- Seal of Righteousness (Rank 1 - 8)

    -- PRIEST
    [21562] = true,   -- Prayer of Fortitude (Rank 1)
    [21564] = true,   -- Prayer of Fortitude (Rank 2)

    [976] = true,     -- Shadow Protection (Rank 1)
    [10957] = true,   -- Shadow Protection (Rank 2)

    [27683] = true,   -- Prayer of Shadow Protection

    [588] = "name",   -- Inner Fire (Rank 1 - 6)
    [14819] = true,   -- Divine Spirit
    [15473] = true,   -- Shadowform
    [27681] = true,   -- Prayer of Spirit

    -- SHAMAN
    [324] = "name",   -- Lightning Shield (Rank 1 - 7)

    -- WARRIOR
    [71] = true,      -- Defensive Stance
    [2457] = true,    -- Battle Stance
    [2458] = true,    -- Berserker Stance
    [6673] = "name",  -- Battle Shout (Rank 1 - 7)

    -- WARLOCK
    [687] = true,     -- Demon Skin (Rank 1)
    [696] = true,     -- Demon Skin (Rank 2)

    [6307] = true,    -- Blood Pact (Rank 1)
    [7804] = true,    -- Blood Pact (Rank 2)
    [7805] = true,    -- Blood Pact (Rank 3)
    [11766] = true,   -- Blood Pact (Rank 4)
    [11767] = true,   -- Blood Pact (Rank 5)

    [706] = "name",   -- Demon Armor (Rank 1 - 5)

    -- Scrolls
    [8091] = true,    -- Armor (Scroll of Protection)
    [8094] = true,    -- Armor (Scroll of Protection II)
    [8095] = true,    -- Armor (Scroll of Protection III)
    [12175] = true,   -- Armor (Scroll of Protection IV)

    [8096] = true,    -- Intellect (Scroll of Intellect)
    [8097] = true,    -- Intellect (Scroll of Intellect II)
    [8098] = true,    -- Intellect (Scroll of Intellect III)
    [12176] = true,   -- Intellect (Scroll of Intellect IV)

    [8099] = true,    -- Stamina (Scroll of Stamina)
    [8100] = true,    -- Stamina (Scroll of Stamina II)
    [8101] = true,    -- Stamina (Scroll of Stamina III)
    [12178] = true,   -- Stamina (Scroll of Stamina IV)

    [8112] = true,    -- Spirit Magic (Scroll of Spirit)
    [8113] = true,    -- Spirit Magic (Scroll of Spirit II)
    [8114] = true,    -- Spirit Magic (Scroll of Spirit III)
    [12177] = true,   -- Spirit Magic (Scroll of Spirit IV)

    [8115] = true,    -- Agility (Scroll of Agility)
    [8116] = true,    -- Agility (Scroll of Agility II)
    [8117] = true,    -- Agility (Scroll of Agility III)
    [12174] = true,   -- Agility (Scroll of Agility IV)

    [8118] = true,    -- Strength (Scroll of Strength)
    [8119] = true,    -- Strength (Scroll of Strength II)
    [8120] = true,    -- Strength (Scroll of Strength III)
    [12179] = true,   -- Strength (Scroll of Strength IV)
}

AddBlacklist(data)
