local att = {}
att.name = "md_fchoke"
att.displayName = "Full Choke"
att.displayNameShort = "FChoke"

att.statModifiers = {OverallMouseSensMult = -0.25,
VelocitySensitivityMult = 0.23,
DrawSpeedMult = -0.1,
HipSpreadMult = 0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "Decreases clump spread by 20%.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.ClumpSpread = nil
end

function att:detachFunc()
	self.ClumpSpread = self.ClumpSpread_Orig
end

CustomizableWeaponry:registerAttachment(att)