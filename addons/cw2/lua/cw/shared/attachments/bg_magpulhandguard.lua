local att = {}
att.name = "bg_magpulhandguard"
att.displayName = "Magpul handguard"
att.displayNameShort = "Magpul"
att.isBG = true

att.statModifiers = {RecoilMult = 0.05,
	OverallMouseSensMult = 0.1,
	DrawSpeedMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15magpul")
	att.description = {[1] = {t = "A comfortable, lightweight handguard.", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.magpul)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)