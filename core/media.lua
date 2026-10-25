local _, ns = ...

-- Blizzard
local ColorMixin = _G.ColorMixin

------------------------------------------------------------
-- Medias
------------------------------------------------------------
local media = {}

media.fonts = {
    ["normal"] = [[Interface\AddOns\Filger\medias\fonts\normal_font.ttf]],
    ["pixel"] = [[Interface\AddOns\Filger\medias\fonts\pixel_font.ttf]],
}

media.textures = {
    ["blank"] = [[Interface\AddOns\Filger\medias\textures\blank.blp]],
    ["bubble"] = [[Interface\AddOns\Filger\medias\textures\bubble.blp]],
    ["glow"] = [[Interface\AddOns\Filger\medias\textures\glow.blp]],
}

local color_proto = {
	SetRGBA = function(self, r, g, b, a)
		if (r > 1 or g > 1 or b > 1) then
			r, g, b = r / 255, g / 255, b / 255
		end

		self.r = r
		self[1] = self.r
		self.g = g
		self[2] = self.g
		self.b = b
		self[3] = self.b
		self.a = a or 1

		-- pre-generate the hex color, there's no point to this being generated on the fly
		self.hex = ("ff%.2x%.2x%.2x"):format(self:GetRGBAsBytes());
	end,
	SetAtlas = function(self, atlas)
		self.atlas = atlas
	end,
	GetAtlas = function(self)
		return self.atlas
	end,
	GenerateHexColor = function(self)
		return self.hex
	end
}

function media.CreateColor(r, g, b, a)
	local color = Mixin({}, ColorMixin, color_proto)
	color:SetRGBA(r, g, b, a)
	return color
end

ns.media = media
