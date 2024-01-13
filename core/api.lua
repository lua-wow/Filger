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

API.SetBorderColor = function(self, R, G, B, Alpha)
    if self.BorderTop then
		self.BorderTop:SetColorTexture(R, G, B, Alpha)
	end

	if self.BorderBottom then
		self.BorderBottom:SetColorTexture(R, G, B, Alpha)
	end

	if self.BorderRight then
		self.BorderRight:SetColorTexture(R, G, B, Alpha)
	end

	if self.BorderLeft then
		self.BorderLeft:SetColorTexture(R, G, B, Alpha)
	end
end

API.CreateBackdrop = function(self, template)
    if (self.Backdrop) then return end

	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())

	local BorderR, BorderG, BorderB = unpack(Config.General.BorderColor)
	local BackdropR, BackdropG, BackdropB, BackdropA = unpack(Config.General.BackdropColor)
	local BackgroundAlpha = (template == "Transparent") and 0.75 or BackdropA or 1
	local BorderSize = Scale(1)
    local Texture = Config.Medias.Blank

	self.Backdrop:SetBackdrop({ bgFile = Texture })
	self.Backdrop:SetBackdropColor(BackdropR, BackdropG, BackdropB, BackgroundAlpha)

	self.Backdrop.BorderTop = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderTop:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderTop:SetPoint("TOPLEFT", self.Backdrop, "TOPLEFT", 0, 0)
	self.Backdrop.BorderTop:SetPoint("TOPRIGHT", self.Backdrop, "TOPRIGHT", 0, 0)
	self.Backdrop.BorderTop:SetSnapToPixelGrid(false)
	self.Backdrop.BorderTop:SetTexelSnappingBias(0)

	self.Backdrop.BorderBottom = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderBottom:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderBottom:SetPoint("BOTTOMLEFT", self.Backdrop, "BOTTOMLEFT", 0, 0)
	self.Backdrop.BorderBottom:SetPoint("BOTTOMRIGHT", self.Backdrop, "BOTTOMRIGHT", 0, 0)
	self.Backdrop.BorderBottom:SetSnapToPixelGrid(false)
	self.Backdrop.BorderBottom:SetTexelSnappingBias(0)

	self.Backdrop.BorderLeft = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderLeft:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderLeft:SetPoint("TOPLEFT", self.Backdrop, "TOPLEFT", 0, 0)
	self.Backdrop.BorderLeft:SetPoint("BOTTOMLEFT", self.Backdrop, "BOTTOMLEFT", 0, 0)
	self.Backdrop.BorderLeft:SetSnapToPixelGrid(false)
	self.Backdrop.BorderLeft:SetTexelSnappingBias(0)

	self.Backdrop.BorderRight = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderRight:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderRight:SetPoint("TOPRIGHT", self.Backdrop, "TOPRIGHT", 0, 0)
	self.Backdrop.BorderRight:SetPoint("BOTTOMRIGHT", self.Backdrop, "BOTTOMRIGHT", 0, 0)
	self.Backdrop.BorderRight:SetSnapToPixelGrid(false)
	self.Backdrop.BorderRight:SetTexelSnappingBias(0)

	self.Backdrop:SetBorderColor(BorderR, BorderG, BorderB, BorderA)
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
