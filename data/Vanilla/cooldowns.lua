local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Classic Era
--------------------------------------------------
local data = {
    ["PALADIN"] = {
        -- General
        CreateSpellCooldown(498),           -- Divine Protection
        CreateSpellCooldown(642),           -- Divine Shield
        CreateSpellCooldown(633),           -- Lay on Hands
        CreateSpellCooldown(1022),          -- Blessing of Protection
        CreateSpellCooldown(1044),          -- Blessing of Freedom
        CreateSpellCooldown(6940),          -- Blessing of Sacrifice
    },
    ["PRIEST"] = {
        -- Discipline
        CreateSpellCooldown(10060),         -- Power Infusion
        CreateSpellCooldown(14751),         -- Inner Focus

        -- Holy
        CreateSpellCooldown(724),           -- Lightwell (Rank 1)
        CreateSpellCooldown(27870),         -- Lightwell (Rank 2)
        CreateSpellCooldown(27871),         -- Lightwell (Rank 3)

        -- Shadow
        CreateSpellCooldown(15286, false),        -- Vampiric Embrace
        CreateSpellCooldown(15487),         -- Silence

        CreateSpellCooldown(586),           -- Fade (Rank 1)
        CreateSpellCooldown(9578),          -- Fade (Rank 2)
        CreateSpellCooldown(9579),          -- Fade (Rank 3)
        CreateSpellCooldown(9592),          -- Fade (Rank 4)
        CreateSpellCooldown(10941),         -- Fade (Rank 5)
        CreateSpellCooldown(10942),         -- Fade (Rank 6)

        CreateSpellCooldown(8122),          -- Psychic Scream (Rank 1)
        CreateSpellCooldown(8124),          -- Psychic Scream (Rank 2)
        CreateSpellCooldown(10888),         -- Psychic Scream (Rank 3)
        CreateSpellCooldown(10890),         -- Psychic Scream (Rank 4)

        -- Night Elf
        CreateSpellCooldown(2651),          -- Elune's Grace (Rank 1)
        CreateSpellCooldown(19289),         -- Elune's Grace (Rank 2)
        CreateSpellCooldown(19291),         -- Elune's Grace (Rank 3)
        CreateSpellCooldown(19292),         -- Elune's Grace (Rank 4)
        CreateSpellCooldown(19293),         -- Elune's Grace (Rank 5)

        -- Human 
        CreateSpellCooldown(13896),         -- Feedback (Rank 1)
        CreateSpellCooldown(19271),         -- Feedback (Rank 2)
        CreateSpellCooldown(19273),         -- Feedback (Rank 3)
        CreateSpellCooldown(19274),         -- Feedback (Rank 4)
        CreateSpellCooldown(19275),         -- Feedback (Rank 5)

        -- Dwarf
        CreateSpellCooldown(6346),          -- Fear Ward (Rank 1)

        -- Dwarf / Humman
        CreateSpellCooldown(13908),         -- Desperate Prayer (Rank 1)
        CreateSpellCooldown(19236),         -- Desperate Prayer (Rank 2)
        CreateSpellCooldown(19238),         -- Desperate Prayer (Rank 3)
        CreateSpellCooldown(19240),         -- Desperate Prayer (Rank 4)
        CreateSpellCooldown(19241),         -- Desperate Prayer (Rank 5)
        CreateSpellCooldown(19242),         -- Desperate Prayer (Rank 6)
        CreateSpellCooldown(19243),         -- Desperate Prayer (Rank 7)
        
        -- Undead
        CreateSpellCooldown(2944),          -- Devouring Plague(Rank 1)
        CreateSpellCooldown(19276),         -- Devouring Plague(Rank 2)
        CreateSpellCooldown(19277),         -- Devouring Plague(Rank 3)
        CreateSpellCooldown(19278),         -- Devouring Plague(Rank 4)
        CreateSpellCooldown(19279),         -- Devouring Plague(Rank 5)
        CreateSpellCooldown(19280),         -- Devouring Plague(Rank 6)
    },
    ["WARRIOR"] = {
        -- Arms
        CreateSpellCooldown(6178),          -- Charge
        CreateSpellCooldown(7400),          -- Mocking Blow
        CreateSpellCooldown(20230),         -- Retaliation
        
        -- Fury
        CreateSpellCooldown(1161),          -- Challenging Shout
        CreateSpellCooldown(5246),          -- Intimidating Shout
        CreateSpellCooldown(18499),         -- Berserker Rage
        CreateSpellCooldown(20252),         -- Intercept

        -- Protection
        CreateSpellCooldown(355),           -- Taunt
        CreateSpellCooldown(676),           -- Disarm
        CreateSpellCooldown(871),           -- Shield Wall
        CreateSpellCooldown(1671),          -- Shield Bash
        CreateSpellCooldown(2687),          -- Bloodrage
    }
}
AddCooldowns(data)
