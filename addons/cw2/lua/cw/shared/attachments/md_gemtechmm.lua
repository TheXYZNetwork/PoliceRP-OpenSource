local att = {}
att.name = "md_gemtechmm"
att.displayName = "Gemtech Multimount"
att.displayNameShort = "Gemtech"
att.isSuppressor = true

att.statModifiers = {OverallMouseSensMult = -0.1,
RecoilMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_gemtechmm")
		att.description = {[1] = {t = "Reduces firing signature.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)