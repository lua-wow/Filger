local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Wrath of the Lich King Classic (Titan)
--------------------------------------------------
local data = {
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
        
        CreateSpellCooldown(6346),          -- Fear Ward (Rank 1)

        CreateSpellCooldown(13908),         -- Desperate Prayer (Rank 1)
        CreateSpellCooldown(19236),         -- Desperate Prayer (Rank 2)
        CreateSpellCooldown(19238),         -- Desperate Prayer (Rank 3)
        CreateSpellCooldown(19240),         -- Desperate Prayer (Rank 4)
        CreateSpellCooldown(19241),         -- Desperate Prayer (Rank 5)
        CreateSpellCooldown(19242),         -- Desperate Prayer (Rank 6)
        CreateSpellCooldown(19243),         -- Desperate Prayer (Rank 7)
        CreateSpellCooldown(25437),         -- Desperate Prayer (Rank 8)
        CreateSpellCooldown(48173),         -- Desperate Prayer (Rank 9)

        -- Undead
        CreateSpellCooldown(2944),          -- Devouring Plague(Rank 1)
        CreateSpellCooldown(19276),         -- Devouring Plague(Rank 2)
        CreateSpellCooldown(19277),         -- Devouring Plague(Rank 3)
        CreateSpellCooldown(19278),         -- Devouring Plague(Rank 4)
        CreateSpellCooldown(19279),         -- Devouring Plague(Rank 5)
        CreateSpellCooldown(19280),         -- Devouring Plague(Rank 6)
    }
}
AddCooldowns(data)
