local att = {}
att.name = "bg_aa12_drummag"
att.displayName = "30 Round Drum Magazine"
att.displayNameShort = "Drum Mag"
att.isBG = true

att.statModifiers = {
ReloadSpeedMult = -0.15,
OverallMouseSensMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_aa12_drummag")
	att.description = {[1] = {t = "Increases mag size to 32 rounds.", c = CustomizableWeaponry.textColors.POSITIVE},
[2] = {t = "Too large to fit in a ammo bag.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.drum)
	self:unloadWeapon()
	self.Primary.ClipSize = 32
	self.Primary.ClipSize_Orig = 32
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)