local att = {}
att.name = "md_muzl"
att.displayName = "Enhanced Muzzlebrake"
att.displayNameShort = "Mzlbrake"

att.statModifiers = {RecoilMult = -.2,
AimSpreadMult = .5,
OverallMouseSensMult = -0.05,
MaxSpreadIncMult = 0.25
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_muzl")
	att.description = {[1] = {t = "Decreases recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)