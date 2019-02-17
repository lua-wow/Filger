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
        { spellID = 26297 , caster = "player", filter = "BUFF" },   -- Berserking (Troll)
        { spellID = 20572 , caster = "player", filter = "BUFF" },   -- Blood Fury (Orc - Attack Power)
        { spellID = 33697 , caster = "player", filter = "BUFF" },   -- Blood Fury (Orc - Attack Power/Intellect)
        { spellID = 33702 , caster = "player", filter = "BUFF" },   -- Blood Fury (Orc - Intellect)

        { spellID = 57724 , caster = "all", filter = "DEBUFF" },    -- Sated
        { spellID = 80354 , caster = "all", filter = "DEBUFF" },    -- Temporal Displacement
        { spellID = 264689, caster = "all", filter = "DEBUFF" },    -- Fatigued

        -- Potions / Flasks
        -- Trinkets
        -- Profissions
            -- Enchanting
            -- Engineering
            -- Herbalism
            -- Tailoring
        
        ----------------------------------------------------------------
        -- Raid Cooldowns
        ----------------------------------------------------------------
        { spellID = 2825  , caster = "all", filter = "BUFF" },      -- Bloodlust (Shaman Horde)
        { spellID = 32182 , caster = "all", filter = "BUFF" },      -- Heroism (Shaman Alliance)
        { spellID = 80353 , caster = "all", filter = "BUFF" },      -- Time Warp (Mage)
        { spellID = 264667, caster = "all", filter = "BUFF" },      -- Primal Rage (Hunter)
        { spellID = 97463 , caster = "all", filter = "BUFF" },      -- Rallying Cry
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
        { spellID = 77761 , caster = "all", filter = "BUFF" },      -- Stampeding Roar (Guardian)
        { spellID = 77764 , caster = "all", filter = "BUFF" },      -- Stampeding Roar (Feral)
        { spellID = 102342, caster = "all", filter = "BUFF" },      -- Ironbark
        -- Monk
        { spellID = 116841, caster = "all", filter = "BUFF" },      -- Tiger's Lust
        { spellID = 116849, caster = "all", filter = "BUFF" },      -- Life Cocoon
        -- Paladin
        { spellID = 1022  , caster = "all", filter = "BUFF" },      -- Blessing of Protection
        { spellID = 1044  , caster = "all", filter = "BUFF" },      -- Blessing of Freedom
        { spellID = 6940  , caster = "all", filter = "BUFF" },      -- Blessing of Sacrifice
        { spellID = 204018, caster = "all", filter = "BUFF" },      -- Blessing of Spellwarding
        -- Priest
        { spellID = 33206 , caster = "all", filter = "BUFF" },      -- Pain Suppression
        { spellID = 47788 , caster = "all", filter = "BUFF" },      -- Guardian Spirit
        -- Shaman
        { spellID = 98007 , caster = "all", filter = "BUFF" },      -- Spirit Link Totem
        { spellID = 192082, caster = "all", filter = "BUFF" },      -- Wind Rush Totem
        { spellID = 207498, caster = "all", filter = "BUFF" },      -- Ancestral Protection Totem
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
        { spellID = 199804, caster = "all", filter = "DEBUFF" },   -- Between the Eyes
        -- Paladin
        { spellID = 853   , caster = "all", filter = "DEBUFF" },   -- Hammer of Justice
        { spellID = 20066 , caster = "all", filter = "DEBUFF" },   -- Repentance
        { spellID = 105421, caster = "all", filter = "DEBUFF" },   -- Blinding Light
        -- Mage
        { spellID = 118   , caster = "all", filter = "DEBUFF" },   -- Polymorph: Sheep
        { spellID = 28271 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Turtle
        { spellID = 28272 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Pig
        { spellID = 61305 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Black Cat
        { spellID = 61721 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Rabbit
        { spellID = 61780 , caster = "all", filter = "DEBUFF" },   -- Polymorph: Turkey
        { spellID = 126819, caster = "all", filter = "DEBUFF" },   -- Polymorph: Porcupine
        { spellID = 161353, caster = "all", filter = "DEBUFF" },   -- Polymorph: Polar Bear Cub
        { spellID = 161354, caster = "all", filter = "DEBUFF" },   -- Polymorph: Monkey
        { spellID = 161355, caster = "all", filter = "DEBUFF" },   -- Polymorph: Penguin
        { spellID = 161372, caster = "all", filter = "DEBUFF" },   -- Polymorph: Peacock
        { spellID = 277787, caster = "all", filter = "DEBUFF" },   -- Polymorph: Direhorn
        { spellID = 277792, caster = "all", filter = "DEBUFF" },   -- Polymorph: Bumblebee
        { spellID = 31661 , caster = "all", filter = "DEBUFF" },   -- Dragon's Breath
        { spellID = 82691 , caster = "all", filter = "DEBUFF" },   -- Ring of Frost
        -- Death Knight
        { spellID = 91797 , caster = "all", filter = "DEBUFF" },   -- Monstrous Blow (Mutated Ghoul)
        { spellID = 91800 , caster = "all", filter = "DEBUFF" },   -- Gnaw (Ghoul)
        { spellID = 108194, caster = "all", filter = "DEBUFF" },   -- Asphyxiate
        -- Druid
        { spellID = 99    , caster = "all", filter = "DEBUFF" },   -- Incapacitating Roar
        { spellID = 5211  , caster = "all", filter = "DEBUFF" },   -- Mighty Bash
        { spellID = 22570 , caster = "all", filter = "DEBUFF" },   -- Maim
        { spellID = 33786 , caster = "all", filter = "DEBUFF" },   -- Cyclone
        { spellID = 163505, caster = "all", filter = "DEBUFF" },   -- Rake
        -- Hunter
        { spellID = 3355  , caster = "all", filter = "DEBUFF" },   -- Freezing Trap
        { spellID = 19386 , caster = "all", filter = "DEBUFF" },   -- Wyvern Sting
        { spellID = 24394 , caster = "all", filter = "DEBUFF" },   -- Intimidation
        { spellID = 117526, caster = "all", filter = "DEBUFF" },   -- Binding Shot
        -- Priest
        { spellID = 605   , caster = "all", filter = "DEBUFF" },   -- Dominate Mind
        { spellID = 8122  , caster = "all", filter = "DEBUFF" },   -- Psychic Scream
        { spellID = 64044 , caster = "all", filter = "DEBUFF" },   -- Psychic Horror
        { spellID = 87204 , caster = "all", filter = "DEBUFF" },   -- Sin and Punishment
        -- Shaman
        { spellID = 51514 , caster = "all", filter = "DEBUFF" },   -- Hex
        { spellID = 118345, caster = "all", filter = "DEBUFF" },   -- Pulverize (Earth Elemental)
        { spellID = 118905, caster = "all", filter = "DEBUFF" },   -- Static Charge
        -- Warlock
        { spellID = 5484  , caster = "all", filter = "DEBUFF" },   -- Howl of Terror
        { spellID = 6358  , caster = "all", filter = "DEBUFF" },   -- Seduction (Succubus)
        { spellID = 6789  , caster = "all", filter = "DEBUFF" },   -- Mortal Coil
        { spellID = 30283 , caster = "all", filter = "DEBUFF" },   -- Shadowfury
        { spellID = 89766 , caster = "all", filter = "DEBUFF" },   -- Axe Toss (Felguard)
        { spellID = 115268, caster = "all", filter = "DEBUFF" },   -- Mesmerize (Shivarra)
        { spellID = 118699, caster = "all", filter = "DEBUFF" },   -- Fear
        { spellID = 171156, caster = "all", filter = "DEBUFF" },   -- Meteor Strike (Abyssal)
        -- Warrior
        { spellID = 5246  , caster = "all", filter = "DEBUFF" },   -- Intimidating Shout
        { spellID = 132168, caster = "all", filter = "DEBUFF" },   -- Shockwave
        { spellID = 132169, caster = "all", filter = "DEBUFF" },   -- Storm Bolt
        -- Monk
        { spellID = 115078, caster = "all", filter = "DEBUFF" },   -- Paralysis
        { spellID = 119381, caster = "all", filter = "DEBUFF" },   -- Leg Sweep
        { spellID = 120086, caster = "all", filter = "DEBUFF" },   -- Fists of Fury
        -- Racials
        { spellID = 20549 , caster = "all", filter = "DEBUFF" },   -- War Stomp
        { spellID = 69179 , caster = "all", filter = "DEBUFF" },   -- Arcane Torrent
        { spellID = 107079, caster = "all", filter = "DEBUFF" },   -- Quaking Palm
        -- Other
        { spellID = 66271 , caster = "all", filter = "DEBUFF" },   -- Seaforium
        { spellID = 76577 , caster = "all", filter = "DEBUFF" },   -- Smoke Bomb
        { spellID = 77606 , caster = "all", filter = "DEBUFF" },   -- Dark Simulacrum
        { spellID = 87023 , caster = "all", filter = "DEBUFF" },   -- Cauterize
        { spellID = 94794 , caster = "all", filter = "DEBUFF" },   -- Rocket Fuel Leak
        { spellID = 116888, caster = "all", filter = "DEBUFF" },   -- Shroud of Purgatory
        { spellID = 125174, caster = "all", filter = "DEBUFF" },   -- Touch of Karma
        { spellID = 206491, caster = "all", filter = "DEBUFF" },   -- Nemesis
    }, -- [6]
}