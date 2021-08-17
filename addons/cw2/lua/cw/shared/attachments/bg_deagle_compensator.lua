local att = {}
att.name = "bg_deagle_compensator"
att.displayName = "Compensator"
att.displayNameShort = "Comp"
att.isBG = true

att.statModifiers = {RecoilMult = -0.3,
AimSpreadMult = 0.15,
OverallMouseSensMult = -0.1,
DrawSpeedMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/deagle_compensator")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.compensator)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)