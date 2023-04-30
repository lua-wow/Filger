local _, ns = ...

------------------------------------------------------------
-- Wrath of the Lich King
------------------------------------------------------------
if (not ns.Filger.isWOTLK) then return end

ns.BlackList = {
    -- DRUID
    
    -- MAGE

    -- PRIEST
    [588] = false,                                      -- Inner Fire (Rank 1)
    [7128] = false,                                     -- Inner Fire (Rank 2)
    [602] = false,                                      -- Inner Fire (Rank 3)
    [1006] = false,                                     -- Inner Fire (Rank 4)
    [10951] = false,                                    -- Inner Fire (Rank 5)
    [10952] = false,                                    -- Inner Fire (Rank 6)

    [1243] = true,                                      -- Power World: Fortitude (Rank 1)
    [1244] = true,                                      -- Power World: Fortitude (Rank 2)
    [1245] = true,                                      -- Power World: Fortitude (Rank 3)
    [2791] = true,                                      -- Power World: Fortitude (Rank 4)
    [10937] = true,                                     -- Power World: Fortitude (Rank 5)
    [10938] = true,                                     -- Power World: Fortitude (Rank 6)

    [21562] = true,                                     -- Prayer of Fortitude (Rank 1)
    [21564] = true,                                     -- Prayer of Fortitude (Rank 2)

    [976] = true,                                       -- Shadow Protection (Rank 1)
    [10957] = true,                                     -- Shadow Protection (Rank 2)
    [10958] = true,                                     -- Shadow Protection (Rank 3)
    [10958] = true,                                     -- Shadow Protection (Rank 4)
    [10958] = true,                                     -- Shadow Protection (Rank 5)

    [27683] = true,                                     -- Prayer of Shadow Protection (Rank 1)
    [27683] = true,                                     -- Prayer of Shadow Protection (Rank 2)
    [27683] = true,                                     -- Prayer of Shadow Protection (Rank 3)

    [14752] = true,                                     -- Divine Spirit (Rank 1)
    [14818] = true,                                     -- Divine Spirit (Rank 2)
    [14819] = true,                                     -- Divine Spirit (Rank 3)
    [27841] = true,                                     -- Divine Spirit (Rank 4)

    [27681] = true,                                     -- Prayer of Spirit (Rank 1)
    [27681] = true,                                     -- Prayer of Spirit (Rank 2)
    [27681] = true,                                     -- Prayer of Spirit (Rank 3)
}

ns.Cooldowns = {
    ["PRIEST"] = {
        -- Talents
        { spellID = 6346, check = true },               -- Fear Ward
        { spellID = 32375, check = true },              -- Mass Dispel
        { spellID = 64901, check = true },              -- Hymn of Hope

        -- Disciplie
        { spellID = 10060, check = true },              -- Power Infusion
        { spellID = 14751, check = true },              -- Inner Focus
        { spellID = 33206, check = true },              -- Pain Suppression

        -- Holy
        { spellID = 47788, check = true },              -- Guardian Spirit
        { spellID = 64843, check = true },              -- Divine Hymn (Rank 1)
        
        { spellID = 19236, check = true },              -- Desperate Prayer (Rank 1)
        { spellID = 19238, check = true },              -- Desperate Prayer (Rank 2)
        { spellID = 19240, check = true },              -- Desperate Prayer (Rank 3)
        { spellID = 19241, check = true },              -- Desperate Prayer (Rank 4)
        { spellID = 19242, check = true },              -- Desperate Prayer (Rank 5)
        { spellID = 19243, check = true },              -- Desperate Prayer (Rank 6)
        { spellID = 25437, check = true },              -- Desperate Prayer (Rank 7)
        { spellID = 48172, check = true },              -- Desperate Prayer (Rank 8)
        { spellID = 48173, check = true },              -- Desperate Prayer (Rank 9)

        { spellID = 724, check = true },                -- Lightwell (Rank !)
        { spellID = 27870, check = true },              -- Lightwell (Rank 2)
        { spellID = 27871, check = true },              -- Lightwell (Rank 3)
        { spellID = 28275, check = true },              -- Lightwell (Rank 4)
        { spellID = 48086, check = true },              -- Lightwell (Rank 5)
        { spellID = 48087, check = true },              -- Lightwell (Rank 6)

        -- Shadow
        { spellID = 15487, check = false },             -- Silence
        { spellID = 34433, check = true },              -- Shadowfiend
        { spellID = 47585, check = true }               -- Dispersion
    }
}
