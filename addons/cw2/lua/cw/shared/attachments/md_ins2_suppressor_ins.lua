local att = {}
att.name = "md_ins2_suppressor_ins"
att.displayName = "Universal suppressor"
att.displayNameShort = "Suppressor"
att.isSuppressor = true

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	RecoilMult = -0.15,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ins2_suppressor_ins")
	att.description = {
		[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE},
		-- [2] = {t = "Increases weapon length.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)