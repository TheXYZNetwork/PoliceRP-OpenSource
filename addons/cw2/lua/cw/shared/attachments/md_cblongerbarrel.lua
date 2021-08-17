local att = {}
att.name = "md_cblongerbarrel"
att.displayName = "Longer Improved Barrel"
att.displayNameShort = "Longer"
att.isSuppressor = false
att.SpeedDec = 10

att.statModifiers = {OverallMouseSensMult = -.2,
ReloadSpeedMult = -0.15,
AimSpreadMult = -.4}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
end

CustomizableWeaponry:registerAttachment(att)