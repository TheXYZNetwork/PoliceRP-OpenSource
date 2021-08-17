local att = {}
att.name = "bg_ar15heavystock"
att.displayName = "Heavy stock"
att.displayNameShort = "H. stock"
att.isBG = true
att.SpeedDec = 2

att.statModifiers = {RecoilMult = -0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15heavystock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.heavy)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)