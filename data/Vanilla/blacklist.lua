local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Classic Era
--------------------------------------------------
do
    local data = {
        -- DRUID
        [5232] = true,                                      -- Mark of the Wild (Rank 2)
        [6756] = true,                                      -- Mark of the Wild (Rank 3)
        [5234] = true,                                      -- Mark of the Wild (Rank 4)
        [8907] = true,                                      -- Mark of the Wild (Rank 5)
        [9884] = true,                                      -- Mark of the Wild (Rank 6)
        [9885] = true,                                      -- Mark of the Wild (Rank 7)

        [782] = true,                                       -- Thorns (Rank 2)
        [1075] = true,                                      -- Thorns (Rank 3)
        [8914] = true,                                      -- Thorns (Rank 4)
        [9756] = true,                                      -- Thorns (Rank 5)
        [9910] = true,                                      -- Thorns (Rank 6)

        -- MAGE
        [1460] = true,                                      -- Arcane Intellect (Rank 2)
        [1461] = true,                                      -- Arcane Intellect (Rank 3)
        [10156] = true,                                     -- Arcane Intellect (Rank 4)
        [10157] = true,                                     -- Arcane Intellect (Rank 5)

        -- PRIEST
        [1243] = true,                                      -- Power Word: Fortitude (Rank 1)
        [1244] = true,                                      -- Power Word: Fortitude (Rank 2)
        [1245] = true,                                      -- Power Word: Fortitude (Rank 3)
        [2791] = true,                                      -- Power Word: Fortitude (Rank 4)
        [10937] = true,                                     -- Power Word: Fortitude (Rank 5)
        [10938] = true,                                     -- Power Word: Fortitude (Rank 6)

        [21562] = true,                                     -- Prayer of Fortitude (Rank 1)
        [21564] = true,                                     -- Prayer of Fortitude (Rank 2)

        [27681] = true,                                     -- Prayer of Spirit

        -- WARLOCK
        [687] = true,                                       -- Demon Skin (Rank 1)
        [696] = true,                                       -- Demon Skin (Rank 2)

        [6307] = true,                                      -- Blood Pact (Rank 1)
        [7804] = true,                                      -- Blood Pact (Rank 2)
        [7805] = true,                                      -- Blood Pact (Rank 3)
        [11766] = true,                                     -- Blood Pact (Rank 4)
        [11787] = true,                                     -- Blood Pact (Rank 5)

        -- Consumables
        [17629] = true,                                     -- Flask of Chromatic Resistance

        -- Scrolls
        [8091] = true,                                      -- Armor (Scroll of Protection)
        [8094] = true,                                      -- Armor (Scroll of Protection II)
        [8095] = true,                                      -- Armor (Scroll of Protection III) 
        [12175] = true,                                     -- Armor (Scroll of Protection IV)

        [8096] = true,                                      -- Intellect (Scroll of Intellect)
        [8097] = true,                                      -- Intellect (Scroll of Intellect II)
        [8098] = true,                                      -- Intellect (Scroll of Intellect III)
        [12176] = true,                                     -- Intellect (Scroll of Intellect IV)

        [8099] = true,                                      -- Stamina (Scroll of Stamina)
        [8100] = true,                                      -- Stamina (Scroll of Stamina II)
        [8101] = true,                                      -- Stamina (Scroll of Stamina III)
        [12178] = true,                                     -- Stamina (Scroll of Stamina IV)

        [8112] = true,                                      -- Spirit Magic (Scroll of Spirit)
        [8113] = true,                                      -- Spirit Magic (Scroll of Spirit II)
        [8114] = true,                                      -- Spirit Magic (Scroll of Spirit III)
        [12177] = true,                                     -- Spirit Magic (Scroll of Spirit IV)

        [8115] = true,                                      -- Agility (Scroll of Agility)
        [8116] = true,                                      -- Agility (Scroll of Agility II)
        [8117] = true,                                      -- Agility (Scroll of Agility III)
        [12174] = true,                                     -- Agility (Scroll of Agility IV)

        [8118] = true,                                      -- Strength (Scroll of Strength)
        [8119] = true,                                      -- Strength (Scroll of Strength II)
        [8120] = true,                                      -- Strength (Scroll of Strength III)
        [12179] = true,                                     -- Strength (Scroll of Strength IV)

        -- Christimas
        [26218] = true,                                     -- Mistletoe

        --------------------------------------------------
        -- Season of Discovery
        --------------------------------------------------
        [349981] = true,                                    -- Supercharged Chronoboon Displacer
        [410935] = true,                                    -- Meditation on the Light
        [417316] = true,                                    -- Meditation on the Loa
        [418459] = true,                                    -- Meditation on Undeath
        [419307] = true,                                    -- Meditation on Elune
        [430947] = true,                                    -- Boon of Blackfathom (World Buff)
        [436412] = true,                                    -- Discoverer's Delight
    }

    AddBlacklist(data)
end
