local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Battle for Azeroth Dungeons
----------------------------------------------------------------
local Ignore = {
    { spellID = 209859, unit = "target", caster = "all", filter = "BUFF" }, -- Bolster
}

-- The Motherlode
Instances[1594] = {
    saved = true,
    
    --[[ Coin-Operated Crowd Pummeler ]]--
    { spellID = 257337, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shocking Claw
    { spellID = 262347, unit = "player", caster = "all", filter = "DEBUFF" },   -- Static Pulse
    { spellID = 271867, unit = "target", caster = "all", filter = "DEBUFF" },   -- Pay to Win

    { spellID = 269493, unit = "target", caster = "all", filter = "BUFF" },     -- Footbomb Launcher
    { spellID = 271903, unit = "target", caster = "all", filter = "BUFF" },     -- Coin Magnet
    { spellID = 267547, unit = "target", caster = "all", filter = "BUFF" },     -- Insufficient Funds

    --[[ Azerokk ]]--
    { spellID = 275907, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tectonic Smash
    { spellID = 257544, unit = "player", caster = "all", filter = "DEBUFF" },   -- Jagged Cut
    { spellID = 257582, unit = "player", caster = "all", filter = "DEBUFF" },   -- Raging Gaze

    { spellID = 257597, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite Infusion
    { spellID = 275598, unit = "target", caster = "all", filter = "BUFF" },     -- "Ascended"

    --[[ Rixxa Fluxflame ]]--
    { spellID = 259853, unit = "player", caster = "all", filter = "DEBUFF" },   -- Chemical Burn
    { spellID = 260669, unit = "player", caster = "all", filter = "DEBUFF" },   -- Propellant Blast
    { spellID = 260103, unit = "player", caster = "all", filter = "DEBUFF" },   -- Propellant Blast
    { spellID = 259533, unit = "player", caster = "all", filter = "DEBUFF" },   -- Azerite Catalyst

    --[[ Mogul Razdunk ]]--
    { spellID = 270277, unit = "player", caster = "all", filter = "DEBUFF" },   -- Big Red Rocket
    { spellID = 260838, unit = "player", caster = "all", filter = "DEBUFF" },   -- Homing Missile
    { spellID = 260829, unit = "player", caster = "all", filter = "DEBUFF" },   -- Homing Missile
    { spellID = 262513, unit = "player", caster = "all", filter = "DEBUFF" },   -- Azerite Heartseeker
    { spellID = 260280, unit = "target", caster = "all", filter = "BUFF" },     -- Gatling Gun
    { spellID = 260189, unit = "target", caster = "all", filter = "BUFF" },     -- Configuration: Drill
    { spellID = 260190, unit = "target", caster = "all", filter = "BUFF" },     -- Configuration: Combat

    --[[ Trash ]]--
    { spellID = 268846, unit = "player", caster = "all", filter = "DEBUFF" },   -- Echo Blade
    { spellID = 268704, unit = "player", caster = "all", filter = "DEBUFF" },   -- Furious Quake
    { spellID = 269092, unit = "player", caster = "all", filter = "DEBUFF" },   -- Artillery Barrage
    { spellID = 262515, unit = "player", caster = "all", filter = "DEBUFF" },   -- Azerite Heartseeker
    { spellID = 262811, unit = "player", caster = "all", filter = "DEBUFF" },   -- Leech Globule
    { spellID = 269429, unit = "player", caster = "all", filter = "DEBUFF" },   -- Charged Shot
    { spellID = 262811, unit = "player", caster = "all", filter = "DEBUFF" },   -- Leech Globule
    { spellID = 263637, unit = "player", caster = "all", filter = "DEBUFF" },   -- Clothesline
    { spellID = 263074, unit = "player", caster = "all", filter = "DEBUFF" },   -- Festering Bite
    { spellID = 269298, unit = "player", caster = "all", filter = "DEBUFF" },   -- Widowmaker Toxin
    { spellID = 263202, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rock Lance
    { spellID = 262794, unit = "player", caster = "all", filter = "DEBUFF" },   -- Energy Lash
    { spellID = 262270, unit = "player", caster = "all", filter = "DEBUFF" },   -- Caustic Compound
    { spellID = 268797, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transmute: Enemy to Goo
    { spellID = 262377, unit = "player", caster = "all", filter = "DEBUFF" },   -- Seek and Destroy
    { spellID = 262348, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mine Blast
    { spellID = 280604, unit = "player", caster = "all", filter = "DEBUFF" },   -- Iced Spritzer
    { spellID = 280605, unit = "player", caster = "all", filter = "DEBUFF" },   -- Brain Freeze
    { spellID = 257481, unit = "target", caster = "all", filter = "DEBUFF" },   -- Fracking Totem
    { spellID = 263276, unit = "target", caster = "all", filter = "DEBUFF" },   -- Cover
    { spellID = 257481, unit = "target", caster = "all", filter = "DEBUFF" },   -- Fracking Totem
    { spellID = 275616, unit = "target", caster = "all", filter = "DEBUFF" },   -- Azerite Smoke
    
    { spellID = 263215, unit = "target", caster = "all", filter = "BUFF" },     -- Tectonic Barrier
    { spellID = 268702, unit = "target", caster = "all", filter = "BUFF" },     -- Furious Quake
    { spellID = 256493, unit = "target", caster = "all", filter = "BUFF" },     -- Blazing Azerite
    { spellID = 268815, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite-Enriched Blood
    { spellID = 268712, unit = "target", caster = "all", filter = "BUFF" },     -- Bag of Bombs
    { spellID = 260190, unit = "target", caster = "all", filter = "BUFF" },     -- Configuration: Combat
    { spellID = 268815, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite-Enriched Blood
    { spellID = 262940, unit = "target", caster = "all", filter = "BUFF" },     -- Leech Globule
    { spellID = 262540, unit = "target", caster = "all", filter = "BUFF" },     -- Overcharge
    { spellID = 262554, unit = "target", caster = "all", filter = "BUFF" },     -- Repair
    { spellID = 258627, unit = "target", caster = "all", filter = "BUFF" },     -- Resonant Quake
    { spellID = 262940, unit = "target", caster = "all", filter = "BUFF" },     -- Leech Globule
    { spellID = 263103, unit = "target", caster = "all", filter = "BUFF" },     -- Blowtorch
    { spellID = 263066, unit = "target", caster = "all", filter = "BUFF" },     -- Transfiguration Serum
    { spellID = 262092, unit = "target", caster = "all", filter = "BUFF" },     -- Inhale Vapors
    { spellID = 263275, unit = "target", caster = "all", filter = "BUFF" },     -- Cover
    { spellID = 263601, unit = "target", caster = "all", filter = "BUFF" },     -- Desperate Measures
    { spellID = 263066, unit = "target", caster = "all", filter = "BUFF" },     -- Transfiguration Serum
    { spellID = 269302, unit = "target", caster = "all", filter = "BUFF" },     -- Toxic Blades
    { spellID = 267354, unit = "target", caster = "all", filter = "BUFF" },     -- Hail of Flechettes
    { spellID = 268709, unit = "target", caster = "all", filter = "BUFF" },     -- Earth Shield
    { spellID = 267367, unit = "target", caster = "all", filter = "BUFF" },     -- Deactivated
    { spellID = 262412, unit = "target", caster = "all", filter = "BUFF" },     -- Energy Shield
    { spellID = 263628, unit = "target", caster = "all", filter = "BUFF" },     -- Charged Claw
    { spellID = 262947, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite Injection
    { spellID = 271428, unit = "target", caster = "all", filter = "BUFF" },     -- Energy Lash
    { spellID = 268130, unit = "target", caster = "all", filter = "BUFF" },     -- Kaja'Cola Refresher
    { spellID = 268712, unit = "target", caster = "all", filter = "BUFF" },     -- Bag of Bombs
    { spellID = 280602, unit = "target", caster = "all", filter = "BUFF" },     -- Eject!
    { spellID = 268810, unit = "target", caster = "all", filter = "BUFF" },     -- Unstable Mutation
    { spellID = 275681, unit = "target", caster = "all", filter = "BUFF" },     -- Unbridled Fury
}

-- Freehold
Instances[1754] = {
    saved = false,

    --[[ Skycap'n Kragg ]]--
    { spellID = 258323, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infected Wound
    { spellID = 257274, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vile Coating
    { spellID = 256060, unit = "target", caster = "all", filter = "BUFF" },     -- Revitalizing Brew

    --[[ Council o' Captains ]]--
    { spellID = 257821, unit = "target", caster = "all", filter = "BUFF" },     -- Under One Banner

        --[[ Captain Raoul ]]--
        { spellID = 258875, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blackout Barrel
        { spellID = 256589, unit = "target", caster = "all", filter = "BUFF" },     -- Barrel Smash

        --[[ Captain Eudora ]]--
        --[[ Captain Jolly ]]--
        { spellID = 267525, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cutting Surge

        --[[ Rummy Mancomb ]]--
        { spellID = 264605, unit = "target", caster = "all", filter = "BUFF" },     -- Tending Bar
        { spellID = 278467, unit = "target", caster = "all", filter = "DEBUFF" },   -- Caustic Freehold Brew
        { spellID = 265085, unit = "player", caster = "all", filter = "DEBUFF" },   -- Confidence-Boosting Freehold Brew
        { spellID = 265056, unit = "player", caster = "all", filter = "DEBUFF" },   -- Invigorating Freehold Brew
    
    --[[ Ring of Booty ]]--
        --[[ Lightning ]]--
        { spellID = 257829, unit = "target", caster = "all", filter = "BUFF" },     -- Greasy

        --[[ Ludwig ]]--

        --[[ Trothak ]]--
        { spellID = 256363, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ripper Punch
        { spellID = 256405, unit = "target", caster = "all", filter = "BUFF" },     -- Shark Tornado
    
    --[[ Harlan Sweete ]]--
    { spellID = 257305, unit = "player", caster = "all", filter = "DEBUFF" },       -- Cannon Barrage
    
    --[[ Trash ]]--
    { spellID = 257908, unit = "player", caster = "all", filter = "DEBUFF" },   -- Oiled Blade
    { spellID = 274389, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rat Traps
    { spellID = 274555, unit = "player", caster = "all", filter = "DEBUFF" },   -- Scabrous Bite
    { spellID = 274507, unit = "player", caster = "all", filter = "DEBUFF" },   -- Slippery Suds
    { spellID = 257747, unit = "player", caster = "all", filter = "DEBUFF" },   -- Earth Shaker
    { spellID = 257437, unit = "player", caster = "all", filter = "DEBUFF" },   -- Poisoning Strike
    { spellID = 257775, unit = "player", caster = "all", filter = "DEBUFF" },   -- Plague Step
    { spellID = 274400, unit = "player", caster = "all", filter = "DEBUFF" },   -- Duelist Dash
    { spellID = 257784, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frost Blast
    { spellID = 257478, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crippling Bite
    { spellID = 257460, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fiery Debris
    { spellID = 257739, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blind Rage

    { spellID = 274860, unit = "target", caster = "all", filter = "BUFF" },     -- Shattering Toss
    { spellID = 257476, unit = "target", caster = "all", filter = "BUFF" },     -- Bestial Wrath
    { spellID = 257756, unit = "target", caster = "all", filter = "BUFF" },     -- Goin' Bananas
    { spellID = 257870, unit = "target", caster = "all", filter = "BUFF" },     -- Blade Barrage
    { spellID = 257736, unit = "target", caster = "all", filter = "BUFF" },     -- Thundering Squall
    { spellID = 257741, unit = "target", caster = "all", filter = "BUFF" },     -- Blind Rage
}

-- Kings Rest
Instances[1762] = {
    saved = true,

    --[[ The Golden Serpent ]]--
    { spellID = 265773, unit = "player", caster = "all", filter = "DEBUFF" },   -- Spit Gold

    --[[ The Council of Tribes ]]--
        --[[ Kula the Butcher ]]--
        { spellID = 266231, unit = "player", caster = "all", filter = "DEBUFF" }, -- Severing Axe

    --[[ Mchimba the Embalmer ]]--
    { spellID = 267618, unit = "player", caster = "all", filter = "DEBUFF" },   -- Drain Fluids
    { spellID = 267874, unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Ground
    { spellID = 267702, unit = "player", caster = "all", filter = "DEBUFF" },   -- Entomb

    --[[ Dazar, The First King ]]--
        --[[ King Dazar ]]--
        { spellID = 268586, unit = "target", caster = "all", filter = "BUFF" }, -- Blade Combo
        --[[ Reban ]]--
        { spellID = 269232, unit = "target", caster = "all", filter = "BUFF" }, -- Hunting Leap
        --[[ T'zala ]]--
        { spellID = 269351, unit = "target", caster = "all", filter = "BUFF" },   -- Eternal Guardian
        { spellID = 269369, unit = "player", caster = "all", filter = "DEBUFF" }, -- Deathly Roar

    --[[ Thrash ]]--
    { spellID = 270487, unit = "player", caster = "all", filter = "DEBUFF" },   -- Severing Blade
    { spellID = 271640, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dark Revelation
    { spellID = 272388, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadow Barrage
    { spellID = 270084, unit = "player", caster = "all", filter = "DEBUFF" },   -- Axe Barrage
    { spellID = 271555, unit = "player", caster = "all", filter = "DEBUFF" },   -- Entomb
    { spellID = 270920, unit = "player", caster = "all", filter = "DEBUFF" },   -- Seduction
    { spellID = 270003, unit = "player", caster = "all", filter = "DEBUFF" },   -- Suppression Slam
    { spellID = 270507, unit = "player", caster = "all", filter = "DEBUFF" },   -- Poison Barrage
    { spellID = 270499, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frost Shock
    { spellID = 269936, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fixate
    { spellID = 276031, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pit of Despair
    { spellID = 270495, unit = "target", caster = "all", filter = "DEBUFF" },   -- Healing Tide
    { spellID = 270865, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hidden Blade
    { spellID = 270889, unit = "target", caster = "all", filter = "BUFF" },     -- Channel Lightning
    { spellID = 269928, unit = "target", caster = "all", filter = "BUFF" },     -- Vigilant Defense
    { spellID = 269976, unit = "target", caster = "all", filter = "BUFF" },     -- Ancestral Fury
    { spellID = 271561, unit = "target", caster = "all", filter = "BUFF" },     -- Wail of Mourning
    { spellID = 271562, unit = "target", caster = "all", filter = "BUFF" },     -- Wail of Mourning
    { spellID = 270016, unit = "target", caster = "all", filter = "BUFF" },     -- Released Inihibitors
    { spellID = 270901, unit = "target", caster = "all", filter = "BUFF" },     -- Induce Regeneration
    { spellID = 270284, unit = "target", caster = "all", filter = "BUFF" },     -- Purification Beam
    { spellID = 270502, unit = "target", caster = "all", filter = "BUFF" },     -- Hunting Leap
    { spellID = 269935, unit = "target", caster = "all", filter = "BUFF" },     -- Bound by Shadow
    { spellID = 270927, unit = "target", caster = "all", filter = "BUFF" },     -- Bladestorm
}

-- Atal'Dazar
Instances[1763] = {
    saved = true,
    
    --[[ Priestess Alun'za ]]--
    { spellID = 255836, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion
    { spellID = 255835, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion
    { spellID = 255582, unit = "player", caster = "all", filter = "DEBUFF" },   -- Molten Gold
    { spellID = 255558, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tainted Blood
    { spellID = 255577, unit = "target", caster = "all", filter = "BUFF" },     -- Transfusion
    { spellID = 255579, unit = "target", caster = "all", filter = "BUFF" },     -- Gilded Claws

    --[[ Vol'kaal ]]--
    { spellID = 250372, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lingering Nausea
    { spellID = 259572, unit = "target", caster = "all", filter = "BUFF" },     -- Noxious Stench
    { spellID = 250241, unit = "target", caster = "all", filter = "BUFF" },     -- Rapid Decay

    --[[ Rezan ]]--
    { spellID = 257407, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pursuit
    { spellID = 255371, unit = "player", caster = "all", filter = "DEBUFF" },   -- Terrifying Visage
    { spellID = 255434, unit = "player", caster = "all", filter = "DEBUFF" },   -- Serrated Teeth
    { spellID = 250096, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wracking Pain
    { spellID = 255421, unit = "target", caster = "all", filter = "BUFF" },     -- Devour

    --[[ Yazma ]]--
    { spellID = 256577, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soulfeast
    
    --[[ Trash ]]--
    { spellID = 260666, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion
    { spellID = 260668, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju
    { spellID = 277072, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Gold
    { spellID = 252687, unit = "player", caster = "all", filter = "DEBUFF" },   -- Venomfang Strike
    { spellID = 252692, unit = "player", caster = "all", filter = "DEBUFF" },   -- Waylaying Jab
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju
    { spellID = 257483, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pile of Bones
    { spellID = 258723, unit = "player", caster = "all", filter = "DEBUFF" },   -- Grotesque Pool
    { spellID = 250036, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadowy Remains
    { spellID = 250585, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxic Pool
    { spellID = 257692, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tiki Blaze
    { spellID = 252781, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Hex
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju
    { spellID = 253562, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wildfire
    { spellID = 255814, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rending Maul
    { spellID = 255620, unit = "player", caster = "all", filter = "DEBUFF" },   -- Festering Eruption
    { spellID = 255041, unit = "player", caster = "all", filter = "DEBUFF" },   -- Terrifying Screech

    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju
    { spellID = 256960, unit = "target", caster = "all", filter = "DEBUFF" },   -- Rotting Decay
    { spellID = 253721, unit = "target", caster = "all", filter = "BUFF" },     -- Bulwark of Juju
    { spellID = 255824, unit = "target", caster = "all", filter = "BUFF" },     -- Fanatic's Rage
    { spellID = 250192, unit = "target", caster = "all", filter = "BUFF" },     -- Bad Voodoo
    { spellID = 254958, unit = "target", caster = "all", filter = "BUFF" },     -- Soulforged Construct
    { spellID = 207707, unit = "target", caster = "all", filter = "BUFF" },     -- Stealth
    { spellID = 259097, unit = "target", caster = "all", filter = "BUFF" },     -- Vanish
    { spellID = 253548, unit = "target", caster = "all", filter = "BUFF" },     -- Bwonsamdi's Mantle
}

-- Tol Dagor
Instances[1771] = {
    saved = false,

    --[[ The Sand Queen ]]--
    { spellID = 259975, unit = "target", caster = "all", filter = "BUFF" },     -- Enrage
    { spellID = 257495, unit = "target", caster = "all", filter = "BUFF" },     -- Sandstorm
    { spellID = 257608, unit = "target", caster = "all", filter = "BUFF" },     -- Upheaval
    { spellID = 260016, unit = "player", caster = "all", filter = "DEBUFF" },   -- Itchy Bite

    --[[ Jes Howlis ]]--
    { spellID = 257793, unit = "all"   , caster = "all", filter = "DEBUFF" },   -- Smoke Powder
    { spellID = 257777, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crippling Shiv
    { spellID = 257791, unit = "player", caster = "all", filter = "DEBUFF" },   -- Howling Fear
    
    { spellID = 257956, unit = "target", caster = "all", filter = "BUFF" },     -- Motivated
    { spellID = 257827, unit = "target", caster = "all", filter = "BUFF" },     -- Motivating Cry

    --[[ Knight Captain Valyri ]]--
    { spellID = 257028, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fuselighter

    --[[ Overseer Korgus ]]--
    { spellID = 256105, unit = "player", caster = "all", filter = "DEBUFF" },   -- Explosive Burst
    { spellID = 256038, unit = "player", caster = "all", filter = "DEBUFF" },   -- Deadeye
    { spellID = 256200, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heartstopper Venom
    { spellID = 256201, unit = "player", caster = "all", filter = "DEBUFF" },   -- Incendiary Rounds
    { spellID = 256044, unit = "player", caster = "all", filter = "DEBUFF" },   -- Deadeye
    { spellID = 257119, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sand Trap

    { spellID = 256199, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite Rounds: Blast
    { spellID = 256198, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite Rounds: Incendiary

    --[[ Trash ]]--
    { spellID = 259711, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lockdown
    { spellID = 258917, unit = "player", caster = "all", filter = "DEBUFF" },   -- Righteous Flames
    { spellID = 258058, unit = "player", caster = "all", filter = "DEBUFF" },   -- Squeeze
    { spellID = 258128, unit = "player", caster = "all", filter = "DEBUFF" },   -- Debilitating Shout
    { spellID = 258864, unit = "player", caster = "all", filter = "DEBUFF" },   -- Suppression Fire
    { spellID = 265889, unit = "player", caster = "all", filter = "DEBUFF" },   -- Torch Strike
    { spellID = 258313, unit = "player", caster = "all", filter = "DEBUFF" },   -- Handcuff
    { spellID = 260067, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vicious Mauling
    { spellID = 259711, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lockdown
    { spellID = 258079, unit = "player", caster = "all", filter = "DEBUFF" },   -- Massive Chomp
    { spellID = 258075, unit = "player", caster = "all", filter = "DEBUFF" },   -- Itchy Bite
    { spellID = 258864, unit = "player", caster = "all", filter = "DEBUFF" },   -- Suppression Fire
    { spellID = 265271, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sewer Slime
    { spellID = 256474, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heartstopper Venom
    { spellID = 260066, unit = "target", caster = "all", filter = "DEBUFF" },   -- Blade Turning

    { spellID = 264878, unit = "player", caster = "all", filter = "BUFF" },     -- Crow's Nest Scope
    { spellID = 258938, unit = "target", caster = "all", filter = "BUFF" },     -- Inner Flames
    { spellID = 258935, unit = "target", caster = "all", filter = "BUFF" },     -- Inner Flames
    { spellID = 258133, unit = "target", caster = "all", filter = "BUFF" },     -- Darkstep
    { spellID = 258153, unit = "target", caster = "all", filter = "BUFF" },     -- Watery Dome
    { spellID = 258317, unit = "target", caster = "all", filter = "BUFF" },     -- Riot Shield
    { spellID = 259188, unit = "target", caster = "all", filter = "BUFF" },     -- Heavily Armed
}

-- Siege of Boralus
Instances[1822] = {
    saved = false,

    --[[ Sergeant Bainbridge ]] --
    { spellID = 260954, unit = "player", caster = "all", filter = "DEBUFF" },   -- Iron Gaze
    { spellID = 261428, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hangman's Noose
    { spellID = 257650, unit = "target", caster = "all", filter = "BUFF" },     -- Boiling Rage

    --[[ Dread Captain Lockwood ]]--
    { spellID = 273470, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gut Shot

    --[[ Hadal Darkfathom ]]--

    --[[ Viq'Goth ]]--
    { spellID = 275014, unit = "player", caster = "all", filter = "DEBUFF" }, -- Putrid Waters

    --[[ Trash ]]--
    { spellID = 257168, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cursed Slash
    { spellID = 273930, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hindering Cut
    { spellID = 257069, unit = "player", caster = "all", filter = "DEBUFF" },   -- Watertight Shell
    { spellID = 272874, unit = "player", caster = "all", filter = "DEBUFF" },   -- Trample
    { spellID = 272588, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rotting Wounds
    { spellID = 272421, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sighted Artillery
    { spellID = 275836, unit = "player", caster = "all", filter = "DEBUFF" },   -- Stinging Venom
    { spellID = 257292, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heavy Slash
    { spellID = 272834, unit = "player", caster = "all", filter = "DEBUFF" },   -- Viscous Slobber
    { spellID = 257169, unit = "player", caster = "all", filter = "DEBUFF" },   -- Terrifying Roar
    { spellID = 277965, unit = "target", caster = "all", filter = "DEBUFF" },   -- Heavy Ordnance
    { spellID = 272571, unit = "player", caster = "all", filter = "DEBUFF" },   -- Choking Waters
    { spellID = 256616, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tooth Breaker

    { spellID = 256957, unit = "target", caster = "all", filter = "BUFF" },     -- Watertight Shell
    { spellID = 275826, unit = "target", caster = "all", filter = "BUFF" },     -- Bolstering Shout
    { spellID = 272888, unit = "target", caster = "all", filter = "BUFF" },     -- Ferocity
    { spellID = 257170, unit = "target", caster = "all", filter = "BUFF" },     -- Savage Tempest
    { spellID = 275835, unit = "target", caster = "all", filter = "BUFF" },     -- Stinging Venom Coating
    { spellID = 256867, unit = "target", caster = "all", filter = "BUFF" },     -- Heavy Hitter
    { spellID = 257042, unit = "target", caster = "all", filter = "BUFF" },     -- Feral Bond
    { spellID = 272471, unit = "target", caster = "all", filter = "BUFF" },     -- Evasive
    { spellID = 270624, unit = "target", caster = "all", filter = "BUFF" },     -- Crushing Embrace
}

-- The Underrot
Instances[1841] = {
    sabed = false,

    --[[ Elder Leaxa ]]--
    { spellID = 260685, unit = "player", caster = "all", filter = "DEBUFF" },   -- Taint of G'huun

    --[[ Cragmaw the Infested ]]--

    --[[Sporecaller Zancha ]]--
    { spellID = 259718, unit = "player", caster = "all", filter = "DEBUFF" },   -- Upheaval
    { spellID = 259830, unit = "target", caster = "all", filter = "BUFF" },     -- Boundless Rot

    --[[ Unbound Abomination ]]--
    { spellID = 269301, unit = "player", caster = "all", filter = "DEBUFF" },   -- Putrid Blood"
    { spellID = 269406, unit = "target", caster = "all", filter = "DEBUFF" },   -- Purge Corruption

    --[[ Trash ]]--
    { spellID = 265377, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hooked Snare
    { spellID = 265468, unit = "player", caster = "all", filter = "DEBUFF" },   -- Withering Curse
    { spellID = 272180, unit = "player", caster = "all", filter = "DEBUFF" },   -- Death Bolt
    { spellID = 278961, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decaying Mind
    { spellID = 265019, unit = "player", caster = "all", filter = "DEBUFF" },   -- Savage Cleave
    { spellID = 272609, unit = "player", caster = "all", filter = "DEBUFF" },   -- Maddening Gaze
    { spellID = 265568, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dark Omen
    { spellID = 266107, unit = "player", caster = "all", filter = "DEBUFF" },   -- Thirst For Blood
    { spellID = 266265, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wicked Assault
    { spellID = 273226, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decaying Spores
    { spellID = 278789, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wave of Decay
    { spellID = 269838, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vile Expulsion
    { spellID = 261498, unit = "player", caster = "all", filter = "DEBUFF" },   -- Creeping Rot
    { spellID = 260455, unit = "player", caster = "all", filter = "DEBUFF" },   -- Serrated Fangs
    { spellID = 265533, unit = "target", caster = "all", filter = "DEBUFF" },   -- Blood Maw

    { spellID = 265081, unit = "target", caster = "all", filter = "BUFF" },     -- Warcry
    { spellID = 265091, unit = "target", caster = "all", filter = "BUFF" },     -- Gift of G'huun
    { spellID = 266201, unit = "target", caster = "all", filter = "BUFF" },     -- Bone Shield
    { spellID = 266209, unit = "target", caster = "all", filter = "BUFF" },     -- Wicked Frenzy
    { spellID = 269185, unit = "target", caster = "all", filter = "BUFF" },     -- Blood Barrier
}

-- Waycrest Manor
Instances[1862] = {
    saved = true,
    
    --[[ Heartsbane Triad ]]--
        --[[ Sister Briar ]]--
        { spellID = 260741, unit = "player", caster = "all", filter = "DEBUFF" },   -- Jagged Nettles
        { spellID = 268122, unit = "target", caster = "all", filter = "BUFF" },     -- Aura of Thorns
        { spellID = 261265, unit = "target", caster = "all", filter = "BUFF" },     -- Ironbark Shield

        --[[ Sister Malady ]]--
        { spellID = 260703, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Runic Mark
        { spellID = 268088, unit = "target", caster = "all", filter = "BUFF" },     -- Aura of Dread
        { spellID = 261266, unit = "target", caster = "all", filter = "BUFF" },     -- Runic Ward

        --[[ Sister Solena ]]--
        { spellID = 260900, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soul Manipulation
        { spellID = 260926, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soul Manipulation

        { spellID = 260852, unit = "target", caster = "all", filter = "BUFF" },     -- Claim the Iris
        { spellID = 260805, unit = "target", caster = "all", filter = "BUFF" },     -- Focusing Iris
        { spellID = 268077, unit = "target", caster = "all", filter = "BUFF" },     -- Aura of Apathy
        { spellID = 261264, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Armor
        { spellID = 260923, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Manipulation
    
    --[[ Soulbound Goliath ]]--
    { spellID = 267907, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soul Thorns
    { spellID = 260512, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Harvest
    { spellID = 260541, unit = "target", caster = "all", filter = "BUFF" },     -- Burning Brush
    
    --[[ Raal the Gluttonous ]]--
    { spellID = 265005, unit = "target", caster = "all", filter = "BUFF" },     -- Consumed Servant
    
    --[[ Lord and Lady Waycrest ]]--
        --[[ Lord Waycrest ]]--
        { spellID = 261438, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wasting Strike
        { spellID = 261440, unit = "player", caster = "all", filter = "DEBUFF" },   -- Virulent Pathogen
        { spellID = 261447, unit = "target", caster = "all", filter = "BUFF" },     -- Putrid Vitality
    
        --[[ Lady Waycrest ]]--
        { spellID = 271590, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Armor
        { spellID = 261446, unit = "target", caster = "all", filter = "BUFF" },     -- Vitality Transfer
        { spellID = 268306, unit = "target", caster = "all", filter = "BUFF" },     -- Discordant Cadenza
    
    --[[ Gorak Tul ]]--
    
    --[[ Trash ]]--
    { spellID = 264105, unit = "player", caster = "all", filter = "DEBUFF" },   -- Runic Mark
    { spellID = 264050, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infected Thorn
    { spellID = 265881, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decaying Touch
    { spellID = 266035, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bone Splinter
    { spellID = 263905, unit = "player", caster = "all", filter = "DEBUFF" },   -- Marking Cleave
    { spellID = 271178, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ravaging Leap
    { spellID = 264150, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shatter
    { spellID = 264556, unit = "target", caster = "all", filter = "DEBUFF" },   -- Tearing Strike
    { spellID = 265880, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dread Mark
    { spellID = 265882, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lingering Dread
    { spellID = 263891, unit = "player", caster = "all", filter = "DEBUFF" },   -- Grasping Thorns
    { spellID = 268202, unit = "player", caster = "all", filter = "DEBUFF" },   -- Death Lens
    { spellID = 265407, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dinner Bell
    { spellID = 264390, unit = "player", caster = "all", filter = "DEBUFF" },   -- Spellbind
    { spellID = 264378, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fragment Soul
    { spellID = 266036, unit = "player", caster = "all", filter = "DEBUFF" },   -- Drain Essence
    { spellID = 265761, unit = "player", caster = "all", filter = "DEBUFF" },   -- Thorned Barrage
    { spellID = 265352, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toad Blight
    { spellID = 273294, unit = "target", caster = "all", filter = "DEBUFF" },   -- Wildfire
    { spellID = 264153, unit = "player", caster = "all", filter = "DEBUFF" },   -- Spit
    { spellID = 278456, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infest
    { spellID = 278444, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infest
    { spellID = 257260, unit = "target", caster = "all", filter = "BUFF" },     -- Enrage
    { spellID = 265368, unit = "target", caster = "all", filter = "BUFF" },     -- Spirited Defense
    { spellID = 264396, unit = "target", caster = "all", filter = "BUFF" },     -- Spectral Talisman
    { spellID = 264387, unit = "target", caster = "all", filter = "BUFF" },     -- Consumed Soul Fragment
    { spellID = 278567, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Fetish
    { spellID = 264027, unit = "target", caster = "all", filter = "BUFF" },     -- Warding Candles
    { spellID = 265760, unit = "target", caster = "all", filter = "BUFF" },     -- Thorned Barrage
    { spellID = 278431, unit = "target", caster = "all", filter = "BUFF" },     -- Parasitic
    { spellID = 266008, unit = "target", caster = "all", filter = "BUFF" },     -- Infected
    { spellID = 264110, unit = "target", caster = "all", filter = "BUFF" },     -- Darkened Blade
    { spellID = 272668, unit = "target", caster = "all", filter = "BUFF" },     -- Burning Fists
    { spellID = 278551, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Fetish
}

-- Shrine of the Storm
Instances[1864] = {
    sabed = true,

    --[[ Aqu'sirr ]]--
    { spellID = 264560, unit = "player", caster = "all", filter = "DEBUFF" },   -- Chocking Brine
    { spellID = 264526, unit = "player", caster = "all", filter = "DEBUFF" },   -- Grasp from the Depths
    { spellID = 264144, unit = "player", caster = "all", filter = "DEBUFF" },   -- Undertow
    { spellID = 264101, unit = "target", caster = "all", filter = "BUFF" },     -- Surging Rush
    { spellID = 264903, unit = "target", caster = "all", filter = "BUFF" },     -- Erupting Waters
    
    --[[ Tidesage Council ]]--

        --[[ Brother Ironhull ]]--
        { spellID = 267818, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sclicing Blast
        { spellID = 267899, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hindering Cleave
        { spellID = 267904, unit = "all"   , caster = "all", filter = "BUFF" },     -- Reinforcing Ward
        { spellID = 267901, unit = "target", caster = "all", filter = "BUFF" },     -- Blessing of Ironsides

        --[[ Galecaller Faye ]]--
        { spellID = 267830, unit = "target", caster = "all", filter = "BUFF" },     -- Blessing of the Tempest
    
    --[[ Lord Stormsong ]]--
    { spellID = 268896, unit = "player", caster = "all", filter = "DEBUFF" },   -- Mind Rend
    { spellID = 269131, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ancient Mindbender
    
    --[[ Vol'zith the Whisperer ]]--
    { spellID = 267037, unit = "player", caster = "all", filter = "DEBUFF" },   -- Whispers of Power
    { spellID = 267444, unit = "target", caster = "all", filter = "BUFF" },     -- Grasp of the Sunken City
    { spellID = 267299, unit = "target", caster = "all", filter = "BUFF" },     -- Call the Abyss

        --[[ Awoken Void ]]--
        { spellID = 269104, unit = "player", caster = "all", filter = "DEBUFF" },   -- Explosive Void

    --[[ Trash ]]--
    { spellID = 274633, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sundeing Blow
    { spellID = 276268, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heaving Blow
    { spellID = 268233, unit = "player", caster = "all", filter = "DEBUFF" },   -- Electrifying Shock
    { spellID = 268309, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unending Darkness
    { spellID = 268322, unit = "player", caster = "all", filter = "DEBUFF" },   -- Touch of the Drowned
    { spellID = 268317, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rip Mind
    { spellID = 267956, unit = "player", caster = "all", filter = "DEBUFF" },   -- Zap
    { spellID = 274720, unit = "player", caster = "all", filter = "DEBUFF" },   -- Abyssal Strike
    { spellID = 268315, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lash
    { spellID = 276297, unit = "player", caster = "all", filter = "DEBUFF" },   -- Void Seed
    { spellID = 268214, unit = "player", caster = "all", filter = "DEBUFF" },   -- Carve Flesh
    { spellID = 268027, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rising Tides
    { spellID = 267836, unit = "target", caster = "all", filter = "DEBUFF" },   -- Blowback
    { spellID = 265366, unit = "player", caster = "all", filter = "DEBUFF" },   -- Undertow

    { spellID = 268212, unit = "all"   , caster = "all", filter = "BUFF" },     -- Minor Reinforcing Ward
    { spellID = 274631, unit = "target", caster = "all", filter = "BUFF" },     -- Lesser Blessing of Ironsides
    { spellID = 276265, unit = "target", caster = "all", filter = "BUFF" },     -- Swiftness
    { spellID = 276266, unit = "target", caster = "all", filter = "BUFF" },     -- Spirit's Swiftness
    { spellID = 267548, unit = "target", caster = "all", filter = "BUFF" },     -- Leviathan's Wake
    { spellID = 274210, unit = "target", caster = "all", filter = "BUFF" },     -- Reanimated Bones
    { spellID = 268187, unit = "target", caster = "all", filter = "BUFF" },     -- Gale Winds
    { spellID = 267981, unit = "target", caster = "all", filter = "BUFF" },     -- Protective Aura
    { spellID = 267977, unit = "target", caster = "all", filter = "BUFF" },     -- Tidal Surge
    { spellID = 268239, unit = "target", caster = "all", filter = "BUFF" },     -- Shipbreaker Storm
    { spellID = 268183, unit = "target", caster = "all", filter = "BUFF" },     -- Minor Swiftness Ward
    { spellID = 267890, unit = "target", caster = "all", filter = "BUFF" },     -- Swiftness Ward
    { spellID = 268186, unit = "target", caster = "all", filter = "BUFF" },     -- Reinforcing Ward
}

-- Temple of Sethraliss
Instances[1877] = {
    saved = true,

    --[[ Adderis and Aspix ]]--
    { spellID = 263371, unit = "player", caster = "all", filter = "DEBUFF" },   -- Conduction

        --[[ Aspix ]]--
        { spellID = 263778, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gale Force
        { spellID = 273411, unit = "target", caster = "all", filter = "BUFF" },     -- Lightning Shield
        { spellID = 263246, unit = "target", caster = "all", filter = "BUFF" },     -- Lightning Shield
    
    --[[ Merektha ]]--
    { spellID = 263927, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tocix Pool
    { spellID = 263958, unit = "player", caster = "all", filter = "DEBUFF" },   -- A Knot of Snakes
    { spellID = 269970, unit = "player", caster = "all", filter = "DEBUFF" }, -- Blinding Sand

    --[[ Galvazzt ]]--
    { spellID = 266923, unit = "player", caster = "all", filter = "DEBUFF" },   -- Galvanize
    { spellID = 266511, unit = "target", caster = "all", filter = "BUFF" },     -- Capacitance

    --[[ Avatar of Sethraliss ]]--
    { spellID = 269670, unit = "player", caster = "all", filter = "DEBUFF" },   -- Empowerment
    { spellID = 269686, unit = "player", caster = "all", filter = "DEBUFF" },   -- Plague
    { spellID = 268024, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pulse
    
    --[[ Trash ]]--
    { spellID = 272699, unit = "player", caster = "all", filter = "DEBUFF" },   -- Venomous Spit
    { spellID = 272657, unit = "player", caster = "all", filter = "DEBUFF" },   -- Noxious Breath
    { spellID = 268007, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heart Attack
    { spellID = 272655, unit = "player", caster = "all", filter = "DEBUFF" },   -- Scouring Sand
    { spellID = 267027, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cytotoxin
    { spellID = 280032, unit = "player", caster = "all", filter = "DEBUFF" },   -- Neurotoxin
    { spellID = 1604  , unit = "player", caster = "all", filter = "DEBUFF" }, -- Dazed
    { spellID = 268008, unit = "player", caster = "all", filter = "DEBUFF" }, -- Snake Charm
    { spellID = 268013, unit = "player", caster = "all", filter = "DEBUFF" }, -- Flame Shock
    { spellID = 272696, unit = "player", caster = "all", filter = "DEBUFF" }, -- Lightning in a Bottle
    { spellID = 260792, unit = "target", caster = "all", filter = "DEBUFF" }, -- Dust Cloud
    { spellID = 268993, unit = "player", caster = "all", filter = "DEBUFF" }, -- Cheap Shot
    { spellID = 273234, unit = "target", caster = "all", filter = "DEBUFF" }, -- Loose Sparks
    { spellID = 273563, unit = "player", caster = "all", filter = "DEBUFF" }, -- Neurotoxin
    { spellID = 265755, unit = "target", caster = "all", filter = "DEBUFF" }, -- Reclaimed Orb

    { spellID = 269129, unit = "target", caster = "all", filter = "BUFF" },     -- Accumulated Charge
    { spellID = 258908, unit = "target", caster = "all", filter = "BUFF" }, -- Blade Flurry
    { spellID = 265912, unit = "target", caster = "all", filter = "BUFF" }, -- Accumulate Charge
    { spellID = 272659, unit = "target", caster = "all", filter = "BUFF" }, -- Electrified Scales
    { spellID = 273956, unit = "target", caster = "all", filter = "BUFF" }, -- Alchemical Tolerance
    { spellID = 269896, unit = "target", caster = "all", filter = "BUFF" }, -- Embryonic Vigor
    { spellID = 267237, unit = "target", caster = "all", filter = "BUFF" }, -- Drain
    { spellID = 267584, unit = "target", caster = "all", filter = "BUFF" }, -- Spawn
    { spellID = 273272, unit = "target", caster = "all", filter = "BUFF" }, -- Polarized Field
    { spellID = 274609, unit = "target", caster = "all", filter = "BUFF" }, -- Bind
    { spellID = 265338, unit = "target", caster = "all", filter = "BUFF" }, -- Spawn
    { spellID = 273641, unit = "target", caster = "all", filter = "BUFF" }, -- Stealth
}
