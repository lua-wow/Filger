local addon, ns = ...
local Filger = ns.Filger

if not Filger.Options.rec then return end
------------------------------------------------------------
-- Development
-- 		it's annoying to look for spellId on wowhead
--		so this code to save all buffs/debuffs on target and player units.
------------------------------------------------------------

local max = 30
local MyUnits = {
	player = true,
	target = true,
	focus = true,
	vehicle = true,
	pet = true,
}

local Filters = {
	["BUFF"] = true,
	["DEBUFF"] = true,
}

local SpellList = {}

local function OnEvent(self, event, arg)
	
	if (event == "ADDON_LOADED" and arg == "Filger") then
		if (FilgerDB == nil) then
			-- create a empty table when loading filger at the first time.
			FilgerDB = {}
		else
			-- loading saved variables
			SpellList = FilgerDB
		end
	elseif (event == "UNIT_AURA") then
		local unit = arg
		if not MyUnits[unit] then return end
		
		local class
		for filter, value in pairs(Filters) do
			for i = 1, max do
				local name, dispelTYpe, caster, spellID, isBossDebuff
				
				if (filter == "BUFF") then
					name, _, _, _, dispelType, _, _, caster, _, _, spellID, _, isBossDebuff = UnitBuff(unit, i)
				elseif (filter == "DEBUFF") then
					name, _, _, _, dispelType, _, _, caster, _, _, spellID, _, isBossDebuff = UnitDebuff(unit, i)
				end
				
				if caster then
					class = select(2, UnitClass(caster))
					if not class then
						class = "ALL"
					end
				else
					class = "ALL"
				end
				
				if not SpellList[class] then
					SpellList[class] = {}
				end
				
				for index, item in ipairs(SpellList[class]) do
					if (item.name == name and item.spellID == spellID) then
						table.remove(SpellList[class], index)
					end
				end
				
				if (name) then
					local spell = {
						spellID = spellID,
						name = name,
						filter = filter,
						class = class,
						boss = isBossDebuff and "BOSS" or nil,
					}
					table.insert(SpellList[class], spell)
					
					table.sort(SpellList[class], function(a, b)
						return a.spellID < b.spellID
					end)
				end
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
--f:RegisterEvent("UNIT_AURA")
f:SetScript("OnEvent", OnEvent)

local commandTable = {
	["start"] = function()
		print("|cffFF0000filger on:|r begin recording spells")
		f:RegisterEvent("UNIT_AURA")
		--f:SetScript("OnEvent", OnEvent)
	end,
	["stop"] = function()
		print("|cffFF0000filger off:|r stop recording spells")
		f:UnregisterEvent("UNIT_AURA")
	end,
	["reset"] = function()
		print("|cffFF0000filger reset:|r reseting spell list")
		for key, value in pairs(SpellList) do
			SpellList[key] = nil
		end
	end,
	["save"] = function()
		print("save")
		SaveVaraibles()
	end,
	["help"] = function()
		-- print commands info
		print("|cffFF0000/filger|r <command>")
		print("start : begin recording buffs/debuff os player and target units")
		print("stop : stop recording buffs/debuff")
		print("reset : clear spell list")
		print("all : print the whole spell list")
		print("class <CLASS> : print buff/debuff casted by the specificed class")
	end,
	["list"] = function()
		-- print the whole spell list
		for class, _ in pairs(SpellList) do
			print(class)
			for filter, _ in pairs(Filters) do
				for index, item in ipairs(SpellList[class]) do
					if (item.filter == filter) then
						print(" ", item.spellID, ", ", item.name, ", ", item.class, ", ", item.filter)
					end
				end
			end
		end
	end,
	["class"] = function(class)
		-- print spell casted by class
		print(class)
		for filter, _ in pairs(Filters) do
			for index, item in ipairs(SpellList[class]) do
				if (item.filter == filter) then
					print(" ", item.spellID, ", ", item.name, ", ", item.class, ", ", item.filter)
				end
			end
		end
	end,
}

SLASH_FILGER1 = "/filger"
SlashCmdList["FILGER"] = function (msg)
	local _, _, command, arg = string.find(msg, "%s?(%w+)%s?(.*)")
	
	if not command then command = "help" end
	
	local entry
	if SpellList[command:upper()] then
		entry = commandTable["class"]
		entry(command:upper())
	elseif (commandTable[command:lower()]) then
		entry = commandTable[command:lower()]
		entry(command)
	else
		print("|cffFF0000/filger:|r command <" .. command .. "> doesn't exist or spell list is empty.")
	end
end