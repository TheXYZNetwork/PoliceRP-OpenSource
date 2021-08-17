local att = {}
att.name = "bg_deagle_extendedbarrel"
att.displayName = "Extended barrel"
att.displayNameShort = "Ext. b."
att.isBG = true

att.statModifiers = {RecoilMult = 0.15,
AimSpreadMult = -0.2,
OverallMouseSensMult = -0.1,
DrawSpeedMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/deagle_extendedbarrel")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.extended)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)