local att = {}
att.name = "ins2_atow_hvatrocket"
att.displayName = "HVAT Warhead"
att.displayNameShort = "HVAT"
att.isBG = true
att.SpeedDec = 4

att.statModifiers = {DamageMult = .265,
ReloadSpeedMult = -.09}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpg7hvat")
	att.description = {[1] = {t = "A high velocity, anti-tank shaped charge warhead.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Much higher damage and speed.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Directed explosion limits blast radius.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
end

function att:attachFunc()
	self:setBodygroup(self.WarheadBGs.main, self.WarheadBGs.hvat)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.WarheadBGs.main, self.WarheadBGs.heat)
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
