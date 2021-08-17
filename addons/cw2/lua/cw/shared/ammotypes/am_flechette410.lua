local att = {}
att.name = "am_flechette410"
att.displayName = "Flechette Shells"
att.displayNameShort = "Flechette"

att.statModifiers = {ClumpSpreadMult = -0.4,
	DamageMult = -0.6}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flechetterounds")
	att.description = {{t = "Increases amount of shot to 8.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.Shots = 8
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)