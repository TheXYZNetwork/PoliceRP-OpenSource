local att = {}
att.name = "bg_6inchsw29"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {RecoilMult = 0.15,
AimSpreadMult = -0.4,
DrawSpeedMult = -0.2,
OverallMouseSensMult = -0.1,
DamageMult = 0.06}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_6inchsw29")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("M29Long")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.snub)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)