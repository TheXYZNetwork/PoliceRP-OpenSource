local att = {}
att.name = "md_dank"
att.displayName = "Dank"
att.displayNameShort = "Dank"

att.statModifiers = {RecoilMult = -.65,
OverallMouseSensMult = .81,
FireDelayMult = -.55,
ReloadSpeedMult = 100,
DamageMult = -.5,
MaxSpreadIncMult = -.80,
VelocitySensitivityMult = -.70
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_muzl")
	att.description = {[1] = {t = "Decreases recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = 2000
	self.Primary.ClipSize_Orig = 2000
end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)