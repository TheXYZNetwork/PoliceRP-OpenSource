local att = {}
att.name = "bg_sksbayonetfold"
att.displayName = "Folded Bayonet"
att.displayNameShort = "Fold"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_sksbayonetfold")
	att.description = {[1] = {t = "Adds a cosmetic folded bayonet.", c = CustomizableWeaponry.textColors.NEUTRAL}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.one)
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.none)
end

CustomizableWeaponry:registerAttachment(att)