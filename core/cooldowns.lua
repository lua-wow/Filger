local _, ns = ...
local Filger = ns.Filger
local class = Filger.class
local interface = Filger.interface

-- Blizzard
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo

-- Mine
local CLASSIC = 10000
local BURNING_CRUSADE = 20000
local WRATH_LICH_KING = 30000
local CATACLYSM = 40000
local MISTS_PANDARIA = 50000
local WARLODS_DRAENOR = 60000
local LEGION = 70000
local BATTLE_AZEROTH = 80000
local SHADOWLANDS = 90000
local DRAGONFLIGHT = 100000

local cooldowns = {}

local importData = function(dest, row)
    if row.enabled then
        local data = GetSpellInfo(row.spellId)
        if data then
            table.insert(dest, row)
        else
            Filger.warn("COOLDOWN", "Spell " .. row.spellId .. " do not exists.")
        end
    end
end

local import = function(source, dest)
    for class, spells in next, source do
        if not dest[class] then
            dest[class] = {}
        end
        
        for _, row in next, spells do
            importData(dest[class], row)
            -- if row.enabled then
            --     local data = GetSpellInfo(row.spellId)
            --     if data then
            --         table.insert(dest[class], row)
            --     else
            --         Filger.warn("COOLDOWN", "Spell " .. row.spellId .. " do not exists.")
            --     end
            -- end
        end
    end
end

local CreateSpellCooldown = function(spellId, enabled)
    assert(tonumber(spellId), "Filger: Invalid cooldown spellId")
    if (enabled == nil) then
        enabled = true
    end
    return { spellId = spellId, enabled = enabled }
end

local CreateSlotCooldown = function(slotId, enabled)
    assert(tonumber(slotId), "Filger: Invalid slotId")
    if (enabled == nil) then
        enabled = true
    end
    return { slotId = slotId, enabled = enabled }
end

local racials = {
    -- Horde
    CreateSpellCooldown(7744, interface >= CLASSIC),            -- Will of the Forsaken (Undead)
    CreateSpellCooldown(20549, interface >= CLASSIC),           -- War Stomp (Tauren)
    CreateSpellCooldown(20572, interface >= CLASSIC),           -- Blood Fury (Orc)
    CreateSpellCooldown(26297, interface >= CLASSIC),           -- Berserking (Troll)
    CreateSpellCooldown(28730, interface >= BURNING_CRUSADE),   -- Arcane Torrent (Blood Elf)
    CreateSpellCooldown(255654, interface >= LEGION),           -- Bull Rush (Highmountain Tauren)

    -- Alliance
    CreateSpellCooldown(20594, interface >= CLASSIC),           -- Stoneform (Dwarf)
    CreateSpellCooldown(265221, interface >= BATTLE_AZEROTH),   -- Fireblood Fury (Dark Iron Dwarf)
}

local gear = {
   CreateSlotCooldown(2),    -- Neck
   CreateSlotCooldown(6),    -- Waist
   CreateSlotCooldown(13),   -- Trinket 1
   CreateSlotCooldown(14),   -- Trinket 2 
}

--------------------------------------------------
-- Classic
--------------------------------------------------
if Filger.isClassic then
    local data = {
        ["PALADIN"] = {
            -- General
            CreateSpellCooldown(498),           -- Divine Protection
            CreateSpellCooldown(642),           -- Divine Shield
            CreateSpellCooldown(633),           -- Lay on Hands
            CreateSpellCooldown(1022),          -- Blessing of Protection
            CreateSpellCooldown(1044),          -- Blessing of Freedom
            CreateSpellCooldown(6940),          -- Blessing of Sacrifice
        },
        ["PRIEST"] = {
            -- Discipline
            CreateSpellCooldown(10060),         -- Power Infusion
            CreateSpellCooldown(14751),         -- Inner Focus
    
            -- Holy
            CreateSpellCooldown(724),           -- Lightwell (Rank 1)
            CreateSpellCooldown(27870),         -- Lightwell (Rank 2)
            CreateSpellCooldown(27871),         -- Lightwell (Rank 3)
    
            -- Shadow
            CreateSpellCooldown(15286, false),        -- Vampiric Embrace
            CreateSpellCooldown(15487),         -- Silence

            CreateSpellCooldown(586),           -- Fade (Rank 1)
            CreateSpellCooldown(9578),          -- Fade (Rank 2)
            CreateSpellCooldown(9579),          -- Fade (Rank 3)
            CreateSpellCooldown(9592),          -- Fade (Rank 4)
            CreateSpellCooldown(10941),         -- Fade (Rank 5)
            CreateSpellCooldown(10942),         -- Fade (Rank 6)
    
            CreateSpellCooldown(8122),          -- Psychic Scream (Rank 1)
            CreateSpellCooldown(8124),          -- Psychic Scream (Rank 2)
            CreateSpellCooldown(10888),         -- Psychic Scream (Rank 3)
            CreateSpellCooldown(10890),         -- Psychic Scream (Rank 4)
    
            -- Night Elf
            CreateSpellCooldown(2651),          -- Elune's Grace (Rank 1)
            CreateSpellCooldown(19289),         -- Elune's Grace (Rank 2)
            CreateSpellCooldown(19291),         -- Elune's Grace (Rank 3)
            CreateSpellCooldown(19292),         -- Elune's Grace (Rank 4)
            CreateSpellCooldown(19293),         -- Elune's Grace (Rank 5)
    
            -- Human 
            CreateSpellCooldown(13896),         -- Feedback (Rank 1)
            CreateSpellCooldown(19271),         -- Feedback (Rank 2)
            CreateSpellCooldown(19273),         -- Feedback (Rank 3)
            CreateSpellCooldown(19274),         -- Feedback (Rank 4)
            CreateSpellCooldown(19275),         -- Feedback (Rank 5)
    
            -- Dwarf
            CreateSpellCooldown(6346),          -- Fear Ward (Rank 1)

            -- Dwarf / Humman
            CreateSpellCooldown(13908),         -- Desperate Prayer (Rank 1)
            CreateSpellCooldown(19236),         -- Desperate Prayer (Rank 2)
            CreateSpellCooldown(19238),         -- Desperate Prayer (Rank 3)
            CreateSpellCooldown(19240),         -- Desperate Prayer (Rank 4)
            CreateSpellCooldown(19241),         -- Desperate Prayer (Rank 5)
            CreateSpellCooldown(19242),         -- Desperate Prayer (Rank 6)
            CreateSpellCooldown(19243),         -- Desperate Prayer (Rank 7)
            
            -- Undead
            CreateSpellCooldown(2944),          -- Devouring Plague(Rank 1)
            CreateSpellCooldown(19276),         -- Devouring Plague(Rank 2)
            CreateSpellCooldown(19277),         -- Devouring Plague(Rank 3)
            CreateSpellCooldown(19278),         -- Devouring Plague(Rank 4)
            CreateSpellCooldown(19279),         -- Devouring Plague(Rank 5)
            CreateSpellCooldown(19280),         -- Devouring Plague(Rank 6)
        }
    }
    import(data, cooldowns)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
if Filger.isBCC then
    local data = {
        ["PRIEST"] = {
            -- Discipline
            CreateSpellCooldown(10060),         -- Power Infusion
            CreateSpellCooldown(14751),         -- Inner Focus
    
            -- Holy
            CreateSpellCooldown(724),           -- Lightwell (Rank 1)
            CreateSpellCooldown(27870),         -- Lightwell (Rank 2)
            CreateSpellCooldown(27871),         -- Lightwell (Rank 3)
    
            -- Shadow
            CreateSpellCooldown(15286, false),        -- Vampiric Embrace
            CreateSpellCooldown(15487),         -- Silence

            CreateSpellCooldown(586),           -- Fade (Rank 1)
            CreateSpellCooldown(9578),          -- Fade (Rank 2)
            CreateSpellCooldown(9579),          -- Fade (Rank 3)
            CreateSpellCooldown(9592),          -- Fade (Rank 4)
            CreateSpellCooldown(10941),         -- Fade (Rank 5)
            CreateSpellCooldown(10942),         -- Fade (Rank 6)
    
            CreateSpellCooldown(8122),          -- Psychic Scream (Rank 1)
            CreateSpellCooldown(8124),          -- Psychic Scream (Rank 2)
            CreateSpellCooldown(10888),         -- Psychic Scream (Rank 3)
            CreateSpellCooldown(10890),         -- Psychic Scream (Rank 4)
            
            CreateSpellCooldown(6346),          -- Fear Ward (Rank 1)

            -- Night Elf
            CreateSpellCooldown(2651),          -- Elune's Grace
    
            -- Human 
            CreateSpellCooldown(13896),         -- Feedback (Rank 1)
            CreateSpellCooldown(19271),         -- Feedback (Rank 2)
            CreateSpellCooldown(19273),         -- Feedback (Rank 3)
            CreateSpellCooldown(19274),         -- Feedback (Rank 4)
            CreateSpellCooldown(19275),         -- Feedback (Rank 5)
            CreateSpellCooldown(25441),         -- Feedback (Rank 6)
    
            -- Dwarf / Humman
            CreateSpellCooldown(13908),         -- Desperate Prayer (Rank 1)
            CreateSpellCooldown(19236),         -- Desperate Prayer (Rank 2)
            CreateSpellCooldown(19238),         -- Desperate Prayer (Rank 3)
            CreateSpellCooldown(19240),         -- Desperate Prayer (Rank 4)
            CreateSpellCooldown(19241),         -- Desperate Prayer (Rank 5)
            CreateSpellCooldown(19242),         -- Desperate Prayer (Rank 6)
            CreateSpellCooldown(19243),         -- Desperate Prayer (Rank 7)
            CreateSpellCooldown(25437),         -- Desperate Prayer (Rank 8)
            
            -- Undead
            CreateSpellCooldown(2944),          -- Devouring Plague(Rank 1)
            CreateSpellCooldown(19276),         -- Devouring Plague(Rank 2)
            CreateSpellCooldown(19277),         -- Devouring Plague(Rank 3)
            CreateSpellCooldown(19278),         -- Devouring Plague(Rank 4)
            CreateSpellCooldown(19279),         -- Devouring Plague(Rank 5)
            CreateSpellCooldown(19280),         -- Devouring Plague(Rank 6)
        }
    }
    import(data, cooldowns)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if Filger.isWotLK then
    local data = {
        ["PRIEST"] = {
            -- Discipline
            CreateSpellCooldown(10060),         -- Power Infusion
            CreateSpellCooldown(14751),         -- Inner Focus
    
            -- Holy
            CreateSpellCooldown(724),           -- Lightwell (Rank 1)
            CreateSpellCooldown(27870),         -- Lightwell (Rank 2)
            CreateSpellCooldown(27871),         -- Lightwell (Rank 3)
    
            -- Shadow
            CreateSpellCooldown(15286, false),        -- Vampiric Embrace
            CreateSpellCooldown(15487),         -- Silence

            CreateSpellCooldown(586),           -- Fade (Rank 1)
            CreateSpellCooldown(9578),          -- Fade (Rank 2)
            CreateSpellCooldown(9579),          -- Fade (Rank 3)
            CreateSpellCooldown(9592),          -- Fade (Rank 4)
            CreateSpellCooldown(10941),         -- Fade (Rank 5)
            CreateSpellCooldown(10942),         -- Fade (Rank 6)
    
            CreateSpellCooldown(8122),          -- Psychic Scream (Rank 1)
            CreateSpellCooldown(8124),          -- Psychic Scream (Rank 2)
            CreateSpellCooldown(10888),         -- Psychic Scream (Rank 3)
            CreateSpellCooldown(10890),         -- Psychic Scream (Rank 4)
            
            CreateSpellCooldown(6346),          -- Fear Ward (Rank 1)

            CreateSpellCooldown(13908),         -- Desperate Prayer (Rank 1)
            CreateSpellCooldown(19236),         -- Desperate Prayer (Rank 2)
            CreateSpellCooldown(19238),         -- Desperate Prayer (Rank 3)
            CreateSpellCooldown(19240),         -- Desperate Prayer (Rank 4)
            CreateSpellCooldown(19241),         -- Desperate Prayer (Rank 5)
            CreateSpellCooldown(19242),         -- Desperate Prayer (Rank 6)
            CreateSpellCooldown(19243),         -- Desperate Prayer (Rank 7)
            CreateSpellCooldown(25437),         -- Desperate Prayer (Rank 8)
            CreateSpellCooldown(48173),         -- Desperate Prayer (Rank 9)

            -- Undead
            CreateSpellCooldown(2944),          -- Devouring Plague(Rank 1)
            CreateSpellCooldown(19276),         -- Devouring Plague(Rank 2)
            CreateSpellCooldown(19277),         -- Devouring Plague(Rank 3)
            CreateSpellCooldown(19278),         -- Devouring Plague(Rank 4)
            CreateSpellCooldown(19279),         -- Devouring Plague(Rank 5)
            CreateSpellCooldown(19280),         -- Devouring Plague(Rank 6)
        }
    }
    import(data, cooldowns)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if Filger.isCata then
    local data = {
        ["PRIEST"] = {
            -- Discipline
            CreateSpellCooldown(10060),         -- Power Infusion
            CreateSpellCooldown(14751),         -- Inner Focus
    
            -- Holy
            CreateSpellCooldown(724),           -- Lightwell (Rank 1)
            CreateSpellCooldown(27870),         -- Lightwell (Rank 2)
            CreateSpellCooldown(27871),         -- Lightwell (Rank 3)
    
            -- Shadow
            CreateSpellCooldown(15286, false),        -- Vampiric Embrace
            CreateSpellCooldown(15487),         -- Silence

            CreateSpellCooldown(586),           -- Fade (Rank 1)
            CreateSpellCooldown(9578),          -- Fade (Rank 2)
            CreateSpellCooldown(9579),          -- Fade (Rank 3)
            CreateSpellCooldown(9592),          -- Fade (Rank 4)
            CreateSpellCooldown(10941),         -- Fade (Rank 5)
            CreateSpellCooldown(10942),         -- Fade (Rank 6)
    
            CreateSpellCooldown(8122),          -- Psychic Scream (Rank 1)
            CreateSpellCooldown(8124),          -- Psychic Scream (Rank 2)
            CreateSpellCooldown(10888),         -- Psychic Scream (Rank 3)
            CreateSpellCooldown(10890),         -- Psychic Scream (Rank 4)
            
            CreateSpellCooldown(6346),          -- Fear Ward (Rank 1)

            -- Night Elf
            CreateSpellCooldown(2651),          -- Elune's Grace (Rank 1)
            CreateSpellCooldown(19289),         -- Elune's Grace (Rank 2)
            CreateSpellCooldown(19291),         -- Elune's Grace (Rank 3)
            CreateSpellCooldown(19292),         -- Elune's Grace (Rank 4)
            CreateSpellCooldown(19293),         -- Elune's Grace (Rank 5)
    
            -- Human 
            CreateSpellCooldown(13896),         -- Feedback (Rank 1)
            CreateSpellCooldown(19271),         -- Feedback (Rank 2)
            CreateSpellCooldown(19273),         -- Feedback (Rank 3)
            CreateSpellCooldown(19274),         -- Feedback (Rank 4)
            CreateSpellCooldown(19275),         -- Feedback (Rank 5)
    
            -- Dwarf / Humman
            CreateSpellCooldown(13908),         -- Desperate Prayer (Rank 1)
            CreateSpellCooldown(19236),         -- Desperate Prayer (Rank 2)
            CreateSpellCooldown(19238),         -- Desperate Prayer (Rank 3)
            CreateSpellCooldown(19240),         -- Desperate Prayer (Rank 4)
            CreateSpellCooldown(19241),         -- Desperate Prayer (Rank 5)
            CreateSpellCooldown(19242),         -- Desperate Prayer (Rank 6)
            CreateSpellCooldown(19243),         -- Desperate Prayer (Rank 7)
            
            -- Undead
            CreateSpellCooldown(2944),          -- Devouring Plague(Rank 1)
            CreateSpellCooldown(19276),         -- Devouring Plague(Rank 2)
            CreateSpellCooldown(19277),         -- Devouring Plague(Rank 3)
            CreateSpellCooldown(19278),         -- Devouring Plague(Rank 4)
            CreateSpellCooldown(19279),         -- Devouring Plague(Rank 5)
            CreateSpellCooldown(19280),         -- Devouring Plague(Rank 6)
        }
    }
    import(data, cooldowns)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if Filger.isMoP then
    local data = {}
    import(data, cooldowns)
end

--------------------------------------------------
-- Warlords of Draenor
--------------------------------------------------
if Filger.isWoD then
    local data = {}
    import(data, cooldowns)
end

--------------------------------------------------
-- Legion
--------------------------------------------------
if Filger.isLegion then
    local data = {}
    import(data, cooldowns)
end

--------------------------------------------------
-- Battle for Azeroth
--------------------------------------------------
if Filger.BFA then
    local data = {}
    import(data, cooldowns)
end

--------------------------------------------------
-- Shadowlands
--------------------------------------------------
if Filger.Shadowlands then
    local data = {
        ["ALL"] = {
            -- Kyrian
            CreateSpellCooldown(324739, false),      -- Summon Steward

            -- Ventyr
            CreateSpellCooldown(323673),       -- Mindgames
            CreateSpellCooldown(300728),       -- Door of Shadows

            -- Necrolords
            CreateSpellCooldown(324143),       -- Conqueror's Banner
            CreateSpellCooldown(324631),       -- Fleshcraft
        }
    }

    import(data, cooldowns)
end

--------------------------------------------------
-- Dragonflight
--------------------------------------------------
if Filger.isDF then
    local data = {
        ["DRUID"] = {
            -- General
            CreateSpellCooldown(22812),         -- Barkskin

            -- Guardian
            CreateSpellCooldown(50334),         -- Berserke
            CreateSpellCooldown(61336),         -- Survival Instincts
        },
        ["MAGE"] = {
            -- Talents
            CreateSpellCooldown(45438),         -- Ice Block
        },
        ["MONK"] = {
            -- Talents
            CreateSpellCooldown(115313),        -- Summon Jade Serpent Statue
            CreateSpellCooldown(115315),        -- Summon Bloack Ox Statue
            CreateSpellCooldown(116841),        -- Tiger Lust
            CreateSpellCooldown(116844),        -- Ring of Peace
            CreateSpellCooldown(388686),        -- Summon White Tiger Statue
            CreateSpellCooldown(322101, false), -- Expel Harm
            CreateSpellCooldown(322109),        -- Touch of Death

            -- Mistweaver
            CreateSpellCooldown(115310),        -- Revival
            CreateSpellCooldown(116849),        -- Life Cocoon
            CreateSpellCooldown(116680),        -- Thunder Focus Tea
            CreateSpellCooldown(191837),        -- Essence Font
            CreateSpellCooldown(197908),        -- Mana Tea
            CreateSpellCooldown(325197),        -- Invoke Chi-ji, The Red Crane
            CreateSpellCooldown(388193),        -- Faeline Stomp
            CreateSpellCooldown(388615),        -- Restoral

            -- Brewmaster
            CreateSpellCooldown(115203),        -- Fortifying Brew
            CreateSpellCooldown(122278),        -- Dumpen Harm
            CreateSpellCooldown(122783),        -- Diffuse Magic
            CreateSpellCooldown(119582),        -- Purifiying Brew
            CreateSpellCooldown(132578),        -- Invoke Niuzao, the Black Ox
            CreateSpellCooldown(322507),        -- Celestial Brew
            CreateSpellCooldown(324312),        -- Clash
            CreateSpellCooldown(325153),        -- Exploding Keg
            CreateSpellCooldown(386276),        -- Bonedust Brew
            CreateSpellCooldown(387184),        -- Weapons of Order
        },
        ["PALADIN"] = {
            CreateSpellCooldown(853),           -- Hammer of Justice
            CreateSpellCooldown(391054),        -- Intercession

            -- Talents
            CreateSpellCooldown(498),           -- Divine Protection
            CreateSpellCooldown(642),           -- Divine Shield
            CreateSpellCooldown(633),           -- Lay on Hands
            CreateSpellCooldown(1022),          -- Blessing of Protection
            CreateSpellCooldown(1044),          -- Blessing of Freedom
            CreateSpellCooldown(6940),          -- Blessing of Sacrifice
            CreateSpellCooldown(96231),         -- Rebuke
            CreateSpellCooldown(105809),        -- Holy Avenger
            CreateSpellCooldown(190784),        -- Divine Steed
            CreateSpellCooldown(389539),        -- Sanctified Wrath

            -- Protection
            CreateSpellCooldown(31850),         -- Ardent Defender
            CreateSpellCooldown(31884),         -- Avenging Wrath: Might
            CreateSpellCooldown(86659),         -- Guardian of Ancient Kings
            CreateSpellCooldown(204018),        -- Blessing of Spellwarding
            CreateSpellCooldown(327193),        -- Moment of Glory
            CreateSpellCooldown(375576),        -- Divine Toll
            CreateSpellCooldown(378974),        -- Bastion of Light
            CreateSpellCooldown(389539),        -- Sentinel
            CreateSpellCooldown(387174),        -- Eye of Tyr
        },
        ["PRIEST"] = {
            -- Talents
            CreateSpellCooldown(10060),         -- Power Infusion
            CreateSpellCooldown(19236),         -- Desperate Prayer
            CreateSpellCooldown(34433),         -- Shadowfiendn
            CreateSpellCooldown(73325),         -- Leap of Faith
            CreateSpellCooldown(373481),        -- Power Word: Life

            -- Disciplie
            CreateSpellCooldown(33206),         -- Pain Suppression
            CreateSpellCooldown(47536),         -- Rapture
            CreateSpellCooldown(62618),         -- Power Word: Barrier
            CreateSpellCooldown(109964),        -- Spirit Shell
            CreateSpellCooldown(120517),        -- Halo
            CreateSpellCooldown(194509),        -- Power Word: Radiance
            CreateSpellCooldown(246287),        -- Evangelism

            -- Holy
            CreateSpellCooldown(2050),          -- Holy Word: Serenity
            CreateSpellCooldown(64901),         -- Symbol of Hope
            CreateSpellCooldown(34861),         -- Holy Word: Sanctify
            CreateSpellCooldown(33076),         -- Prayer of Mending
            CreateSpellCooldown(47788),         -- Guardian Spirit
            CreateSpellCooldown(64843),         -- Divine Hymn
            CreateSpellCooldown(200183),        -- Apotheosis
            CreateSpellCooldown(204883, false), -- Circle of Healing

            -- Shadow
            CreateSpellCooldown(15286),         -- Vampiric Embrace
            CreateSpellCooldown(15487),         -- Silence
            CreateSpellCooldown(47585),         -- Dispersion
            CreateSpellCooldown(108920),        -- Void Tendrils
            CreateSpellCooldown(108968),        -- Void Shift
            CreateSpellCooldown(200174),        -- Mindbender
            CreateSpellCooldown(228260),        -- Void Eruption
            CreateSpellCooldown(205385),        -- Shadow Crash
            CreateSpellCooldown(263165),        -- Void Torrent
            CreateSpellCooldown(120644),        -- Halo
            CreateSpellCooldown(205369),        -- Mind Bomb
            CreateSpellCooldown(375901),        -- Mindgames
        },
        ["WARRIOR"] = {
            -- Talents
            CreateSpellCooldown(1161),          -- Challenging Shout
            CreateSpellCooldown(2565, false),   -- Shield Block
            CreateSpellCooldown(5246),          -- Intimidating Shout
            CreateSpellCooldown(3411),          -- Intervene
            CreateSpellCooldown(6544),          -- Heroic Leap
            CreateSpellCooldown(18499),         -- Berserker Rage
            CreateSpellCooldown(46968),         -- Shockwave
            CreateSpellCooldown(97462),         -- Rallying Cry
            CreateSpellCooldown(376079),        -- Spear of Bastion
            CreateSpellCooldown(383762),        -- Bitter Immunity
            CreateSpellCooldown(384318),        -- Thunderous Roar
            CreateSpellCooldown(384100),        -- Berserker Shout
            CreateSpellCooldown(401150),        -- Avatar

            -- Protection
            CreateSpellCooldown(871),           -- Shield Wall
            CreateSpellCooldown(1160),          -- Demoralizing Shout
            CreateSpellCooldown(12975),         -- Last Stand
            CreateSpellCooldown(23920),         -- Spell Reflection
            CreateSpellCooldown(107570),        -- Storm Bolt
            CreateSpellCooldown(190456),        -- Ignore Pain
            CreateSpellCooldown(316834),        -- Shield Wall
            CreateSpellCooldown(386071),        -- Disrupting Shout
            CreateSpellCooldown(392966),        -- Spell Block
            CreateSpellCooldown(228920),        -- Ravager
            CreateSpellCooldown(385952),        -- Shield Charge
        }
    }

    import(data, cooldowns)
end

if Filger.isRetail then
    local data = {
        ["DRUID"] = {
            -- General
            CreateSpellCooldown(20484),         -- Rebirth
            CreateSpellCooldown(22812),         -- Barkskin
            
            -- Talents
            CreateSpellCooldown(29166),         -- Innervate
            CreateSpellCooldown(102359),        -- Mass Entanglement
            CreateSpellCooldown(102793),        -- Ursol's Vortex
            CreateSpellCooldown(108238),        -- Renewal
            CreateSpellCooldown(124974),        -- Mature's Vigil

            -- All
            CreateSpellCooldown(391528),        -- Convoke the Spirits

            -- Balance
            CreateSpellCooldown(78675),         -- Solar Beam
            CreateSpellCooldown(102560),        -- Incarnation: Chosen of Elune
            CreateSpellCooldown(194223),        -- Celestial Alignment
            CreateSpellCooldown(202425, false), -- Warrior of Elune
            CreateSpellCooldown(202770),        -- Fury of Elune
            CreateSpellCooldown(205636),        -- Force of Nature
            
            -- Feral
            
            -- Guardian
            CreateSpellCooldown(50334),         -- Berserkl: Ravage
            CreateSpellCooldown(61336),         -- Survival Instincts
            CreateSpellCooldown(80313),         -- Pulverize
            CreateSpellCooldown(102558),        -- Incarnation: Guardian of Ursoc
            CreateSpellCooldown(200851),        -- Rage of the Sleeper
            CreateSpellCooldown(204066),        -- Lunar Beam
            
            -- Restoration
            CreateSpellCooldown(740),           -- Tranquility
            CreateSpellCooldown(33891),         -- Incarnation: Tree of Life
            CreateSpellCooldown(102342),        -- Ironbark
            CreateSpellCooldown(132158),        -- Nature's Swiftness
            CreateSpellCooldown(203651),        -- Overgrowth
        },
        ["MAGE"] = {
            -- Talents
            CreateSpellCooldown(45438),         -- Ice Block
            CreateSpellCooldown(80353),         -- Time Warp
            CreateSpellCooldown(110959),        -- Greater Invisibilty
            CreateSpellCooldown(382440),        -- Shifting Power
            CreateSpellCooldown(55342),         -- Mirror Image
            CreateSpellCooldown(414660),        -- Mass Barrier
            
            -- Frost
            CreateSpellCooldown(12472),         -- Icy Veins
            CreateSpellCooldown(84714),         -- Frozen Orb
            CreateSpellCooldown(235219),        -- Cold Snap
        },
        ["MONK"] = {
            -- Talents
            CreateSpellCooldown(115203),        -- Fortifying Brew
            CreateSpellCooldown(116705),        -- Spear Hand Strike
            CreateSpellCooldown(116841, false), -- Tiger Lust
            CreateSpellCooldown(116844),        -- Ring of Peace
            CreateSpellCooldown(122278),        -- Dumpen Harm
            CreateSpellCooldown(122783),        -- Diffuse Magic
            CreateSpellCooldown(123986, false), -- Chi Burst
            CreateSpellCooldown(322109),        -- Touch of Death
            CreateSpellCooldown(324312, false), -- Clash
            -- CreateSpellCooldown(115313),         -- Summon Jade Serpent Statue
            -- CreateSpellCooldown(115315),         -- Summon Bloack Ox Statue
            -- CreateSpellCooldown(388686),         -- Summon White Tiger Statue
            -- CreateSpellCooldown(322101, false),  -- Expel Harm

            -- Mistweaver
            -- CreateSpellCooldown(115310),         -- Revival
            -- CreateSpellCooldown(116849),         -- Life Cocoon
            -- CreateSpellCooldown(116680),         -- Thunder Focus Tea
            -- CreateSpellCooldown(191837),         -- Essence Font
            -- CreateSpellCooldown(197908),         -- Mana Tea
            -- CreateSpellCooldown(325197),         -- Invoke Chi-ji, The Red Crane
            -- CreateSpellCooldown(388193),         -- Faeline Stomp
            -- CreateSpellCooldown(388615),         -- Restoral

            -- Brewmaster
            CreateSpellCooldown(119582, false), -- Purifiying Brew
            CreateSpellCooldown(132578),        -- Invoke Niuzao, the Black Ox
            CreateSpellCooldown(322507),        -- Celestial Brew
            CreateSpellCooldown(115176),        -- Zen Meditation
            CreateSpellCooldown(325153),        -- Exploding Keg
            CreateSpellCooldown(387184),        -- Weapons of Order
        },
        ["PALADIN"] = {
            CreateSpellCooldown(633),           -- Lay on Hands
            CreateSpellCooldown(642),           -- Divine Shield
            CreateSpellCooldown(853),           -- Hammer of Justice
            CreateSpellCooldown(391054),        -- Intercession

            -- Talents
            CreateSpellCooldown(1022),          -- Blessing of Protection
            CreateSpellCooldown(1044),          -- Blessing of Freedom
            CreateSpellCooldown(6940),          -- Blessing of Sacrifice
            CreateSpellCooldown(31884),         -- Avenging Wrath (Holy)
            CreateSpellCooldown(96231, false),  -- Rebuke
            CreateSpellCooldown(115750),        -- Blinding Light
            CreateSpellCooldown(375576),        -- Divine Toll
            
            -- Holy
            CreateSpellCooldown(498),           -- Divine Protection
            CreateSpellCooldown(85222),         -- Aura Mastery
            CreateSpellCooldown(114165, false), -- Holy Prism
            CreateSpellCooldown(148039, false), -- Barrier of Faith
            CreateSpellCooldown(200025, false), -- Beacon of Virtue
            CreateSpellCooldown(200672),        -- Tyr's Deliverance
            CreateSpellCooldown(388007),        -- Blessim of Summer
            CreateSpellCooldown(414273),        -- Hand of Divinity
            
            -- Protection
            CreateSpellCooldown(31850),         -- Ardent Defender
            CreateSpellCooldown(86659),         -- Guardian of Ancient Kings
            CreateSpellCooldown(204018),        -- Blessing of Spellwarding
            CreateSpellCooldown(327193),        -- Moment of Glory
            CreateSpellCooldown(378974),        -- Bastion of Light
            CreateSpellCooldown(31884),         -- Sanctified Wrath
            CreateSpellCooldown(389539),        -- Sentinel
            CreateSpellCooldown(387174),        -- Eye of Tyr
            
            -- Retribution
            CreateSpellCooldown(403876),        -- Divine Protection
            CreateSpellCooldown(31884),         -- Avenging Wrath: Might
            CreateSpellCooldown(255937, false), -- Wake of Ashes
            CreateSpellCooldown(343721),        -- Final Reckoning
            CreateSpellCooldown(343527, false), -- Execution Sentence
        },
        ["PRIEST"] = {
            -- All
            CreateSpellCooldown(586, false),    -- Fade
            CreateSpellCooldown(8122, false),   -- Psychic Scream
            CreateSpellCooldown(19236),         -- Desperate Prayer

            -- Talents
            CreateSpellCooldown(10060),         -- Power Infusion
            CreateSpellCooldown(15286),         -- Vampiric Embrace
            CreateSpellCooldown(32375),         -- Mass Dispel
            CreateSpellCooldown(34433),         -- Shadowfiennd
            CreateSpellCooldown(73325),         -- Leap of Faith
            CreateSpellCooldown(108920),        -- Void Tendrils
            CreateSpellCooldown(108968),        -- Void Shift
            CreateSpellCooldown(120517),        -- Halo (Disciple / Holy)
            CreateSpellCooldown(120644),        -- Halo (Shadow)
            CreateSpellCooldown(205364),        -- Dominate Mind
            CreateSpellCooldown(373481, false), -- Power Word: Life

            -- Discipline
            CreateSpellCooldown(33206),         -- Pain Suppression
            CreateSpellCooldown(47536),         -- Rapture
            CreateSpellCooldown(62618),         -- Power Word: Barrier
            CreateSpellCooldown(271466),        -- Luminous Barrier
            CreateSpellCooldown(123040),        -- Mind Bender
            CreateSpellCooldown(246287),        -- Evangelism

            -- Holy
            CreateSpellCooldown(2050),          -- Holy Word: Serenity
            CreateSpellCooldown(34861),         -- Holy Word: Sanctify
            CreateSpellCooldown(47788),         -- Guardian Spirit
            CreateSpellCooldown(64843),         -- Divine Hymn
            CreateSpellCooldown(64901),         -- Symbol of Hope
            CreateSpellCooldown(88625),         -- Holy Word: Chastise
            CreateSpellCooldown(200183),        -- Apotheosis
            CreateSpellCooldown(372760),        -- Divine Word
            CreateSpellCooldown(372835),        -- Light Well

            -- Shadow
            CreateSpellCooldown(15487),         -- Silence
            CreateSpellCooldown(47585),         -- Dispersion
            CreateSpellCooldown(64044),         -- Psychic Horror
            CreateSpellCooldown(200174),        -- Mindbender
            CreateSpellCooldown(228260),        -- Void Eruption
            CreateSpellCooldown(391109),        -- Dark Ascension
        }
    }

    import(data, cooldowns)
end

-- make sure the player class cooldown exists, even if empty
if not cooldowns[class] then
    cooldowns[class] = {}
end

-- insert racials spells
for i = 1, #racials do
    importData(cooldowns[class], racials[i])
end

-- insert gear slots
for i = 1, #gear do
    table.insert(cooldowns[class], gear[i])
end

Filger.cooldowns = cooldowns[class]
