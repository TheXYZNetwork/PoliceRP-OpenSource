local att = {}
att.name = "bg_mp5_kbarrel"
att.displayName = "K variant"
att.displayNameShort = "Short"
att.isBG = true
att.SpeedDec = -5

att.statModifiers = {RecoilMult = -0.2,
AimSpreadMult = 0.7,
OverallMouseSensMult = 0.15,
DrawSpeedMult = 0.2,
FireDelayMult = -0.11111111111111}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp5_kbarrel")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.k)
	self:setupCurrentIronsights(self.SDPos, self.SDAng)
	self:updateSoundTo("CW_MP5K_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
	self.ForegripOverride = true
	self.ForegripParent = "bg_mp5_kbarrel"
	self.MuzzleEffect = "muzzleflash_smg"
	
	if not self:isAttachmentActive("sights") then
		self:updateIronsights("K")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
	self:revertToOriginalIronsights()
	self.ForegripOverride = false
	self.MuzzleEffect = "muzzleflash_smg"
end

CustomizableWeaponry:registerAttachment(att)