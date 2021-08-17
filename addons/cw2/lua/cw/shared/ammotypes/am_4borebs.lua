local att = {}
att.name = "am_4borebs"
att.displayName = "Standard Slugs"
att.displayNameShort = "Slugs"

att.statModifiers = {DamageMult = 11,
	AimSpreadMult = -.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/slugrounds")
end

function att:attachFunc()
	self.Shots = 1
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)