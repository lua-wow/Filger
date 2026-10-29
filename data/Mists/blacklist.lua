local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Mists of Pandaria Classic
--------------------------------------------------
local data = {
    [128943] = true, -- Cyclonic Inspiration
    [81744] = true,  -- Horde

    -- DEATHKNIGHT
    [48263] = true,  -- Blood Presence
    [48265] = true,  -- Unholy Presence
    [48266] = true,  -- Frost Presence
    [55610] = true,  -- Unholy Aura
    [57330] = true,  -- Horn of Winter

    -- DRUID
    [783] = true,    -- Travel Form
    [1066] = true,   -- Aquatic Form
    [33943] = true,  -- Flight Form
    [40120] = true,  -- Swift Flight Form

    -- HUNTER
    [77769] = true,  -- Trap Launcher
    [13165] = true,  -- Aspect of the Hawk

    -- MAGE
    [61316] = true,  -- Dalaran Brilliance
    [30482] = true,  -- Molten Armor
    [7302] = true,   -- Frost Armor
    [6117] = true,   -- Mage Armor

    -- MONK
    [117666] = true, -- Legacy of the Emperor
    [116781] = true, -- Legacy of the White Tiger
    [103985] = true, -- Stance of the Fierce Tiger
    [115069] = true, -- Stance of the Sturdy Ox
    [115070] = true, -- Stance of the Wise Serpent

    -- PALADIN
    [20217] = true,  -- Blessing of Kings
    [25780] = true,  -- Righteous Fury
    [20165] = true,  -- Seal of Insight
    [20154] = true,  -- Seal of Righteousness
    [31801] = true,  -- Seal of Truth
    [20164] = true,  -- Seal of Justice

    -- PRIEST
    [21562] = true,  -- Power Word: Fortitude
    [49868] = true,  -- Mind Quickening
    [588] = true,    -- Inner Fire
    [73413] = true,  -- Inner Will
    [15473] = true,  -- Shadowform

    -- ROGUE
    [113742] = true, -- Swiftblade's Cunning
    [112942] = true, -- Shadow Focus
    [8679] = true,   -- Wound Poison
    [5761] = true,   -- Mind-numbing Poison
    [108211] = true, -- Leeching Poison
    [108215] = true, -- Paralytic Poison

    -- SHAMAN
    [30809] = true,  -- Unleashed Rage
    [51470] = true,  -- Elemental Oath
    [77747] = true,  -- Burning Wrath
    [116956] = true, -- Grace of Air
    [324] = true,    -- Lightning Shield
    [52127] = true,  -- Water Shield

    -- WARLOCK
    [109773] = true, -- Dark Intent
    [108446] = true, -- Soul Link

    -- WARRIOR
    [2457] = true,   -- Battle Stance
    [71] = true,     -- Defensive Stance
    [2458] = true,   -- Berserker Stance
    [6673] = true,   -- Battle Shout
    [469] = true,    -- Commanding Shout
}

AddBlacklist(data)
