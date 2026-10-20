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
        [129914] = CreateSpellPriority(false), -- Power Strike
        [117666] = CreateSpellPriority(false), -- Legacy of the Emperor
        [121125] = CreateSpellPriority(false), -- Touch of Death

        -- Brewmaster
        [123402] = CreateSpellPriority(9), -- Guard
        [125359] = CreateSpellPriority(8), -- Tiger   Power
        [128636] = CreateSpellPriority(8), -- Power Guard
        [128939] = CreateSpellPriority(9), -- Elusive Brew
        [132365] = CreateSpellPriority(10), -- Vengeance
    }
}

AddSpells(data)

-- TODO: temporary load marker, remove when [Game] loading is verified
print("|cffff8000Filger|r data: Mists")
