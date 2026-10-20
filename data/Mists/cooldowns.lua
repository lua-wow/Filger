local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Mists of Pandaria Classic
--------------------------------------------------
local data = {
    ["DRUID"] = {
        -- General
        CreateSpellCooldown(740), -- Tranquility
        CreateSpellCooldown(20484), -- Rebirth
        CreateSpellCooldown(22812), -- Barkskin
        CreateSpellCooldown(29166), -- Innervate

        -- Guardian / Feral
        CreateSpellCooldown(61336), -- Survival Instincts
        CreateSpellCooldown(102795), -- Bear Hug
        CreateSpellCooldown(106922), -- Might of Ursoc
        CreateSpellCooldown(106952), -- Berkserk

        -- Restoration
			CreateSpellCooldown(102342), -- Ironbark
    },
    ["DEATHKNIGHT"] = {
        CreateSpellCooldown(57330), -- Horn of Winter
			CreateSpellCooldown(48792), -- Icebound Fortitude
			CreateSpellCooldown(48707), -- Anti-Magic Shell
			CreateSpellCooldown(49028), -- Dancing Rune Weapon
			CreateSpellCooldown(49039), -- Lichborne
			CreateSpellCooldown(55233), -- Vampiric Blood
			CreateSpellCooldown(42650), -- Army of the Dead
			CreateSpellCooldown(108200), -- Remorseless Winter
    },
    ["HUNTER"] = {},
    ["MAGE"] = {},
    ["MONK"] = {
        -- General
        CreateSpellCooldown(115078), -- Paralysis
        CreateSpellCooldown(115176), -- Zen Meditation
        CreateSpellCooldown(117368), -- Grapple Weapon
        CreateSpellCooldown(137562), -- Nimble Brew

        -- Talents
        CreateSpellCooldown(116844), -- Ring of Peace
        CreateSpellCooldown(119392), -- Charging Ox Wave
        CreateSpellCooldown(119381), -- Leg Sweep
        CreateSpellCooldown(122278), -- Dampen Harm
        CreateSpellCooldown(122283), -- Diffuse Magic
        CreateSpellCooldown(123904), -- Invoke Xuen, the White Tiger

        -- Brewmaster
        CreateSpellCooldown(115203), -- Fortifying Brew
        CreateSpellCooldown(115213), -- Avert Harm
        CreateSpellCooldown(115308), -- Elusive Brew
        CreateSpellCooldown(115315), -- Summon Black Ox Statue
        CreateSpellCooldown(115399), -- Chi Brew
        CreateSpellCooldown(122057), -- Clash
        CreateSpellCooldown(123402), -- Guard

        -- Mistweaver
        CreateSpellCooldown(115310), -- Revival
        CreateSpellCooldown(116849), -- Life Cocoon
        CreateSpellCooldown(116680), -- Thunder Focus Tea
        
        -- Windwaker
        CreateSpellCooldown(122470), -- Touch of Karma
    },
    ["PALADIN"] = {
        -- General
        CreateSpellCooldown(498), -- Divine Protection
        CreateSpellCooldown(642), -- Divine Shield
        CreateSpellCooldown(633), -- Lay on Hands
        CreateSpellCooldown(1022), -- Blessing of Protection
        CreateSpellCooldown(1044), -- Blessing of Freedom
        CreateSpellCooldown(6940), -- Blessing of Sacrifice

        -- Talents
        CreateSpellCooldown(31821), -- Aura Mastery
        CreateSpellCooldown(31842), -- Divine Favor
        CreateSpellCooldown(31850), -- Ardent Defender
        CreateSpellCooldown(31884), -- Avenging Wrath (Holy)
    },
    ["PRIEST"] = {
        -- General
        CreateSpellCooldown(586), -- Fade
        CreateSpellCooldown(6346), -- Fear Ward
        CreateSpellCooldown(8122), -- Psychic Scream
        CreateSpellCooldown(34433), -- Shadowfiend
        CreateSpellCooldown(73325), -- Leap of Faith
        CreateSpellCooldown(64901), -- Hymn of Hope

        -- Talents
        CreateSpellCooldown(10060), -- Power Infusion

        -- Discipline
        CreateSpellCooldown(33206), -- Pain Suppression
        CreateSpellCooldown(62618), -- Power Word: Barrier
        CreateSpellCooldown(81700), -- Archangel
        CreateSpellCooldown(89485), -- Inner Focus
        CreateSpellCooldown(109964), -- Spirit Shell
        
        -- Holy
        CreateSpellCooldown(64843), -- Divine Hymn
        CreateSpellCooldown(47788), -- Guardian Spirit
        
        -- Shadow
        CreateSpellCooldown(15487), -- Silence
        CreateSpellCooldown(15286), -- Vampiric Embrace
        CreateSpellCooldown(47585), -- Dispersion
        CreateSpellCooldown(64044), -- Psychic Horror
        CreateSpellCooldown(123040), -- Mind Bender
    },
    ["SHAMAN"] = {
        -- General
        CreateSpellCooldown(8143), -- Tremor Totem
        CreateSpellCooldown(32182), -- Heroism
        CreateSpellCooldown(79206), -- Spiritwalker's Grace
        CreateSpellCooldown(108269), -- Capacitor Totem
        CreateSpellCooldown(108280), -- Healing Tide Totem
        CreateSpellCooldown(114049), -- Ascendance
        CreateSpellCooldown(120668), -- Stormlash Totem
    },
    ["WARRIOR"] = {
        -- General
        CreateSpellCooldown(871), -- Shield Wall
        CreateSpellCooldown(1719), -- Recklessness
        CreateSpellCooldown(3411), -- Intervene
        CreateSpellCooldown(5246), -- Intimidating Shout
        CreateSpellCooldown(23920), -- Spell Reflection
        CreateSpellCooldown(64382), -- Shattering Throw
        CreateSpellCooldown(97462), -- Rallying Cry
        CreateSpellCooldown(114192), -- Mocking Banner
        CreateSpellCooldown(114203), -- Demoralizing Banner
        CreateSpellCooldown(114207), -- Skull Banner

        -- Talents
        CreateSpellCooldown(12292), -- Bloodbath
        CreateSpellCooldown(46924), -- Bladestorm
        CreateSpellCooldown(46968), -- Shockwave
        CreateSpellCooldown(55694), -- Enraged Regeneration
        CreateSpellCooldown(107570), -- Storm Bolt
        CreateSpellCooldown(107574), -- Avatar
        CreateSpellCooldown(114028), -- Mass Spell Reflection
        CreateSpellCooldown(114030), -- Vigilance
        CreateSpellCooldown(118000), -- Dragon Roar
    }
}

AddCooldowns(data)
