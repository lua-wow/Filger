local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- All
----------------------------------------------------------------
SpellList["ALL"] = {
    {
        name = "PLAYER_ALL_AURAS",
        anchor = Config["Panels"].PlayerAllAuras,
        direction = "LEFT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HELPFUL",

        ----------------------------------------------------------------
        -- Racials
        ----------------------------------------------------------------
        { spellID = 2652  , caster = "player", filter = "BUFF" },   --Touch of Weakness (Rank 1 - Undead - Priest)
        { spellID = 19261 , caster = "player", filter = "BUFF" },   --Touch of Weakness (Rank 2 - Undead - Priest)
        { spellID = 19262 , caster = "player", filter = "BUFF" },   --Touch of Weakness (Rank 3 - Undead - Priest)
        { spellID = 19264 , caster = "player", filter = "BUFF" },   --Touch of Weakness (Rank 4 - Undead - Priest)
        { spellID = 19265 , caster = "player", filter = "BUFF" },   --Touch of Weakness (Rank 5 - Undead - Priest)
        { spellID = 19266 , caster = "player", filter = "BUFF" },   --Touch of Weakness (Rank 6 - Undead - Priest)

        { spellID =  7744 , caster = "player", filter = "BUFF" },   -- Will of the Forsaken (Undead)
    }, -- [1]
    {
        name = "PLAYER_RAID_AURAS",
        anchor = Config["Panels"].PlayerRaidAuras,
        direction = "LEFT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HELPFUL",

        ----------------------------------------------------------------
        -- External Cooldowns
        ----------------------------------------------------------------
        -- Druid
        { spellID = 29166 , caster = "all", filter = "BUFF" },      -- Innervate
        -- Paladin
        { spellID = 1022  , caster = "all", filter = "BUFF" },      -- Blessing of Protection
        { spellID = 1044  , caster = "all", filter = "BUFF" },      -- Blessing of Freedom
        { spellID = 6940  , caster = "all", filter = "BUFF" },      -- Blessing of Sacrifice
        -- Warlock
        { spellID = 20707 , caster = "all", filter = "BUFF" },      -- Soulstone
    }, -- [2]
    {
        name = "BOSS_DEBUFFS",
        anchor = Config["Panels"].BossDebuffs,
        direction = "LEFT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HARMFUL",
        instance = true,

        -- add boss buffs/debuff on player
    }, -- [3]
    {
        name = "BOSS_BUFFS",
        anchor = Config["Panels"].BossBuffs,
        direction = "RIGHT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "target",
        filter = "HELPFUL",
        instance = true,

        -- add boss self buffs/debuffs
    }, -- [4]
    --[[
    {
        name = "FOCUS_AURAS",
        anchor = Config["Panels"].FocusAuras,
        direction = "RIGHT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "focus",
        filter = "HELPFUL",
        instance = true,

        -- add boss buffs/debuffs on focus
    }, -- [5]
    --]]
    {
        name = "PvP_DEBUFFS",
        anchor = Config["Panels"].PvPDebuffs,
        direction = "LEFT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HARMFUL",

        -- Rogue
        { spellID = 408   , caster = "all", filter = "DEBUFF" },   -- Kidney Shot
        { spellID = 1776  , caster = "all", filter = "DEBUFF" },   -- Gouge
        { spellID = 1833  , caster = "all", filter = "DEBUFF" },   -- Cheap Shot
        { spellID = 2094  , caster = "all", filter = "DEBUFF" },   -- Blind
        { spellID = 6770  , caster = "all", filter = "DEBUFF" },   -- Sap
        -- Paladin
        { spellID = 853   , caster = "all", filter = "DEBUFF" },   -- Hammer of Justice
        { spellID = 20066 , caster = "all", filter = "DEBUFF" },   -- Repentance
        -- Mage
        { spellID = 118   , caster = "all", filter = "DEBUFF" },   -- Polymorph: Sheep
        { spellID = 28271 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Turtle
        { spellID = 28272 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Pig
        -- Druid
        { spellID = 99    , caster = "all", filter = "DEBUFF" },   -- Incapacitating Roar
        { spellID = 5211  , caster = "all", filter = "DEBUFF" },   -- Mighty Bash
        { spellID = 22570 , caster = "all", filter = "DEBUFF" },   -- Maim
        -- Hunter
        { spellID = 3355  , caster = "all", filter = "DEBUFF" },   -- Freezing Trap
        { spellID = 19386 , caster = "all", filter = "DEBUFF" },   -- Wyvern Sting
        { spellID = 24394 , caster = "all", filter = "DEBUFF" },   -- Intimidation
        -- Priest
        { spellID = 605   , caster = "all", filter = "DEBUFF" },   -- Dominate Mind
        { spellID = 8122  , caster = "all", filter = "DEBUFF" },   -- Psychic Scream
        -- Warlock
        { spellID = 5484  , caster = "all", filter = "DEBUFF" },   -- Howl of Terror
        { spellID = 6358  , caster = "all", filter = "DEBUFF" },   -- Seduction (Succubus)
        { spellID = 6789  , caster = "all", filter = "DEBUFF" },   -- Mortal Coil
        -- Warrior
        { spellID = 5246  , caster = "all", filter = "DEBUFF" },   -- Intimidating Shout
        -- Racials
        { spellID = 20549 , caster = "all", filter = "DEBUFF" },   -- War Stomp
    }, -- [6]
}