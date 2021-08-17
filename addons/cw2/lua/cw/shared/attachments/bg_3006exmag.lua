local att = {}
att.name = "bg_3006extmag"
att.displayName = "Extended Mag"
att.displayNameShort = "Ext. Mag"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.15,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/bg_hk416_34rndmag")
	att.description = {[1] = {t = "Increases mag capacity by 10.", c = CustomizableWeaponry.textColors.POSITIVE}}
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