local att = {}
att.name = "bg_regularbarrel"
att.displayName = "Regular barrel"
att.displayNameShort = "Regular"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = -0.15,
DrawSpeedMult = -0.10}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/regularbarrel_revolver")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:updateSoundTo("CW_MR96_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)