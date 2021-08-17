local att = {}
att.name = "md_mchoke"
att.displayName = "Modified Choke"
att.displayNameShort = "MChoke"

att.statModifiers = {OverallMouseSensMult = -0.15,
VelocitySensitivityMult = 0.15,
DrawSpeedMult = -0.05,
HipSpreadMult = 0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "Decreases clump spread by 10%.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.ClumpSpread = nil
end

function att:detachFunc()
	self.ClumpSpread = self.ClumpSpread_Orig
end

CustomizableWeaponry:registerAttachment(att)