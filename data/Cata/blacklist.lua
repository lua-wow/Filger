local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Cataclysm Classic
--------------------------------------------------
local data = {
    -- DEATHKNIGHT
    [55610] = true,   -- Improved Icy Talons
    [48265] = true,   -- Unholy Presence
    [57330] = "name", -- Horn of Winter

    -- DRUID
    [783] = true,     -- Travel Form
    [1066] = true,    -- Aquatic Form
    [33943] = true,   -- Flight Form
    [40120] = true,   -- Swift Flight Form

    -- HUNTER
    [77769] = true,   -- Trap Launcher
    [13165] = "name", -- Aspect of the Hawk

    -- MAGE
    [61316] = true,   -- Dalaran Brilliance
    [6117] = "name",  -- Mage Armor
    [30482] = "name", -- Molten Armor

    -- PALADIN
    [79102] = true,   -- Blessing of Might
    [20165] = true,   -- Seal of Insight
    [465] = "name",   -- Devotion Aura
    [25780] = true,   -- Righteous Fury
    [20217] = true,   -- Blessing of Kings

    -- PRIEST
    [588] = true,     -- Inner Fire
    [49868] = true,   -- Mind Quickening
    [79107] = true,   -- Shadow Protection
    [73413] = true,   -- Inner Will
    [15473] = true,   -- Shadowform

    -- SHAMAN
    [30809] = true,   -- Unleashed Rage
    [51470] = true,   -- Elemental Oath
    [77747] = true,   -- Totemic Wrath
    [324] = "name",   -- Lightning Shield

    -- WARLOCK
    [687] = true,     -- Demon Skin (Rank 1)

    [6307] = true,    -- Blood Pact (Rank 1)

    [28176] = "name", -- Fel Armor

    -- WARRIOR
    [2457] = true,    -- Battle Stance
    [71] = true,      -- Defensive Stance
    [2458] = true,    -- Berserker Stance

    [469] = "name",   -- Commanding Shout
    [6673] = "name",  -- Battle Shout

    -- Consumables
    [17629] = true,   -- Flask of Chromatic Resistance
}

AddBlacklist(data)
