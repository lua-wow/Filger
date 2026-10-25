local _, ns = ...
local textures = ns.media.textures

-- Blizzard
local IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

-- Tukui borders are textures colored by Backdrop:SetBorderColor; ElvUI and Filger use a BackdropTemplate border
function ns.SetBorderColor(backdrop, color)
	if backdrop.SetBorderColor then
		backdrop:SetBorderColor(color.r, color.g, color.b, color.a or 1)
	else
		backdrop:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
	end
end

-- these UIs add their own CreateBackdrop to every frame; OptionalDeps loads them first
local hasUIBackdrop = IsAddOnLoaded("Tainted") or IsAddOnLoaded("Tukui") or IsAddOnLoaded("ElvUI")

---------------------------------------------------
-- API
---------------------------------------------------
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
    local mult = ns.pixelPerfectScale / uiScale

	-- Return the scaled size, rounded to the nearest integer
    return mult * math.floor(size / mult + 0.5)
end

function ns.CreateBackdrop(frame, template)
	if hasUIBackdrop and frame.CreateBackdrop then
		frame:CreateBackdrop(template)
	elseif not frame.Backdrop then
		local backdropTexture = textures.blank
		local backdropColor = ns.config.general.backdrop.color
		local backdropAlpha = (template == "transparent") and 0.70 or 1
		
		local borderTexture = textures.blank
		local borderColor = ns.config.general.border.color

		local inset = Scale(ns.config.general.border.size or 1)
		local backdrop = {
			bgFile = backdropTexture
		}

		if (template ~= "solid") then
			backdrop.edgeFile = borderTexture
			backdrop.edgeSize = inset
			backdrop.insets = { top = inset, left = inset, bottom = inset, right = inset }
		end
		
		local level = frame:GetFrameLevel() or 1

		frame.Backdrop = CreateFrame("Frame", nil, frame, "BackdropTemplate")
		frame.Backdrop:SetPoint("TOPLEFT", -inset, inset)
		frame.Backdrop:SetPoint("BOTTOMRIGHT", inset, -inset)
		frame.Backdrop:SetFrameLevel(level - 1)
		frame.Backdrop:SetBackdrop(backdrop)
		frame.Backdrop:SetBackdropColor(backdropColor.r, backdropColor.g, backdropColor.b, backdropAlpha)
		frame.Backdrop:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
	end
end
