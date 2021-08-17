local att = {}
att.name = "bg_aa12_grip"
att.displayName = "Support Grip"
att.displayNameShort = "AA12 Grip"

att.statModifiers = {VelocitySensitivityMult = -0.15,
OverallMouseSensMult = -0.05,
RecoilMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_aa12_grip")
	att.description = {}
end

function att:attachFunc()
	self:setBodygroup(self.GripBGs.main, self.GripBGs.grip)
end

function att:detachFunc()
	self:setBodygroup(self.GripBGs.main, self.GripBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)