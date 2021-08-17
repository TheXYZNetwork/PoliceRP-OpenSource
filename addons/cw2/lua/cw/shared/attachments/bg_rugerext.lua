local att = {}
att.name = "bg_rugerext"
att.displayName = "Ruger Extended Mag"
att.displayNameShort = "Ext. Mag"

att.statModifiers = {ReloadSpeedMult = -0.10,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp530rnd")
	att.description = {[1] = {t = "Increases mag capacity by 20.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = 30
	self.Primary.ClipSize_Orig = 30
end

function att:detachFunc() 
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)