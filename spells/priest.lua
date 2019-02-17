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
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HELPFUL",

        -- All Spec
        { spellID = 586   , caster = "player", filter = "BUFF" },	-- Fade
        
        -- Discipline
        { spellID = 17    , caster = "player", filter = "BUFF" },	-- Power Word: Shield
        { spellID = 33206 , caster = "player", filter = "BUFF" },	-- Pain Suppression
        { spellID = 47536 , caster = "player", filter = "BUFF" },	-- Rapture
        { spellID = 81782 , caster = "player", filter = "BUFF" },	-- Power Word: Barrier
        { spellID = 194384, caster = "player", filter = "BUFF" },	-- Atonement
        { spellID = 271466, caster = "player", filter = "BUFF" },	-- Luminous Barrier

            -- Procs
            { spellID = 193065, caster = "player", filter = "BUFF" },	-- Masohism (Talent)
            { spellID = 198069, caster = "player", filter = "BUFF" },	-- Power of the Dark Side
            { spellID = 265258, caster = "player", filter = "BUFF" },	-- Twist of Fate
            
            -- Debuffs
            { spellID = 6788  , caster = "player", filter = "DEBUFF" },	-- Weakened Soul

        -- Holy
        { spellID = 139   , caster = "player", filter = "BUFF" },    -- Renew
        { spellID = 41635 , caster = "player", filter = "BUFF" },	-- Prayer of Mending
        { spellID = 47788 , caster = "player", filter = "BUFF" },    -- Guardian Spirit
        { spellID = 64843 , caster = "player", filter = "BUFF" },	-- Divine Hymn
        { spellID = 64901 , caster = "player", filter = "BUFF" },	-- Symbol fo Hope
        { spellID = 77489 , caster = "player", filter = "BUFF" },	-- Echo of Light
        { spellID = 111759, caster = "player", filter = "BUFF" },	-- Levitade
        { spellID = 121557, caster = "player", filter = "BUFF" },	-- Angelic Feather
        { spellID = 19236 , caster = "player", filter = "BUFF" },	-- Desperate Prayer

            -- Procs
            { spellID = 27827 , caster = "player", filter = "BUFF" },   -- Spirit of Redemption
            { spellID = 45242 , caster = "player", filter = "BUFF" },   -- Focused Will
            { spellID = 114255,	caster = "player", filter = "BUFF" },   -- Surge of Light
            { spellID = 200183, caster = "player", filter = "BUFF" },   -- Apotheosis
            { spellID = 214121, caster = "player", filter = "BUFF" },   -- Body and Mind

        -- Shadow
        { spellID = 15286 , caster = "player", filter = "BUFF" },	-- Vampiric Embrace
        { spellID = 47585 , caster = "player", filter = "BUFF" },	-- Dispersion
        { spellID = 65081 , caster = "player", filter = "BUFF" },	-- Body and Soul
        { spellID = 193223, caster = "player", filter = "BUFF" },	-- Surrender to Madness
        { spellID = 194249, caster = "player", filter = "BUFF" },	-- Voidform
        { spellID = 232698, caster = "player", filter = "BUFF" },	-- Shadowform
        { spellID = 263406, caster = "player", filter = "BUFF" },	-- Surrendered to Madness

            -- Procs
            { spellID = 87160 ,	caster = "player", filter = "BUFF" },   -- Surge of Darkness
            { spellID = 123254, caster = "player", filter = "BUFF" },   -- Twist of Fate
            { spellID = 124430, caster = "player", filter = "BUFF" },   -- Shadowy Insight
            { spellID = 197937, caster = "player", filter = "BUFF" },   -- Lingering Insanity
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

        -- Discipline
        { spellID = 33206 , caster = "player", filter = "CD" },	-- Pain Suppression
        { spellID = 62618 , caster = "player", filter = "CD" },	-- Power Word: Barrier
        { spellID = 271466, caster = "player", filter = "CD" },	-- Luminous Barrier

        -- Holy
        { spellID = 19236 , caster = "player", filter = "CD" }, -- Desperate Prayer
        { spellID = 47788 , caster = "player", filter = "CD" }, -- Guardian Spirit
        { spellID = 64843 , caster = "player", filter = "CD" }, -- Divine Hymn
        { spellID = 64901 , caster = "player", filter = "CD" }, -- Symbol fo Hope
        { spellID = 265202, caster = "player", filter = "CD" }, -- Holy Word: Salvation
    
        -- Shadow
        { spellID = 15286 , caster = "player", filter = "CD" },	-- Vampiric Embrace
        { spellID = 47585 , caster = "player", filter = "CD" },	-- Dispersion
        { spellID = 200174, caster = "player", filter = "CD" },	-- Mind Bender
        { spellID = 263346, caster = "player", filter = "CD" },	-- Dark Void
        { spellID = 280711, caster = "player", filter = "CD" },	-- Dark Ascencion
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
        -- Discipline
        { spellID = 17    , caster = "player", filter = "BUFF" },	-- Power Word: Shield
        { spellID = 33206 , caster = "player", filter = "BUFF" },	-- Pain Suppression
        { spellID = 47536 , caster = "player", filter = "BUFF" },	-- Rapture
        { spellID = 81782 , caster = "player", filter = "BUFF" },	-- Power Word: Barrier
        { spellID = 194384, caster = "player", filter = "BUFF" },	-- Atonement
        { spellID = 271466, caster = "player", filter = "BUFF" },	-- Luminous Barrier

        -- Holy
        { spellID = 139   , caster = "player", filter = "BUFF" },    -- Renew
        { spellID = 19236 , caster = "player", filter = "BUFF" },	-- Desperate Prayer
        { spellID = 41635 , caster = "player", filter = "BUFF" },	-- Prayer of Mending
        { spellID = 47788 , caster = "player", filter = "BUFF" },    -- Guardian Spirit
        { spellID = 77489 , caster = "player", filter = "BUFF" },	-- Echo of Light
        { spellID = 111759, caster = "player", filter = "BUFF" },	-- Levitade
        { spellID = 121557, caster = "player", filter = "BUFF" },	-- Angelic Feather

        -- Shadow
        { spellID = 65081 , caster = "player", filter = "BUFF" },	-- Body and Soul

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        -- Discipline
        { spellID = 6788  , caster = "player", filter = "DEBUFF" },	-- Weakened Soul
        { spellID = 204213, caster = "player", filter = "DEBUFF" },	-- Purge the Wicked
        { spellID = 204263, caster = "player", filter = "DEBUFF" },	-- Shining Force
        { spellID = 208772, caster = "player", filter = "DEBUFF" },	-- Smite
        { spellID = 214621, caster = "player", filter = "DEBUFF" },	-- Schism

        -- Holy
        { spellID = 14914 , caster = "player", filter = "DEBUFF" },	-- Holy Fire
        { spellID = 200196, caster = "player", filter = "DEBUFF" },	-- Holy Word: Chastise
        { spellID = 200200, caster = "player", filter = "DEBUFF" },	-- Holy Word: Chastise

        -- Shadow
        { spellID = 589   , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain
        { spellID = 605   , caster = "player", filter = "DEBUFF" },	-- Mind Control
        { spellID = 8122  , caster = "player", filter = "DEBUFF" },	-- Psychic Scream
        { spellID = 15407 , caster = "player", filter = "DEBUFF" },	-- Mind Flay
        { spellID = 15487 , caster = "player", filter = "DEBUFF" },	-- Silence
        { spellID = 34914 , caster = "player", filter = "DEBUFF" },	-- Vampiric Touch
        { spellID = 48045 , caster = "player", filter = "DEBUFF" },	-- Mind Sear
        { spellID = 64044 , caster = "player", filter = "DEBUFF" },	-- Psychic Horror
        { spellID = 226943, caster = "player", filter = "DEBUFF" },	-- Mind Bomb
        { spellID = 205369, caster = "player", filter = "DEBUFF" },	-- Mind Bomb
        { spellID = 263165, caster = "player", filter = "DEBUFF" },	-- Void Torrent
    }, -- [3]
}