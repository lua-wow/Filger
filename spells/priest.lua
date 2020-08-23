local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Priest
----------------------------------------------------------------
SpellList["PRIEST"] = {
    {
        name = "PLAYER_AURAS",
        anchor = Config["Panels"].PlayerAuras,
        direction = "LEFT",
        mode = "ICON",
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,

        unit = "player",
        caster = "player",
        boss = false,
        pvp = false
    }, -- [1]
    {
        name = "TARGET_AURAS",
        anchor = Config["Panels"].TargetAuras,
        direction = "RIGHT",
        mode = "ICON",
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,

        unit = "target",
        caster = "player",
        debuffs = true,
        buffs = true,
        boss = false,
        pvp = false
    }, -- [2]
    {
        name = "TARGET_DEBUFFS",
        anchor = Config["Panels"].TargetDebuffs,
        direction = "RIGHT",
        mode = "ICON",
        limit = 8,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,

        filter = "PLAYER|HARMFUL",

        unit = "target",
        caster = "player",
        debuffs = true,
        buffs = true,
        boss = false,
        pvp = false
    } -- [3]
    -- {
    --     name = "TARGET_DEBUFFS",
    --     anchor = Config["Panels"].TargetDebuffs,
    --     direction = "RIGHT",
    --     mode = "ICON",
    --     limit = 8,
    --     size = Config["General"].IconSize,
    --     spacing = Config["General"].IconSpacing,

    --     filter = "PLAYER|HARMFUL",

    --     unit = "target",
    --     caster = "player",
    --     debuffs = true,
    --     buffs = true,
    --     boss = false,
    --     pvp = false,
    -- } -- [3]
}
