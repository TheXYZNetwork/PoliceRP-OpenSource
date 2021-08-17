local att = {}
att.name = "am_birdshot"
att.displayName = "Turkey shot"
att.displayNameShort = "Turkey"

att.statModifiers = {DamageMult = -.84,
RecoilMult = .1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flechetterounds")
	att.description = {{t = "Deals colossal amounts of damage up close.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Need to be close to target.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.Shots = 78
	self.ClumpSpread = nil
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self.ClumpSpread = self.ClumpSpread_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)