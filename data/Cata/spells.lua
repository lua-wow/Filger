local _, ns = ...

local CreateSpellPriority = ns.data.CreateSpellPriority
local AddSpells = ns.data.AddSpells

--------------------------------------------------
-- Cataclysm Classic
--------------------------------------------------
local data = {
    ["DEATHKNIGHT"] = {
        -- Blood
        [49222] = CreateSpellPriority(8),       -- Bone Shield
    },
    ["PALADIN"] = {
        -- Holy
        [82327] = CreateSpellPriority(5),       -- Holy Radiance
        [86273] = CreateSpellPriority(5),       -- Illuminated Healing
        
        -- Protection
        [20925] = CreateSpellPriority(7),       -- Holy Shield
    },
    ["PRIEST"] = {
        -- Discipline
        [81660] = CreateSpellPriority(8),       -- Evangelism (Rank 1)
        [81661] = CreateSpellPriority(8),       -- Evangelism (Rank 2)
        [59887] = CreateSpellPriority(7),       -- Borrowed Time (Rank 1)
        [59888] = CreateSpellPriority(7),       -- Borrowed Time (Rank 2)
        [59889] = CreateSpellPriority(7),       -- Borrowed Time (Rank 3)
    }
}

AddSpells(data)

-- TODO: temporary load marker, remove when [Game] loading is verified
print("|cffff8000Filger|r data: Cata")
