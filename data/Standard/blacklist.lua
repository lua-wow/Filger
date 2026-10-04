local _, ns = ...

local AddBlacklist = ns.data.AddBlacklist

--------------------------------------------------
-- Retail
--------------------------------------------------
do
    local data = {
        -- Classes
        -- DEMONHUNTER
        [452550] = true, -- Monster Rising
        [453314] = true, -- Enduring Torment
        [1214887] = true, -- Cycle of Hatred

        -- EVOKER
        [369459] = true, -- Source of Magic
        [381753] = true, -- Blessing of the Bronze
        [372014] = true, -- Visage

        -- DRUID
        [400734] = true, -- After the Wildfire

        -- MAGE
        [1217242] = true, -- Enlightened

        -- MONK
        [383733] = true, -- Training of Niuzao
        [450552] = true, -- Jade Walk
        [450572] = true, -- Flow of Chi
        [450574] = true, -- Flow of Chi
        [443574] = true, -- Ox Stance
        [443575] = true, -- Tiger Stance
        [166646] = true, -- Windwalking
        [129914] = true, -- Combat Wisdom
        [450380] = true, -- Chi Wave

        -- PRIEST
        [21562] = true,   -- Power Word: Fortitude

        -- SHAMAN
        [462854] = true, -- Skyfury

        -- WARRIOR
        [386196] = true, -- Berserker Stance

        -- Mount
        [404464] = true, -- Flight Style: Skyriding
        [404468] = true, -- Flight Style: Steady
        [456820] = true, -- Ride Along

        -- Mythic+
        [206150] = true, -- Challenger's Might

        -- Items
        [447962] = true, -- Stance - Surekian Flourish
        [447978] = true, -- Stance - Surekian Decimation
        [448036] = true, -- Stance - Surekian Barrage
        [448433] = true, -- Surekian Grace
        [450696] = true, -- "The 50 Verses of Radiance" (Tome of Light's Devotion)
        [450699] = true, -- "The 50 Verses of Radiance" (Tome of Light's Devotion)
        [450706] = false, -- Inner Radiance (Tome of Light's Devotion)
        [450720] = true, -- Inner Radiance (Tome of Light's Devotion)
        [452226] = true, -- Spiderling (Ara-Kara Sacbrood)
        [457925] = true, -- Venomous Potential (Seal of the Poisoned Pact)
        [451369] = true, -- Empowering Darkness

        -- Costumes
        [452533] = true, -- Magical Mischief

        -- Warband
        [430191] = true, -- Warband Mentored Leveling

        -- Professions
        [442981] = true, -- Weaver's Tutelage
        [462810] = true, -- Weaver's Prodigy

        -- Factions
        [442983] = true, -- Vizier's Savvy
        [462806] = true, -- Vizier's Supremacy
        [440645] = true, -- Fire Flies
        [443248] = true, -- Azj-Kahet Pheromones
        [462821] = true, -- General's Bulwark

        -- Consumables
        ["Well Fed"] = true,
        ["Hearty Well Fed"] = true,
        [454188] = true, -- Hearty Well Fed
        [462180] = true, -- Hearty Well Fed
        [462181] = true, -- Hearty Well Fed
        [462182] = true, -- Hearty Well Fed
        [462183] = true, -- Hearty Well Fed
        [462184] = true, -- Hearty Well Fed
        [462185] = true, -- Hearty Well Fed
        [462186] = true, -- Hearty Well Fed
        [462187] = true, -- Hearty Well Fed
        [462188] = true, -- Hearty Well Fed
        [462189] = true, -- Hearty Well Fed
        [462190] = true, -- Hearty Well Fed
        [462191] = true, -- Hearty Well Fed
        [462192] = true, -- Hearty Well Fed
        [462193] = true, -- Hearty Well Fed
        [462194] = true, -- Hearty Well Fed
        [462195] = true, -- Hearty Well Fed
        [462196] = true, -- Hearty Well Fed
        [462197] = true, -- Hearty Well Fed
        [462198] = true, -- Hearty Well Fed
        [462199] = true, -- Hearty Well Fed
        [462200] = true, -- Hearty Well Fed
        [462201] = true, -- Hearty Well Fed
        [462202] = true, -- Hearty Well Fed
        [462203] = true, -- Hearty Well Fed
        [462204] = true, -- Hearty Well Fed
        [462205] = true, -- Hearty Well Fed
        [462206] = true, -- Hearty Well Fed
        [462207] = true, -- Hearty Well Fed
        [462208] = true, -- Hearty Well Fed
        [462209] = true, -- Hearty Well Fed
        [462210] = true, -- Hearty Well Fed

        [431971] = true, -- Flask of Tempered Aggression
        [431972] = true, -- Flask of Tempered Swiftness
        [431973] = true, -- Flask of Tempered Versatility
        [431974] = true, -- Flask of Tempered Mastery

        --------------------------------------------------
        -- Patch 11.0.0
        --------------------------------------------------
        -- Delves
        [423852] = true, -- Dormouse Ecila
        [448868] = true, -- Lucky Cursed Potion
        [459058] = true, -- Miniature
        [459059] = true, -- Massive
        [459254] = true, -- Loader Signal

        -- Professions
        [457674] = true, -- Duskthread Lining
        [457666] = true, -- Dawnthread Lining

        --------------------------------------------------
        -- Patch 11.0.2
        --------------------------------------------------
        -- World Buffs
        [471521] = true, -- Sign of the Explorer

        --------------------------------------------------
        -- Patch 11.0.5
        --------------------------------------------------
        -- World Buffs
        [452307] = true, -- Sign of the Past
        [455020] = true, -- WoW's Anniversary

        -- Events
        [455050] = true, -- Blessing of the Brozen Drgonflight

        -- Items
        [465642] = true, -- Blizzard Bling

        --------------------------------------------------
        -- Patch 11.0.7
        --------------------------------------------------
        -- Items
        [1215495] = true, -- Cyrce's Circlet

        --------------------------------------------------
        -- Patch 11.1.5
        --------------------------------------------------
        -- World Buffs
        [1214848] = true, -- Winds of Mysterious Fortune
        [1227124] = true, -- Sacred Flame's Ward

        -- Horric Visions
        [472265] = true, -- Vision Hunter
        [472266] = true, -- Vision Hunter
        [472267] = true, -- Vision Hunter
        [472261] = true, -- Experimental Destabilization
        [472263] = true, -- Experimental Destabilization
        [472264] = true, -- Experimental Destabilization
        [1215082] = true, -- Experimental Destabilization
        [471497] = true, -- Singular Sanitation Expertise
        [472160] = true, -- Singular Sanitation Expertise
        [472152] = true, -- Singular Sanitation Expertise
        [472238] = true, -- Clear Sight
        [472248] = true, -- Clear Sight
        [472246] = true, -- Clear Sight
        [472241] = true, -- Elite Extermination
        [1215782] = true, -- Elite Extermination
        [1215783] = true, -- Elite Extermination
        [471317] = true, -- Steeled Mind
        [471318] = true, -- Steeled Mind
        [471320] = true, -- Steeled Mind
        [471321] = true, -- Steeled Mind
        [471322] = true, -- Steeled Mind
        [1216153] = true, -- Steeled Mind
        [1221899] = true, -- Tattered Wold Rider Gear

        --------------------------------------------------
        -- Patch 11.1.7
        --------------------------------------------------
        -- World Buffs
        [1223878] = true, -- Sign of Azeroth
        
        [1250683] = true, -- Collector's Bounty
        [1250685] = true, -- Greedy Emisarry

        [1229050] = true, -- Mastery of Timeways
        [1220736] = true, -- Mysterious Revivification
        [1218497] = true, -- Mysterious Tenacity
        [1218388] = true, -- Mysterious Celerity
        [1218454] = true, -- Mysterious Swiftstrike

        --------------------------------------------------
        -- Patch 11.2.0
        --------------------------------------------------
        [1244018] = true, -- Tazavesh, the Vailed Market, Hard Mode
        [1246366] = true, -- Stree Smart

        --------------------------------------------------
        -- Legion Remix
        --------------------------------------------------
        [1232454] = true, -- Initife Power
        [1238465] = true, -- Heroic World Tier
        [1213439] = true, -- WoW Remix: Legion

        [440361] = true, -- Timeless Scroll of the Wild
        
    }

    AddBlacklist(data)
end
