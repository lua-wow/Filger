local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Battle for Azeroth Dungeons
----------------------------------------------------------------
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
    --[[ Skycap'n Kragg ]]--
    { spellID = 258323, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infected Wound
    { spellID = 257274, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vile Coating

    --[[ Council o' Captains ]]--
    { spellID = 258875, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blackout Barrel
    { spellID = 267525, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cutting Surge
    { spellID = 257821, unit = "target", caster = "all", filter = "BUFF" },     -- Under One Banner
    
    --[[ Ring of Booty ]]--
    
    --[[ Harlan Sweete ]]--
    
    --[[ Trash ]]--
    { spellID = 257908, unit = "player", caster = "all", filter = "DEBUFF" },   -- Oiled Blade
    { spellID = 274389, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rat Traps
    { spellID = 274555, unit = "player", caster = "all", filter = "DEBUFF" },   -- Scabrous Bite
    { spellID = 274507, unit = "player", caster = "all", filter = "DEBUFF" },   -- Slippery Suds
    { spellID = 257747, unit = "player", caster = "all", filter = "DEBUFF" },   -- Earth Shaker
    { spellID = 257437, unit = "player", caster = "all", filter = "DEBUFF" },   -- Poisoning Strike
    { spellID = 257775, unit = "player", caster = "all", filter = "DEBUFF" },   -- Plague Step
}

-- Kings Rest
Instances[1762] = {
    --[[ The Golden Serpent ]]--
    { spellID = 265773, unit = "player", caster = "all", filter = "DEBUFF" },   -- Spit Gold

    --[[ The Council of Tribes ]]--

    --[[ Mchimba the Embalmer ]]--
    { spellID = 267618, unit = "player", caster = "all", filter = "DEBUFF" },   -- Drain Fluids
    { spellID = 267874, unit = "player", caster = "all", filter = "DEBUFF" },   -- Burning Ground

    --[[ Dazar, The First King ]]--

    --[[ Thrash ]]--
    { spellID = 270487, unit = "player", caster = "all", filter = "DEBUFF" },   -- Severing Blade
    { spellID = 271640, unit = "player", caster = "all", filter = "DEBUFF" },   -- Dark Revelation
    { spellID = 272388, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadow Barrage
}

-- Atal'Dazar
Instances[1763] = {
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
    { spellID = 255421, unit = "target", caster = "all", filter = "BUFF" },     -- Devour

    --[[ Yazma ]]--
    { spellID = 256577, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soulfeast
    
    --[[ Trash ]]--
    { spellID = 260666, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion"
    { spellID = 260668, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion"
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju"
    { spellID = 277072, unit = "player", caster = "all", filter = "DEBUFF" },   -- Corrupted Gold"
    { spellID = 252687, unit = "player", caster = "all", filter = "DEBUFF" },   -- Venomfang Strike"
    { spellID = 252692, unit = "player", caster = "all", filter = "DEBUFF" },   -- Waylaying Jab"
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju"
    { spellID = 257483, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pile of Bones"
    { spellID = 258723, unit = "player", caster = "all", filter = "DEBUFF" },   -- Grotesque Pool"
    { spellID = 250036, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shadowy Remains"
    { spellID = 250585, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxic Pool"
    { spellID = 257692, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tiki Blaze"
    { spellID = 252781, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Hex"
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju"
    { spellID = 253562, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wildfire"
    { spellID = 255814, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rending Maul"
    { spellID = 255620, unit = "player", caster = "all", filter = "DEBUFF" },   -- Festering Eruption"
    { spellID = 258653, unit = "target", caster = "all", filter = "DEBUFF" },   -- Bulwark of Juju"
    { spellID = 256960, unit = "target", caster = "all", filter = "DEBUFF" },   -- Rotting Decay"

    { spellID = 253721, unit = "target", caster = "all", filter = "BUFF" },     -- Bulwark of Juju"
    { spellID = 255824, unit = "target", caster = "all", filter = "BUFF" },     -- Fanatic's Rage"
    { spellID = 250192, unit = "target", caster = "all", filter = "BUFF" },     -- Bad Voodoo"
}

-- Tol Dagor
Instances[1771] = {

    --[[ The Sand Queen ]]--
    { spellID = 259975, unit = "target", caster = "all", filter = "BUFF" },     -- Enrage
    { spellID = 257495, unit = "target", caster = "all", filter = "BUFF" },     -- Sandstorm
    { spellID = 257608, unit = "target", caster = "all", filter = "BUFF" },     -- Upheaval
    { spellID = 260016, unit = "player", caster = "all", filter = "DEBUFF" },   -- Itchy Bite

    --[[ Jes Howlis ]]--
    { spellID = 257793, unit = "target", caster = "all", filter = "DEBUFF" },   -- Smoke Powder
    { spellID = 257777, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crippling Shiv

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
}

-- Siege of Boralus
Instances[1822] = {
    --[[ Chopper Redhook ]]--
    --[[ Sergeant Bainbridge ]] --
    { spellID = 260954, unit = "player", caster = "all", filter = "DEBUFF" },   -- Iron Gaze

    --[[ Hadal Darkfathom ]]--
    --[[ Viq'Goth ]]--
    --[[ Dread Captain Lockwood ]]--
    { spellID = 273470, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gut Shot

    --[[ Trash ]]--
    { spellID = 257168, unit = "player", caster = "all", filter = "DEBUFF" },   -- Cursed Slash
    { spellID = 273930, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hindering Cut
}

-- The Underrot
Instances[1841] = {
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
    { spellID = 265533, unit = "target", caster = "all", filter = "DEBUFF" },   -- Blood Maw
    { spellID = 266107, unit = "player", caster = "all", filter = "DEBUFF" },   -- Thirst For Blood
    { spellID = 266265, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wicked Assault
    { spellID = 273226, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decaying Spores
    { spellID = 278789, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wave of Decay
    { spellID = 269838, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vile Expulsion
    { spellID = 261498, unit = "player", caster = "all", filter = "DEBUFF" },   -- Creeping Rot

    { spellID = 265081, unit = "target", caster = "all", filter = "BUFF" },     -- Warcry
    { spellID = 265091, unit = "target", caster = "all", filter = "BUFF" },     -- Gift of G'huun
    { spellID = 266201, unit = "target", caster = "all", filter = "BUFF" },     -- Bone Shield
    { spellID = 266209, unit = "target", caster = "all", filter = "BUFF" },     -- Wicked Frenzy
    { spellID = 269185, unit = "target", caster = "all", filter = "BUFF" },     -- Blood Barrier
}

-- Waycrest Manor
Instances[1862] = {
    --[[ Heartsbane Triad ]]--
    { spellID = 260703, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unstable Runic Mark
    { spellID = 55078 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Blood Plague
    
    --[[ Soulbound Goliath ]]--
    { spellID = 267907, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soul Thorns
    { spellID = 260512, unit = "target", caster = "all", filter = "BUFF" },     -- Soul Harvest
    
    --[[ Raal the Gluttonous ]]--
    
    --[[ Lord and Lady Waycrest ]]--
    
    --[[ Gorak Tul ]]--
    
    --[[ Trash ]]--
    { spellID = 264105, unit = "player", caster = "all", filter = "DEBUFF" },   -- Runic Mark
    { spellID = 264050, unit = "player", caster = "all", filter = "DEBUFF" },   -- Infected Thorn
    { spellID = 265881, unit = "player", caster = "all", filter = "DEBUFF" },   -- Decaying Touch
    { spellID = 266035, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bone Splinter
}

-- Shrine of the Storm
Instances[1864] = {
    --[[ Aqu'sirr ]]--
    { spellID = 264560, unit = "player", caster = "all", filter = "DEBUFF" },   -- Chocking Brine
    { spellID = 264526, unit = "player", caster = "all", filter = "DEBUFF" },   -- Grasp from the Depths
    
    --[[ Tidesage Council ]]--
    { spellID = 267818, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sclicing Blast
    { spellID = 267904, unit = "player", caster = "all", filter = "BUFF" },     -- Reinforcing Ward
    { spellID = 267904, unit = "target", caster = "all", filter = "BUFF" },     -- Reinforcing Ward
    
    --[[ Lord Stormsong ]]--
    
    --[[ Vol'zith the Whisperer ]]--
    { spellID = 267037, unit = "player", caster = "all", filter = "DEBUFF" },   -- Whispers of Power

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

    { spellID = 268212, unit = "player", caster = "all", filter = "BUFF" },     -- Minor Reinforcing Ward
    { spellID = 268212, unit = "target", caster = "all", filter = "BUFF" },     -- Minor Reinforcing Ward
    { spellID = 274631, unit = "target", caster = "all", filter = "BUFF" },     -- Lesser Blessing of Ironsides
    { spellID = 276265, unit = "target", caster = "all", filter = "BUFF" },     -- Swiftness
    { spellID = 276266, unit = "target", caster = "all", filter = "BUFF" },     -- Spirit's Swiftness

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