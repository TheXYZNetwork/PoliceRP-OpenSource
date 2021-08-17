local att = {}
att.name = "am_45lc"
att.displayName = ".45 Long Colt"
att.displayNameShort = ".45 LC"
att.isBG = true

att.statModifiers = {DamageMult = 2.8,
	AimSpreadMult = -.25,
	RecoilMult = .25,}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {{t = "Deals colossal amounts of damage.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Requires a more accurate shot.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.Shots = 1
	self.ClumpSpread = nil
	self:setBodygroup(self.MagBGs.main, self.MagBGs.shell2)
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self.ClumpSpread = self.ClumpSpread_Orig
	self:setBodygroup(self.MagBGs.main, self.MagBGs.shell)
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)