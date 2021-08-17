local att = {}
att.name = "am_shortbuck"
att.displayName = "Mini shot shells"
att.displayNameShort = "Mini"

att.statModifiers = {FireDelayMult = -.12,
	RecoilMult = -.2,
	ReloadSpeedMult = 0.08}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/slugrounds")
	att.description = {{t = "Increases capacity and firerate.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Reduces damage per shot.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.Shots = 6
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)