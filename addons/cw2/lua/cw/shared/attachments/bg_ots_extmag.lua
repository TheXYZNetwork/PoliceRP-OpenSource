local att = {}
att.name = "bg_ots_extmag"
att.displayName = "Extended Mag"
att.displayNameShort = "Ext Mag"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.20,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/makarov_extmag")
	att.description = {[1] = {t = "Increases mag capacity to 40.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = 40
	self.Primary.ClipSize_Orig = 40
end

function att:detachFunc() 
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)