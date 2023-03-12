local _, ns = ...
local Config = ns.Config

------------------------------------------------------------
-- Dragonflight
------------------------------------------------------------
if (not ns.Filger.isRetail) then return end

local Cooldowns = {
    ["DRUID"] = {
        -- General
        { spellID = 22812, check = true },              -- Barkskin

        -- Guardian
        { spellID = 50334, check = true },              -- Berserke
        { spellID = 61336, check = true },              -- Survival Instincts
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
        { spellID = 31884, check = true },              -- Sanctified Wrath
        { spellID = 96231, check = true },              -- Rebuke
        { spellID = 105809, check = true },             -- Holy Avenger
        { spellID = 152262, check = true },             -- Seraphim
        { spellID = 190784, check = true },             -- Divine Steed

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
    ["ALL"] = {}
}

ns.Config.importCooldowns(Cooldowns)
