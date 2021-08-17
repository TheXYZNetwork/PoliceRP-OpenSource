local att = {}
att.name = "md_extmag22"
att.displayName = "Extended mag"
att.displayNameShort = "Ext Mag"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp530rnd")
	att.description = {[1] = {t = "Increases mag capacity by 15.", c = CustomizableWeaponry.textColors.POSITIVE}}
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