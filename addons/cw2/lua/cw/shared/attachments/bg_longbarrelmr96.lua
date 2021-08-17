local att = {}
att.name = "bg_longbarrelmr96"
att.displayName = "Long barrel"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {RecoilMult = 0.2,
AimSpreadMult = -0.2,
DrawSpeedMult = -0.2,
OverallMouseSensMult = -0.1,
DamageMult = 0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/longbarrel_revolver")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
	self:updateSoundTo("CW_MR96_FIRE_LONG", CustomizableWeaponry.sounds.UNSUPPRESSED)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)