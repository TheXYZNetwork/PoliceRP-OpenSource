local att = {}
att.name = "bg_longbarrel"
att.displayName = "Long barrel"
att.displayNameShort = "LNGRNG"
att.isBG = true
att.SpeedDec = 2

att.statModifiers = {DamageMult = 0.1,
AimSpreadMult = -0.1,
RecoilMult = 0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15longbarrel")
	att.description = {[1] = {t = "A barrel for long range engagements.", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
	self:updateSoundTo("CW_AR15_LONGBARREL_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
	self:updateSoundTo("CW_AR15_LONGBARREL_FIRE_SUPPRESSED", CustomizableWeaponry.sounds.SUPPRESSED)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)