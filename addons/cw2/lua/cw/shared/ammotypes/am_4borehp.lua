local att = {}
att.name = "am_4borehp"
att.displayName = "Overpressure Hollowpoint Rounds"
att.displayNameShort = "HP "

att.statModifiers = {DamageMult = 15,
	RecoilMult = 1,
	AimSpreadMult = .45}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {[1] = {t = "Are you hunting dinosaurs?", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Shots = 1
	self:updateSoundTo("CB4_FIRE_HP", CustomizableWeaponry.sounds.UNSUPPRESSED)
end

function att:detachFunc()
	self:unloadWeapon()
	self.Shots = self.Shots_Orig
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)