local att = {}
att.name = "bg_medium38"
att.displayName = "Medium Barrel"
att.displayNameShort = "Medium"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = -0.35,
DamageMult = 0.075,
DrawSpeedMult = -0.10,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_medium38")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.medium)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("SW38Medium")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.snub)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)