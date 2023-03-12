local _, ns = ...
local Filger = ns.Filger
local PLAYER_CLASS = Filger.MyClass

local ClassesDispelFilter = {
    ["FRIENDLY"] = {
        ["DRUID"] = {
            ["Magic"] = false,
            ["Curse"] = true,
            ["Poison"] = true,
            ["Disease"] = false
        },
        ["EVOKER"] = {
            ["Magic"] = true,
            ["Curse"] = true,
            ["Poison"] = true,
            ["Disease"] = true
        },
        ["MAGE"] = {
            ["Curse"] = true
        },
        ["MONK"] = {
            ["Magic"] = true,
            ["Poison"] = true,
            ["Disease"] = true
        },
        ["PALADIN"] = {
            ["Magic"] = true,
            ["Poison"] = true,
            ["Disease"] = true
        },
        ["PRIEST"] = {
            ["Magic"] = true,
            ["Disease"] = true
        },
        ["SHAMAN"] = {
            ["Magic"] = false,
            ["Curse"] = (ns.Filger.isRetail and true) or (ns.Filger.isClassic and true) or false,
            ["Poison"] = true,
            ["Disease"] = true
        }
    },
    ["ENEMY"] = {
        ["DEMONHUNTER"] = {
            ["Magic"] = true
        },
        ["MAGE"] = {
            ["Magic"] = true
        },
        ["PRIEST"] = {
            ["Magic"] = true
        },
        ["SHAMAN"] = {
            ["Magic"] = true
        }
    }
}

Filger.DispelFilter = {}
Filger.DispelFilter["FRIENDLY"] = ClassesDispelFilter["FRIENDLY"][PLAYER_CLASS] or {}
Filger.DispelFilter["ENEMY"] = ClassesDispelFilter["ENEMY"][PLAYER_CLASS] or {}

local function CheckTalentTree(tree)
	local activeSpecGroup = GetActiveSpecGroup()
	if (activeSpecGroup) then
		return (tree == GetSpecialization(false, false, activeSpecGroup))
	end
end

local function IsTalentKnown(spellID)
    return (Filger.talents and Filger.talents[spellID] or false)
end

local function CheckClassicSpecialization()
    if (PLAYER_CLASS == "DRUID") then
        local RemoveCurse = IsSpellKnown(2782)
        local AbolishPoison = IsSpellKnown(2893)
        local CurePoison = IsSpellKnown(8946)
		
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveCurse or false)
		Filger.DispelFilter["FRIENDLY"]["Poison"] = (CurePoison or AbolishPoison or false)
	elseif (PLAYER_CLASS == "HUNTER") then
        local TranquilizingShot = IsSpellKnown(19801)

        Filger.DispelFilter["ENEMY"]["Frenzy"] = (TranquilizingShot or false)
	elseif (PLAYER_CLASS == "MAGE") then
        local RemoveLesserCurse = IsSpellKnown(475)

        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveLesserCurse or false)
	elseif (PLAYER_CLASS == "PALADIN") then
		local Purify = IsSpellKnown(1152)
		local Cleanse = IsSpellKnown(4987)
        
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (Cleanse or false)
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (Cleanse or Purify or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (Cleanse or Purify or false)
	elseif (PLAYER_CLASS == "PRIEST") then
		local DispelMagic = (IsSpellKnown(527) or IsSpellKnown(988))
        local CureDisease = IsSpellKnown(528)
        local AbolishDisease = IsSpellKnown(552)

        Filger.DispelFilter["ENEMY"]["Magic"] = (DispelMagic or false)
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (DispelMagic or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (CureDisease or AbolishDisease or false)
	elseif (PLAYER_CLASS == "SHAMAN") then
        local CureDisease = IsSpellKnown(2870)
        local CurePoison = IsSpellKnown(526)
        local Purge = (IsSpellKnown(370) or IsSpellKnown(8012))

		Filger.DispelFilter["ENEMY"]["Magic"] = (Purge or false)
		Filger.DispelFilter["FRIENDLY"]["Poison"] = (CurePoison or false)
		Filger.DispelFilter["FRIENDLY"]["Disease"] = (CureDisease or false)
    elseif (PLAYER_CLASS == "WARRIOR") then
        local ShieldSlam = (
            IsSpellKnown(23922)
            or IsSpellKnown(23923)
            or IsSpellKnown(23924)
            or IsSpellKnown(23925)
        )

		Filger.DispelFilter["ENEMY"]["Magic"] = (ShieldSlam or false)
    elseif (PLAYER_CLASS == "WARLOCK") then
        local DevourMagic = (
            IsSpellKnown(19505, true) 
            or IsSpellKnown(19731, true)
            or IsSpellKnown(19734, true)
            or IsSpellKnown(19736, true)
        )

		Filger.DispelFilter["ENEMY"]["Magic"] = (DevourMagic or false)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = (DevourMagic or false)
	end
end

local function CheckTBCSpecialization()
    local ConsumeMagic = IsSpellKnown(32676)           -- Blood Elf

    if (PLAYER_CLASS == "DRUID") then
        local RemoveCurse = IsSpellKnown(2782)
        local AbolishPoison = IsSpellKnown(2893)
        local CurePoison = IsSpellKnown(8946)
		
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveCurse or false)
		Filger.DispelFilter["FRIENDLY"]["Poison"] = (CurePoison or AbolishPoison or false)
	elseif (PLAYER_CLASS == "HUNTER") then
        local TranquilizingShot = IsSpellKnown(19801)

        Filger.DispelFilter["ENEMY"]["Frenzy"] = (TranquilizingShot or false)
	elseif (PLAYER_CLASS == "MAGE") then
        local RemoveLesserCurse = IsSpellKnown(475)
        local Spellsteal = IsSpellKnown(30449)

        Filger.DispelFilter["ENEMY"]["Magic"] = (Spellsteal or false)
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveLesserCurse or false)
	elseif (PLAYER_CLASS == "PALADIN") then
		local Purify = IsSpellKnown(1152)
		local Cleanse = IsSpellKnown(4987)
        
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (Cleanse or false)
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (Cleanse or Purify or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (Cleanse or Purify or false)
	elseif (PLAYER_CLASS == "PRIEST") then
		local DispelMagic = (IsSpellKnown(527) or IsSpellKnown(988))
        local CureDisease = IsSpellKnown(528)
        local AbolishDisease = IsSpellKnown(552)
        local MassDispel = IsSpellKnown(32375)

        Filger.DispelFilter["ENEMY"]["Magic"] = (DispelMagic or MassDispel or false)
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (DispelMagic or MassDispel or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (CureDisease or AbolishDisease or false)
	elseif (PLAYER_CLASS == "SHAMAN") then
        local Purge = (IsSpellKnown(370) or IsSpellKnown(8012))
        local CurePoison = IsSpellKnown(526)
        local CureDisease = IsSpellKnown(2870)

		Filger.DispelFilter["ENEMY"]["Magic"] = (Purge or false)
		Filger.DispelFilter["FRIENDLY"]["Poison"] = (CurePoison or false)
		Filger.DispelFilter["FRIENDLY"]["Disease"] = (CureDisease or false)
    elseif (PLAYER_CLASS == "WARRIOR") then
        local ShieldSlam = (
            IsSpellKnown(23922)
            or IsSpellKnown(23923)
            or IsSpellKnown(23924)
            or IsSpellKnown(23925)
            or IsSpellKnown(25258)
            or IsSpellKnown(30356)
        )

		Filger.DispelFilter["ENEMY"]["Magic"] = (ShieldSlam or false)
    elseif (PLAYER_CLASS == "WARLOCK") then
        local DevourMagic = (
            IsSpellKnown(19505, true) 
            or IsSpellKnown(19731, true)
            or IsSpellKnown(19734, true)
            or IsSpellKnown(19736, true)
            or IsSpellKnown(19736, true)
            or IsSpellKnown(27277, true)
        )

		Filger.DispelFilter["ENEMY"]["Magic"] = (DevourMagic or false)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = (DevourMagic or false)
	end
end

local function CheckWOTLKSpecialization()
    local ConsumeMagic = IsSpellKnown(32676)           -- Blood Elf

    if (PLAYER_CLASS == "DRUID") then
        local RemoveCurse = IsSpellKnown(2782)
        local AbolishPoison = IsSpellKnown(2893)
        local CurePoison = IsSpellKnown(8946)
		
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveCurse or false)
		Filger.DispelFilter["FRIENDLY"]["Poison"] = (CurePoison or AbolishPoison or false)
	elseif (PLAYER_CLASS == "HUNTER") then
        local TranquilizingShot = IsSpellKnown(19801)

        Filger.DispelFilter["ENEMY"]["Frenzy"] = (TranquilizingShot or false)
	elseif (PLAYER_CLASS == "MAGE") then
        local RemoveLesserCurse = IsSpellKnown(475)
        local Spellsteal = IsSpellKnown(30449)

        Filger.DispelFilter["ENEMY"]["Magic"] = (Spellsteal or false)
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveLesserCurse or false)
	elseif (PLAYER_CLASS == "PALADIN") then
		local Purify = IsSpellKnown(1152)
		local Cleanse = IsSpellKnown(4987)
        
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (Cleanse or false)
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (Cleanse or Purify or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (Cleanse or Purify or false)
	elseif (PLAYER_CLASS == "PRIEST") then
		local DispelMagic = (IsSpellKnown(527) or IsSpellKnown(988))
        local CureDisease = IsSpellKnown(528)
        local AbolishDisease = IsSpellKnown(552)
        local MassDispel = IsSpellKnown(32375)

        Filger.DispelFilter["ENEMY"]["Magic"] = (DispelMagic or MassDispel or false)
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (DispelMagic or MassDispel or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (CureDisease or AbolishDisease or false)
	elseif (PLAYER_CLASS == "SHAMAN") then
        local Purge = (IsSpellKnown(370) or IsSpellKnown(8012))
        local CureToxins = IsSpellKnown(526)
        local CleansingTotem = IsSpellKnown(8170)

		Filger.DispelFilter["ENEMY"]["Magic"] = (Purge or false)
		Filger.DispelFilter["FRIENDLY"]["Poison"] = (CureToxins or CleansingTotem or false)
		Filger.DispelFilter["FRIENDLY"]["Disease"] = (CureToxins or CleansingTotem or CureDisease or false)
    elseif (PLAYER_CLASS == "WARRIOR") then
        local ShieldSlam = (
            IsSpellKnown(23922)
            or IsSpellKnown(23923)
            or IsSpellKnown(23924)
            or IsSpellKnown(23925)
            or IsSpellKnown(25258)
            or IsSpellKnown(30356)
        )

		Filger.DispelFilter["ENEMY"]["Magic"] = (ShieldSlam or false)
    elseif (PLAYER_CLASS == "WARLOCK") then
        local DevourMagic = (
            IsSpellKnown(19505, true) 
            or IsSpellKnown(19731, true)
            or IsSpellKnown(19734, true)
            or IsSpellKnown(19736, true)
            or IsSpellKnown(19736, true)
            or IsSpellKnown(27277, true)
            or IsSpellKnown(67518, true)
        )

		Filger.DispelFilter["ENEMY"]["Magic"] = (DevourMagic or false)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = (DevourMagic or false)
	end
end

local function CheckRetailSpecialization()
	-- check for certain talents to see if we can dispel magic or not
    if (PLAYER_CLASS == "DEMONHUNTER") then
        local ConsumoMagic = IsSpellKnown(278326)           -- consume 1 beneficial Magic effect removing it from the target

        Filger.DispelFilter["ENEMY"]["Magic"] = (NatureCure or false)
    elseif (PLAYER_CLASS == "DRUID") then
        local NatureCure = IsSpellKnown(88423)              -- cures harmful effects on the friendly target, removing all Magic effects.
        local RemoveCorruption = IsSpellKnown(2782)         -- nullifies corrupting effects on the friendly target, removing all Curse and Poison effects.        
        local ImprovedNatureCure = IsTalentKnown(392378)    -- cures harmful effects on the friendly target, removing all Magic, Curse and Poison effects.

        Filger.DispelFilter["FRIENDLY"]["Magic"] = (NatureCure or false)
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (ImprovedNatureCure or RemoveCorruption or false)
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (ImprovedNatureCure or RemoveCorruption or false)
    elseif (PLAYER_CLASS == "EVOKER") then
        local Expurge = IsSpellKnown(365585)                -- expunge toxins affecting an ally, removing all Poison effects.
        local Naturalize = IsSpellKnown(360823)             -- cleanses harmful effects from the target, removing all Magic and Poison effects.
        local CauterizingFlame = IsSpellKnown(374251)       -- cauterize an ally's wounds, removing all Bleed, Poison, Curse, and Disease effects.

        Filger.DispelFilter["FRIENDLY"]["Magic"] = (Naturalize or false)
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (CauterizingFlame or false)
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (Naturalize or Expurge or CauterizingFlame or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (CauterizingFlame or false)
    elseif (PLAYER_CLASS == "HUNTER") then
        local TranquilizingShot = IsSpellKnown(19801)       -- removes 1 Enrage and 1 Magic effect from an enemy target.
        local MendingBandage = IsSpellKnown(212640)         -- instantly clears all Bleeds, Poisons, and Diseases from the target.

        -- Filger.DispelFilter["FRIENDLY"]["Poison"] = MendingBandage
        -- Filger.DispelFilter["FRIENDLY"]["Disease"] = MendingBandage
        Filger.DispelFilter["ENEMY"]["Magic"] = (TranquilizingShot or false)
    elseif (PLAYER_CLASS == "MAGE") then
        local RemoveCurse = IsSpellKnown(475)               -- removes 1 Curse from a friendly target.
        local Spellsteal = IsSpellKnown(30449)              -- steals a beneficial Magic effect from the target.

        Filger.DispelFilter["ENEMY"]["Magic"] = (Spellsteal or false)
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (RemoveCurse or false)
    elseif (PLAYER_CLASS == "MONK") then
        local MistweaverDetox = IsSpellKnown(115450)        -- removes all Magic effects from the target.
        local BrewmasterDetox = IsSpellKnown(218164)        -- removes all Poison and Disease effects from the target.
        local ImprovedDetox = IsTalentKnown(388874)         -- removes all Magic, Poison and Disease effects from the target.
        local Revival = IsSpellKnown(115310)                -- clears all harmful Magic, Poison and Disease effects.
        local Restoral = IsSpellKnown(388615)               -- clears them of all harmful Poison and Disease effects.

        Filger.DispelFilter["FRIENDLY"]["Magic"] = (MistweaverDetox or ImprovedDetox or Revival) or false
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (BrewmasterDetox or ImprovedDetox or Revival or Restoral) or false
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (BrewmasterDetox or ImprovedDetox or Revival or Restoral) or false
	elseif (PLAYER_CLASS == "PALADIN") then
        local Cleanse = IsSpellKnown(4987)                  -- cleanses a friendly target, removing all Magic effects.
        local CleanseToxins = IsSpellKnown(213644)          -- cleanses a friendly target, removing all Poison and Disease effects.
        local ImprovedCleanse = IsTalentKnown(393024)       -- cleanses a friendly target, removing all Magic, Poison and Disease effects.

		Filger.DispelFilter["FRIENDLY"]["Magic"] = (Cleanse or false)
        Filger.DispelFilter["FRIENDLY"]["Poison"] = (ImprovedCleanse or CleanseToxins or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (ImprovedCleanse or CleanseToxins or false)
    elseif (PLAYER_CLASS == "PRIEST") then
        local Purify = IsSpellKnown(527)                    -- dispels harmful effects on the target, removing all Magic effects.
        local DispelMagic = IsSpellKnown(528)               -- dispels Magic on the enemy target, removing 1 beneficial Magic effect.
		local MassDispel = IsSpellKnown(32375)              -- removing all harmful Magic from 5 friendly targets and 1 beneficial Magic effects from 5 enemy targets.
        local PurifyDisease = IsSpellKnown(213634)          -- removes all Disease effects from a friendly target.
        local ImprovedPurify = IsTalentKnown(390632)        -- dispels harmful effects on the target, removing all Magic and Disease effects.

        Filger.DispelFilter["ENEMY"]["Magic"] = (DispelMagic or MassDispel or false)
        Filger.DispelFilter["FRIENDLY"]["Magic"] = (Purify or MassDispel or false)
        Filger.DispelFilter["FRIENDLY"]["Disease"] = (PurifyDisease or ImprovedPurify or false)
    elseif (PLAYER_CLASS == "SHAMAN") then
        local Purge = IsSpellKnown(370)                     -- purges the enemy target, removing 1 beneficial Magic effect.
        local GreaterPurge = IsSpellKnown(378773)           -- purges the enemy target, removing 2 beneficial Magic effects.
        local PurifySpirit = IsSpellKnown(77130)            -- removes all Magic effects from a friendly target.
        local ImprovedPurifySpirit = IsTalentKnown(383016)  -- removes all Magic and Curse effects from a friendly target.
        local CleanseSpirit = IsSpellKnown(51886)           -- removes all Curse effects from a friendly target.

		Filger.DispelFilter["ENEMY"]["Magic"] = (Purge or GreaterPurge or false)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = (PurifySpirit or false)
        Filger.DispelFilter["FRIENDLY"]["Curse"] = (CleanseSpirit or ImprovedPurifySpirit or false)
	elseif (PLAYER_CLASS == "WARLOCK") then
        local DevourMagic = IsSpellKnown(19505, true)       -- removes 1 beneficial Magic effect from enemy target. (Felhunter)
        local SingeMagic = IsSpellKnown(89808, true)        -- removes harmful Magic effects from friendly target. (Imp)

        Filger.DispelFilter["ENEMY"]["Magic"] = (DevourMagic or SingeMagic or false)
	end
end

--[[
local function CheckClassicSpecialization()
    if (PLAYER_CLASS == "DRUID") then
		local isRestoration = CheckTalentTree(4)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = isRestoration
	elseif (PLAYER_CLASS == "EVOKER") then
		local isPreservation = CheckTalentTree(2)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = isPreservation
		Filger.DispelFilter["FRIENDLY"]["Curse"] = isPreservation
		Filger.DispelFilter["FRIENDLY"]["Poison"] = isPreservation
		Filger.DispelFilter["FRIENDLY"]["Disease"] = isPreservation
    elseif (PLAYER_CLASS == "MONK") then
		local isMistweaver = CheckTalentTree(2)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = isMistweaver
	elseif (PLAYER_CLASS == "PALADIN") then
		local isHoly = CheckTalentTree(1)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = isHoly
	elseif (PLAYER_CLASS == "PRIEST") then
		-- do nothing
	elseif (PLAYER_CLASS == "SHAMAN") then
		local isRestoration = CheckTalentTree(3)
		Filger.DispelFilter["FRIENDLY"]["Magic"] = isRestoration
	end
end
]]

Filger.UpdateDispelFilter = (
    (Filger.isClassic and CheckClassicSpecialization)
    or (Filger.isTBC and CheckTBCSpecialization)
    or (Filger.isWOTLK and CheckWOTLKSpecialization)
    or CheckRetailSpecialization
)

function Filger:Inspect()
    local unit = "player"
    local guid = UnitGUID("player")

    self.talents = {}

    local configID = C_ClassTalents.GetActiveConfigID()

    local configInfo = C_Traits.GetConfigInfo(configID)
    for _, treeID in ipairs(configInfo.treeIDs) do
        local nodeIDs = C_Traits.GetTreeNodes(treeID)
        for _, nodeID in ipairs(nodeIDs) do
            local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
            if (nodeInfo) then
                local activeEntry = nodeInfo.activeEntry
                local activeRank = nodeInfo.activeRank
                if (activeRank and activeRank > 0) then
                    local entryInfo = C_Traits.GetEntryInfo(configID, activeEntry.entryID)
                    if (entryInfo) then
                        local definitionInfo = C_Traits.GetDefinitionInfo(entryInfo.definitionID)
                        if (definitionInfo) then
                            local spellID = definitionInfo.spellID
                            local spellName = GetSpellInfo(definitionInfo.spellID)
                            self.talents[definitionInfo.spellID] = true
                        end
                    end
                end
            end
        end
    end

    self:UpdateDispelFilter()
end
