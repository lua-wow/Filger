local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Classic Era
--------------------------------------------------
local data = {
    --------------------------------------------------
    -- Hardcore
    --------------------------------------------------
    [364001] = true,  -- Soul of Iron

    --------------------------------------------------
    -- Season of Discovery
    --------------------------------------------------
    [349981] = true,  -- Supercharged Chronoboon Displacer
    [410935] = true,  -- Meditation on the Light
    [417316] = true,  -- Meditation on the Loa
    [418459] = true,  -- Meditation on Undeath
    [419307] = true,  -- Meditation on Elune
    [430947] = true,  -- Boon of Blackfathom (World Buff)
    [436412] = true,  -- Discoverer's Delight

    -- PALADIN
    [407627] = true,  -- Righteous Fury

    [438536] = true,  -- Spark of Inspiration
    [446695] = true,  -- Fervor of the Temple Explorer
    [460940] = true,  -- Might of Stormwind
}

AddBlacklist(data)
