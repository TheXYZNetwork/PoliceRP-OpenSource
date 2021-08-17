local att = {}
att.name = "bg_sksbayonetunfold"
att.displayName = "Unfolded Bayonet"
att.displayNameShort = "Unfold"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_sksbayonetunfold")
	att.description = {[1] = {t = "Adds a cosmetic unfolded bayonet.", c = CustomizableWeaponry.textColors.NEUTRAL}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.two)
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.none)
end

CustomizableWeaponry:registerAttachment(att)