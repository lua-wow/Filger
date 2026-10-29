local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- The Burning Crusade Classic
--------------------------------------------------
local data = {
    -- HUNTER
    [34074] = true,   -- Aspect of the Viper
    [24529] = true,   -- Spirit Bond

    [25431] = true,   -- Inner Fire (Rank 7)
}

AddBlacklist(data)
