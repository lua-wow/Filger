local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Monk
----------------------------------------------------------------
SpellList["MONK"] = {
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

        -- Brewmaster
        { spellID = 115176, caster = "player", filter = "BUFF" },   -- Zen Meditation
        { spellID = 115295, caster = "player", filter = "BUFF" },   -- Guard
        { spellID = 116847, caster = "player", filter = "BUFF" },   -- Rushing Jade Wind
        { spellID = 120954, caster = "player", filter = "BUFF" },   -- Fortigying Brew
        { spellID = 122278, caster = "player", filter = "BUFF" },   -- Dampen Harm
        { spellID = 195630, caster = "player", filter = "BUFF" },   -- Elusive Brawler
        { spellID = 215479, caster = "player", filter = "BUFF" },   -- Ironskin Brew

            -- Procs
            { spellID = 228563, caster = "player", filter = "BUFF" },   -- Blackout Combo

            { spellID = 124273, caster = "player", filter = "DEBUFF" }, -- Heavy Stagger
            { spellID = 124274, caster = "player", filter = "DEBUFF" }, -- Moderate Stagger
            { spellID = 124275, caster = "player", filter = "DEBUFF" }, -- Light Stagger
    
        -- Mistweaver
        { spellID = 115175, caster = "player", filter = "BUFF" },   -- Soothing Mist
        { spellID = 116680, caster = "player", filter = "BUFF" },   -- Thunder Focus Tea
        { spellID = 116849, caster = "player", filter = "BUFF" },   -- Life Cocoon
        { spellID = 119611, caster = "player", filter = "BUFF" },   -- Renewing Mist
        { spellID = 122783, caster = "player", filter = "BUFF" },   -- Diffuse Magic
        { spellID = 124682, caster = "player", filter = "BUFF" },	-- Enveloping Mist
        { spellID = 191837, caster = "player", filter = "BUFF" },   -- Essence Font
        { spellID = 197908, caster = "player", filter = "BUFF" },   -- Mana Tea
        { spellID = 197916, caster = "player", filter = "BUFF" },   -- Lifecycles (Vivify)
        { spellID = 197919, caster = "player", filter = "BUFF" },   -- Lifecycles (Enveloping Mist)
        { spellID = 243435, caster = "player", filter = "BUFF" },   -- Fortifying Brew

        -- Windwalker
        { spellID = 115288, caster = "player", filter = "BUFF" },   -- Energizing Elixir
        { spellID = 116768, caster = "player", filter = "BUFF" },   -- Blackout Kick!
        { spellID = 137639, caster = "player", filter = "BUFF" },   -- Storm, Earth, and Fire
        { spellID = 152173, caster = "player", filter = "BUFF" },   -- Serenity
        { spellID = 261769, caster = "player", filter = "BUFF" },   -- Inner Strength
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
        
        -- Brewmaster
        { spellID = 115176, caster = "player", filter = "CD" }, -- Zen Meditation
        { spellID = 115203, caster = "player", filter = "CD" }, -- Fortifying Brew
        { spellID = 115295, caster = "player", filter = "CD" }, -- Guard
        { spellID = 115308, caster = "player", filter = "CD" }, -- Ironskin Brew
        { spellID = 115399, caster = "player", filter = "CD" }, -- Black Ox Brew
        { spellID = 122278, caster = "player", filter = "CD" }, -- Dampen Harm
        { spellID = 215479, caster = "player", filter = "CD" }, -- Ironskin Brew

        -- Mistweaver
        { spellID = 115310, caster = "player", filter = "CD" }, -- Revival
        { spellID = 116849, caster = "player", filter = "CD" }, -- Life Cocoon
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
        { spellID = 116841, caster = "player", filter = "BUFF" },   -- Tiger's Lust

        -- Brewmaster
        -- Mistweaver
        { spellID = 119611, caster = "player", filter = "BUFF" },	-- Renewing Mist
        { spellID = 115175, caster = "player", filter = "BUFF" },	-- Soothing Mist
        { spellID = 116849, caster = "player", filter = "BUFF" },	-- Life Cocoon
        { spellID = 124682, caster = "player", filter = "BUFF" },	-- Enveloping Mist

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        { spellID = 115078, caster = "player", filter = "DEBUFF" }, -- Paralysis

        -- Brewmaster
        { spellID = 113746, caster = "player", filter = "DEBUFF" }, -- Mystic Touch
        { spellID = 118635, caster = "player", filter = "DEBUFF" }, -- Provoke
        { spellID = 116189, caster = "player", filter = "DEBUFF" }, -- Provoke
        { spellID = 119381, caster = "player", filter = "DEBUFF" }, -- Leg Sweep
        { spellID = 121253, caster = "player", filter = "DEBUFF" }, -- Keg Smash
        { spellID = 123725, caster = "player", filter = "DEBUFF" }, -- Breath of Fire
        { spellID = 117952, caster = "player", filter = "DEBUFF" }, -- Crackling Jade Lightning
        { spellID = 196608, caster = "player", filter = "DEBUFF" }, -- Eye of the Tiger

        -- Windwalker
        { spellID = 115080, caster = "player", filter = "DEBUFF" }, -- Touch of Death
        { spellID = 115804, caster = "player", filter = "DEBUFF" }, -- Mortal Wound
        { spellID = 116095, caster = "player", filter = "DEBUFF" }, -- Disable
        { spellID = 122470, caster = "player", filter = "DEBUFF" }, -- Touch of Karma
        { spellID = 228287, caster = "player", filter = "DEBUFF" }, -- Mark of the Crane
    }, -- [3]
}