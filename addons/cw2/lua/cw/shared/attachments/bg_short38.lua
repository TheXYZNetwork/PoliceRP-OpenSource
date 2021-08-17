local att = {}
att.name = "bg_short38"
att.displayName = "Short Barrel"
att.displayNameShort = "Short"
att.isBG = true

att.statModifiers = {RecoilMult = 0.05,
AimSpreadMult = -0.15,
DamageMult = 0.05,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_short38")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("SW38Short")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.snub)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)