local att = {}
att.name = "bg_ak74_ubarrel"
att.displayName = "Shortened barrel"
att.displayNameShort = "Short"
att.isBG = true
att.categoryFactors = {cqc = 3}
att.SpeedDec = -3

att.statModifiers = {RecoilMult = -0.1,
AimSpreadMult = 1,
OverallMouseSensMult = 0.1,
DrawSpeedMult = 0.15,
DamageMult = -0.1,
FireDelayMult = -0.0714285}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_ubarrel")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
	self:setupCurrentIronsights(self.ShortenedPos, self.ShortenedAng)
	
	if not self:isAttachmentActive("sights") then
		self:updateIronsights("Shortened")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)