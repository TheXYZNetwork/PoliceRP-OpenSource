local att = {}
att.name = "md_bfstock"
att.displayName = "Bumpfire Stock"
att.displayNameShort = "BF Stock"

att.statModifiers = {FireDelayMult = -.084}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15heavystock")
end

function att:attachFunc()
	self:CycleFiremodes() 
	self.FireModes = {"auto","safe"}
	self:CycleFiremodes()
	self:CycleFiremodes()
end

function att:detachFunc()
	self:CycleFiremodes()
	self.FireModes = {"semi","safe"}
	self:CycleFiremodes()
	self:CycleFiremodes()
end

CustomizableWeaponry:registerAttachment(att)