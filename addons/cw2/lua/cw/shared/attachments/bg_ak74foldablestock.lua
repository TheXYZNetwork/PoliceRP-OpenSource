local att = {}
att.name = "bg_ak74foldablestock"
att.displayName = "Foldable stock"
att.displayNameShort = "F. stock"
att.isBG = true
att.SpeedDec = -5

att.statModifiers = {DrawSpeedMult = 0.15,
RecoilMult = 0.1,
OverallMouseSensMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74foldablestock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.foldable)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)