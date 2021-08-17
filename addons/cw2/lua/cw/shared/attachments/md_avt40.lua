local att = {}
att.name = "md_avt40"
att.displayName = "AVT-40"
att.displayNameShort = "AVT-40"

att.statModifiers = {FireDelayMult = -.5,
RecoilMult = .1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74heavystock")
	att.description = {[1] = {t = "Automatic firemode", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:CycleFiremodes() 
	self.FireModes = {"semi","safe","auto"}
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