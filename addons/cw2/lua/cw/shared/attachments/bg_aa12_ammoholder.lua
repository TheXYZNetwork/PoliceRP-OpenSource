local att = {}
att.name = "bg_aa12_AmmoHolder"
att.displayName = "Receiver Shell Holder"
att.displayNameShort = "R. Shell Holder"

att.statModifiers = {
	ReloadSpeedMult = 0.10,
	DrawSpeedMult = -0.1,
	OverallMouseSensMult = -0.10
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_aa12_AmmoHolder")
	att.description = {[1] = {t = "Conveniently placed shells.", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	self:setBodygroup(self.AmmoHolderBGs.main, self.AmmoHolderBGs.AmmoHolder)
end

function att:detachFunc()
	self:setBodygroup(self.AmmoHolderBGs.main, self.AmmoHolderBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)