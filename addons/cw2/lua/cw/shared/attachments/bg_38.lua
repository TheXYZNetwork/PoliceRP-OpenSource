local att = {}
att.name = "bg_38"
att.displayName = "Barrel"
att.displayNameShort = "Barrel"
att.isBG = true

att.statModifiers = {AimSpreadMult = -1,
HipSpreadMult = -1,
FireDelayMult = -.75,
DamageMult = 10,
ReloadSpeedMult = 1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/regularbarrel_revolver")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.topkek)
				if not self:isAttachmentActive("sights") then
		self:updateIronsights("SW38Topkek")
	end
	self.Primary.ClipSize = 200
	self.Primary.ClipSize_Orig = 200
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.snub)
	self:revertToOriginalIronsights()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)