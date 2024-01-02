local _, ns = ...

------------------------------------------------------------
-- Retail
------------------------------------------------------------
ns.BlackList = {
    -- Druid
    [1126] = true,                  -- Mark of the Wild

    -- Mage
    [1459] = true,                  -- Arcane Intellect

    -- -- Monk
    [389684] = true,                -- Close to Heart

    -- Priest
    [21562] = true,                 -- Power Word: Fortitude
    [232698] = true,                -- Shadowform

    -- -- Paladin
    [465] = true,                   -- Devotion Aura
    [32223] = true,                 -- Crusader Aura
    [183435] = true,                -- Retribution Aura
    [317920] = true,                -- Concentration Aura

    -- World Buffs
    [186401] = true,                -- Sign of the Skirmisher
    [186403] = true,                -- Sign of Battle
    [186406] = true,                -- Sign of the Critter
    [225787] = true,                -- Sign of the Warrior
    [225788] = true,                -- Sign of the Emissary
    [331079] = true,                -- Trainee
    [335148] = true,                -- Sign of the Twisting Nether
    [335149] = true,                -- Sign of the Scourge
    [335150] = true,                -- Sign of the Destroyer
    [335151] = true,                -- Sign of the Mists
    [335152] = true,                -- Sign of Iron
    [359082] = true,                -- Sign of the Legion
    [397734] = true,                -- Word of a Worthy Ally
    [394006] = true,                -- Rockin' Mining Gear
    
    -- Mounts
    ["Ride Along"] = true,
    [297871] = true,                -- Anglers' Water Stiders
    [388376] = true,                -- Dragonrider's Compassion

    -- Food
    ["Well Fed"] = true,

    -- Costumes
    [8219] = true,                  -- Flip Out
    [8222] = true,                  -- Yaaarrrr
    [16739] = true,                 -- Orb of Deception
    [58501] = true,                 -- Iron Boot Flask
    [61340] = true,                 -- Frenzyheart Brew
    [75532] = true,                 -- Darkspear Pride
    [74589] = true,                 -- Identity Crisis
    [93095] = true,                 -- Burgy Blackheart's Handsome Hat
    [96312] = true,                 -- Kalytha's Haunted Locked
    [101185] = true,                -- Levara's Locket
    [127315] = true,                -- Skymirror Image
    [129023] = true,                -- Surgical Alterations
    [134522] = true,                -- Dressed to Kill
    [149229] = true,                -- Celestial Defender
    [160331] = true,                -- Blood Elf Illusion
    [165185] = true,                -- Bloodclaw Charm
    [289184] = true,                -- Dark Banner's Spare Cowl
    [399502] = true,                -- Atomically Recalibrated
    [328906] = true,                -- Envious Glimmer

    -- Gear
    [331462] = true,                -- Stinky

    -- War Mode
    [269083] = true,                -- Enlisted
    [282559] = true,                -- Enlisted

    -- Mythic
    [206151] = true,                -- Challenger's Burden

    -- Forbiden Reach
    [405261] = true,                -- Dragonscale's Favor
    [405263] = true,                -- Iskaara's Favor
    [405264] = true,                -- Maruukai's Favor
    [405265] = true,                -- Valdrakken's Favor

    --Zaralek Cavern
    [411060] = true,                -- New Niffen No-Sniffin' Tonic

    -- Legion
    [227723] = true,                -- Mana Diving Stone

    -- Court of Stars
    [213213] = true,                -- Masquerade
}

-- Config.importBlackList(BlackList)
ns.Cooldowns = {
    ["DRUID"] = {
        -- General
        { spellID = 22812, check = true },              -- Barkskin

        -- Guardian
        { spellID = 50334, check = true },              -- Berserke
        { spellID = 61336, check = true },              -- Survival Instincts
    },
    ["MAGE"] = {
        -- Talents
        { spellID = 45438, check = true },              -- Ice Block

        -- Frost
    },
    ["MONK"] = {
        -- Talents
        { spellID = 115313, check = true },             -- Summon Jade Serpent Statue
        { spellID = 115315, check = true },             -- Summon Bloack Ox Statue
        { spellID = 116841, check = true },             -- Tiger Lust
        { spellID = 116844, check = true },             -- Ring of Peace
        { spellID = 388686, check = true },             -- Summon White Tiger Statue
        { spellID = 322101, check = false },            -- Expel Harm
        { spellID = 322109, check = true },             -- Touch of Death

        -- Mistweaver
        { spellID = 115310, check = true },             -- Revival
        { spellID = 116849, check = true },             -- Life Cocoon
        { spellID = 116680, check = true },             -- Thunder Focus Tea
        { spellID = 191837, check = true },             -- Essence Font
        { spellID = 197908, check = true },             -- Mana Tea
        { spellID = 325197, check = true },             -- Invoke Chi-ji, The Red Crane
        { spellID = 388193, check = true },             -- Faeline Stomp
        { spellID = 388615, check = true },             -- Restoral

        -- Brewmaster
        { spellID = 115203, check = true },             -- Fortifying Brew
        { spellID = 122278, check = true },             -- Dumpen Harm
        { spellID = 122783, check = true },             -- Diffuse Magic
        { spellID = 119582, check = true },             -- Purifiying Brew
        { spellID = 132578, check = true },             -- Invoke Niuzao, the Black Ox
        { spellID = 322507, check = true },             -- Celestial Brew
        { spellID = 324312, check = true },             -- Clash
        { spellID = 325153, check = true },             -- Exploding Keg
        { spellID = 386276, check = true },             -- Bonedust Brew
        { spellID = 387184, check = true },             -- Weapons of Order
    },
    ["PALADIN"] = {
        { spellID = 853, check = true },                -- Hammer of Justice
        { spellID = 391054, check = true },             -- Intercession

        -- Talents
        { spellID = 498, check = true },                -- Divine Protection
        { spellID = 642, check = true },                -- Divine Shield
        { spellID = 633, check = true },                -- Lay on Hands
        { spellID = 1022, check = true },               -- Blessing of Protection
        { spellID = 1044, check = true },               -- Blessing of Freedom
        { spellID = 6940, check = true },               -- Blessing of Sacrifice
        { spellID = 96231, check = true },              -- Rebuke
        { spellID = 105809, check = true },             -- Holy Avenger
        { spellID = 190784, check = true },             -- Divine Steed
        { spellID = 389539, check = true },             -- Sanctified Wrath

        -- Protection
        { spellID = 31850, check = true },              -- Ardent Defender
        { spellID = 31884, check = true },              -- Avenging Wrath: Might
        { spellID = 86659, check = true },              -- Guardian of Ancient Kings
        { spellID = 204018, check = true },             -- Blessing of Spellwarding
        { spellID = 327193, check = true },             -- Moment of Glory
        { spellID = 375576, check = true },             -- Divine Toll
        { spellID = 378974, check = true },             -- Bastion of Light
        { spellID = 389539, check = true },             -- Sentinel
        { spellID = 387174, check = true },             -- Eye of Tyr
    },
    ["PRIEST"] = {
        -- Talents
        { spellID = 10060, check = true },              -- Power Infusion
        { spellID = 19236, check = true },              -- Desperate Prayer
        { spellID = 34433, check = true },              -- Shadowfiendn
        { spellID = 73325, check = true },              -- Leap of Faith
        { spellID = 373481, check = true },             -- Power Word: Life

        -- Disciplie
        { spellID = 33206, check = true },              -- Pain Suppression
        { spellID = 47536, check = true },              -- Rapture
        { spellID = 62618, check = true },              -- Power Word: Barrier
        { spellID = 109964, check = true },             -- Spirit Shell
        { spellID = 120517, check = true },             -- Halo
        { spellID = 194509, check = true },             -- Power Word: Radiance
        { spellID = 246287, check = true },             -- Evangelism

        -- Holy
        { spellID = 2050, check = true },               -- Holy Word: Serenity
        { spellID = 64901, check = true },              -- Symbol of Hope
        { spellID = 34861, check = true },              -- Holy Word: Sanctify
        { spellID = 33076, check = true },              -- Prayer of Mending
        { spellID = 47788, check = true },              -- Guardian Spirit
        { spellID = 64843, check = true },              -- Divine Hymn
        { spellID = 200183, check = true },             -- Apotheosis
        { spellID = 204883, check = false },            -- Circle of Healing

        -- Shadow
        { spellID = 15286, check = true },              -- Vampiric Embrace
        { spellID = 15487, check = true },              -- Silence
        { spellID = 47585, check = true },              -- Dispersion
        { spellID = 108920, check = true },             -- Void Tendrils
        { spellID = 108968, check = true },             -- Void Shift
        { spellID = 200174, check = true },             -- Mindbender
        { spellID = 228260, check = true },             -- Void Eruption
        { spellID = 205385, check = true },             -- Shadow Crash
        { spellID = 263165, check = true },             -- Void Torrent
        { spellID = 120644, check = true },             -- Halo
        { spellID = 205369, check = true },             -- Mind Bomb
        { spellID = 375901, check = true },             -- Mindgames
    },
    ["WARRIOR"] = {
        -- Talents
        { spellID = 1161, check = true },               -- Challenging Shout
        { spellID = 2565, check = false },              -- Shield Block
        { spellID = 5246, check = true },               -- Intimidating Shout
        { spellID = 3411, check = true },               -- Intervene
        { spellID = 6544, check = true },               -- Heroic Leap
        { spellID = 18499, check = true },              -- Berserker Rage
        { spellID = 46968, check = true },              -- Shockwave
        { spellID = 97462, check = true },              -- Rallying Cry
        { spellID = 376079, check = true },             -- Spear of Bastion
        { spellID = 383762, check = true },             -- Bitter Immunity
        { spellID = 384318, check = true },             -- Thunderous Roar
        { spellID = 384100, check = true },             -- Berserker Shout
        { spellID = 401150, check = true },             -- Avatar

        -- Protection
        { spellID = 871, check = true },                -- Shield Wall
        { spellID = 1160, check = true },               -- Demoralizing Shout
        { spellID = 12975, check = true },              -- Last Stand
        { spellID = 23920, check = true },              -- Spell Reflection
        { spellID = 107570, check = true },             -- Storm Bolt
        { spellID = 190456, check = true },             -- Ignore Pain
        { spellID = 316834, check = true },             -- Shield Wall
        { spellID = 386071, check = true },             -- Disrupting Shout
        { spellID = 392966, check = true },             -- Spell Block
        { spellID = 228920, check = true },             -- Ravager
        { spellID = 385952, check = true },             -- Shield Charge
    },
    ["ALL"] = {
        -- Horde Racials
        { spellID = 7744, check = true },                       -- Will of the Forsaken (Undead)
        { spellID = 20549, check = true },                      -- War Stomp (Tauren)
        { spellID = 20572, check = true },                      -- Blood Fury (Orc)
        { spellID = 26297, check = true },                      -- Berserking (Troll)
        { spellID = 28730, check = (not Filger.isClassic) },    -- Arcane Torrent (Blood Elf)
        { spellID = 255654, check = (not Filger.isClassic) },   -- Bull Rush (Highmountain Tauren)

        -- Alliance Racials
        { spellID = 20594, check = true },                      -- Stoneform (Dwarf)
        { spellID = 265221, check = (not Filger.isClassic) },   -- Fireblood Fury (Dark Iron Dwarf)

        -- Kyrian
        { spellID = 324739, check = false },                    -- Summon Steward

        -- Ventyr
        { spellID = 323673, check = (not Filger.isClassic) },   -- Mindgames
        { spellID = 300728, check = (not Filger.isClassic) },   -- Door of Shadows

        -- Necrolords
        { spellID = 324143, check = (not Filger.isClassic) },   -- Conqueror's Banner
        { spellID = 324631, check = (not Filger.isClassic) },   -- Fleshcraft

        -- Gear
        { slotID = 2, check = true },                   -- Neck
        { slotID = 6, check = true },                   -- Waist
        { slotID = 13, check = true },                  -- Trinket 1
        { slotID = 14, check = true },                  -- Trinket 2

        -- Potions
        { itemID = 76089, check = true },               -- Virmen's Bite
        { itemID = 127834, check = true },              -- Acient Healing Potion
        { itemID = 163225, check = true },              -- Battle Potion of Stamina
        { itemID = 180318, check = true },              -- Soulful Mana Potion
    }
}
