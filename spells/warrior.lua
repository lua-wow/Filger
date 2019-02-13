local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Warrior
----------------------------------------------------------------
SpellList["WARRIOR"] = {
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

        -- All Spec
        { spellID = 586   , caster = "player", filter = "BUFF" },	-- Fade

        -- Protection
        { spellID = 871   , caster = "player", filter = "BUFF" },	-- Shield Wall
        { spellID = 12975 , caster = "player", filter = "BUFF" },	-- Last Stand
        { spellID = 18499 , caster = "player", filter = "BUFF" },	-- Berserker Rage
        { spellID = 23920 , caster = "player", filter = "BUFF" },	-- Spell Reflection
        { spellID = 107574, caster = "player", filter = "BUFF" },	-- Avatar
        { spellID = 132404, caster = "player", filter = "BUFF" },	-- Shield Block
        { spellID = 190456, caster = "player", filter = "BUFF" },	-- Ignore Pain

        { spellID = 202602, caster = "player", filter = "BUFF" },	-- Into the Fray

        -- Procs
        { spellID = 5302  , caster = "player", filter = "BUFF" },	-- Vengeance
        { spellID = 202573, caster = "player", filter = "BUFF" },	-- Vengeance: Revenge
        { spellID = 202574, caster = "player", filter = "BUFF" },	-- Vengeance: Ignore Pain
        { spellID = 227744, caster = "player", filter = "BUFF" },	-- Ravager

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

        -- Protection
        { spellID = 871   , caster = "player", filter = "CD" },     -- Shield Wall
        { spellID = 12975 , caster = "player", filter = "CD" },     -- Last Stand
        { spellID = 18499 , caster = "player", filter = "CD" },     -- Berserker Rage
        { spellID = 107574, caster = "player", filter = "CD" },     -- Avatar
        { spellID = 97462 , caster = "player", filter = "CD" },     -- Rallying Cry

    }, -- [2]
    --]]
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
        -- Protection
        { spellID = 147833, caster = "player", filter = "BUFF" },       -- Intervene
        { spellID = 223658, caster = "player", filter = "BUFF" },       -- Safeguard

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        -- Protection
        { spellID = 355   , caster = "player", filter = "DEBUFF" },     -- Taunt
        { spellID = 1160  , caster = "player", filter = "DEBUFF" },     -- Demoralizing Shout
        { spellID = 5246  , caster = "player", filter = "DEBUFF" },     -- Intimidating Shout
        { spellID = 6343  , caster = "player", filter = "DEBUFF" },     -- Thunder Clap
        { spellID = 105771, caster = "player", filter = "DEBUFF" },     -- Charge
        { spellID = 115767, caster = "player", filter = "DEBUFF" },     -- Deep Wounds
        { spellID = 118000, caster = "player", filter = "DEBUFF" },     -- Dragon Roar
        { spellID = 132168, caster = "player", filter = "DEBUFF" },     -- Shockwave
        { spellID = 132169, caster = "player", filter = "DEBUFF" },     -- Storm Bolt
        { spellID = 275335, caster = "player", filter = "DEBUFF" },     -- Punish
    }, -- [3]
}