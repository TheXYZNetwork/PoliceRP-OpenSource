local att = {}
att.name = "bg_r8rail"
att.displayName = "Picatinny Rail"
att.displayNameShort = "Rail"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_r8rail")
	att.description = {[1] = {t = "Allows mounting of optics.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.rail)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.norail)
end

CustomizableWeaponry:registerAttachment(att)