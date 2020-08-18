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
        { spellID = 974   , caster = "player", filter = "BUFF" },   -- Earth Shield
        { spellID = 108271, caster = "player", filter = "BUFF" },   -- Astral Shift
        { spellID = 260881, caster = "player", filter = "BUFF" },   -- Spirit Wolf
        
        -- Elemental
        { spellID = 108281, caster = "player", filter = "BUFF" },   -- Ancestral Guidance
        { spellID = 114050, caster = "player", filter = "BUFF" },   -- Ascendance
        { spellID = 191634, caster = "player", filter = "BUFF" },   -- Stormkeeper
        { spellID = 263806, caster = "player", filter = "BUFF" },   -- Wind Gust

            -- Procs
            { spellID = 77762 , caster = "player", filter = "BUFF" },   -- Lava Surge
            { spellID = 118522, caster = "player", filter = "BUFF" },   -- Elemental Blast: Critical Strike
            { spellID = 173183, caster = "player", filter = "BUFF" },   -- Elemental Blast: Haste
            { spellID = 173184, caster = "player", filter = "BUFF" },   -- Elemental Blast: Mastery
            { spellID = 210174, caster = "player", filter = "BUFF" },   -- Icefury
            { spellID = 260734, caster = "player", filter = "BUFF" },   -- Master of the Elements
            { spellID = 272737, caster = "player", filter = "BUFF" },   -- Unlimited Power
            { spellID = 285514, caster = "player", filter = "BUFF" },   -- Surge of Power

        -- Restoration
        { spellID = 61295 , caster = "player", filter = "BUFF" },   -- Riptide
        { spellID = 79206 , caster = "player", filter = "BUFF" },   -- Spiritwalker's Grace
        { spellID = 114052, caster = "player", filter = "BUFF" },   -- Ascendance
        { spellID = 207400, caster = "player", filter = "BUFF" },   -- Ancestral Vigor
        { spellID = 288675, caster = "player", filter = "BUFF" },   -- High Tide
        
            -- Procs
            { spellID = 53390 , caster = "player", filter = "BUFF" },   -- Tidal Waves
            { spellID = 216251, caster = "player", filter = "BUFF" },   -- Undulation
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
        { spellID = 974   , caster = "player", filter = "BUFF" },   -- Earth Shield
        
        -- Restoration
        { spellID = 61295 , caster = "player", filter = "BUFF" },   -- Riptide
        { spellID = 207400, caster = "player", filter = "BUFF" },   -- Ancestral Vigor

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        -- Hex
        { spellID = 51514 , caster = "player", filter = "DEBUFF" },  -- Hex: Frog
        { spellID = 210873, caster = "player", filter = "DEBUFF" }, -- Hex: Compy
        { spellID = 211004, caster = "player", filter = "DEBUFF" }, -- Hex: Spider
        { spellID = 211010, caster = "player", filter = "DEBUFF" }, -- Hex: Snake
        { spellID = 211015, caster = "player", filter = "DEBUFF" }, -- Hex: Cockroach
        { spellID = 269352, caster = "player", filter = "DEBUFF" }, -- Hex: Skeletal Hatchling
        { spellID = 277778, caster = "player", filter = "DEBUFF" }, -- Hex: Zandalari Tendonripper
        { spellID = 277784, caster = "player", filter = "DEBUFF" }, -- Hex: Wicker Mongrel

        -- Elemental
        { spellID = 51490 , caster = "player", filter = "DEBUFF" }, -- Thunderstorm
        { spellID = 182387, caster = "player", filter = "DEBUFF" }, -- Earthquake
        { spellID = 188389, caster = "player", filter = "DEBUFF" }, -- Flame Shock
        { spellID = 196840, caster = "player", filter = "DEBUFF" }, -- Frost Shock

        -- Restoration
        { spellID = 188838, caster = "player", filter = "DEBUFF" }, -- Flame Shock

        -- Totems
        { spellID = 3600  , caster = "player", filter = "DEBUFF" },  -- Earthbind
        { spellID = 118905, caster = "player", filter = "DEBUFF" },  -- Stack Charge
    }, -- [3]
}
