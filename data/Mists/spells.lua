local _, ns = ...

local CreateSpellPriority = ns.data.CreateSpellPriority
local AddSpells = ns.data.AddSpells

--------------------------------------------------
-- Mists of Pandaria Classic
--------------------------------------------------
local data = {
    ["PRIEST"] = {

    },
    ["MONK"] = {
        [115080] = CreateSpellPriority(false), -- Touch of Death
        [117666] = CreateSpellPriority(false), -- Legacy of the Emperor
        [129914] = CreateSpellPriority(false), -- Power Strike

        -- Brewmaster
        [118636] = CreateSpellPriority(8),     -- Power Guard
        [123402] = CreateSpellPriority(9),     -- Guard
        [125359] = CreateSpellPriority(8),     -- Tiger Power
        [128939] = CreateSpellPriority(9),     -- Elusive Brew
        [132365] = CreateSpellPriority(10),    -- Vengeance
    }
}

AddSpells(data)
