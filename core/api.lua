local _, ns = ...
local Filger = ns.Filger
local config = Filger.config
local textures = Filger.textures

-- Blizzard
local IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

-- skip it if Tukui exists
if IsAddOnLoaded("Tainted") or IsAddOnLoaded("Tukui") then
	return
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
        if (not Object:IsForbidden() and not Handled[t]) then
            AddAPI(Object)
            Handled[t] = true
        end
        Object = EnumerateFrames(Object)
    end
end
