local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Mists of Pandaria Classic
--------------------------------------------------
local data = {
    [128943] = true, -- Cyclonic Inspiration
    [81744] = true,  -- Horde

    -- HUNTER
    [77769] = true,  -- Trap Launcher

    -- MONK
    [117666] = true, -- Legacy of the Emperor
    [116781] = true, -- Legacy of the White Tiger
    [103985] = true, -- Stance of the Fierce Tiger
    [115069] = true, -- Stance of the Sturdy Ox
    [115070] = true, -- Stance of the Wise Serpent

    -- PALADIN
    [20165] = true,  -- Seal of Insight
    [20154] = true,  -- Seal of Righteousness
    [31801] = true,  -- Seal of Truth
    [20164] = true,  -- Seal of Justice

    -- PRIEST
    [49868] = true,  -- Mind Quickening
    [73413] = true,  -- Inner Will

    -- ROGUE
    [113742] = true, -- Swiftblade's Cunning
    [112942] = true, -- Shadow Focus
    [108211] = true, -- Leeching Poison
    [108215] = true, -- Paralytic Poison

    -- SHAMAN
    [77747] = true,  -- Burning Wrath
    [116956] = true, -- Grace of Air

    -- WARLOCK
    [109773] = true, -- Dark Intent
    [108446] = true, -- Soul Link
}

AddBlacklist(data)
