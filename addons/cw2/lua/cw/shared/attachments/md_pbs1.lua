local att = {}
att.name = "md_pbs1"
att.displayName = "PBS-1"
att.displayNameShort = "PBS-1"
att.isSuppressor = true

att.statModifiers = {OverallMouseSensMult = -0.1,
RecoilMult = -0.15,
DamageMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/pbs1")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:resetSuppressorStatus()
end

CustomizableWeaponry:registerAttachment(att)