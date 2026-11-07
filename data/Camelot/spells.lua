--------------------------------------------------
-- Classic Forever
--------------------------------------------------
local _, ns = ...

local CreateSpellPriority = ns.data.CreateSpellPriority
local AddSpells = ns.data.AddSpells

-- PLAYER_AURAS shows only listed spells here, by spell ID, so every rank is listed
local data = {
    ["DRUID"] = {
        -- Defensives
        [22812] = CreateSpellPriority(5),    -- Barkskin
        [428713] = CreateSpellPriority(5),   -- Barkskin
        [22842] = CreateSpellPriority(5),    -- Frenzied Regeneration
        [428708] = CreateSpellPriority(5),   -- Frenzied Regeneration
        [16689] = CreateSpellPriority(5),    -- Nature's Grasp (Rank 1)
        [16810] = CreateSpellPriority(5),    -- Nature's Grasp (Rank 2)
        [16811] = CreateSpellPriority(5),    -- Nature's Grasp (Rank 3)
        [16812] = CreateSpellPriority(5),    -- Nature's Grasp (Rank 4)
        [16813] = CreateSpellPriority(5),    -- Nature's Grasp (Rank 5)
        [17329] = CreateSpellPriority(5),    -- Nature's Grasp (Rank 6)
        [1850] = CreateSpellPriority(5),     -- Dash (Rank 1)
        [9821] = CreateSpellPriority(5),     -- Dash (Rank 2)
        [29166] = CreateSpellPriority(5),    -- Innervate
        [456195] = CreateSpellPriority(5),   -- Innervate

        -- Heals
        [774] = CreateSpellPriority(5),      -- Rejuvenation (Rank 1)
        [1058] = CreateSpellPriority(5),     -- Rejuvenation (Rank 2)
        [1430] = CreateSpellPriority(5),     -- Rejuvenation (Rank 3)
        [2090] = CreateSpellPriority(5),     -- Rejuvenation (Rank 4)
        [2091] = CreateSpellPriority(5),     -- Rejuvenation (Rank 5)
        [3627] = CreateSpellPriority(5),     -- Rejuvenation (Rank 6)
        [8910] = CreateSpellPriority(5),     -- Rejuvenation (Rank 7)
        [9839] = CreateSpellPriority(5),     -- Rejuvenation (Rank 8)
        [9840] = CreateSpellPriority(5),     -- Rejuvenation (Rank 9)
        [9841] = CreateSpellPriority(5),     -- Rejuvenation (Rank 10)
        [25299] = CreateSpellPriority(5),    -- Rejuvenation (Rank 11)
        [417057] = CreateSpellPriority(5),   -- Rejuvenation (Rank 1)
        [417058] = CreateSpellPriority(5),   -- Rejuvenation (Rank 2)
        [417059] = CreateSpellPriority(5),   -- Rejuvenation (Rank 3)
        [417060] = CreateSpellPriority(5),   -- Rejuvenation (Rank 4)
        [417061] = CreateSpellPriority(5),   -- Rejuvenation (Rank 5)
        [417062] = CreateSpellPriority(5),   -- Rejuvenation (Rank 6)
        [417063] = CreateSpellPriority(5),   -- Rejuvenation (Rank 7)
        [417064] = CreateSpellPriority(5),   -- Rejuvenation (Rank 8)
        [417065] = CreateSpellPriority(5),   -- Rejuvenation (Rank 9)
        [417066] = CreateSpellPriority(5),   -- Rejuvenation (Rank 10)
        [417068] = CreateSpellPriority(5),   -- Rejuvenation (Rank 11)
        [8936] = CreateSpellPriority(5),     -- Regrowth (Rank 1)
        [8938] = CreateSpellPriority(5),     -- Regrowth (Rank 2)
        [8939] = CreateSpellPriority(5),     -- Regrowth (Rank 3)
        [8940] = CreateSpellPriority(5),     -- Regrowth (Rank 4)
        [8941] = CreateSpellPriority(5),     -- Regrowth (Rank 5)
        [9750] = CreateSpellPriority(5),     -- Regrowth (Rank 6)
        [9856] = CreateSpellPriority(5),     -- Regrowth (Rank 7)
        [9857] = CreateSpellPriority(5),     -- Regrowth (Rank 8)
        [9858] = CreateSpellPriority(5),     -- Regrowth (Rank 9)
        [436937] = CreateSpellPriority(5),   -- Regrowth (Rank 1)
        [436938] = CreateSpellPriority(5),   -- Regrowth (Rank 2)
        [436939] = CreateSpellPriority(5),   -- Regrowth (Rank 3)
        [436940] = CreateSpellPriority(5),   -- Regrowth (Rank 4)
        [436942] = CreateSpellPriority(5),   -- Regrowth (Rank 5)
        [436943] = CreateSpellPriority(5),   -- Regrowth (Rank 6)
        [436944] = CreateSpellPriority(5),   -- Regrowth (Rank 7)
        [436945] = CreateSpellPriority(5),   -- Regrowth (Rank 8)
        [436946] = CreateSpellPriority(5),   -- Regrowth (Rank 9)

        -- Cooldowns and procs
        [17116] = CreateSpellPriority(5),    -- Nature's Swiftness
        [16870] = CreateSpellPriority(5),    -- Clearcasting
        [16886] = CreateSpellPriority(5),    -- Nature's Grace
        [5217] = CreateSpellPriority(5),     -- Tiger's Fury
        [1312152] = CreateSpellPriority(5),  -- Tiger's Fury
        [5229] = CreateSpellPriority(5),     -- Enrage
        [25503] = CreateSpellPriority(5),    -- Enrage
        [408255] = CreateSpellPriority(5),   -- Eclipse
        [414800] = CreateSpellPriority(5),   -- Fury of Stormrage
        [1226035] = CreateSpellPriority(5),  -- Swiftbloom
        [467204] = CreateSpellPriority(5),   -- Healing Grace
        [1226105] = CreateSpellPriority(5),  -- Sunsurge
        [1226106] = CreateSpellPriority(5),  -- Moonsurge
        [467088] = CreateSpellPriority(5),   -- Astral Power
        [1226127] = CreateSpellPriority(5),  -- Savage Flurry
        [1213190] = CreateSpellPriority(5),  -- Animal Fury
    },
    ["HUNTER"] = {
        -- Defensives
        [19263] = CreateSpellPriority(5),    -- Deterrence

        -- Cooldowns and procs
        [3045] = CreateSpellPriority(5),     -- Rapid Fire
        [6150] = CreateSpellPriority(5),     -- Quick Shots
        [1223758] = CreateSpellPriority(5),  -- The Beast Within
        [415414] = CreateSpellPriority(5),   -- Lock and Load
        [425714] = CreateSpellPriority(5),   -- Cobra Strikes
        [415401] = CreateSpellPriority(5),   -- Sniper's Aim
        [456382] = CreateSpellPriority(5),   -- Precision
        [415407] = CreateSpellPriority(5),   -- Rapid Killing
        [1233451] = CreateSpellPriority(5),  -- Trick Shots
        [468388] = CreateSpellPriority(5),   -- Locked In
        [23721] = CreateSpellPriority(5),    -- Arcane Infused
        [467446] = CreateSpellPriority(5),   -- Arcane Infused
        [467331] = CreateSpellPriority(5),   -- Clever Strikes
    },
    ["MAGE"] = {
        -- Defensives
        [11958] = CreateSpellPriority(5),    -- Ice Block
        [27619] = CreateSpellPriority(5),    -- Ice Block
        [11426] = CreateSpellPriority(5),    -- Ice Barrier (Rank 1)
        [13031] = CreateSpellPriority(5),    -- Ice Barrier (Rank 2)
        [13032] = CreateSpellPriority(5),    -- Ice Barrier (Rank 3)
        [13033] = CreateSpellPriority(5),    -- Ice Barrier (Rank 4)
        [1213278] = CreateSpellPriority(5),  -- Ice Barrier (Rank 4)
        [1463] = CreateSpellPriority(5),     -- Mana Shield (Rank 1)
        [8494] = CreateSpellPriority(5),     -- Mana Shield (Rank 2)
        [8495] = CreateSpellPriority(5),     -- Mana Shield (Rank 3)
        [10191] = CreateSpellPriority(5),    -- Mana Shield (Rank 4)
        [10192] = CreateSpellPriority(5),    -- Mana Shield (Rank 5)
        [10193] = CreateSpellPriority(5),    -- Mana Shield (Rank 6)
        [412116] = CreateSpellPriority(5),   -- Mana Shield (Rank 1)
        [412118] = CreateSpellPriority(5),   -- Mana Shield (Rank 2)
        [412120] = CreateSpellPriority(5),   -- Mana Shield (Rank 3)
        [412121] = CreateSpellPriority(5),   -- Mana Shield (Rank 4)
        [412122] = CreateSpellPriority(5),   -- Mana Shield (Rank 5)
        [412123] = CreateSpellPriority(5),   -- Mana Shield (Rank 6)
        [543] = CreateSpellPriority(5),      -- Fire Ward (Rank 1)
        [8457] = CreateSpellPriority(5),     -- Fire Ward (Rank 2)
        [8458] = CreateSpellPriority(5),     -- Fire Ward (Rank 3)
        [10223] = CreateSpellPriority(5),    -- Fire Ward (Rank 4)
        [10225] = CreateSpellPriority(5),    -- Fire Ward (Rank 5)
        [412214] = CreateSpellPriority(5),   -- Fire Ward (Rank 1)
        [412218] = CreateSpellPriority(5),   -- Fire Ward (Rank 2)
        [412230] = CreateSpellPriority(5),   -- Fire Ward (Rank 3)
        [412231] = CreateSpellPriority(5),   -- Fire Ward (Rank 4)
        [412232] = CreateSpellPriority(5),   -- Fire Ward (Rank 5)
        [6143] = CreateSpellPriority(5),     -- Frost Ward (Rank 1)
        [8461] = CreateSpellPriority(5),     -- Frost Ward (Rank 2)
        [8462] = CreateSpellPriority(5),     -- Frost Ward (Rank 3)
        [10177] = CreateSpellPriority(5),    -- Frost Ward (Rank 4)
        [28609] = CreateSpellPriority(5),    -- Frost Ward (Rank 5)
        [412202] = CreateSpellPriority(5),   -- Frost Ward (Rank 1)
        [412205] = CreateSpellPriority(5),   -- Frost Ward (Rank 2)
        [412207] = CreateSpellPriority(5),   -- Frost Ward (Rank 3)
        [412209] = CreateSpellPriority(5),   -- Frost Ward (Rank 4)
        [412210] = CreateSpellPriority(5),   -- Frost Ward (Rank 5)

        -- Cooldowns and procs
        [12042] = CreateSpellPriority(5),    -- Arcane Power
        [12043] = CreateSpellPriority(5),    -- Presence of Mind
        [28682] = CreateSpellPriority(5),    -- Combustion
        [12051] = CreateSpellPriority(5),    -- Evocation
        [456397] = CreateSpellPriority(5),   -- Evocation
        [425121] = CreateSpellPriority(5),   -- Icy Veins
        [429125] = CreateSpellPriority(5),   -- Icy Veins
        [12536] = CreateSpellPriority(5),    -- Clearcasting
        [48108] = CreateSpellPriority(5),    -- Hot Streak
        [400625] = CreateSpellPriority(5),   -- Heating Up
        [400669] = CreateSpellPriority(5),   -- Fingers of Frost
        [400670] = CreateSpellPriority(5),   -- Fingers of Frost
        [400589] = CreateSpellPriority(5),   -- Missile Barrage
        [1326083] = CreateSpellPriority(5),  -- Missile Barrage
        [400730] = CreateSpellPriority(5),   -- Fireball!
        [400573] = CreateSpellPriority(5),   -- Arcane Blast
        [400586] = CreateSpellPriority(5),   -- Arcane Blast
        [1300176] = CreateSpellPriority(5),  -- Arcane Blast
        [1300177] = CreateSpellPriority(5),  -- Arcane Blast
        [22008] = CreateSpellPriority(5),    -- Netherwind Focus
    },
    ["PALADIN"] = {
        -- Defensives
        [642] = CreateSpellPriority(5),      -- Divine Shield (Rank 1)
        [1020] = CreateSpellPriority(5),     -- Divine Shield (Rank 2)
        [498] = CreateSpellPriority(5),      -- Divine Protection (Rank 1)
        [5573] = CreateSpellPriority(5),     -- Divine Protection (Rank 2)
        [458312] = CreateSpellPriority(5),   -- Divine Protection (Rank 1)
        [458371] = CreateSpellPriority(5),   -- Divine Protection (Rank 2)
        [1022] = CreateSpellPriority(5),     -- Blessing of Protection (Rank 1)
        [5599] = CreateSpellPriority(5),     -- Blessing of Protection (Rank 2)
        [10278] = CreateSpellPriority(5),    -- Blessing of Protection (Rank 3)
        [442948] = CreateSpellPriority(5),   -- Blessing of Protection
        [1044] = CreateSpellPriority(5),     -- Blessing of Freedom
        [6940] = CreateSpellPriority(5),     -- Blessing of Sacrifice (Rank 1)
        [20729] = CreateSpellPriority(5),    -- Blessing of Sacrifice (Rank 2)
        [20925] = CreateSpellPriority(5),    -- Holy Shield (Rank 1)
        [20927] = CreateSpellPriority(5),    -- Holy Shield (Rank 2)
        [20928] = CreateSpellPriority(5),    -- Holy Shield (Rank 3)
        [1239570] = CreateSpellPriority(5),  -- Holy Shield (Rank 4)
        [53601] = CreateSpellPriority(5),    -- Sacred Shield (Rank 1)
        [58597] = CreateSpellPriority(5),    -- Sacred Shield (Rank 1)
        [412019] = CreateSpellPriority(5),   -- Sacred Shield
        [1310927] = CreateSpellPriority(5),  -- Light's Fury
        [1311015] = CreateSpellPriority(5),  -- Templar's Bulwark
        [20128] = CreateSpellPriority(5),    -- Redoubt

        -- Seals
        [21084] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 1)
        [20287] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 2)
        [20288] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 3)
        [20289] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 4)
        [20290] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 5)
        [20291] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 6)
        [20292] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 7)
        [20293] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 8)
        [20154] = CreateSpellPriority(5),    -- Seal of Righteousness (Rank 1)
        [21082] = CreateSpellPriority(5),    -- Seal of the Crusader (Rank 1)
        [20162] = CreateSpellPriority(5),    -- Seal of the Crusader (Rank 2)
        [20305] = CreateSpellPriority(5),    -- Seal of the Crusader (Rank 3)
        [20306] = CreateSpellPriority(5),    -- Seal of the Crusader (Rank 4)
        [20307] = CreateSpellPriority(5),    -- Seal of the Crusader (Rank 5)
        [20308] = CreateSpellPriority(5),    -- Seal of the Crusader (Rank 6)
        [20375] = CreateSpellPriority(5),    -- Seal of Command (Rank 1)
        [20915] = CreateSpellPriority(5),    -- Seal of Command (Rank 2)
        [20918] = CreateSpellPriority(5),    -- Seal of Command (Rank 3)
        [20919] = CreateSpellPriority(5),    -- Seal of Command (Rank 4)
        [20920] = CreateSpellPriority(5),    -- Seal of Command (Rank 5)
        [20165] = CreateSpellPriority(5),    -- Seal of Light (Rank 1)
        [20347] = CreateSpellPriority(5),    -- Seal of Light (Rank 2)
        [20348] = CreateSpellPriority(5),    -- Seal of Light (Rank 3)
        [20349] = CreateSpellPriority(5),    -- Seal of Light (Rank 4)
        [20166] = CreateSpellPriority(5),    -- Seal of Wisdom (Rank 1)
        [20356] = CreateSpellPriority(5),    -- Seal of Wisdom (Rank 2)
        [20357] = CreateSpellPriority(5),    -- Seal of Wisdom (Rank 3)
        [20164] = CreateSpellPriority(5),    -- Seal of Justice
        [1311649] = CreateSpellPriority(5),  -- Seal of Fury (Rank 1)
        [1311656] = CreateSpellPriority(5),  -- Seal of Fury (Rank 2)

        -- Cooldowns and procs
        [20216] = CreateSpellPriority(5),    -- Divine Favor
        [20050] = CreateSpellPriority(5),    -- Vengeance
        [407788] = CreateSpellPriority(5),   -- Avenging Wrath
        [53489] = CreateSpellPriority(5),    -- The Art of War
        [53672] = CreateSpellPriority(5),    -- Infusion of Light
        [437063] = CreateSpellPriority(5),   -- Infusion of Light
        [1213415] = CreateSpellPriority(5),  -- Shielded in Righteousness
    },
    ["PRIEST"] = {
        -- Defensives
        [17] = CreateSpellPriority(5),       -- Power Word: Shield (Rank 1)
        [592] = CreateSpellPriority(5),      -- Power Word: Shield (Rank 2)
        [600] = CreateSpellPriority(5),      -- Power Word: Shield (Rank 3)
        [3747] = CreateSpellPriority(5),     -- Power Word: Shield (Rank 4)
        [6065] = CreateSpellPriority(5),     -- Power Word: Shield (Rank 5)
        [6066] = CreateSpellPriority(5),     -- Power Word: Shield (Rank 6)
        [10898] = CreateSpellPriority(5),    -- Power Word: Shield (Rank 7)
        [10899] = CreateSpellPriority(5),    -- Power Word: Shield (Rank 8)
        [10900] = CreateSpellPriority(5),    -- Power Word: Shield (Rank 9)
        [10901] = CreateSpellPriority(5),    -- Power Word: Shield (Rank 10)
        [27607] = CreateSpellPriority(5),    -- Power Word: Shield (Rank 10)
        [1236154] = CreateSpellPriority(5),  -- Power Word: Shield (Rank 10)
        [402004] = CreateSpellPriority(5),   -- Pain Suppression
        [425294] = CreateSpellPriority(5),   -- Dispersion
        [6346] = CreateSpellPriority(5),     -- Fear Ward
        [2651] = CreateSpellPriority(5),     -- Elune's Grace
        [586] = CreateSpellPriority(5),      -- Fade (Rank 1)
        [9578] = CreateSpellPriority(5),     -- Fade (Rank 2)
        [9579] = CreateSpellPriority(5),     -- Fade (Rank 3)
        [9592] = CreateSpellPriority(5),     -- Fade (Rank 4)
        [10941] = CreateSpellPriority(5),    -- Fade (Rank 5)
        [10942] = CreateSpellPriority(5),    -- Fade (Rank 6)
        [13896] = CreateSpellPriority(5),    -- Feedback (Rank 1)
        [19271] = CreateSpellPriority(5),    -- Feedback (Rank 2)
        [19273] = CreateSpellPriority(5),    -- Feedback (Rank 3)
        [19274] = CreateSpellPriority(5),    -- Feedback (Rank 4)
        [19275] = CreateSpellPriority(5),    -- Feedback (Rank 5)
        [447549] = CreateSpellPriority(5),   -- Feedback (Rank 5)

        -- Heals
        [139] = CreateSpellPriority(5),      -- Renew (Rank 1)
        [6074] = CreateSpellPriority(5),     -- Renew (Rank 2)
        [6075] = CreateSpellPriority(5),     -- Renew (Rank 3)
        [6076] = CreateSpellPriority(5),     -- Renew (Rank 4)
        [6077] = CreateSpellPriority(5),     -- Renew (Rank 5)
        [6078] = CreateSpellPriority(5),     -- Renew (Rank 6)
        [10927] = CreateSpellPriority(5),    -- Renew (Rank 7)
        [10928] = CreateSpellPriority(5),    -- Renew (Rank 8)
        [10929] = CreateSpellPriority(5),    -- Renew (Rank 9)
        [25315] = CreateSpellPriority(5),    -- Renew (Rank 10)
        [27606] = CreateSpellPriority(5),    -- Renew (Rank 9)
        [1236151] = CreateSpellPriority(5),  -- Renew (Rank 9)
        [1289450] = CreateSpellPriority(5),  -- Renew (Rank 9)
        [425268] = CreateSpellPriority(5),   -- Renew (Rank 1)
        [425269] = CreateSpellPriority(5),   -- Renew (Rank 2)
        [425270] = CreateSpellPriority(5),   -- Renew (Rank 3)
        [425271] = CreateSpellPriority(5),   -- Renew (Rank 4)
        [425272] = CreateSpellPriority(5),   -- Renew (Rank 5)
        [425273] = CreateSpellPriority(5),   -- Renew (Rank 6)
        [425274] = CreateSpellPriority(5),   -- Renew (Rank 7)
        [425275] = CreateSpellPriority(5),   -- Renew (Rank 8)
        [425276] = CreateSpellPriority(5),   -- Renew (Rank 9)
        [425277] = CreateSpellPriority(5),   -- Renew (Rank 10)

        -- Cooldowns and procs
        [14751] = CreateSpellPriority(5),    -- Inner Focus
        [10060] = CreateSpellPriority(5),    -- Power Infusion
        [15271] = CreateSpellPriority(5),    -- Spirit Tap
        [413247] = CreateSpellPriority(5),   -- Serendipity
        [1226500] = CreateSpellPriority(5),  -- Absolution
        [467543] = CreateSpellPriority(5),   -- Deliverance
        [1284536] = CreateSpellPriority(5),  -- Holy Purpose
        [456549] = CreateSpellPriority(5),   -- Melting Faces
    },
    ["ROGUE"] = {
        -- Defensives
        [5277] = CreateSpellPriority(5),     -- Evasion
        [15087] = CreateSpellPriority(5),    -- Evasion
        [2983] = CreateSpellPriority(5),     -- Sprint (Rank 1)
        [8696] = CreateSpellPriority(5),     -- Sprint (Rank 2)
        [11305] = CreateSpellPriority(5),    -- Sprint (Rank 3)
        [400024] = CreateSpellPriority(5),   -- Cheating Death
        [14278] = CreateSpellPriority(5),    -- Ghostly Strike
        [1329326] = CreateSpellPriority(5),  -- Ghostly Strike

        -- Cooldowns and procs
        [5171] = CreateSpellPriority(5),     -- Slice and Dice (Rank 1)
        [6774] = CreateSpellPriority(5),     -- Slice and Dice (Rank 2)
        [13750] = CreateSpellPriority(5),    -- Adrenaline Rush
        [13877] = CreateSpellPriority(5),    -- Blade Flurry
        [14177] = CreateSpellPriority(5),    -- Cold Blood
        [14143] = CreateSpellPriority(5),    -- Remorseless
        [462707] = CreateSpellPriority(5),   -- Cutthroat
        [1241810] = CreateSpellPriority(5),  -- Cutthroat
        [457342] = CreateSpellPriority(5),   -- Clearcasting
        [467735] = CreateSpellPriority(5),   -- Clearcasting
    },
    ["SHAMAN"] = {
        -- Defensives
        [974] = CreateSpellPriority(5),      -- Earth Shield (Rank 1)
        [440591] = CreateSpellPriority(5),   -- Spirit Walk
        [1213934] = CreateSpellPriority(5),  -- Stormbraced

        -- Heals
        [408521] = CreateSpellPriority(5),   -- Riptide (Rank 1)
        [1239242] = CreateSpellPriority(5),  -- Riptide (Rank 2)
        [1239243] = CreateSpellPriority(5),  -- Riptide (Rank 3)

        -- Cooldowns and procs
        [16188] = CreateSpellPriority(5),    -- Nature's Swiftness
        [16166] = CreateSpellPriority(5),    -- Lightning Mastery
        [16246] = CreateSpellPriority(5),    -- Clearcasting
        [16257] = CreateSpellPriority(5),    -- Flurry
        [408505] = CreateSpellPriority(5),   -- Maelstrom Weapon
        [415105] = CreateSpellPriority(5),   -- Power Surge
        [440285] = CreateSpellPriority(5),   -- Power Surge
        [468526] = CreateSpellPriority(5),   -- Power Surge
        [432041] = CreateSpellPriority(5),   -- Tidal Waves
        [467880] = CreateSpellPriority(5),   -- Stormfury
        [1227088] = CreateSpellPriority(5),  -- Swiftearth
        [1233835] = CreateSpellPriority(5),  -- Thunder and Lava
    },
    ["WARLOCK"] = {
        -- Defensives
        [6229] = CreateSpellPriority(5),     -- Shadow Ward (Rank 1)
        [11739] = CreateSpellPriority(5),    -- Shadow Ward (Rank 2)
        [11740] = CreateSpellPriority(5),    -- Shadow Ward (Rank 3)
        [28610] = CreateSpellPriority(5),    -- Shadow Ward (Rank 4)
        [7812] = CreateSpellPriority(5),     -- Sacrifice (Rank 1)
        [19438] = CreateSpellPriority(5),    -- Sacrifice (Rank 2)
        [19440] = CreateSpellPriority(5),    -- Sacrifice (Rank 3)
        [19441] = CreateSpellPriority(5),    -- Sacrifice (Rank 4)
        [19442] = CreateSpellPriority(5),    -- Sacrifice (Rank 5)
        [19443] = CreateSpellPriority(5),    -- Sacrifice (Rank 6)
        [128] = CreateSpellPriority(5),      -- Spellstone
        [17729] = CreateSpellPriority(5),    -- Greater Spellstone
        [17730] = CreateSpellPriority(5),    -- Major Spellstone
        [425463] = CreateSpellPriority(5),   -- Demonic Grace
        [430025] = CreateSpellPriority(5),   -- Demonic Grace
        [469224] = CreateSpellPriority(5),   -- Void Walking

        -- Cooldowns and procs
        [17941] = CreateSpellPriority(5),    -- Shadow Trance
        [18708] = CreateSpellPriority(5),    -- Fel Domination
        [18288] = CreateSpellPriority(5),    -- Amplify Curse
        [427714] = CreateSpellPriority(5),   -- Backdraft
        [440873] = CreateSpellPriority(5),   -- Decimation
        [457558] = CreateSpellPriority(5),   -- Fire Trance
        [457643] = CreateSpellPriority(5),   -- Soul Fire!
        [450013] = CreateSpellPriority(5),   -- Shadow Spark
    },
    ["WARRIOR"] = {
        -- Defensives
        [871] = CreateSpellPriority(5),      -- Shield Wall
        [15062] = CreateSpellPriority(5),    -- Shield Wall
        [29061] = CreateSpellPriority(5),    -- Shield Wall
        [1277424] = CreateSpellPriority(5),  -- Shield Wall
        [12976] = CreateSpellPriority(5),    -- Last Stand
        [2565] = CreateSpellPriority(5),     -- Shield Block
        [23920] = CreateSpellPriority(5),    -- Spell Reflection
        [20230] = CreateSpellPriority(5),    -- Retaliation
        [18499] = CreateSpellPriority(5),    -- Berserker Rage

        -- Cooldowns and procs
        [29131] = CreateSpellPriority(5),    -- Bloodrage
        [12328] = CreateSpellPriority(5),    -- Death Wish
        [1719] = CreateSpellPriority(5),     -- Recklessness
        [13847] = CreateSpellPriority(5),    -- Recklessness
        [12292] = CreateSpellPriority(5),    -- Sweeping Strikes
        [12880] = CreateSpellPriority(5),    -- Enrage
        [427066] = CreateSpellPriority(5),   -- Enrage
        [462885] = CreateSpellPriority(5),   -- Enrage
        [12966] = CreateSpellPriority(5),    -- Flurry
        [440114] = CreateSpellPriority(5),   -- Sudden Death
        [413399] = CreateSpellPriority(5),   -- Blood Surge
        [426969] = CreateSpellPriority(5),   -- Taste for Blood
        [426979] = CreateSpellPriority(5),   -- Sword and Board
    },
}

AddSpells(data)
