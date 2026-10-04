local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Mists of Pandaria Classic
--------------------------------------------------
do
    local data = {
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
        [55610] = true, -- Unholy Aura

        -- HUNTER
        [77769] = true, -- Trap Launcher

        -- MAGE
        [61316] = true, -- Dalaran Brilliance

        -- MONK
        [117666] = true, -- Legacy of the Emperor
        [116781] = true, -- Legacy of the White Tiger

        -- PRIEST
        [49868] = true, -- Mind Quickening

        -- ROGUE
        [113742] = true, -- Swiftblade's Cunning
        [112942] = true, -- Shadow Focus
        

        -- SHAMAN
        [30809] = true, -- Unleashed Rage
        [51470] = true, -- Elemental Oath
        [77747] = true, -- Burning Wrath
        [116956] = true, -- Grace of Air

        -- WARLOCK
        [109773] = true, -- Dark Intent
    }
    AddBlacklist(data)
end
