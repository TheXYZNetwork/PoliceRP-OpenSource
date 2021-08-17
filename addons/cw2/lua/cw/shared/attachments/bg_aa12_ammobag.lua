local att = {}
att.name = "bg_aa12_ammobag"
att.displayName = "Ammo Bag"
att.displayNameShort = "Ammo Bag"
att.isBG = true

att.statModifiers = {
	ReloadSpeedMult = 0.35,
	OverallMouseSensMult = -0.10,
	DrawSpeedMult = -0.10
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_aa12_ammobag")
	att.description = {[1] = {t = "Convenient ammo bag that makes reloads faster.", c = CustomizableWeaponry.textColors.COSMETIC},
[2] = {t = "Not large enough for drum mags.", c = CustomizableWeaponry.textColors.NEGATIVE}
}
end

function att:attachFunc()
	self:setBodygroup(self.BagBGs.main, self.BagBGs.on)
end

function att:detachFunc()
	self:setBodygroup(self.BagBGs.main, self.BagBGs.off)
end

CustomizableWeaponry:registerAttachment(att)