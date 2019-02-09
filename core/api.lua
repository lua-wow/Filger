local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config

----------------------------------------------------------------
-- API
----------------------------------------------------------------
local function SetOutside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end

	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

local function SetInside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end

	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

local function SetTemplate(f, t, tex)
	local balpha = 1
	if t == "Transparent" then balpha = 0.8 end
	local borderr, borderg, borderb = unpack(Config["General"].BorderColor)
	local backdropr, backdropg, backdropb = unpack(Config["General"].BackdropColor)
	local backdropa = balpha
	local texture = Config["Medias"].Blank

	if tex then
		texture = Config["Medias"].Normal
	end

	f:SetBackdrop({
		bgFile = texture,
		edgeFile = Config["Medias"].Blank,
		tile = false, tileSize = 0, edgeSize = 1,
    })
    
    if (not f.isInsetDone) then
		f.insettop = f:CreateTexture(nil, "BORDER")
		f.insettop:SetPoint("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insettop:SetPoint("TOPRIGHT", f, "TOPRIGHT", 1, -1)
		f.insettop:SetHeight(1)
		f.insettop:SetColorTexture(.0,.0,.0)
		f.insettop:SetDrawLayer("BORDER", -7)

		f.insetbottom = f:CreateTexture(nil, "BORDER")
		f.insetbottom:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -1, -1)
		f.insetbottom:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, -1)
		f.insetbottom:SetHeight(1)
		f.insetbottom:SetColorTexture(.0,.0,.0)
		f.insetbottom:SetDrawLayer("BORDER", -7)

		f.insetleft = f:CreateTexture(nil, "BORDER")
		f.insetleft:SetPoint("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insetleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, -1)
		f.insetleft:SetWidth(1)
		f.insetleft:SetColorTexture(.0,.0,.0)
		f.insetleft:SetDrawLayer("BORDER", -7)

		f.insetright = f:CreateTexture(nil, "BORDER")
		f.insetright:SetPoint("TOPRIGHT", f, "TOPRIGHT", 1, 1)
		f.insetright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, -1)
		f.insetright:SetWidth(1)
		f.insetright:SetColorTexture(.0,.0,.0)
		f.insetright:SetDrawLayer("BORDER", -7)

		f.insetinsidetop = f:CreateTexture(nil, "BORDER")
		f.insetinsidetop:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsidetop:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, 1)
		f.insetinsidetop:SetHeight(1)
		f.insetinsidetop:SetColorTexture(.0,.0,.0)
		f.insetinsidetop:SetDrawLayer("BORDER", -7)

		f.insetinsidebottom = f:CreateTexture(nil, "BORDER")
		f.insetinsidebottom:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		f.insetinsidebottom:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
		f.insetinsidebottom:SetHeight(1)
		f.insetinsidebottom:SetColorTexture(.0,.0,.0)
		f.insetinsidebottom:SetDrawLayer("BORDER", -7)

		f.insetinsideleft = f:CreateTexture(nil, "BORDER")
		f.insetinsideleft:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsideleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -1, 1)
		f.insetinsideleft:SetWidth(1)
		f.insetinsideleft:SetColorTexture(.0,.0,.0)
		f.insetinsideleft:SetDrawLayer("BORDER", -7)

		f.insetinsideright = f:CreateTexture(nil, "BORDER")
		f.insetinsideright:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
		f.insetinsideright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, 1)
		f.insetinsideright:SetWidth(1)
		f.insetinsideright:SetColorTexture(.0,.0,.0)
		f.insetinsideright:SetDrawLayer("BORDER", -7)

		f.isInsetDone = true
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local borders = {
	"insettop",
	"insetbottom",
	"insetleft",
	"insetright",
	"insetinsidetop",
	"insetinsidebottom",
	"insetinsideleft",
	"insetinsideright",
}

-- hide insets (border)
local function HideInsets(f)
	for i, border in pairs(borders) do
		if f[border] then
			f[border]:SetColorTexture(.0,.0,.0,.0)
		end
	end
end

local function CreateBackdrop(f, t, tex)
	if f.Backdrop then return end
	if not t then t = "Default" end

	local b = CreateFrame("Frame", nil, f)
	b:SetOutside()
	b:SetTemplate(t, tex)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end

	f.Backdrop = b
end

-- local function Kill(object)
-- 	if object.UnregisterAllEvents then
-- 		object:UnregisterAllEvents()
-- 	end
-- 	object.Show = Noop
-- 	object:Hide()
-- end

----------------------------------------------------------------
-- Merge Filger API with WoW API
----------------------------------------------------------------

local function AddAPI(object)
	local mt = getmetatable(object).__index

    if not object.SetOutside then mt.SetOutside = SetOutside end
    if not object.SetInside then mt.SetInside = SetInside end
    if not object.SetTemplate then mt.SetTemplate = SetTemplate end
    if not object.HideInsets then mt.HideInsets = HideInsets end
    if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	-- if not object.Kill then mt.Kill = Kill end
end

local Handled = {["Frame"] = true}

local Object = CreateFrame("Frame")
AddAPI(Object)
AddAPI(Object:CreateTexture())
AddAPI(Object:CreateFontString())

Object = EnumerateFrames()

while Object do
	if not Object:IsForbidden() and not Handled[Object:GetObjectType()] then
		AddAPI(Object)
		Handled[Object:GetObjectType()] = true
	end

	Object = EnumerateFrames(Object)
end