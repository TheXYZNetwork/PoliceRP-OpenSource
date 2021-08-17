local att = {}
att.name = "ins2_atow_hvrocket"
att.displayName = "HV Warhead"
att.displayNameShort = "HV"
att.isBG = true
att.SpeedDec = -3

att.statModifiers = {DamageMult = -.333,
ReloadSpeedMult = .09}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpg7hv")
	att.description = {[1] = {t = "A high velocity light armor piercing warhead.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Much lighter, straightening trajectory.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Limited payload decreases blast radius & damage.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
end

function att:attachFunc()
	self:setBodygroup(self.WarheadBGs.main, self.WarheadBGs.hv)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.WarheadBGs.main, self.WarheadBGs.heat)
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
