local att = {}
att.name = "bg_mp530rndmag"
att.displayName = "30 round magazine"
att.displayNameShort = "30 RND"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.1,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp530rnd")
	att.description = {[1] = {t = "Increases mag size to 30 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round30)
	self:unloadWeapon()
	self.Primary.ClipSize = 30
	self.Primary.ClipSize_Orig = 30
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round15)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)