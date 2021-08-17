local att = {}
att.name = "bg_aa12_longBarrel"
att.displayName = "Long barrel"
att.displayNameShort = "LNG"
att.isBG = true

att.statModifiers = {DamageMult = 0.1,
AimSpreadMult = -0.1,
RecoilMult = 0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_aa12_longBarrel")
	att.description = {[1] = {t = "A barrel for mid range engagements.", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)