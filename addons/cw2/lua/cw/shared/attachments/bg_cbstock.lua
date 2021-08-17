local att = {}
att.name = "bg_cbstock"
att.displayName = "Recoil-Absorbing Stock"
att.displayNameShort = "Stock"
att.SpeedDec = 5

att.statModifiers = {RecoilMult = -0.25,
OverallMouseSensMult = -.1,
HipSpreadMult = -.1,
VelocitySensitivityMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15heavystock")
end

CustomizableWeaponry:registerAttachment(att)