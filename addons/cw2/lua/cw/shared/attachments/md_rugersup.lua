local att = {}
att.name = "md_rugersup"
att.displayName = "22LR Suppressor"
att.displayNameShort = "Suppressor"
att.isSuppressor = true

att.statModifiers = {OverallMouseSensMult = -0.1,
RecoilMult = -0.15,
HipSpreadMult = -0.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "Suppressor and barrel extension.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)