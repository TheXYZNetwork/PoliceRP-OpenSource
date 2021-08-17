local att = {}
att.name = "md_prextmag"
att.displayName = "PR Ext Mag"
att.displayNameShort = "Teeth"

att.statModifiers = {DamageMult = 200,
	RecoilMult = -.9,
	AimSpreadMult = -50,
	HipSpreadMult = -50,
	ReloadSpeedMult = 5,
	FireDelayMult = -.6}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flechetterounds")
	att.description = {{t = "Extended Mag", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.Primary.ClipSize = 500
	self.Primary.ClipSize_Orig = 500
	self:CycleFiremodes() 
	self.FireModes = {"semi","safe","auto"}
	self:CycleFiremodes()
	self:CycleFiremodes()
end

function att:detachFunc()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	self:CycleFiremodes()
	self.FireModes = {"semi","safe"}
	self:CycleFiremodes()
	self:CycleFiremodes()
end

CustomizableWeaponry:registerAttachment(att)