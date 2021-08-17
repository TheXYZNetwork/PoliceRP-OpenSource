local att = {}
att.name = "am_slugrounds2k"
att.displayName = "Slug rounds"
att.displayNameShort = "Slug"

att.statModifiers = {DamageMult = 6,
	AimSpreadMult = -.55,
	RecoilMult = 0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/slugrounds")
	att.description = {{t = "Deals colossal amounts of damage.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Requires a more accurate shot.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.Shots = 1
	self.ClumpSpread = nil
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self.ClumpSpread = self.ClumpSpread_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)