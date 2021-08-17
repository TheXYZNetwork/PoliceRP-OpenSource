local att = {}
att.name = "md_cblongbarrel"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isSuppressor = false
att.SpeedDec = 5

att.statModifiers = {OverallMouseSensMult = -.1,
ReloadSpeedMult = -0.1,
AimSpreadMult = -.20}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
end

CustomizableWeaponry:registerAttachment(att)