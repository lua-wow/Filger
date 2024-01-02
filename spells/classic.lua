local _, ns = ...

------------------------------------------------------------
-- Classic
------------------------------------------------------------
ns.BlackList = {
    -- DRUID
    [1126] = true,                                      -- Mark of the Wild (Rank 1)
    [5232] = true,                                      -- Mark of the Wild (Rank 2)
    [6756] = true,                                      -- Mark of the Wild (Rank 3)

    [467] = true,                                      -- Thorns (Rank 1)
    [782] = true,                                      -- Thorns (Rank 2)

    -- MAGE
    [1459] = true,                                      -- Arcane Intellect (Rankj 1)
    [1460] = true,                                      -- Arcane Intellect (Rank 2)

    -- PRIEST
    [1243] = true,                                      -- Power Word: Fortitude (Rank 1)
    [1244] = true,                                      -- Power Word: Fortitude (Rank 2)
    [1245] = true,                                      -- Power Word: Fortitude (Rank 3)

    -- WARLOCK
    [687] = true,                                       -- Demon Skin
    [6307] = true,                                      -- Blood Pact (Rank 1)

    -- Others
    [8091] = true,                                      -- Armor (Scroll fo Protection)
    [8112] = true,                                      -- Spirit Magic (Scroll fo Protection)
    [8113] = true,                                      -- Spirit Magic (Scroll fo Protection)

    --------------------------------------------------
    -- Season of Discovery
    --------------------------------------------------
    [410935] = true,                                    -- Meditation on the Light
    [417316] = true,                                    -- Meditation on the Loa
    [418459] = true,                                    -- Meditation on Undeath
    [419307] = true                                     -- Meditation on Elune
}

ns.Cooldowns = {
    ["PALADIN"] = {
        -- General
        { spellID = 498, check = true },                -- Divine Protection
        { spellID = 642, check = true },                -- Divine Shield
        { spellID = 633, check = true },                -- Lay on Hands
        { spellID = 1022, check = true },               -- Blessing of Protection
        { spellID = 1044, check = true },               -- Blessing of Freedom
        { spellID = 6940, check = true },               -- Blessing of Sacrifice
    },
    ["PRIEST"] = {
        -- General
        { spellID = 10060, check = true },              -- Power Infusion
        { spellID = 14751, check = true },              -- Inner Focus

        -- Discipline
        -- { spellID = 33206, check = true },           -- Pain Suppression

        -- Holy
        { spellID = 724, check = true },                -- Lightwell (Rank !)
        { spellID = 27870, check = true },              -- Lightwell (Rank 2)
        { spellID = 27871, check = true },              -- Lightwell (Rank 3)

        { spellID = 13908, check = true },              -- Desperate Prayer (Rank 1)
        { spellID = 19236, check = true },              -- Desperate Prayer (Rank 2)
        { spellID = 19238, check = true },              -- Desperate Prayer (Rank 3)
        { spellID = 19240, check = true },              -- Desperate Prayer (Rank 4)
        { spellID = 19241, check = true },              -- Desperate Prayer (Rank 5)
        { spellID = 19242, check = true },              -- Desperate Prayer (Rank 6)
        { spellID = 19243, check = true },              -- Desperate Prayer (Rank 7)

        -- Shadow
        { spellID = 15286, check = false },             -- Vampiric Embrace
        { spellID = 15487, check = true },              -- Silence
        { spellID = 586, check = true },                -- Fade (Rank 1)
        { spellID = 9578, check = true },               -- Fade (Rank 2)
        { spellID = 9579, check = true },               -- Fade (Rank 3)
        { spellID = 9592, check = true },               -- Fade (Rank 4)
        { spellID = 10941, check = true },              -- Fade (Rank 5)
        { spellID = 10942, check = true },              -- Fade (Rank 6)

        { spellID = 8122, check = true },               -- Psychic Scream (Rank 1)
        { spellID = 8124, check = true },               -- Psychic Scream (Rank 2)
        { spellID = 10888, check = true },              -- Psychic Scream (Rank 3)
        { spellID = 10890, check = true },              -- Psychic Scream (Rank 4)

        -- Night Elf
        { spellID = 2651, check = true },               -- Elune's Grace (Rank 1)
        { spellID = 19289, check = true },              -- Elune's Grace (Rank 2)
        { spellID = 19291, check = true },              -- Elune's Grace (Rank 3)
        { spellID = 19292, check = true },              -- Elune's Grace (Rank 4)
        { spellID = 19293, check = true },              -- Elune's Grace (Rank 5)

        -- Human 
        { spellID = 13896, check = true },              -- Feedback (Rank 1)
        { spellID = 19271, check = true },              -- Feedback (Rank 2)
        { spellID = 19273, check = true },              -- Feedback (Rank 3)
        { spellID = 19274, check = true },              -- Feedback (Rank 4)
        { spellID = 19275, check = true },              -- Feedback (Rank 5)

        -- Dwarf
        { spellID = 6346, check = true },               -- Fear Ward (Rank 1)
        
        -- Undead
        { spellID = 2944, check = true },               -- Devouring Plague(Rank 1)
        { spellID = 19276, check = true },              -- Devouring Plague(Rank 2)
        { spellID = 19277, check = true },              -- Devouring Plague(Rank 3)
        { spellID = 19278, check = true },              -- Devouring Plague(Rank 4)
        { spellID = 19279, check = true },              -- Devouring Plague(Rank 5)
        { spellID = 19280, check = true },              -- Devouring Plague(Rank 6)
    },
    ["WARRIOR"] = {
        -- General
        { spellID = 1161, check = true },               -- Challenging Shout
        { spellID = 2565, check = true },               -- Shield Block (Rank 1)
        { spellID = 3411, check = true },               -- Intervene
        { spellID = 6544, check = true },               -- Heroic Leap
        { spellID = 18499, check = true },              -- Berserker Rage
        { spellID = 97462, check = true },              -- Rallying Cry (Rank 1)
        { spellID = 190456, check = true },             -- Ignore Pain
        { spellID = 231847, check = true },             -- Shield Block (Rank 2)
        { spellID = 316825, check = true },             -- Rallying Cry (Rank 2)

        -- Protection
        { spellID = 871, check = true },                -- Shield Wall
        { spellID = 12975, check = true },              -- Last Stand
        { spellID = 23920, check = true },              -- Spell Reflection
        { spellID = 107574, check = true },             -- Avatar
        { spellID = 316438, check = true },             -- Avatar (Rank 2)
        { spellID = 316778, check = true },             -- Ignore Pain (Rank 2)
        { spellID = 316834, check = true },             -- Shield Wall
        { spellID = 107570, check = true },             -- Storm Bolt
    }
}
