local att = {}
att.name = "bg_retractablestock"
att.displayName = "Retractable stock"
att.displayNameShort = "R. stock"
att.isBG = true
att.SpeedDec = -3

att.statModifiers = {DrawSpeedMult = 0.1,
OverallMouseSensMult = 0.1,
RecoilMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/retractablestock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.retractable)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)