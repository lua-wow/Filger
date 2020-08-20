local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Shaman
----------------------------------------------------------------
SpellList["SHAMAN"] = {
    {
        name = "PLAYER_AURAS",
        anchor = Config["Panels"].PlayerAuras,
        direction = "LEFT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HELPFUL",

        -- All Specs
        
        -- Elemental
        { spellID = 324  , caster = "player", filter = "BUFF" }, -- Lightning Shield (Rank 1)
        { spellID = 325  , caster = "player", filter = "BUFF" }, -- Lightning Shield (Rank 2)
        { spellID = 905  , caster = "player", filter = "BUFF" }, -- Lightning Shield (Rank 3)
        { spellID = 945  , caster = "player", filter = "BUFF" }, -- Lightning Shield (Rank 4)
        { spellID = 8134 , caster = "player", filter = "BUFF" }, -- Lightning Shield (Rank 5)
        { spellID = 10431, caster = "player", filter = "BUFF" }, -- Lightning Shield (Rank 6)

        -- Restoration
        
    }, -- [1]
    --[[
    {
        name = "PLAYER_COOLDOWNS",
        anchor = Config["Panels"].PlayerCooldowns,
        direction = "DOWN",
        mode = "BAR",
        num = 3,
        size = Config["General"].BarHeight,
        width = Config["General"].BarWidth,
        spacing = Config["General"].BarSpacing,
        unit = "player",
        filter = "COOLDOWN",
        
        -- All Specs
        { spellID = 108271, caster = "player", filter = "CD" }, -- Astral Shift

        -- Elemental
        { spellID = 51490 , caster = "player", filter = "CD" }, -- Thunderstorm
        { spellID = 108281, caster = "player", filter = "CD" }, -- Ancestral Guidance
        { spellID = 114050, caster = "player", filter = "CD" }, -- Ascendance

        -- Restoration
        { spellID = 79206 , caster = "player", filter = "CD" }, -- Spiritwalker's Grace
        { spellID = 98008 , caster = "player", filter = "CD" }, -- Spirit Link Totem
        { spellID = 108280, caster = "player", filter = "CD" }, -- Healing Tide Totem
        { spellID = 192007, caster = "player", filter = "CD" }, -- Wind Rush Totem
        { spellID = 207399, caster = "player", filter = "CD" }, -- Ancestral Protection Totem
    }, -- [2]
    ]]--
    {
        name = "TARGET_AURAS",
        anchor = Config["Panels"].TargetAuras,
        direction = "RIGHT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "target",
        filter = "HELPFUL",

        ----------------------------------------------------------------
        -- Buffs
        ----------------------------------------------------------------
        -- Restoration

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------

        -- Elemental
        { spellID = 8050 , caster = "player", filter = "DEBUFF" }, -- Flame Shick (Rank 1)
        { spellID = 8052 , caster = "player", filter = "DEBUFF" }, -- Flame Shick (Rank 2)
        { spellID = 8053 , caster = "player", filter = "DEBUFF" }, -- Flame Shick (Rank 3)
        { spellID = 10447, caster = "player", filter = "DEBUFF" }, -- Flame Shick (Rank 4)
        { spellID = 10448, caster = "player", filter = "DEBUFF" }, -- Flame Shick (Rank 5)

        -- Restoration

        -- Totems
        { spellID = 3600  , caster = "player", filter = "DEBUFF" },  -- Earthbind
    }, -- [3]
}
