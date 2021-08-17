local att = {}
att.name = "bg_ak74heavystock"
att.displayName = "Heavy stock"
att.displayNameShort = "H. stock"
att.isBG = true

att.statModifiers = {RecoilMult = -0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74heavystock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.heavy)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)