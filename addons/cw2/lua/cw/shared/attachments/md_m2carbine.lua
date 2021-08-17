local att = {}
att.name = "md_m2carbine"
att.displayName = "M2 Carbine"
att.displayNameShort = "M2 Carbine"

att.statModifiers = {FireDelayMult = -.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/matchgradeammo")
	att.description = {[1] = {t = "Automatic firemode", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:CycleFiremodes() 
	self.FireModes = {"auto","safe","semi"}
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