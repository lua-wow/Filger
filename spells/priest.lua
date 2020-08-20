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
        { spellID = 586   , caster = "player", filter = "BUFF" },	-- Fade (Rank 1)
        { spellID = 9578  , caster = "player", filter = "BUFF" },	-- Fade (Rank 2)
        { spellID = 9579  , caster = "player", filter = "BUFF" },	-- Fade (Rank 3)
        { spellID = 9592  , caster = "player", filter = "BUFF" },	-- Fade (Rank 4)
        { spellID = 10941 , caster = "player", filter = "BUFF" },	-- Fade (Rank 5)
        { spellID = 10942 , caster = "player", filter = "BUFF" },	-- Fade (Rank 6)

        { spellID = 15274 , caster = "player", filter = "BUFF" },	-- Improved Fade (Rank 1)
        { spellID = 15311 , caster = "player", filter = "BUFF" },	-- Improved Fade (Rank 2)
        
        -- Discipline
        { spellID = 17    , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 1)
        { spellID = 592   , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 2)
        { spellID = 600   , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 3)
        { spellID = 3747  , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 4)
        { spellID = 6065  , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 5)
        { spellID = 6066  , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 6)
        { spellID = 10898 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 7)
        { spellID = 10899 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 8)
        { spellID = 10900 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 9)
        { spellID = 10901 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 10)

        { spellID = 14748 , caster = "player", filter = "BUFF" },	-- Improved Power Word: Shield (Rank 1)
        { spellID = 14768 , caster = "player", filter = "BUFF" },	-- Improved Power Word: Shield (Rank 2)
        { spellID = 14769 , caster = "player", filter = "BUFF" },	-- Improved Power Word: Shield (Rank 3)

        { spellID = 10060 , caster = "player", filter = "BUFF" },	-- Power Infusion

            -- Procs
            { spellID = 14743 , caster = "player", filter = "BUFF" },   -- Focused Casting (Rank 1)
            { spellID = 27828 , caster = "player", filter = "BUFF" },   -- Focused Casting (Rank 2)
            
            -- Debuffs
            { spellID = 6788  , caster = "player", filter = "DEBUFF" },	-- Weakened Soul

        -- Holy
        { spellID = 139   , caster = "player", filter = "BUFF" },    -- Renew (Rank 1)
        { spellID = 6074  , caster = "player", filter = "BUFF" },    -- Renew (Rank 2)
        { spellID = 6075  , caster = "player", filter = "BUFF" },    -- Renew (Rank 3)
        { spellID = 6076  , caster = "player", filter = "BUFF" },    -- Renew (Rank 4)
        { spellID = 6077  , caster = "player", filter = "BUFF" },    -- Renew (Rank 5)
        { spellID = 6078  , caster = "player", filter = "BUFF" },    -- Renew (Rank 6)
        { spellID = 10927 , caster = "player", filter = "BUFF" },    -- Renew (Rank 7)
        { spellID = 10928 , caster = "player", filter = "BUFF" },    -- Renew (Rank 8)
        { spellID = 10929 , caster = "player", filter = "BUFF" },    -- Renew (Rank 9)
        { spellID = 25351 , caster = "player", filter = "BUFF" },    -- Renew (Rank 10)

        { spellID = 14908 , caster = "player", filter = "BUFF" },    -- Improved Renew (Rank 1)
        { spellID = 15020 , caster = "player", filter = "BUFF" },    -- Improved Renew (Rank 2)
        { spellID = 17191 , caster = "player", filter = "BUFF" },    -- Improved Renew (Rank 3)

        -- Shadow
        { spellID = 15473 , caster = "player", filter = "BUFF" },	-- Shadowform
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
        { spellID = 17    , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 1)
        { spellID = 592   , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 2)
        { spellID = 600   , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 3)
        { spellID = 3747  , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 4)
        { spellID = 6065  , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 5)
        { spellID = 6066  , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 6)
        { spellID = 10898 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 7)
        { spellID = 10899 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 8)
        { spellID = 10900 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 9)
        { spellID = 10901 , caster = "player", filter = "BUFF" },	-- Power Word: Shield (Rank 10)

        { spellID = 14748 , caster = "player", filter = "BUFF" },	-- Improved Power Word: Shield (Rank 1)
        { spellID = 14768 , caster = "player", filter = "BUFF" },	-- Improved Power Word: Shield (Rank 2)
        { spellID = 14769 , caster = "player", filter = "BUFF" },	-- Improved Power Word: Shield (Rank 3)

        -- Holy
        { spellID = 139   , caster = "player", filter = "BUFF" },    -- Renew (Rank 1)
        { spellID = 6074  , caster = "player", filter = "BUFF" },    -- Renew (Rank 2)
        { spellID = 6075  , caster = "player", filter = "BUFF" },    -- Renew (Rank 3)
        { spellID = 6076  , caster = "player", filter = "BUFF" },    -- Renew (Rank 4)
        { spellID = 6077  , caster = "player", filter = "BUFF" },    -- Renew (Rank 5)
        { spellID = 6078  , caster = "player", filter = "BUFF" },    -- Renew (Rank 6)
        { spellID = 10927 , caster = "player", filter = "BUFF" },    -- Renew (Rank 7)
        { spellID = 10928 , caster = "player", filter = "BUFF" },    -- Renew (Rank 8)
        { spellID = 10929 , caster = "player", filter = "BUFF" },    -- Renew (Rank 9)
        { spellID = 25351 , caster = "player", filter = "BUFF" },    -- Renew (Rank 10)

        { spellID = 14908 , caster = "player", filter = "BUFF" },    -- Improved Renew (Rank 1)
        { spellID = 15020 , caster = "player", filter = "BUFF" },    -- Improved Renew (Rank 2)
        { spellID = 17191 , caster = "player", filter = "BUFF" },    -- Improved Renew (Rank 3)

        -- Shadow

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        -- Discipline
        -- { spellID = 6788  , caster = "player", filter = "DEBUFF" },	-- Weakened Soul

        -- -- Holy
        -- { spellID = 14914 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 1)
        -- { spellID = 15262 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 2)
        -- { spellID = 15263 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 3)
        -- { spellID = 15264 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 4)
        -- { spellID = 15265 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 5)
        -- { spellID = 15266 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 6)
        -- { spellID = 15267 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 7)
        -- { spellID = 15261 , caster = "player", filter = "DEBUFF" },	-- Holy Fire (Rank 8)

        -- -- Shadow
        -- { spellID = 589   , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 1)
        -- { spellID = 594   , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 2)
        -- { spellID = 970   , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 3)
        -- { spellID = 992   , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 4)
        -- { spellID = 2767  , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 5)
        -- { spellID = 10892 , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 6)
        -- { spellID = 10893 , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 7)
        -- { spellID = 10894 , caster = "player", filter = "DEBUFF" },	-- Shadow Word: Pain (Rank 8)

        -- { spellID = 15275 , caster = "player", filter = "DEBUFF" },	-- Improved Shadow Word: Pain (Rank 1)
        -- { spellID = 15317 , caster = "player", filter = "DEBUFF" },	-- Improved Shadow Word: Pain (Rank 2)

        -- { spellID = 2944  , caster = "player", filter = "DEBUFF" },	-- Devouring Plague (Rank 1 - Undead)
        -- { spellID = 19276 , caster = "player", filter = "DEBUFF" },	-- Devouring Plague (Rank 2 - Undead)
        -- { spellID = 19277 , caster = "player", filter = "DEBUFF" },	-- Devouring Plague (Rank 3 - Undead)
        -- { spellID = 19278 , caster = "player", filter = "DEBUFF" },	-- Devouring Plague (Rank 4 - Undead)
        -- { spellID = 19279 , caster = "player", filter = "DEBUFF" },	-- Devouring Plague (Rank 5 - Undead)
        -- { spellID = 19280 , caster = "player", filter = "DEBUFF" },	-- Devouring Plague (Rank 6 - Undead)

        -- { spellID = 15286 , caster = "player", filter = "DEBUFF" },	-- Vampiric Embrace (Rank 1)
        
        -- { spellID = 27839 , caster = "player", filter = "DEBUFF" },	-- Improved Vampiric Embrace (Rank 1)
        -- { spellID = 27840 , caster = "player", filter = "DEBUFF" },	-- Improved Vampiric Embrace (Rank 2)

        -- { spellID = 15407 , caster = "player", filter = "DEBUFF" },	-- Mind Flay (Rank 1)
        -- { spellID = 17311 , caster = "player", filter = "DEBUFF" },	-- Mind Flay (Rank 2)
        -- { spellID = 17312 , caster = "player", filter = "DEBUFF" },	-- Mind Flay (Rank 3)
        -- { spellID = 17313 , caster = "player", filter = "DEBUFF" },	-- Mind Flay (Rank 4)
        -- { spellID = 17314 , caster = "player", filter = "DEBUFF" },	-- Mind Flay (Rank 5)
        -- { spellID = 18807 , caster = "player", filter = "DEBUFF" },	-- Mind Flay (Rank 6)

        { spellID = 15258 , caster = "player", filter = "DEBUFF" },	-- Shadow Vulnerability

        -- { spellID = 453   , caster = "player", filter = "DEBUFF" },	-- Mind Soothe (Rank 1)
        -- { spellID = 8192  , caster = "player", filter = "DEBUFF" },	-- Mind Soothe (Rank 2)
        -- { spellID = 10953 , caster = "player", filter = "DEBUFF" },	-- Mind Soothe (Rank 3)

        -- { spellID = 605   , caster = "player", filter = "DEBUFF" },	-- Mind Control (Rank 1)
        -- { spellID = 10911 , caster = "player", filter = "DEBUFF" },	-- Mind Control (Rank 2)
        -- { spellID = 10912 , caster = "player", filter = "DEBUFF" },	-- Mind Control (Rank 3)

        -- { spellID = 8122  , caster = "player", filter = "DEBUFF" },	-- Psychic Scream
        -- { spellID = 15407 , caster = "player", filter = "DEBUFF" },	-- Mind Flay
        -- { spellID = 15487 , caster = "player", filter = "DEBUFF" },	-- Silence

        -- { spellID = 2652  , caster = "player", filter = "DEBUFF" },   --Touch of Weakness (Rank 1 - Undead - Priest)
        -- { spellID = 19261 , caster = "player", filter = "DEBUFF" },   --Touch of Weakness (Rank 2 - Undead - Priest)
        -- { spellID = 19262 , caster = "player", filter = "DEBUFF" },   --Touch of Weakness (Rank 3 - Undead - Priest)
        -- { spellID = 19264 , caster = "player", filter = "DEBUFF" },   --Touch of Weakness (Rank 4 - Undead - Priest)
        -- { spellID = 19265 , caster = "player", filter = "DEBUFF" },   --Touch of Weakness (Rank 5 - Undead - Priest)
        -- { spellID = 19266 , caster = "player", filter = "DEBUFF" },   --Touch of Weakness (Rank 6 - Undead - Priest)
    }, -- [3]
}
