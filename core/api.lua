local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config

-- blizzard
local IsAddOnLoaded = _G.IsAddOnLoaded

-- skip it if Tukui exists
if IsAddOnLoaded("Tukui") then return end

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

API.Kill = function(self)
    if (self.UnregisterAllEvents) then
        self:UnregisterAllEvents()
        self:SetParent()
    else
        self.Show = self.Hide
    end
    self:Hide()
end

API.StripTexts = function(self, Kill)
	for i = 1, self:GetNumRegions() do
		local Region = select(i, self:GetRegions())
		if (Region and Region:GetObjectType() == "FontString") then
			if (Kill and type(Kill) == "boolean") then
				Region:Kill()
			else
				Region:SetText("")
			end
		end
	end
end

API.StripTextures = function(self, Kill)
	for i = 1, self:GetNumRegions() do
		local Region = select(i, self:GetRegions())
		if (Region and Region:GetObjectType() == "Texture") then
			if (Kill and type(Kill) == "boolean") then
				Region:Kill()
			elseif (Region:GetDrawLayer() == Kill) then
				Region:SetTexture(nil)
			elseif (Kill and type(Kill) == "string" and Region:GetTexture() ~= Kill) then
				Region:SetTexture(nil)
			else
				Region:SetTexture(nil)
			end
		end
	end
end

API.SetOutside = function(self, Anchor, OffsetX, OffsetY)
	OffsetX = OffsetX and Scale(OffsetX) or Scale(1)
	OffsetY = OffsetY and Scale(OffsetY) or Scale(1)

	Anchor = Anchor or self:GetParent()

	if self:GetPoint() then
		self:ClearAllPoints()
	end

	self:SetPoint("TOPLEFT", Anchor, "TOPLEFT", -OffsetX, OffsetY)
	self:SetPoint("BOTTOMRIGHT", Anchor, "BOTTOMRIGHT", OffsetX, -OffsetY)
end

API.SetInside = function(self, Anchor, OffsetX, OffsetY)
	OffsetX = OffsetX and Scale(OffsetX) or Scale(1)
	OffsetY = OffsetY and Scale(OffsetY) or Scale(1)

	Anchor = Anchor or self:GetParent()

	if self:GetPoint() then
		self:ClearAllPoints()
	end

	self:SetPoint("TOPLEFT", Anchor, "TOPLEFT", OffsetX, -OffsetY)
	self:SetPoint("BOTTOMRIGHT", Anchor, "BOTTOMRIGHT", -OffsetX, OffsetY)
end

API.CreateBackdrop = function(self, template)
	local BackdropColorR, BackdropColorG, BackdropColorB, BackdropColorA = unpack(Config.General.BackdropColor)
	local BorderColorR, BorderColorG, BorderColorB = unpack(Config.General.BorderColor)
	local BackgroundAlpha = (template == "Transparent") and 0.75 or BackdropColorA or 1
	local Texture = Config.Medias.Blank

	local Backdrop = {
		bgFile = Texture,
		edgeFile = Texture,
		edgeSize = Scale(1),
		insets = {
			top = 0,
			left = 0,
			bottom = 0,
			right = 0
		}
	}

	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	-- self.Backdrop:SetOutside(self, 2, 2)
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())
	self.Backdrop:SetBackdrop(Backdrop)
	self.Backdrop:SetBackdropColor(BackdropColorR, BackdropColorG, BackdropColorB, BackgroundAlpha)
	self.Backdrop:SetBackdropBorderColor(BorderColorR, BorderColorG, BorderColorB)
end

API.SetBorderColor = function(self, R, G, B, Alpha)
    if (self.Backdrop) then
        self.Backdrop:SetBackdropBorderColor(R, G, B, Alpha or 1)
    end
end

function Filger:EnableAPI()
    -- Merge JasjeUI API with WOW API
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
