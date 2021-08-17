local att = {}
att.name = "bg_long38"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = -0.50,
DamageMult = 0.1,
DrawSpeedMult = -0.10,
OverallMouseSensMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_long38")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("SW38Long")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.snub)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)