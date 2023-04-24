local _, ns = ...
local Config = ns.Config

------------------------------------------------------------
-- Warlords of Draenor
------------------------------------------------------------
local BlackList = {
    [155347] = true,                -- Shamanstone: Spirit ofthe Wolf
}

if (not ns.Filger.isWoD) then return end

Config.importBlackList(BlackList)
