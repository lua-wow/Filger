local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Cataclysm Classic
--------------------------------------------------
do
    local data = {
        -- WARLOCK
        [687] = true,                                       -- Demon Skin (Rank 1)

        [6307] = true,                                      -- Blood Pact (Rank 1)

        -- Consumables
        [17629] = true,                                     -- Flask of Chromatic Resistance

        --------------------------------------------------
        -- Season of Discovery
        --------------------------------------------------
        [349981] = true,                                    -- Supercharged Chronoboon Displacer
    }

    AddBlacklist(data)
end

do
    local data = {
        -- DEATHKNIGHT
        [55610] = true, -- Improved Icy Talons

        -- HUNTER
        [77769] = true, -- Trap Launcher

        -- MAGE
        [61316] = true, -- Dalaran Brilliance

        -- PALADIN
        [79102] = true, -- Blessing of Might
        [20165] = true, -- Seal of Insight

        -- PRIEST
        [588] = true, -- Inner Fire
        [49868] = true, -- Mind Quickening
        [79107] = true, -- Shadow Protection
        [73413] = true, -- Inner Will

        -- SHAMAN
        [30809] = true, -- Unleashed Rage
        [51470] = true, -- Elemental Oath
        [77747] = true, -- Totemic Wrath
    }

    AddBlacklist(data)
end
