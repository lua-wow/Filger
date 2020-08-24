local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

--[[ Example:
{
    name = "PLAYER_AURAS",                              -- frame name
    anchor = { "CENTER", UIParent, "CENTER", 0, 0 },    -- frame anchor
    direction = "LEFT",                                 -- frame growth direction
    mode = "ICON",                                      -- auras mode ("ICON" or "BAR")
    limit = 8,                                          -- maximum number of auras displayed
    size = 32,                                          -- aura icon size or bar height
    spacing = 3,                                        -- space between auras

    buffs = true,                                       -- display buffs
    buffFilter = "PLAYER|HELPFUL",                      -- overwrite buffs filters

    debuffs = true,                                     -- display debuffs
    debuffFilter = "PLAYER|HARMFUL",                    -- overwrite debuffs filter

    unit = "player",                                    -- unit which has the auras
    caster = "player",                                  -- unit who applyed the aura ("player", "target", etc.). if nil it will not filter caster.
    pve = false,                                        -- display only auras applied by npcs.                                       
    pvp = false                                         -- display only auras applied by players.
}
--]]

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
        buffs = true
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
        buffs = true
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
        debuffs = true
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
