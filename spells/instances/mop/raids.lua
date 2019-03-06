local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Mists of Pandaria Raids
----------------------------------------------------------------

-- Mogu'shan Vaults
Instances[1008] = {
    ----------------------------------------------------------------
    -- The Stone Guard
    ----------------------------------------------------------------
    { spellID = 130774, unit = "player", caster = "all", filter = "DEBUFF" },   -- Amethyst Pool
    { spellID = 129460, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cobalt Mine
    { spellID = 130395, unit = "player", caster = "all", filter = "DEBUFF" },   -- Jasper Chains
    { spellID = 125206, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rend Flesh
    { spellID = 116541, unit = "player", caster = "all", filter = "BUFF" },     -- Energized Tiles
    { spellID = 116322, unit = "player", caster = "all", filter = "DEBUFF" },   -- Living Amethyst
    { spellID = 116199, unit = "player", caster = "all", filter = "DEBUFF" },   -- Living Cobalt
    { spellID = 116301, unit = "player", caster = "all", filter = "DEBUFF" },   -- Living Jade
    { spellID = 116304, unit = "player", caster = "all", filter = "DEBUFF" },   -- Living Jasper

    ----------------------------------------------------------------
    -- Feng the Accursed
    ----------------------------------------------------------------
    { spellID = 116937, unit = "player", caster = "all", filter = "DEBUFF" },   -- Epicenter
    { spellID = 116374, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lightning Charge
    { spellID = 131788, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lightning Lash
    { spellID = 116784, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wildfire Spark
    { spellID = 116942, unit = "player", caster = "all", filter = "DEBUFF" },   -- Flaming Spear
    { spellID = 116417, unit = "player", caster = "all", filter = "DEBUFF" },   -- Arcane Resonance
    { spellID = 131790, unit = "player", caster = "all", filter = "DEBUFF" },   -- Arcane Shock
    { spellID = 115811, unit = "player", caster = "all", filter = "BUFF" },     -- Nullification Barrier
    { spellID = 115972, unit = "player", caster = "all", filter = "BUFF" },     -- Shroud of Reversal

    { spellID = 116937, unit = "target", caster = "all", filter = "DEBUFF" },   -- Epicenter
    { spellID = 116374, unit = "target", caster = "all", filter = "DEBUFF" },   -- Lightning Charge
    { spellID = 131788, unit = "target", caster = "all", filter = "DEBUFF" },   -- Lightning Lash
    { spellID = 116784, unit = "target", caster = "all", filter = "DEBUFF" },   -- Wildfire Spark
    { spellID = 116942, unit = "target", caster = "all", filter = "DEBUFF" },   -- Flaming Spear
    { spellID = 116417, unit = "target", caster = "all", filter = "DEBUFF" },   -- Arcane Resonance
    { spellID = 131790, unit = "target", caster = "all", filter = "DEBUFF" },   -- Arcane Shock

    ----------------------------------------------------------------
    -- Gara'jal the Spiritbinder
    ----------------------------------------------------------------
    { spellID = 116161, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crossed Over
    { spellID = 116278, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soul Sever
    { spellID = 116000, unit = "player", caster = "all", filter = "DEBUFF" },   -- Voodoo Dolls
    { spellID = 117723, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frail Soul
    { spellID = 117549, unit = "player", caster = "all", filter = "BUFF" },     -- Spiritual Innervation

    ----------------------------------------------------------------
    -- The Spirit Kings
    ----------------------------------------------------------------
    -- Qiang the Merciless
    { spellID = 117961, unit = "target", caster = "all", filter = "BUFF" },     -- Impervious Shield

    -- Subetai the Swift
    { spellID = 118141, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pinning Arrow
    { spellID = 118163, unit = "player", caster = "all", filter = "DEBUFF" },   -- Robbed Blind
    { spellID = 118162, unit = "target", caster = "all", filter = "BUFF" },     -- Sleight of Hand

    -- Zian of the Endless Shadow
    { spellID = 117539, unit = "player", caster = "all", filter = "DEBUFF" },   -- Coalescing Shadows
    { spellID = 117697, unit = "target", caster = "all", filter = "BUFF" },     -- Shield of Darkness

    -- Meng the Demented
    { spellID = 117708, unit = "player", caster = "all", filter = "DEBUFF" },   -- Maddening Shout
    { spellID = 117756, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cowardice
    { spellID = 117837, unit = "target", caster = "all", filter = "BUFF" },     -- Delirious

    ----------------------------------------------------------------
    -- Elegon
    ----------------------------------------------------------------
    { spellID = 117878, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overcharged
    { spellID = 130287, unit = "player", caster = "all", filter = "DEBUFF" },   -- Touch of the Titans
    { spellID = 117949, unit = "player", caster = "all", filter = "DEBUFF" },   -- Closed Circuit
    { spellID = 119722, unit = "player", caster = "all", filter = "DEBUFF" },   -- Energy Cascade
    { spellID = 132222, unit = "player", caster = "all", filter = "DEBUFF" },   -- Destabilizing Energies

    { spellID = 119387, unit = "target", caster = "all", filter = "DEBUFF" },   -- Draw Power

    ----------------------------------------------------------------
    -- Will of Emperor
    ----------------------------------------------------------------
    { spellID = 116782, unit = "player", caster = "all", filter = "DEBUFF" },   -- Titan Gas
    { spellID = 116782, unit = "target", caster = "all", filter = "DEBUFF" },   -- Titan Gas

        -- Jan-xi and Qin-xi
        { spellID = 34716 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Stomp
        { spellID = 116818, unit = "player", caster = "all", filter = "DEBUFF" },   -- Magnetized (Qin-xi)
        { spellID = 117195, unit = "player", caster = "all", filter = "DEBUFF" },   -- Magnetized (Jan-xi)
        { spellID = 116835, unit = "player", caster = "all", filter = "DEBUFF" },   -- Devastating Arc
        -- Emperor's Rage 
        { spellID = 116525, unit = "player", caster = "all", filter = "DEBUFF" },   -- Focused Assault
        -- Emperor's Strength
        { spellID = 116550, unit = "player", caster = "all", filter = "DEBUFF" },   -- Energizing Smash
        -- Emperor's Courage
        { spellID = 116778, unit = "player", caster = "all", filter = "DEBUFF" },   -- Focused Defense
        { spellID = 117485, unit = "player", caster = "all", filter = "DEBUFF" },   -- Impeding Thrust
        -- Titan Spark (Heroic)
        { spellID = 116829, unit = "player", caster = "all", filter = "DEBUFF" },   -- Focused Energy

    ----------------------------------------------------------------
    -- Trash
    ----------------------------------------------------------------
    { spellID = 118552, unit = "player", caster = "all", filter = "DEBUFF" },   -- Flesh of Stone
    { spellID = 118562, unit = "player", caster = "all", filter = "DEBUFF" },   -- Petrified
    { spellID = 125091, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fully Petrified
    { spellID = 125092, unit = "player", caster = "all", filter = "DEBUFF" },   -- Petrification
}

-- Terrace of Endless Spring
Instances[996] = {
    ----------------------------------------------------------------
    -- Protectors of the Endless
    ----------------------------------------------------------------
    -- Protector Kaolan
    { spellID = 117519, unit = "player", caster = "all", filter = "DEBUFF" },   -- Touch of Sha
    { spellID = 118091, unit = "player", caster = "all", filter = "DEBUFF" },   -- Defiled Ground
    { spellID = 117052, unit = "target", caster = "all", filter = "BUFF" },     -- Sha Corruption
    { spellID = 117905, unit = "target", caster = "all", filter = "BUFF" },     -- Greater Corruption Essence
    
    -- Elder Regail 
    { spellID = 117398, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lightning Prison
    
    -- Elder Asani
    { spellID = 117235, unit = "player", caster = "all", filter = "DEBUFF" },   -- Purified
    { spellID = 117309, unit = "target", caster = "all", filter = "BUFF" },     -- Cleansing Waters

    -- Minion of Fear
    { spellID = 118191, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Essence

    ----------------------------------------------------------------
    -- Tsulong
    ----------------------------------------------------------------
    -- The Night
    { spellID = 122768, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dread Shadows
    { spellID = 122777, unit = "player", caster = "all", filter = "DEBUFF" },   -- Nightmares
    { spellID = 122752, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadow Breath
    { spellID = 122782, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sunbeam (122789)
    -- The Day
    { spellID = 123011, unit = "player", caster = "all", filter = "DEBUFF" },   -- Terrorize
    { spellID = 123036, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fright
    { spellID = 122881, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Bolt
    { spellID = 123105, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sun Breath
    { spellID = 122858, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bathed in Light
    { spellID = 123011, unit = "target", caster = "all", filter = "DEBUFF" },   -- Terrorize

    ----------------------------------------------------------------
    -- Lei Shi
    ----------------------------------------------------------------
    { spellID = 123121, unit = "player", caster = "all", filter = "DEBUFF" },   -- Spray
    { spellID = 123461, unit = "player", caster = "all", filter = "DEBUFF" },   -- Get Away!
    { spellID = 123705, unit = "player", caster = "all", filter = "DEBUFF" },   -- Scary Fog
    { spellID = 123705, unit = "target", caster = "all", filter = "DEBUFF" }, -- Scary Fog
    { spellID = 123712, unit = "target", caster = "all", filter = "DEBUFF" }, -- Scary Fog

    ----------------------------------------------------------------
    -- Sha of Fear
    ----------------------------------------------------------------
    -- Pure Light
    { spellID = 117964, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wall of Light
    { spellID = 119086, unit = "player", caster = "all", filter = "DEBUFF" },   -- Penetrating Bolt
    { spellID = 119775, unit = "player", caster = "all", filter = "DEBUFF" },   -- Reaching Attack
    { spellID = 129368, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lei's Hope
    -- The Outer Shrines
    { spellID = 119983, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dread Spray
    { spellID = 129189, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sha Globe
    { spellID = 118977, unit = "player", caster = "all", filter = "BUFF" },     -- Fearless
    -- The Dread Expanse
    { spellID = 120268, unit = "player", caster = "all", filter = "BUFF" },     -- Champion of the Light
    { spellID = 129378, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fading Light
    { spellID = 120669, unit = "player", caster = "all", filter = "DEBUFF" },   -- Naked and Afraid
    { spellID = 75683 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Waterspout
    { spellID = 120629, unit = "player", caster = "all", filter = "DEBUFF" },   -- Huddle in Terror
}

-- Heart of Fear
Instances[1009] = {
    ----------------------------------------------------------------
    -- Imperial Vizier Zor'lok
    ----------------------------------------------------------------
    { spellID = 123812, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pheromones of Zeal
    { spellID = 122761, unit = "player", caster = "all", filter = "DEBUFF" },   -- Exhale
    { spellID = 122740, unit = "player", caster = "all", filter = "DEBUFF" },   -- Convert

    ----------------------------------------------------------------
    -- Blade Lord Ta'yak
    ----------------------------------------------------------------
    { spellID = 123175, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wind Step
    { spellID = 123474, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overwhelming Assault
    { spellID = 123017, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unseen Strike

    ----------------------------------------------------------------
    -- Garalon
    ----------------------------------------------------------------
    { spellID = 123081, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pungency
    { spellID = 123235, unit = "player", caster = "all", filter = "DEBUFF" },   -- Weak Points
    { spellID = 122786, unit = "target", caster = "all", filter = "DEBUFF" },   -- Broken Leg

    ----------------------------------------------------------------
    -- Wind Lord Mel'jarak
    ----------------------------------------------------------------
    { spellID = 121876, unit = "player", caster = "all", filter = "DEBUFF" },   -- Amber Prison
    { spellID = 122055, unit = "player", caster = "all", filter = "DEBUFF" },   -- Residue
    { spellID = 122064, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrosive Resin
    { spellID = 122125, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrosive Resin Pool

    { spellID = 122149, unit = "target", caster = "all", filter = "BUFF" },     -- Quickening
    { spellID = 125873, unit = "target", caster = "all", filter = "BUFF" },     -- Recklessness
    { spellID = 122224, unit = "target", caster = "all", filter = "DEBUFF" },   -- Impaling Spear

    ----------------------------------------------------------------
    -- Amber-Shaper Un'sok
    ----------------------------------------------------------------
    { spellID = 122504, unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Amber
    { spellID = 121949, unit = "player", caster = "all", filter = "DEBUFF" },   -- Parasitic Growth
    { spellID = 122370, unit = "player", caster = "all", filter = "DEBUFF" },   -- Reshape Life
    { spellID = 125498, unit = "player", caster = "all", filter = "DEBUFF" },   -- Amber Globule
    { spellID = 123059, unit = "target", caster = "all", filter = "DEBUFF" },   -- Destabilize

    ----------------------------------------------------------------
    -- Grand Empress Shek'zeer
    ----------------------------------------------------------------
    { spellID = 123707, unit = "player", caster = "all", filter = "DEBUFF" },   -- Eyes of the Empress
    { spellID = 123788, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cry of Terror
    { spellID = 105695, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fixate
    { spellID = 124097, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sticky Resin
    { spellID = 124777, unit = "player", caster = "all", filter = "DEBUFF" },   -- Poison Bomb
    { spellID = 124821, unit = "player", caster = "all", filter = "DEBUFF" },   -- Poison-Drenched Armor
    { spellID = 124827, unit = "player", caster = "all", filter = "BUFF" },     -- Poison Fumes
    { spellID = 124862, unit = "player", caster = "all", filter = "DEBUFF" },   -- Visions of Demise
    { spellID = 123845, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heart of Fear (Heroic)
    { spellID = 125283, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sha Corruption

    ----------------------------------------------------------------
    -- Trash
    ----------------------------------------------------------------
    -- Kor'thik Fleshrender
    { spellID = 126912, unit = "player", caster = "all", filter = "DEBUFF" },   -- Grievous Whirl
    { spellID = 126901, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mortal Rend
    -- Amber-Ridden Mushan
    { spellID = 125081, unit = "player", caster = "all", filter = "DEBUFF" },   -- Slam
    -- Amber Searsting
    { spellID = 125490, unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Sting
    -- Kor'thik Warsinger
    { spellID = 125907, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cry Havoc
}

-- Throne of Thunder
Instances[1098] = {
    ----------------------------------------------------------------
    -- Jin'rokh the Breaker
    ----------------------------------------------------------------
    { spellID = 138002, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fluidity
    { spellID = 138349, unit = "player", caster = "all", filter = "DEBUFF" },   -- Static Wound
    { spellID = 137422, unit = "player", caster = "all", filter = "DEBUFF" },   -- Focused Lightning (Fixate)
    { spellID = 138006, unit = "player", caster = "all", filter = "DEBUFF" },   -- Electrified Waters
    { spellID = 137371, unit = "player", caster = "all", filter = "DEBUFF" },   -- Thundering Throw
    { spellID = 138733, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ionization
    { spellID = 137261, unit = "target", caster = "all", filter = "BUFF" },     -- Lightning Storm

    ----------------------------------------------------------------
    -- Horridon
    ----------------------------------------------------------------
    { spellID = 138768, unit = "player", caster = "all", filter = "DEBUFF" },   -- Triple Puncture
    -- The Farraki
    { spellID = 136708, unit = "player", caster = "all", filter = "DEBUFF" },   -- Stone Gaze
    -- The Gurubashi
    { spellID = 136653, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rending Charge
    { spellID = 136587, unit = "player", caster = "all", filter = "DEBUFF" },   -- Venom Bolt Volley
    -- The Drakkari
    { spellID = 136710, unit = "player", caster = "all", filter = "DEBUFF" },   -- Deadly Plague
    { spellID = 12294 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Mortal Strike
    -- The Amani
    { spellID = 136512, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hex of Confusion
    -- The Zandalari
    { spellID = 137294, unit = "target", caster = "all", filter = "DEBUFF" },   -- Headache
    { spellID = 137240, unit = "target", caster = "all", filter = "BUFF" },     -- Cracked Shell
    { spellID = 136817, unit = "target", caster = "all", filter = "BUFF" },     -- Bestial Cry
    { spellID = 136821, unit = "target", caster = "all", filter = "BUFF" },     -- Rampage

    ----------------------------------------------------------------
    -- Council of Elders
    ----------------------------------------------------------------
    -- The Spirit of Gara'jal
    { spellID = 137650, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadowed Soul
    { spellID = 71905 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Soul Fragment
    { spellID = 136442, unit = "target", caster = "all", filter = "BUFF" },     -- Possessed
    --{ spellID = 136467, unit = "target", caster = "all", filter = "BUFF" },   -- Lingering Presence

    -- Frost King Malakk 
    { spellID = 136903, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frigid Assault
    { spellID = 136922, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frostbite
    { spellID = 136992, unit = "player", caster = "all", filter = "DEBUFF" },   -- Biting Cold
    { spellID = 137084, unit = "player", caster = "all", filter = "DEBUFF" },   -- Body Heat

    -- Kazra'jin
    { spellID = 137166, unit = "player", caster = "all", filter = "DEBUFF" },   -- Discharge
    { spellID = 137149, unit = "target", caster = "all", filter = "DEBUFF" },   -- Overload

    -- Sul the Sandcrawler 
    { spellID = 136878, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ensnared
    { spellID = 136857, unit = "player", caster = "all", filter = "DEBUFF" },   -- Entrapped
    { spellID = 136864, unit = "target", caster = "all", filter = "BUFF" },     -- Fortified

    -- High Priestess Mar'li 
    { spellID = 137359, unit = "player", caster = "all", filter = "DEBUFF" },   -- Marked Soul (fixate)

    ----------------------------------------------------------------
    -- Tortos
    ----------------------------------------------------------------
    { spellID = 134920, unit = "player", caster = "all", filter = "DEBUFF" },   -- Quake Stomp
    { spellID = 137552, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crystal Shell
    { spellID = 140701, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crystal Shell: Full Capacity!
    { spellID = 133971, unit = "target", caster = "all", filter = "BUFF" },     -- Shell Block
    { spellID = 136431, unit = "target", caster = "all", filter = "DEBUFF" },   -- Shell Concussion

    ----------------------------------------------------------------
    -- Megaera
    ----------------------------------------------------------------
    { spellID = 139822, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cinders
    { spellID = 137731, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ignite Flesh
    { spellID = 139909, unit = "player", caster = "all", filter = "DEBUFF" },   -- Icy Ground
    { spellID = 139866, unit = "player", caster = "all", filter = "DEBUFF" },   -- Torrent of Ice (fixate)
    { spellID = 139843, unit = "player", caster = "all", filter = "DEBUFF" },   -- Arctic Freeze
    { spellID = 137737, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rot Armor
    { spellID = 140179, unit = "player", caster = "all", filter = "DEBUFF" },   -- Supression
    { spellID = 139994, unit = "player", caster = "all", filter = "DEBUFF" },   -- Difussion

    -- { spellID = 139942, unit = "target", caster = "all", filter = "BUFF" },  -- Hydra Frenzy
    { spellID = 139586, unit = "target", caster = "all", filter = "BUFF" }, -- Elemental Blood of Megaera (Fire)
    { spellID = 139587, unit = "target", caster = "all", filter = "BUFF" }, -- Elemental Blood of Megaera (Frost)
    { spellID = 139588, unit = "target", caster = "all", filter = "BUFF" }, -- Elemental Blood of Megaera (Venom)
    ----------------------------------------------------------------
    -- Ji-Kun
    ----------------------------------------------------------------
    { spellID = 134256, unit = "player", caster = "all", filter = "DEBUFF" },   -- Slimed
    { spellID = 140741, unit = "player", caster = "all", filter = "BUFF" },     -- Primal Nutriment
    { spellID = 134366, unit = "player", caster = "all", filter = "DEBUFF" },   -- Talon Rake
    { spellID = 140092, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infected Talons
    { spellID = 140014, unit = "player", caster = "all", filter = "BUFF" },     -- Daedalian Wings
    { spellID = 133755, unit = "player", caster = "all", filter = "BUFF" },     -- Flight
    { spellID = 140571, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lesson of Icarus

    ----------------------------------------------------------------
    -- Durumu the Forgotten
    ----------------------------------------------------------------
    { spellID = 133767, unit = "player", caster = "all", filter = "DEBUFF" },   -- Serious Wound
    { spellID = 133768, unit = "player", caster = "all", filter = "DEBUFF" },   -- Arterial Cut
    { spellID = 133732, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infrared Light
    { spellID = 133738, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bright Light
    { spellID = 133677, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blue Rays
    { spellID = 77699 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Flash Freeze
    { spellID = 77760 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Biting Chill
    { spellID = 133798, unit = "player", caster = "all", filter = "DEBUFF" },   -- Life Drain
    { spellID = 133597, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dark Parasite
    { spellID = 133598, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dark Plague
    
    ----------------------------------------------------------------
    -- Primordius
    ----------------------------------------------------------------
    { spellID = 137000, unit = "player", caster = "all", filter = "DEBUFF" },   -- Black Blood (Heroic)
    { spellID = 136050, unit = "player", caster = "all", filter = "DEBUFF" },   -- Malformed Blood
    { spellID = 140546, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fully Mutated
    { spellID = 136228, unit = "player", caster = "all", filter = "DEBUFF" },   -- Volatile Pathogen

    -- { spellID = 140544, unit = "target", caster = "all", filter = "BUFF" },   -- Mutated Abomination
    { spellID = 136209, unit = "target", caster = "all", filter = "BUFF" },     -- Evolution
    { spellID = 137000, unit = "target", caster = "all", filter = "DEBUFF" },   -- Black Blood
    
    -- Helpful Mutations
    { spellID = 136180, unit = "player", caster = "all", filter = "DEBUFF" },   -- Keen Eyesight
    { spellID = 136182, unit = "player", caster = "all", filter = "DEBUFF" },   -- Improved Synapses
    { spellID = 136184, unit = "player", caster = "all", filter = "DEBUFF" },   -- Thick Bones
    { spellID = 136186, unit = "player", caster = "all", filter = "DEBUFF" },   -- Clear Mind

    -- Harmful Mutations
    { spellID = 136181, unit = "all", caster = "all", filter = "DEBUFF" },      -- Impaired Eyesight
    { spellID = 136183, unit = "all", caster = "all", filter = "DEBUFF" },      -- Dulled Synapses
    { spellID = 136185, unit = "all", caster = "all", filter = "DEBUFF" },      -- Fragile Bones
    { spellID = 136187, unit = "all", caster = "all", filter = "DEBUFF" },      -- Clouded Mind

    ----------------------------------------------------------------
    -- Dark Animus
    ----------------------------------------------------------------
        -- Anime Golem
        { spellID = 138453, unit = "target", caster = "all", filter = "BUFF" },     -- Acceleration Link
        -- Large Anima Golem
        -- Massive Large Golem
        { spellID = 138609, unit = "all", caster = "all", filter = "DEBUFF" },      -- Matter Swap
        { spellID = 139919, unit = "all", caster = "all", filter = "DEBUFF" },      -- Target: Matter Swap
        { spellID = 138569, unit = "player", caster = "all", filter = "DEBUFF" },   -- Explosive Slam
        -- Dark Animus
        { spellID = 138978, unit = "player", caster = "all", filter = "DEBUFF" },   -- Anima Ring (fixate)
        { spellID = 136962, unit = "player", caster = "all", filter = "DEBUFF" },   -- Anima Ring
        { spellID = 138691, unit = "player", caster = "all", filter = "DEBUFF" },   -- Anima Font
        { spellID = 139537, unit = "target", caster = "all", filter = "BUFF" },     -- Activation Sequence

    ----------------------------------------------------------------
    -- Iron Qon
    ----------------------------------------------------------------
    -- The Quilen Champions
    { spellID = 134691, unit = "player", caster = "all", filter = "DEBUFF" },   -- Impale

        -- Ro'shak, the Molten Flare
        { spellID = 134647, unit = "player", caster = "all", filter = "DEBUFF" },   -- Scorched
        { spellID = 135052, unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Cinders
        { spellID = 137221, unit = "target", caster = "all", filter = "BUFF" },     -- Molten Overload

        -- Quet'zal, the Stormcaller
        { spellID = 136193, unit = "player", caster = "all", filter = "DEBUFF" },   -- Arcing Lightning
        { spellID = 137669, unit = "player", caster = "all", filter = "DEBUFF" },   -- Storm Cloud
        { spellID = 135147, unit = "target", caster = "all", filter = "BUFF" },     -- Frozen Resilience

        -- Dam'ren, the Frozen Sage
        { spellID = 135147, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dead Zone
        { spellID = 135145, unit = "player", caster = "all", filter = "DEBUFF" },   -- Freeze
        { spellID = 137664, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frozen Blood

    -- Iron Qon's Last Stand
    { spellID = 136323, unit = "target", caster = "all", filter = "BUFF" },     -- Rising Anger

    ----------------------------------------------------------------
    -- Twin Consorts
    ----------------------------------------------------------------
    -- Darkness Falls: Lu'lin's Luminosity
    { spellID = 136722, unit = "player", caster = "all", filter = "DEBUFF" },   -- Slumber Spores
    { spellID = 137341, unit = "player", caster = "all", filter = "DEBUFF" },   -- Beast of Nightmares
    { spellID = 137360, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Healing

    -- Blazing Daylight: Suen's Fury
    { spellID = 137408, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fan of Flames
    { spellID = 137440, unit = "player", caster = "all", filter = "DEBUFF" },   -- Icy Shadows
    { spellID = 137410, unit = "target", caster = "all", filter = "BUFF" },     -- Blazing Radiance
    { spellID = 137491, unit = "target", caster = "all", filter = "BUFF" },     -- Nuclear Inferno

    -- Break of Dusk: The Dance of the Consorts
    { spellID = 137531, unit = "target", caster = "all", filter = "BUFF" },     -- Tidal Force

    -- Niuzao
    { spellID = 138300, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fortitude of the Ox

    -- Chi-Ji: A Rush of Cranes
    -- Yu'lon
    { spellID = 138306, unit = "player", caster = "all", filter = "DEBUFF" },   -- The Serpent's Vitality

    -- Xuen: The Tiger's Celerity

    ----------------------------------------------------------------
    -- Lei Shen
    ----------------------------------------------------------------
    -- Stage One: Thunderstruck!
    { spellID = 135000, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decapitate
    { spellID = 134990, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decapitate
    { spellID = 136326, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overcharge
    { spellID = 136295, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overcharge (stun)
    { spellID = 135695, unit = "player", caster = "all", filter = "DEBUFF" },   -- Static Shock
    { spellID = 139011, unit = "player", caster = "all", filter = "DEBUFF" },   -- Helm of Command
    -- Stage Two: Lightning Will End You!
    { spellID = 134820, unit = "player", caster = "all", filter = "DEBUFF" },   -- Discharged Energy
    { spellID = 136478, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fusion Slash
    -- Stage Three: Master of Thunder and Lightning
    { spellID = 136913, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overwhelming Power
    -- Intermission: Supercharge Conduits!
    { spellID = 139011, unit = "player", caster = "all", filter = "DEBUFF" },   -- Helm of Command
    { spellID = 140208, unit = "player", caster = "all", filter = "DEBUFF" },   -- Windburn
    { spellID = 136914, unit = "player", caster = "all", filter = "DEBUFF" },   -- Electrical Shock

    ----------------------------------------------------------------
    -- Ra-den
    ----------------------------------------------------------------
    { spellID = 138308, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Vita
    { spellID = 138372, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vita Sensitivity

    ----------------------------------------------------------------
    -- Trash
    ----------------------------------------------------------------
    { spellID = 140049, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wounding Strike
    { spellID = 139559, unit = "player", caster = "all", filter = "DEBUFF" },   -- Storm Energy
    { spellID = 139888, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ancient Venom
    { spellID = 138742, unit = "player", caster = "all", filter = "DEBUFF" },   -- Chocking Sand
    { spellID = 140400, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mark of the Prophet
    { spellID = 139213, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mark of the Loa
    { spellID = 136751, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sonic Screech
    { spellID = 136753, unit = "player", caster = "all", filter = "DEBUFF" },   -- Slashing Talons
    { spellID = 140618, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crush Armor
    { spellID = 140616, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shale Shards
    { spellID = 140629, unit = "player", caster = "all", filter = "DEBUFF" },   -- Eternal Prison
    { spellID = 112844, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cocoon
    { spellID = 138235, unit = "player", caster = "all", filter = "DEBUFF" },   -- Electro Pulse
    { spellID = 140682, unit = "player", caster = "all", filter = "DEBUFF" },   -- Choking Mists
    { spellID = 134668, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gnawed Upon

    { spellID = 138201, unit = "target", caster = "all", filter = "BUFF" }, -- Lei Shen's Gift
    { spellID = 140296, unit = "target", caster = "all", filter = "BUFF" }, -- Conductive Shield
}

-- Siege of Orgrimmar
Instances[1136] = {
    ----------------------------------------------------------------
    -- Immerseus
    ----------------------------------------------------------------
    -- Tears of the Vale
    { spellID = 143295, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sha Bolt
    { spellID = 143436, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrosive Blast
    { spellID = 143574, unit = "target", caster = "all", filter = "BUFF" },     -- Swelling Corruptio

    -- Split
    { spellID = 143459, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sha Residue
    { spellID = 143540, unit = "player", caster = "all", filter = "DEBUFF" },   -- Congealing
    { spellID = 143524, unit = "player", caster = "all", filter = "DEBUFF" },   -- Purified Residue
    { spellID = 143460, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sha Pool
    { spellID = 143297, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sha Splash
    
    ----------------------------------------------------------------
    -- The Fallen Protectors
    ----------------------------------------------------------------
    { spellID = 143840, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mark of Anguish

    -- Rook Stonetoe
    { spellID = 143962, unit = "player", caster = "all", filter = "DEBUFF" },   -- Inferno Strike
    { spellID = 144007, unit = "player", caster = "all", filter = "DEBUFF" },   -- Residual Burn
    { spellID = 145655, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shared Torment
    { spellID = 144396, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vengeful Strikes
    { spellID = 143019, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Brew
    { spellID = 143027, unit = "player", caster = "all", filter = "DEBUFF" },   -- Clash
    { spellID = 143007, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corruption Kick

    -- He Softfoot
    { spellID = 144176, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadow Weakness
    { spellID = 147383, unit = "player", caster = "all", filter = "DEBUFF" },   -- Debilitation
    { spellID = 703, unit = "player", caster = "all", filter = "DEBUFF" },      -- Garrote
    { spellID = 1776, unit = "player", caster = "all", filter = "DEBUFF" },     -- Gouge
    { spellID = 143808, unit = "target", caster = "all", filter = "BUFF" },     -- Mark of Anguish

    -- Sun Tenderheart
    { spellID = 143745, unit = "player", caster = "all", filter = "DEBUFF" }, -- Dark Meditation
    { spellID = 143423, unit = "player", caster = "all", filter = "DEBUFF" }, -- Sha Sear
    { spellID = 143434, unit = "player", caster = "all", filter = "DEBUFF" }, -- Shadow Word: Bane
    { spellID = 143564, unit = "player", caster = "all", filter = "DEBUFF" }, -- Meditation Field
    { spellID = 143225, unit = "player", caster = "all", filter = "DEBUFF" }, -- Noxious Poison
    
    ----------------------------------------------------------------
    -- Norushen
    ----------------------------------------------------------------
    { spellID = 144421, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corruption
    { spellID = 144452, unit = "player", caster = "all", filter = "BUFF" },     -- Purified
    { spellID = 146124, unit = "player", caster = "all", filter = "DEBUFF" },   -- Self Doubt
    { spellID = 145226, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blind Hatred
    { spellID = 145733, unit = "player", caster = "all", filter = "DEBUFF" },   -- Icy Fear
    { spellID = 144724, unit = "player", caster = "all", filter = "DEBUFF" },   -- Look Within
    { spellID = 144849, unit = "player", caster = "all", filter = "DEBUFF" },   -- Test of Serenity
    { spellID = 144850, unit = "player", caster = "all", filter = "DEBUFF" },   -- Test of Reliance
    { spellID = 144514, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lingering Corruption
    { spellID = 144851, unit = "player", caster = "all", filter = "DEBUFF" },   -- Test of Confidence

    { spellID = 145132, unit = "target", caster = "all", filter = "BUFF" },     -- Fusion
    { spellID = 146179, unit = "target", caster = "all", filter = "BUFF" },     -- Frayed

    ----------------------------------------------------------------
    -- Sha of Pride
    ----------------------------------------------------------------
    { spellID = 147207, unit = "player", caster = "all", filter = "DEBUFF" },   -- Weakened Resolve (heroic)
    { spellID = 145320, unit = "player", caster = "all", filter = "DEBUFF" },   -- Projection (heroic)
    { spellID = 145215, unit = "player", caster = "all", filter = "DEBUFF" },   -- Banishment (heroic)
    { spellID = 147207, unit = "player", caster = "all", filter = "DEBUFF" },   -- Weakened Resolve (heroic)
    { spellID = 144359, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gift of the Titans
    { spellID = 144364, unit = "player", caster = "all", filter = "DEBUFF" },   -- Power of the Titans
    { spellID = 146817, unit = "player", caster = "all", filter = "DEBUFF" },   -- Aura of Pride
    { spellID = 144843, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overcome
    { spellID = 144351, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mark of Arrogance
    { spellID = 144358, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wounded Pride
    { spellID = 144574, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Prison
    { spellID = 119775, unit = "player", caster = "all", filter = "DEBUFF" },   -- Reaching Attack
    { spellID = 147207, unit = "player", caster = "all", filter = "DEBUFF" },   -- Weakened Resolve
    -- { spellID = 145345, unit = "player", caster = "all", filter = "DEBUFF" },-- Orb of Light

    ----------------------------------------------------------------
    -- Galakras
    ----------------------------------------------------------------
    { spellID = 147043, unit = "target", caster = "all", filter = "BUFF" }, -- Pulsing Flames

    -- Phase 1: Bring Her Down!
    { spellID = 146902, unit = "player", caster = "all", filter = "DEBUFF" }, -- Poison-Tipped Blades
    { spellID = 147705, unit = "player", caster = "all", filter = "DEBUFF" }, -- Poison Cloud
    { spellID = 146765, unit = "player", caster = "all", filter = "DEBUFF" }, -- Flame Arrow
    { spellID = 146899, unit = "player", caster = "all", filter = "DEBUFF" }, -- Fracture

    -- Phase 2: Galakras, The Last of His Progeny
    { spellID = 147029, unit = "player", caster = "all", filter = "DEBUFF" }, -- Flames of Galakrond
    { spellID = 147042, unit = "player", caster = "all", filter = "DEBUFF" }, -- Pulsing Flames
    
    ----------------------------------------------------------------
    -- Iron Juggernaut
    ----------------------------------------------------------------
    -- Pressing the Attack: Assault Mode
    { spellID = 144218, unit = "player", caster = "all", filter = "DEBUFF" },   -- Borer Drill
    { spellID = 144459, unit = "player", caster = "all", filter = "DEBUFF" },   -- Laser Burn
    { spellID = 144467, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ignite Armor
    -- Breaking the Defense: Siege Mode
    { spellID = 144498, unit = "player", caster = "all", filter = "DEBUFF" },   -- Explosive Tar
    
    ----------------------------------------------------------------
    -- Kor'kron Dark Shaman
    ----------------------------------------------------------------
    { spellID = 144263, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rend
    -- Earthbreaker Haromm
    { spellID = 144215, unit = "player", caster = "all", filter = "DEBUFF" },   -- Froststorm Strike
    { spellID = 144089, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxic Mist
    { spellID = 144107, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxicity
    -- Wavebinder Kardris
    { spellID = 143990, unit = "player", caster = "all", filter = "DEBUFF" },   -- Foul Geyser
    { spellID = 144330, unit = "player", caster = "all", filter = "DEBUFF" },   -- Iron Prison (heroic)

    ----------------------------------------------------------------
    -- General Nazgrim
    ----------------------------------------------------------------
    { spellID = 143494, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sundering Blow
    { spellID = 143638, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bonecracker

    -- Kor'kron Forces
    { spellID = 143432, unit = "player", caster = "all", filter = "DEBUFF" },   -- Arcane Shock
    { spellID = 143431, unit = "player", caster = "all", filter = "DEBUFF" },   -- Magistrike
    { spellID = 143480, unit = "player", caster = "all", filter = "DEBUFF" },   -- Assassin's Mark
    { spellID = 143882, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hunter's Mark (heroic)

    { spellID = 143484, unit = "target", caster = "all", filter = "BUFF" },     -- Cooling Off
    { spellID = 974   , unit = "target", caster = "all", filter = "BUFF" },     -- Earth Shield
    { spellID = 143593, unit = "target", caster = "all", filter = "BUFF" },     -- Defensive Stance
    { spellID = 143594, unit = "target", caster = "all", filter = "BUFF" },     -- Berserker Stance
    { spellID = 143589, unit = "target", caster = "all", filter = "BUFF" },     -- Battle Stance
    { spellID = 144330, unit = "target", caster = "all", filter = "DEBUFF" },   -- Iron Prison (heroic) - healer

    ----------------------------------------------------------------
    -- Malkorok
    ----------------------------------------------------------------
    { spellID = 142863, unit = "player", caster = "all", filter = "DEBUFF" },   -- Weak Ancient Barrier
    { spellID = 142864, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ancient Barrier
    { spellID = 142865, unit = "player", caster = "all", filter = "DEBUFF" },   -- Strong Ancient Barrier
    --{ spellID = 142861, unit = "player", caster = "all", filter = "DEBUFF" }, -- Ancient Miasma
    --{ spellID = 142862, unit = "player", caster = "all", filter = "DEBUFF" }, -- Ancient Barrier
    { spellID = 142913, unit = "player", caster = "all", filter = "DEBUFF" },   -- Displaced Energy
    { spellID = 143919, unit = "player", caster = "all", filter = "DEBUFF" },   -- Languish
    { spellID = 142990, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fatal Strike

    { spellID = 143261, unit = "target", caster = "all", filter = "BUFF" },     -- Relentless Assault

    ----------------------------------------------------------------
    -- Spoils of Pandaria
    ----------------------------------------------------------------
    { spellID = 145685, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Defense Systems
    { spellID = 145998, unit = "target", caster = "all", filter = "BUFF" }, -- Strength of the Stone
    { spellID = 145790, unit = "target", caster = "all", filter = "BUFF" }, -- Residue
    { spellID = 145812, unit = "target", caster = "all", filter = "BUFF" }, -- Rage of the Empress
    { spellID = 145813, unit = "target", caster = "all", filter = "BUFF" }, -- Rage of the Empress
    { spellID = 145692, unit = "target", caster = "all", filter = "BUFF" }, -- Enrage
            
    -- Massive Crate of Goods
    { spellID = 142944, unit = "player", caster = "all", filter = "DEBUFF" }, -- Return to Stone
    { spellID = 145993, unit = "player", caster = "all", filter = "DEBUFF" }, -- Set to Blow
    { spellID = 148760, unit = "player", caster = "all", filter = "DEBUFF" }, -- Pheromone Cloud

    -- Stout Crate of Goods
    { spellID = 145288, unit = "player", caster = "all", filter = "DEBUFF" },   -- Matter Scramble
    { spellID = 142947, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crimson Reconstitution
    { spellID = 136885, unit = "player", caster = "all", filter = "DEBUFF" },   -- Torment
    { spellID = 145458, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mogu Rune of Power

    -- Lightweight Crate of Goods
    { spellID = 144922, unit = "player", caster = "all", filter = "DEBUFF" },   -- Harden Flesh
    { spellID = 144853, unit = "player", caster = "all", filter = "DEBUFF" },   -- Carnivorous Bite
    { spellID = 142524, unit = "player", caster = "all", filter = "DEBUFF" },   -- Encapsulated Pheromones

    -- Crate of Pandaren Relics
    { spellID = 146213, unit = "player", caster = "all", filter = "DEBUFF" },   -- Keg Toss
    { spellID = 115181, unit = "player", caster = "all", filter = "DEBUFF" },   -- Breath of Fire
    { spellID = 146068, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blade of the Hundred Steps
    { spellID = 146098, unit = "player", caster = "all", filter = "DEBUFF" },   -- Staff of Resonating Water
    { spellID = 146253, unit = "player", caster = "all", filter = "DEBUFF" },   -- Path of Blossoms
    { spellID = 146141, unit = "player", caster = "all", filter = "BUFF" },     -- Claw of Burning Anger
    { spellID = 146289, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mass Paralysis
    
    ----------------------------------------------------------------
    -- Thok the Bloodthirsty
    ----------------------------------------------------------------
    { spellID = 144117, unit = "player", caster = "all", filter = "BUFF" },     -- Restorative Waters
    { spellID = 143452, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bloodied
    { spellID = 143766, unit = "player", caster = "all", filter = "DEBUFF" },   -- Panic

    { spellID = 143442, unit = "target", caster = "all", filter = "BUFF" },     -- Blood Frenzy
    { spellID = 143411, unit = "target", caster = "all", filter = "BUFF" },     -- Acceleration
            
    -- Stage 1: A Cry in the Carkness
    { spellID = 23364, unit = "player", caster = "all", filter = "DEBUFF" },    -- Tail Lash

    -- Stage 2: Frenzy for Blood!
    { spellID = 143445, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fixate
    { spellID = 147906, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wrecking Ball

    -- Priosoners of War
    { spellID = 143780, unit = "player", caster = "all", filter = "DEBUFF" },   -- Acid Breath
    { spellID = 143791, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrosive Blood
    { spellID = 143773, unit = "player", caster = "all", filter = "DEBUFF" },   -- Freezing Breath
    { spellID = 143800, unit = "player", caster = "all", filter = "DEBUFF" },   -- Icy Blood
    { spellID = 82660 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Blood
    { spellID = 144115, unit = "player", caster = "all", filter = "DEBUFF" },   -- Flame Coating
    
    ----------------------------------------------------------------
    -- Siegecrafter Blackfuse
    ----------------------------------------------------------------
    { spellID = 143385, unit = "player", caster = "all", filter = "DEBUFF" },   -- Electrostatic Charge
    { spellID = 144236, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pattern Recognition
    { spellID = 143856, unit = "player", caster = "all", filter = "DEBUFF" },   -- Superheated
    { spellID = 144466, unit = "player", caster = "all", filter = "DEBUFF" },   -- Magnetic Crush
    { spellID = 144466, unit = "player", caster = "all", filter = "DEBUFF" },   -- Locked On
    { spellID = 147877, unit = "player", caster = "all", filter = "DEBUFF" },   -- Adrenaline Bomb

    { spellID = 116982, unit = "target", caster = "all", filter = "BUFF" },     -- Protective Frenzy
    { spellID = 148990, unit = "target", caster = "all", filter = "BUFF" },     -- Energized Defensive Matrix
    { spellID = 143387, unit = "target", caster = "all", filter = "BUFF" },     -- Reactive Armor
    { spellID = 145444, unit = "target", caster = "all", filter = "BUFF" },     -- Overload
    { spellID = 143856, unit = "target", caster = "all", filter = "BUFF" },     -- Superheated
    { spellID = 145269, unit = "target", caster = "all", filter = "BUFF" },     -- Break-in Period
    { spellID = 145580, unit = "target", caster = "all", filter = "BUFF" },     -- Ready to Go!

    ----------------------------------------------------------------
    -- Paragons of the Klaxxi
    ----------------------------------------------------------------
    { spellID = 143218, unit = "target", caster = "all", filter = "DEBUFF" },   -- Marked for Death
    { spellID = 143376, unit = "target", caster = "all", filter = "DEBUFF" },   -- Sting
    -- Kil'ruk the Wind-Reaver 
    { spellID = 142931, unit = "player", caster = "all", filter = "DEBUFF" },   -- Exposed Veins
    { spellID = 1776, unit = "player", caster = "all", filter = "DEBUFF" },     -- Gouge
    -- Xaril the Poisoned Mind 
    { spellID = 142315, unit = "player", caster = "all", filter = "DEBUFF" },   -- Caustic Blood
    { spellID = 142929, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tenderizing Strikes
    -- Kaz'tik the Manipulator 
    { spellID = 142649, unit = "player", caster = "all", filter = "DEBUFF" },   -- Devour
    { spellID = 142671, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mesmerize
    { spellID = 127351, unit = "player", caster = "all", filter = "DEBUFF" },   -- Master of Puppets
    -- Korven the Prime 
    { spellID = 143974, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shield Bash
    { spellID = 143979, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vicius Assault
    -- Iyyokuk Lucid
    { spellID = 142416, unit = "player", caster = "all", filter = "DEBUFF" },   -- Insane Calculation: Fiery Edge
    { spellID = 141858, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ingenious
    -- Ka'roz the Locust
    { spellID = 143701, unit = "player", caster = "all", filter = "DEBUFF" },   -- Whirling
    { spellID = 143964, unit = "player", caster = "all", filter = "DEBUFF" },   -- Strong Legs
    -- Skeer the Bloodseeker
    { spellID = 143275, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hewn
    { spellID = 138693, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bloodletting
    { spellID = 143319, unit = "player", caster = "all", filter = "BUFF" },     -- Bloodletting
    -- Rik'kal the Dissector
    { spellID = 143373, unit = "player", caster = "all", filter = "BUFF" },     -- Gene Splice
    { spellID = 143339, unit = "player", caster = "all", filter = "DEBUFF" },   -- Injection
    { spellID = 143362, unit = "player", caster = "all", filter = "DEBUFF" },   -- Feed
    -- Hisek the Swarmkeeper
    { spellID = 142948, unit = "player", caster = "all", filter = "DEBUFF" },   -- Aim
    { spellID = 143358, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hunger
    --
    { spellID = 142808, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fiery Edge
    { spellID = 142533, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxin: Red
    { spellID = 143610, unit = "player", caster = "all", filter = "DEBUFF" },   -- Red Drum
    { spellID = 143605, unit = "player", caster = "all", filter = "DEBUFF" },   -- Red Sword
    { spellID = 143615, unit = "player", caster = "all", filter = "DEBUFF" },   -- Red Bomb
    { spellID = 143534, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxin: Yellow
    { spellID = 143358, unit = "player", caster = "all", filter = "DEBUFF" },   -- Yellow Drum
    { spellID = 143619, unit = "player", caster = "all", filter = "DEBUFF" },   -- Yellow Bomb
    { spellID = 143609, unit = "player", caster = "all", filter = "DEBUFF" },   -- Yellow Sword
    { spellID = 142532, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxin: Blue
    { spellID = 143607, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blue Sword
    { spellID = 143612, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blue Drum
    { spellID = 143617, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blue Bomb
    { spellID = 143735, unit = "player", caster = "all", filter = "DEBUFF" },   -- Caustic Amber
    { spellID = 143337, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mutate
    { spellID = 143355, unit = "player", caster = "all", filter = "DEBUFF" },   -- Genetic Modifications
    
    ----------------------------------------------------------------
    -- Garrosh Hellscream
    ----------------------------------------------------------------
    -- Stage One: The True Horde
    { spellID = 144762, unit = "player", caster = "all", filter = "DEBUFF" },   -- Desecrated
    { spellID = 26141, unit = "player", caster = "all", filter = "DEBUFF" },    -- Hamstring

    -- Intermission: Realm of Y'Shaarj
    { spellID = 147324, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crushing Fear
    { spellID = 149347, unit = "player", caster = "all", filter = "DEBUFF" },   -- Emboied Doubt
    { spellID = 147341, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ultimate Despair
    { spellID = 147342, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ultimate Despair
    { spellID = 144954, unit = "player", caster = "all", filter = "DEBUFF" },   -- Realm of Y'Shaarj
    { spellID = 145065, unit = "player", caster = "all", filter = "DEBUFF" },   -- Touch of Y'Shaarj
    { spellID = 148983, unit = "player", caster = "all", filter = "DEBUFF" },   -- Courage
    { spellID = 148994, unit = "player", caster = "all", filter = "DEBUFF" },   -- Faith
    { spellID = 149004, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hope
    { spellID = 55711, unit = "player", caster = "all", filter = "DEBUFF" },    -- Wealened Heart

    -- Stage Two: Power of Y'Shaarj
    { spellID = 145199, unit = "player", caster = "all", filter = "DEBUFF" },   -- Explosive Despair
    { spellID = 145183, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gripping Despair (tank)
    { spellID = 145195, unit = "player", caster = "all", filter = "DEBUFF" },   -- Empowered Gripping Despair (tank)
    
    -- Stage Three: MY WORLD

    ----------------------------------------------------------------
    -- Trash
    ----------------------------------------------------------------
    { spellID = 147135, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lesser Purified Residue
    { spellID = 147083, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lesser Sha Residue
    { spellID = 146324, unit = "player", caster = "all", filter = "DEBUFF" },   -- Jealousy
    { spellID = 145861, unit = "player", caster = "all", filter = "DEBUFF" },   -- Self-Absorbed
    { spellID = 145940, unit = "player", caster = "all", filter = "DEBUFF" },   -- Growing Overconfidance
    { spellID = 145893, unit = "player", caster = "all", filter = "DEBUFF" },   -- Overconfidance
    { spellID = 149207, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Touch
    { spellID = 15708 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Mortal Strike
    { spellID = 140276, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rend
    { spellID = 145553, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bribe
    { spellID = 75015 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Curse of Shadows
    { spellID = 145561, unit = "player", caster = "all", filter = "DEBUFF" },   -- Assasin's Mark
    { spellID = 145563, unit = "player", caster = "all", filter = "DEBUFF" },   -- Magistrike
    { spellID = 146606, unit = "player", caster = "all", filter = "DEBUFF" },   -- Poison Blast
    { spellID = 146556, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pierce
    { spellID = 143828, unit = "player", caster = "all", filter = "DEBUFF" },   -- Locked On
    { spellID = 15470 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Curse of Tongues
    { spellID = 147642, unit = "player", caster = "all", filter = "DEBUFF" },   -- Reaping Whirlwind
    { spellID = 147554, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blood of Y'Shaarj

    { spellID = 145580, unit = "target", caster = "all", filter = "BUFF" }, -- Y'Shaarj Touched
}