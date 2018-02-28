-- importing oUF_Lua global table (Functions, varaibles, Constants, ...)
local T, C, L, G = unpack(oUFLua)

local texture = C.media.blankTex
local fontName, fontSize, fontFlag = C.media.pixelfont, 10, "THINOUTLINE"
local FormatTime = T.FormatTime

------------------------------------------------------------
-- Filger
------------------------------------------------------------
local _, ns = ...
local Filger = ns.Filger
local FilgerOptions = Filger.Options
local FilgerSpells = Filger.Spells

local _, class = UnitClass("player")		-- player class
local color = RAID_CLASS_COLORS[class]
local active = {}							-- table to save current active auras/buffs/debuffs.
local elements = {}
local MyUnits = {
	player = true,
	vehicle = true,
	pet = true,
}

local function CreateIcon(self, index)
	if not index then index = "" end
	
	local element = CreateFrame("Frame", self:GetName() .. "_Icon" .. index, self)
	element:SetSize(self.size, self.size)
	element:SetBorder("Default")
	
	local cd = CreateFrame("Cooldown", nil, element, "CooldownFrameTemplate")
	cd:SetAllPoints()
	cd:SetReverse(true)
	
	local icon = element:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints()
	icon:SetTexCoord(.08,.92,.08,.92)
	
	local count = element:CreateFontString(nil, "OVERLAY")
	count:SetPoint("BOTTOMRIGHT", element, "BOTTOMRIGHT", 2, 1)
	count:SetJustifyH("RIGHT")
	count:SetFont(fontName, fontSize, fontFlag)
	
	local timer = element:CreateFontString(nil, "OVERLAY")
	timer:SetPoint("CENTER", element, "CENTER", 2, 1)
	timer:SetJustifyH("CENTER")
	timer:SetFont(fontName, 16, fontFlag)
	timer:SetTextColor(1.,1.,1.) --(.84,.75,.65)
	
	element.cd = cd
	element.icon = icon
	element.count = count
	element.timer = timer
	
	return element
end

local function CreateBar(self, index)
	
	local element = CreateFrame("StatusBar", self:GetName() .. "_Bar" .. index, self)
	element:SetSize(self.width, self.size)
	element:SetStatusBarTexture(texture)
	element:SetStatusBarColor(color.r, color.g, color.b, 1.)
	element:SetBorder("Default")
	
	local name = element:CreateFontString(nil, "OVERLAY")
	name:SetPoint("LEFT", element, "LEFT", 5, 1)
	name:SetJustifyH("LEFT")
	name:SetFont(fontName, fontSize, fontFlag)
	
	local timer = element:CreateFontString(nil, "OVERLAY")
	timer:SetPoint("RIGHT", element, "RIGHT", -3, 1)
	timer:SetJustifyH("RIGHT")
	timer:SetFont(fontName, fontSize, fontFlag)
	timer:SetTextColor(1.,1.,1.)
	
	local button = CreateFrame("Frame", nil, element)
	button:SetPoint("RIGHT", element, "LEFT", -self.spacing, 0)
	button:SetSize(self.size, self.size)
	button:SetBorder("Default")
	
	local icon = element:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints(button)
	icon:SetTexCoord(.08,.92,.08,.92)
	
	element.name = name
	element.timer = timer
	element.icon = icon
	
	return element
end

local Update
local function OnUpdate(self, elapsed)
	local parent = self:GetParent()
	local id = parent.id
	
	if (self.expires) then
		self.expires = self.expires - elapsed
		
		if (self.expires > 0) then
			self.timer:SetFormattedText("%s", FormatTime(self.expires))
			
			if (parent.mode == "BAR") then
				self:SetValue(self.expires)
			end
			
			if (self.expires <= 5) then
				self.timer:SetTextColor(.99,.31,.31)
			else
				self.timer:SetTextColor(1.,1.,1.)
			end
		else
			self.timer:SetText("")
			
			-- remove spell from active table
			table.remove(active[id], self.index)
			-- for index, item in ipairs(active[id]) do
				-- if (self.spellname == item.name) then
					-- print("removing", self.spellname, self.index, index)
					-- table.remove(active[id], index)
				-- end
			-- end
			
			self:SetScript("OnUpdate", nil)
			
			Update(parent)
		end
	end
end

-- update spell icons
function Update(self)
	local id = self.id
	
	if not elements[id] then
		elements[id] = {}
	end
	
	for index, item in ipairs(elements[id]) do
		item:Hide()
	end
	
	local element
	for index, item in pairs(active[id]) do
		element = elements[id][index]
		if not element then
			if (self.mode == "ICON") then
				element = CreateIcon(self, index)
			elseif (self.mode == "BAR") then
				element = CreateBar(self, index)
				element:SetMinMaxValues(0, 1)
				element:SetValue(1)
			end
			
			if (index == 1) then
				element:SetPoint(unpack(self.anchor))
			else
				if (self.direction == "UP") then
					element:SetPoint("BOTTOM", elements[id][index - 1], "TOP", 0, self.spacing)
				elseif (self.direction == "DOWN") then
					element:SetPoint("TOP", elements[id][index - 1], "BOTTOM", 0, -self.spacing)
				elseif (self.direction == "LEFT") then
					element:SetPoint("RIGHT", elements[id][index - 1], "LEFT", -self.spacing, 0)
				elseif (self.direction == "RIGHT") then
					element:SetPoint("LEFT", elements[id][index - 1], "RIGHT", self.spacing, 0)
				end
			end
			
			if (element.name) then element.name:SetText() end
			if (element.icon) then element.icon:SetTexture() end
			if (element.count) then element.count:SetText() end
			if (element.timer) then element.timer:SetText() end
			
			table.insert(elements[id], element)
		end
		
		if (element.name) then element.name:SetText(item.name) end
		if (element.icon) then element.icon:SetTexture(item.icon) end
		if (element.count) then
			element.count:SetText(item.count and item.count > 1 and item.count or "")
		end
		
		-- color borde by spell type
		if (FilgerOptions.colordebuff) then
			if (item.dispelType and item.filter == "DEBUFF") then
				local color = DebuffTypeColor[item.dispelType or "none"]
				element:SetBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)
			else
				element:SetBorderColor(unpack(C.media.bordercolor))
			end
		end
		
		if (item.duration and item.duration > 0) then
			element.index = index
			element.spellname = item.name
			element.duration = item.duration
			element.expires = item.expires - GetTime()
			if (self.mode == "BAR") then
				element:SetMinMaxValues(0, element.duration)
			end
			element:SetScript("OnUpdate", OnUpdate)
		else
			element.timer:SetText("")
			element:SetScript("OnUpdate", nil)
		end
		
		-- show just a set number of icons
		if (index <= self.num) then
			element:Show()
		else
			element:Hide()
		end
	end
end

-- update table with the current active spells
local function OnEvent(self, event, unit)
	if ((unit == "target" or unit == "player" or unit == "pet" or unit == "focus") or
		event == "PLAYER_TARGET_CHANGED" or
		event == "PLAYER_ENTERING_WORLD" or
		event == "SPELL_UPDATE_COOLDOWN") then
	
		local id = self.id
		local data = FilgerSpells[class][id]
		for index, item in ipairs(data) do
			
			local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, spellID
			local start, enabled, slotLink
			
			if (item.filter == "BUFF") then
				name, rank, icon, count, dispelType, duration, expires, caster, isStealable, _, spellID = UnitBuff(self.unit, item.name)
			elseif (item.filter == "DEBUFF") then
				name, rank, icon, count, dispelType, duration, expires, caster, isStealable, _, spellID = UnitDebuff(self.unit, item.name)
			elseif (item.filter == "CD") then
				if (item.spellID) then
					name, rank, icon, _, _, _, spellID = GetSpellInfo(item.spellID)
					start, duration, enabled = GetSpellCooldown(name)
				else
					slotLink = GetInventoryItemLink("player", item.slotID)
					if (slotLink) then
						name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink)
						start, duration, enabled = GetInventoryItemCooldown("player", item.slotID)
					end
					count = nil
					caster = "all"
				end
				
				if (start and duration) then
					expires = start + duration
				end
			end
			
			if not item.name then
				item.name = name
			end
			
			if not active[id] then
				active[id] = {}
			end
			
			-- remove the same spell
			for i, spell in ipairs(active[id]) do
				if (item.name == spell.name) then
					table.remove(active[id], i)
					break
				end
			end
			
			-- insert spell into active[id] table
			if ((name and (caster and (caster == item.caster or item.caster == "all") or MyUnits[caster])) or
				((enabled and enabled > 0) and (duration and duration > 1.5))) then
				local spell = {
					spellID = spellID,
					name = name,
					icon = icon,
					count = count,
					duration = duration,
					expires = expires or start,
					filter = item.filter,
					dispelType = dispelType,
				}
				table.insert(active[id], spell)
				
				-- sort spell by expiration time else spellID
				table.sort(active[id], function(a, b)
					if (a.expires == b.expires) then
						return a.spellID < b.spellID
					end
					return a.expires < b.expires
				end)
			end
		end
		-- update icons/bars
		Update(self)
	end
end

if FilgerSpells then
	-- generate a empty class table if it doesn't exist
	if not FilgerSpells[class] then
		FilgerSpells[class] = {}
	end
	
	-- inset 'all' class table into player class table.
	if FilgerSpells["ALL"] then
		for index, tbl in ipairs(FilgerSpells["ALL"]) do
			table.insert(FilgerSpells[class], tbl)
		end
	end
	
	-- remove all the other class tables
	for index in pairs(FilgerSpells) do
		if (index ~= class) then
			FilgerSpells[index] = nil
		end
	end
	
	-- filter spell table
	local idx = {}				-- save index of empty sections
	for i = 1, #FilgerSpells[class] do
		local data = FilgerSpells[class][i]
		
		local spellname
		local jdx = {}			-- save index non-existent spellID
		for j = 1, #data do
			if (data[j].spellID) then
				data[j].name = GetSpellInfo(data[j].spellID)
			else
				local slotLink = GetInventoryItemLink("player", data[j].slotID)
				if (slotLink) then
					data[j].name = GetItemInfo(slotLink)
				end
			end
			
			-- check if there is any bad spellID
			if not (data[j].name) then
				print("|cffFF0000Filger WARNING:|r " .. data.name .. " spellID(" .. j ..") = " .. data[j].spellID .. " doesn't exist.")
				table.insert(jdx, j)
			end
		end
		
		-- remove the non-existents spellIDs
		-- this need to be done from bottom to the top
		for j = #jdx, 1, -1 do
			table.remove(data, jdx[j])
		end
		
		-- check if there is any empty sections
		if (#data == 0) then
			print("|cffFF0000Filger WARNING:|r " .. data.name .. " section is empty.")
			table.insert(idx, i)
		end
	end
	
	-- remove the empty sections
	for i = #idx, 1, -1 do
		table.remove(FilgerSpells[class], idx[i])
	end
	
	-- create frames
	local frame = CreateFrame("Frame", "Filger", UIParent)
	for i = 1, #FilgerSpells[class] do
		local data = FilgerSpells[class][i]
		
		local element = frame[i]
		element = CreateFrame("Frame", frame:GetName() .. i, frame)
		element.id = i
		element.name = data.name
		element.anchor = data.anchor
		element.direction = data.direction
		element.mode = data.mode
		element.num = data.num
		element.size = data.size
		element.width = data.width
		element.spacing = data.spacing
		element.unit = data.unit
		element:SetPoint(unpack(element.anchor))
		
		if (element.mode == "ICON") then
			element:SetWidth(element.num * element.size + (element.num - 1) * element.spacing)
		else
			element:SetWidth(element.size + element.spacing + (element.width or 200))
		end
		element:SetHeight(element.size)
		
		if FilgerOptions.show then
			local bg = element:CreateTexture(nil, "BORDER")
			bg:SetAllPoints()
			bg:SetTexture(texture)
			bg:SetColorTexture(.0,.7,.0,.5)
			element.bg = bg
			
			local name = element:CreateFontString(nil, "OVERLAY")
			name:SetPoint("CENTER", element, "CENTER", 0, 1)
			name:SetJustifyH("CENTER")
			name:SetFont(fontName, fontSize, fontFlag)
			name:SetText(element:GetName() .. " " .. element.name)
			element.name = name
		end
		
		if (FilgerOptions.configmode) then
			local name, icon
			
			for index, item in ipairs(data) do
				if not active[i] then
					active[i] = {}
				end
				
				if (item.spellID) then
					name, _, icon = GetSpellInfo(item.spellID)
				else
					local slotLink = GetInventoryItemLink("player", item.slotID)
					if (slotLink) then
						name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink)
					end
				end
				
				local duration = index * 15
				local time = GetTime()
				
				local spell = {
					spellID = spellID,
					name = name,
					icon = icon,
					count = index,
					duration = duration,
					expires = time + duration,
					filter = item.filter,
					dispelType = dispelType,
				}
				
				table.insert(active[i], spell)
			end
			Update(element)
		else
			for i = 1, #data do
				if (data[i].filter == "CD") then
					element:RegisterEvent("SPELL_UPDATE_COOLDOWN")
					break
				end
			end
			
			element:RegisterEvent("UNIT_AURA")
			element:RegisterEvent("PLAYER_TARGET_CHANGED")
			element:RegisterEvent("PLAYER_ENTERING_WORLD")
			element:SetScript("OnEvent", OnEvent)
		end
	end
end