local att = {}
att.name = "bg_ar15sturdystock"
att.displayName = "Sturdy stock"
att.displayNameShort = "S. stock"
att.isBG = true

att.statModifiers = {RecoilMult = -0.05,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15sturdystock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.sturdy)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)