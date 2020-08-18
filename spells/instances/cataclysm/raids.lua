local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Cataclysm Raids
----------------------------------------------------------------

-- The Bastion of Twilight
Instances[671] = {
    ----------------------------------------------------------------
    -- Halfus Wyrmbreaker
    ----------------------------------------------------------------
    { spellID = 39171, unit = "player", caster = "all", filter = "DEBUFF" },    -- Malevolent Strikes

    ----------------------------------------------------------------
    -- Valiona & Theralion
    ----------------------------------------------------------------
    -- Theralion
    { spellID = 86622, unit = "player", caster = "all", filter = "DEBUFF" },    -- Engulfing Magic
    -- Valiona
    { spellID = 86788, unit = "player", caster = "all", filter = "DEBUFF" },    -- Blackout
    { spellID = 86840, unit = "player", caster = "all", filter = "DEBUFF" },    -- Devouring Flames
    { spellID = 86013, unit = "player", caster = "all", filter = "DEBUFF" },    -- Twilight Meteorite
    { spellID = 86214, unit = "player", caster = "all", filter = "DEBUFF" },    -- Twilight Zone
    
    ----------------------------------------------------------------
    -- Twilight Ascendant Council
    ----------------------------------------------------------------
    -- Feludius
    { spellID = 82762, unit = "player", caster = "all", filter = "DEBUFF" },    -- Waterlogged
    { spellID = 82772, unit = "player", caster = "all", filter = "DEBUFF" },    -- Frozen
    { spellID = 82665, unit = "player", caster = "all", filter = "DEBUFF" },    -- Heart of Ice
    { spellID = 82666, unit = "player", caster = "all", filter = "BUFF" },      -- Frost Imbued
    { spellID = 92307, unit = "player", caster = "all", filter = "DEBUFF" },    -- Frost Beacon (Frozen Orb target)
    -- Ignacious
    { spellID = 82662, unit = "player", caster = "all", filter = "DEBUFF" },    -- Burning Blood
    { spellID = 82663, unit = "player", caster = "all", filter = "BUFF" },      -- Flame Imbued
    { spellID = 82777, unit = "player", caster = "all", filter = "DEBUFF" },    -- Flame Torrent
    -- Arion
    { spellID = 92067, unit = "player", caster = "all", filter = "DEBUFF" },    -- Static Overload
    { spellID = 83500, unit = "player", caster = "all", filter = "DEBUFF" },    -- Swirling Winds
    { spellID = 83099, unit = "player", caster = "all", filter = "DEBUFF" },    -- Lightning Rod
    -- Terrastra
    { spellID = 92075, unit = "player", caster = "all", filter = "DEBUFF" },    -- Gravity Core
    { spellID = 92076, unit = "player", caster = "all", filter = "DEBUFF" },    -- Gravity Core (2)
    { spellID = 83581, unit = "player", caster = "all", filter = "DEBUFF" },    -- Grounded
    -- Elementium Monstrosity
    { spellID = 84948, unit = "player", caster = "all", filter = "DEBUFF" },    -- Gravity Crush

    ----------------------------------------------------------------
    -- Cho'gall	
    ----------------------------------------------------------------
    { spellID = 81836, unit = "player", caster = "all", filter = "DEBUFF" },    -- Corruption: Accelerated
    { spellID = 81831, unit = "player", caster = "all", filter = "DEBUFF" },    -- Corruption: Sickness
    { spellID = 82125, unit = "player", caster = "all", filter = "DEBUFF" },    -- Corruption: Malformation
    { spellID = 82170, unit = "player", caster = "all", filter = "DEBUFF" },    -- Corruption: Absolute
    { spellID = 86028, unit = "player", caster = "all", filter = "DEBUFF" },    -- Cho's Blast
    { spellID = 86029, unit = "player", caster = "all", filter = "DEBUFF" },    -- Gall's Blast

    ----------------------------------------------------------------
    -- Sinestra (Heroic)
    ----------------------------------------------------------------
    { spellID = 89421, unit = "player", caster = "all", filter = "DEBUFF" },    -- Wrack
    { spellID = 87946, unit = "player", caster = "all", filter = "BUFF" },      -- Essence of the Red
}

-- Baradin Hold
Instances[757] = {
    ----------------------------------------------------------------
    -- Argaloth
    ----------------------------------------------------------------
    { spellID = 88954 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Consuming Darkness
    { spellID = 88942 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Meteor Slash

    ----------------------------------------------------------------
    -- Occu'thar
    ----------------------------------------------------------------
    { spellID = 96920 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Gaze of Occu'thar

    ----------------------------------------------------------------
    -- Alizabal, Mistress of Hate
    ----------------------------------------------------------------
    { spellID = 104936, unit = "player", caster = "all", filter = "DEBUFF" },   -- Skewer
}

-- Blackwing Descent
Instances[669] = {
    ----------------------------------------------------------------
    -- Magmaw
    ----------------------------------------------------------------
    { spellID = 78097, unit = "player", caster = "all", filter = "DEBUFF" },    -- Parasitic Infection
    { spellID = 89773, unit = "player", caster = "all", filter = "DEBUFF" },    -- Mangle
    { spellID = 79589, unit = "player", caster = "all", filter = "DEBUFF" },    -- Constricting Chains

    ----------------------------------------------------------------
    -- Omintron Defense System
    ----------------------------------------------------------------
    -- Arcanotron
    { spellID = 91857, unit = "player", caster = "all", filter = "BUFF" },      -- Power Generator
    { spellID = 79735, unit = "player", caster = "all", filter = "BUFF" },      -- Converted Power
    { spellID = 79729, unit = "target", caster = "all", filter = "BUFF" },      -- Power Conversion
    -- Electron
    { spellID = 79889, unit = "player", caster = "all", filter = "DEBUFF" },    -- Lightning Conductor
    -- Magmatron
    { spellID = 79023, unit = "player", caster = "all", filter = "DEBUFF" },    -- Incineration Security Measure
    { spellID = 79501, unit = "player", caster = "all", filter = "DEBUFF" },    -- Incineration Security Measure-- Acquiring Target
    -- Toxitron
    { spellID = 80161, unit = "player", caster = "all", filter = "DEBUFF" },    -- Chemical Cloud
    { spellID = 79835, unit = "player", caster = "all", filter = "DEBUFF" },    -- Poison Soaked Shell
    
    ----------------------------------------------------------------
    -- Maloriak
    ----------------------------------------------------------------
    { spellID = 77760, unit = "player", caster = "all", filter = "DEBUFF" },    -- Biting Chill
    { spellID = 77699, unit = "player", caster = "all", filter = "DEBUFF" },    -- Flash Freeze
    { spellID = 92787, unit = "player", caster = "all", filter = "DEBUFF" },    -- Engulfing Darkness
    { spellID = 92930, unit = "player", caster = "all", filter = "DEBUFF" },    -- Dark Sludge
    { spellID = 77912, unit = "target", caster = "all", filter = "BUFF" },      -- Remedy
    { spellID = 77786, unit = "target", caster = "all", filter = "DEBUFF" },    -- Consuming Flames

    ----------------------------------------------------------------
    -- Atramedes
    ----------------------------------------------------------------
    { spellID = 78075, unit = "player", caster = "all", filter = "DEBUFF" },    -- Sonic Breath
    { spellID = 77982, unit = "player", caster = "all", filter = "DEBUFF" },    -- Searing Flame
    { spellID = 77840, unit = "player", caster = "all", filter = "DEBUFF" },    -- Searing Flame

    ----------------------------------------------------------------
    -- Chimaeron
    ----------------------------------------------------------------
    { spellID = 82935, unit = "player", caster = "all", filter = "DEBUFF" },    -- Caustic Slime
    { spellID = 82881, unit = "player", caster = "all", filter = "DEBUFF" },    -- Break
    { spellID = 89084, unit = "player", caster = "all", filter = "DEBUFF" },    -- Low Health

    ----------------------------------------------------------------
    -- Nefarian
    ----------------------------------------------------------------
    { spellID = 79318, unit = "player", caster = "all", filter = "DEBUFF" },    -- Dominion
    { spellID = 80627, unit = "player", caster = "all", filter = "BUFF" },      -- Stolen Power
    { spellID = 98932, unit = "player", caster = "all", filter = "BUFF" },      -- Free Your Mind
    { spellID = 92053, unit = "player", caster = "all", filter = "DEBUFF" },    -- Shadow Conductor
}

-- Throne of the Four Winds
Instances[754] = {
    ----------------------------------------------------------------
    -- Conclave of Wind:
    ----------------------------------------------------------------
    -- Nezir <Lord of the North Wind>
    { spellID = 84645, unit = "player", caster = "all", filter = "DEBUFF" }, -- Wind Chill
    { spellID = 86111, unit = "player", caster = "all", filter = "DEBUFF" }, -- Ice Patch
    -- Anshal <Lord of the West Wind>
    { spellID = 86206, unit = "player", caster = "all", filter = "DEBUFF" }, -- Soothing Breeze
    { spellID = 86282, unit = "player", caster = "all", filter = "DEBUFF" }, -- Toxic Spores
    -- Rohash <Lord of the East Wind>
    
    ----------------------------------------------------------------
    -- Al'Akir
    ----------------------------------------------------------------
    { spellID = 91020, unit = "player", caster = "all", filter = "DEBUFF" }, -- Ice Storm
    { spellID = 87873, unit = "player", caster = "all", filter = "DEBUFF" }, -- Static Shock
    { spellID = 88301, unit = "player", caster = "all", filter = "DEBUFF" }, -- Acid Rain
    { spellID = 89666, unit = "player", caster = "all", filter = "DEBUFF" }, -- Lightning Rod
}

-- Firelands
Instances[720] = {
    ----------------------------------------------------------------
    -- Shannox
    ----------------------------------------------------------------
    { spellID = 99840, unit = "player", caster = "all", filter = "DEBUFF" },    -- Magma Rupture
    { spellID = 99837, unit = "player", caster = "all", filter = "DEBUFF" },    -- Crystal Prison Trap 
    { spellID = 99936, unit = "player", caster = "all", filter = "DEBUFF" },    -- Jagged Tear

    ----------------------------------------------------------------
    -- Lord Rhyolith
    ----------------------------------------------------------------
    { spellID = 98492, unit = "player", caster = "all", filter = "DEBUFF" },    -- Eruption

    ----------------------------------------------------------------
    -- Beth'tilac
    ----------------------------------------------------------------
    { spellID = 99526, unit = "player", caster = "all", filter = "DEBUFF" },    -- Fixate
    { spellID = 99278, unit = "player", caster = "all", filter = "DEBUFF" },    -- Volatile Poison
    { spellID = 99476, unit = "player", caster = "all", filter = "DEBUFF" },    -- The Widow's Kiss

    ----------------------------------------------------------------
    -- Alysrazor
    ----------------------------------------------------------------
    { spellID = 97128, unit = "player", caster = "all", filter = "BUFF" },  -- Molten Feather
    { spellID = 98619, unit = "player", caster = "all", filter = "BUFF" },  -- Wings of Flame
    { spellID = 99461, unit = "player", caster = "all", filter = "DEBUFF" },    -- Blazing Power
    { spellID = 100029, unit = "player", caster = "all", filter = "DEBUFF" },   -- Alysra's Razor
    { spellID = 99389, unit = "player", caster = "all", filter = "DEBUFF" },    -- Imprinted

    ----------------------------------------------------------------
    -- Baleroc
    ----------------------------------------------------------------
    { spellID = 99256, unit = "player", caster = "all", filter = "DEBUFF" },    -- Torment
    { spellID = 99257, unit = "player", caster = "all", filter = "DEBUFF" },    -- Tormented
    { spellID = 99252, unit = "player", caster = "all", filter = "DEBUFF" },    -- Blaze of Glory
    { spellID = 99263, unit = "player", caster = "all", filter = "BUFF" },      -- Vital Flame
    { spellID = 99262, unit = "player", caster = "all", filter = "BUFF" },      -- Vital Spark
    { spellID = 99516, unit = "player", caster = "all", filter = "BUFF" },      -- Countdown

    ----------------------------------------------------------------
    -- Majordomo Staghelm
    ----------------------------------------------------------------
    { spellID = 98450, unit = "player", caster = "all", filter = "DEBUFF" },    -- Searing Seeds
    { spellID = 98584, unit = "player", caster = "all", filter = "DEBUFF" },    -- Burning Orbs

    ----------------------------------------------------------------
    -- Ragnaros
    ----------------------------------------------------------------
    { spellID = 100460, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blazing Heat
    { spellID = 99399, unit = "player", caster = "all", filter = "DEBUFF" },    -- Burning Wound 
    { spellID = 99849, unit = "player", caster = "all", filter = "DEBUFF" },    -- Fixate

    ----------------------------------------------------------------
    -- Trash
    ----------------------------------------------------------------
    { spellID = 99532, unit = "player", caster = "all", filter = "DEBUFF" },    -- Melt Armor
}

-- Dragon Soul
Instances[967] = {
    ----------------------------------------------------------------
    -- Morchok
    ----------------------------------------------------------------
    { spellID = 103541, unit = "player", caster = "all", filter = "DEBUFF" }, -- Safe
    { spellID = 103536, unit = "player", caster = "all", filter = "DEBUFF" }, -- Warning
    { spellID = 103534, unit = "player", caster = "all", filter = "DEBUFF" }, -- Danger
    { spellID = 103785, unit = "player", caster = "all", filter = "DEBUFF" }, -- Black Blood of the Earth
    { spellID = 103687, unit = "player", caster = "all", filter = "DEBUFF" }, -- Crush Armor

    ----------------------------------------------------------------
    -- Warlord Zon'ozz
    ----------------------------------------------------------------
    { spellID = 103434, unit = "player", caster = "all", filter = "DEBUFF" }, -- Disrupting Shadows
    { spellID = 104378, unit = "player", caster = "all", filter = "DEBUFF" }, -- Black Blood of Go'rath

    ----------------------------------------------------------------
    -- Yor'sahj the Unsleeping
    ----------------------------------------------------------------
    { spellID = 103628, unit = "player", caster = "all", filter = "DEBUFF" }, -- Deep Corruption

    ----------------------------------------------------------------
    -- Hagara the Stormbinder
    ----------------------------------------------------------------
    { spellID = 105285, unit = "player", caster = "all", filter = "DEBUFF" }, -- Target
    { spellID = 105316, unit = "player", caster = "all", filter = "DEBUFF" }, -- Ice Lance
    { spellID = 104451, unit = "player", caster = "all", filter = "DEBUFF" }, -- Ice Tomb
    { spellID = 105289, unit = "player", caster = "all", filter = "DEBUFF" }, -- Shattered Ice
    { spellID = 109325, unit = "player", caster = "all", filter = "DEBUFF" }, -- Frostflake
    { spellID = 120562, unit = "player", caster = "all", filter = "DEBUFF" }, -- Lightning Storm
    { spellID = 105465, unit = "player", caster = "all", filter = "DEBUFF" }, -- Lightning Storm (2)

    ----------------------------------------------------------------
    -- Ultraxion
    ----------------------------------------------------------------
    { spellID = 109075, unit = "player", caster = "all", filter = "DEBUFF" }, -- Fading Light
    { spellID = 106498, unit = "player", caster = "all", filter = "DEBUFF" }, -- Looming Darkness
    { spellID = 106415, unit = "player", caster = "all", filter = "DEBUFF" }, -- Twilight Burst
    { spellID = 105896, unit = "player", caster = "all", filter = "DEBUFF" }, -- Gift of Life
    { spellID = 105900, unit = "player", caster = "all", filter = "DEBUFF" }, -- Essence of Dreams
    { spellID = 105903, unit = "player", caster = "all", filter = "DEBUFF" }, -- Source of Magic

    ----------------------------------------------------------------
    -- Warmaster Blackhorn
    ----------------------------------------------------------------
    { spellID = 107439, unit = "player", caster = "all", filter = "DEBUFF" }, -- Twilight Barrage
    { spellID = 107558, unit = "player", caster = "all", filter = "DEBUFF" }, -- Degeneration
    { spellID = 107567, unit = "player", caster = "all", filter = "DEBUFF" }, -- Brutal Strike
    { spellID = 108044, unit = "player", caster = "all", filter = "DEBUFF" }, -- Disrupting Roar
    { spellID = 108043, unit = "player", caster = "all", filter = "DEBUFF" }, -- Sunder Armor
    { spellID = 108046, unit = "player", caster = "all", filter = "DEBUFF" }, -- Shockwave

    ----------------------------------------------------------------
    -- Spine of Deathwing
    ----------------------------------------------------------------
    { spellID = 105563, unit = "player", caster = "all", filter = "DEBUFF" }, -- Grasping Tendrils
    { spellID = 105479, unit = "player", caster = "all", filter = "DEBUFF" }, -- Searing Plasma
    { spellID = 105490, unit = "player", caster = "all", filter = "DEBUFF" }, -- Fiery Grip
    { spellID = 106199, unit = "player", caster = "all", filter = "DEBUFF" }, -- Blood Corruption: Death
    { spellID = 106200, unit = "player", caster = "all", filter = "DEBUFF" }, -- Blood Corruption: Earth
    { spellID = 106213, unit = "player", caster = "all", filter = "BUFF" },   -- Blood of Neltharion
    { spellID = 106005, unit = "player", caster = "all", filter = "DEBUFF" }, -- Degradation

    ----------------------------------------------------------------
    -- Madness of Deathwing
    ----------------------------------------------------------------
    { spellID = 108649, unit = "player", caster = "all", filter = "DEBUFF" }, -- Corrupting Parasite
    { spellID = 105841, unit = "player", caster = "all", filter = "DEBUFF" }, -- Degenerative Bite
    { spellID = 105408, unit = "player", caster = "all", filter = "DEBUFF" }, -- Burning Blood
    { spellID = 105445, unit = "player", caster = "all", filter = "DEBUFF" }, -- Blistering heat
    { spellID = 106444, unit = "player", caster = "all", filter = "DEBUFF" }, -- Impale
    { spellID = 106791, unit = "player", caster = "all", filter = "DEBUFF" }, -- Shrapnel
    { spellID = 106728, unit = "player", caster = "all", filter = "DEBUFF" }, -- Tetanus
}
