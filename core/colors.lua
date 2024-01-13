local _, ns = ...
local Filger = ns.Filger

local colorMixin = {
	SetRGBA = function(self, r, g, b, a)
		if(r > 1 or g > 1 or b > 1) then
			r, g, b = r / 255, g / 255, b / 255
		end

		self.r = r
		self[1] = r
		self.g = g
		self[2] = g
		self.b = b
		self[3] = b
		self.a = a

		-- pre-generate the hex color, there's no point to this being generated on the fly
		self.hex = string.format('ff%02x%02x%02x', self:GetRGBAsBytes())
	end,
	SetAtlas = function(self, atlas)
		self.atlas = atlas
	end,
	GetAtlas = function(self)
		return self.atlas
	end,
	GenerateHexColor = function(self)
		return self.hex
	end,
}

function Filger:CreateColor(r, g, b, a)
	local color = Mixin({}, ColorMixin, colorMixin)
	color:SetRGBA(r, g, b, a)
	return color
end

local Colors = {
    Stealable = Filger:CreateColor(0.93, 0.91, 0.55)
}

for debuffType, color in next, _G.DebuffTypeColor do
	Colors[debuffType] = Filger:CreateColor(color.r, color.g, color.b)
end

Filger.Colors = Colors
