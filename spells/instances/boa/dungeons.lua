local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Battle for Azeroth Dungeons
----------------------------------------------------------------
-- The Motherlode
Instances[1594] = {
    --[[ Coin-Operated Crowd Pummeler ]]--
    
    --[[ Azerokk ]]--
    
    --[[ Rixxa Fluxflame ]]--
    { spellID = 260103, unit = "player", caster = "all", filter = "DEBUFF" },   -- Propeliant Blast
    { spellID = 259533, unit = "player", caster = "all", filter = "DEBUFF" },   -- Azerite Catalyst
    { spellID = 259853, unit = "player", caster = "all", filter = "DEBUFF" },   -- Chemical Burn
    
    --[[ Mogul Razdunk ]]--
    { spellID = 262513, unit = "player", caster = "all", filter = "DEBUFF" },   -- Azerite Heartseeker
    { spellID = 260829, unit = "player", caster = "all", filter = "DEBUFF" },   -- Homing Missile

    --[[ Trash ]]--
    { spellID = 268846, unit = "player", caster = "all", filter = "DEBUFF" },   -- Echo Blade
    { spellID = 263074, unit = "player", caster = "all", filter = "DEBUFF" },   -- Festering Bite
    { spellID = 262794, unit = "player", caster = "all", filter = "DEBUFF" },   -- Energy Lash

    { spellID = 262947, unit = "target", caster = "all", filter = "BUFF" },     -- Azerite Injection
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
    --[[ Vol'kaal ]]--
    { spellID = 250585, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxic Pool
    { spellID = 250372, unit = "player", caster = "all", filter = "DEBUFF" },   -- Lingering Nausean

    --[[ Priestess Alun'za ]]--
    { spellID = 255582, unit = "player", caster = "all", filter = "DEBUFF" },   -- Molten Gold
    { spellID = 255836, unit = "player", caster = "all", filter = "DEBUFF" },   -- Transfusion
    { spellID = 255558, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tainted Blodd

    --[[ Rezan ]]--

    --[[ Yazma ]]--
    { spellID = 256577, unit = "player", caster = "all", filter = "DEBUFF" },   -- Soulfeast

    --[[ Thrash ]]--
}

-- Tol Dagor
Instances[1771] = {
    --[[ Overseer Korgus ]]--
    
    --[[ The Sand Queen ]]--
    
    --[[ Jes Howlis ]]--
    
    --[[ Knight Captain Valyri ]]--
    { spellID = 257028, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fuselighter
    
    --[[ Trash ]]--
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
    --[[ Sporecaller Zancha ]]--
    
    --[[ Cragmaw the Infested ]]--
    
    --[[ Elder Leaxa ]]--
    
    --[[ Unbound Abomination ]]--

    --[[ Trash ]]--
    { spellID = 265535, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blood Maw
    { spellID = 265377, unit = "player", caster = "all", filter = "DEBUFF" },   -- Hooked Snare
    { spellID = 265019, unit = "player", caster = "all", filter = "DEBUFF" },   -- Savage Cleave
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
    
    --[[ Tidesage Council ]]--
    { spellID = 267818, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sclicing Blast
    { spellID = 267904, unit = "player", caster = "all", filter = "BUFF" },     -- Reinforcing Ward
    { spellID = 267904, unit = "target", caster = "all", filter = "BUFF" },     -- Reinforcing Ward
    
    --[[ Lord Stormsong ]]--
    
    --[[ Vol'zith the Whisperer ]]--
    { spellID = 267037, unit = "player", caster = "all", filter = "DEBUFF" },   -- Whispers of Power

    --[[ Trash ]]--
    { spellID = 274633, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sundeing Blow
    { spellID = 268233, unit = "player", caster = "all", filter = "DEBUFF" },   -- Electrifying Shock
    { spellID = 268309, unit = "player", caster = "all", filter = "DEBUFF" },   -- Unending Darkness
    { spellID = 268322, unit = "player", caster = "all", filter = "DEBUFF" },   -- Touch of the Drowned
    { spellID = 268317, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rip Mind
    { spellID = 267956, unit = "player", caster = "all", filter = "DEBUFF" },   -- Zap
    { spellID = 274720, unit = "player", caster = "all", filter = "DEBUFF" },   -- Abyssal Strike

    { spellID = 268212, unit = "all", caster = "all", filter = "BUFF" },        -- Minor Reinforcing Ward
}

-- Temple of Sethraliss
Instances[1877] = {
    --[[ Adderis and Aspix ]]--
    
    --[[ Merektha ]]--
    { spellID = 263927, unit = "player", caster = "all", filter = "DEBUFF" },   -- Tocix Pool

    --[[ Galvazzt ]]--
    { spellID = 266923, unit = "player", caster = "all", filter = "DEBUFF" },   -- Galvanize

    --[[ Avatar of Sethraliss ]]--
    { spellID = 269670, unit = "player", caster = "all", filter = "DEBUFF" },   -- Empowerment
    { spellID = 269686, unit = "player", caster = "all", filter = "DEBUFF" },   -- Plague
    { spellID = 268024, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pulse
    
    --[[ Trash ]]--
    { spellID = 272699, unit = "player", caster = "all", filter = "DEBUFF" },   -- Venomous Spit
    { spellID = 272657, unit = "player", caster = "all", filter = "DEBUFF" },   -- Noxious Breath
    { spellID = 268007, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heart Attack
    { spellID = 272655, unit = "player", caster = "all", filter = "DEBUFF" },   -- Scouring Sand
}