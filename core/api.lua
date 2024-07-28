local _, ns = ...
local Filger = ns.Filger
local config = Filger.config
local fonts = Filger.fonts
local textures = Filger.textures

-- blizzard
local IsAddOnLoaded = _G.IsAddOnLoaded

-- skip it if Tukui exists
if IsAddOnLoaded("Tainted") then 
	function Filger.SetBorderColor(frame, color)
		if frame.Backdrop then
			frame.Backdrop:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
		end
	end

	return
elseif IsAddOnLoaded("Tukui") then 
	function Filger.SetBorderColor(frame, color)
		frame:SetBorderColor(color.r, color.g, color.b, color.a or 1)
	end

	return
end

---------------------------------------------------
-- Functions
---------------------------------------------------
local Resolution = select(1, GetPhysicalScreenSize()).."x"..select(2, GetPhysicalScreenSize())
local PixelPerfectScale = 768 / string.match(Resolution, "%d+x(%d+)")
local Scale = function(size)
	-- Little protection just in case
	if size == "" then
		size = 1
	end

	local Mult = PixelPerfectScale / GetCVar("uiScale")
	local Value = Mult * math.floor(size / Mult + .5)

	return Value
end

---------------------------------------------------
-- API
---------------------------------------------------
local API = {}

local Scale = function(size)
	-- Ensure 'size' is a valid number, default to 1 if not
	size = tonumber(size) or 1

	-- Retrieve the UI scale value and ensure it is valid
	-- Default to 1 if 'uiScale' is not a valid number
	local uiScale = tonumber(GetCVar("uiScale"))
	if not uiScale then
		uiScale = 1
	end

	-- Calculate the scaling multiplier
    local mult = Filger.pixelPerfectScale / uiScale

	-- Return the scaled size, rounded to the nearest integer
    return mult * math.floor(size / mult + 0.5)
end

API.SetOutside = function(self, anchor, xOffset, yOffset)
	xOffset = xOffset and Scale(xOffset) or Scale(1)
	yOffset = yOffset and Scale(yOffset) or Scale(1)

	anchor = anchor or self:GetParent()

	if self:GetPoint() then
		self:ClearAllPoints()
	end

	self:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	self:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

API.SetInside = function(self, anchor, xOffset, yOffset)
	xOffset = xOffset and Scale(xOffset) or Scale(1)
	yOffset = yOffset and Scale(yOffset) or Scale(1)

	anchor = anchor or self:GetParent()

	if self:GetPoint() then
		self:ClearAllPoints()
	end

	self:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	self:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

API.CreateBackdrop = function(self, template)
	if not self.Backdrop then
		local backdropTexture = textures.blank
		local backdropColor = config.general.backdrop.color
		local backdropAlpha = (template == "transparent") and 0.70 or 1
		
		local borderTexture = textures.blank
		local borderColor = config.general.border.color

		local inset = Scale(config.general.border.size or 1)
		local backdrop = {
			bgFile = backdropTexture
		}

		if (template ~= "solid") then
			backdrop.edgeFile = borderTexture
			backdrop.edgeSize = inset
			backdrop.insets = { top = inset, left = inset, bottom = inset, right = inset }
		end
		
		local level = self:GetFrameLevel() or 1

		self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
		self.Backdrop:SetPoint("TOPLEFT", -inset, inset)
		self.Backdrop:SetPoint("BOTTOMRIGHT", inset, -inset)
		self.Backdrop:SetFrameLevel(level - 1)
		self.Backdrop:SetBackdrop(backdrop)
		self.Backdrop:SetBackdropColor(backdropColor.r, backdropColor.g, backdropColor.b, backdropAlpha)
		self.Backdrop:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
	end
end

--------------------------------------------------
-- Merge Filger API with WoW API
--------------------------------------------------
function Filger:MergeAPI()
    local AddAPI = function(obj)
        local mt = getmetatable(obj).__index
        for name, func in pairs(API) do
            if (not obj[name]) then mt[name] = func end
        end
    end

    local Handled = {
        ["Frame"] = true
    }

    local Object = CreateFrame("Frame")
    AddAPI(Object)
    AddAPI(Object:CreateTexture())
    AddAPI(Object:CreateFontString())

    Object = EnumerateFrames()

    while (Object) do
        local t = Object:GetObjectType()
        if (not Object:IsForbidden() and not Handled[Object:GetObjectType()]) then
            AddAPI(Object)
            Handled[Object:GetObjectType()] = true
        end
        Object = EnumerateFrames(Object)
    end
end
