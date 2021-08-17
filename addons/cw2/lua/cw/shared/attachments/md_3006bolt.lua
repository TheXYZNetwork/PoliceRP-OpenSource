local att = {}
att.name = "md_lightbolt"
att.displayName = "Light Bolt"
att.displayNameShort = "Light Bolt"

att.statModifiers = {RecoilMult = 0.15,
FireDelayMult = -.25,
MaxSpreadIncMult = 0.25
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_3006bolt")
	att.description = {[1] = {t = "Increases RPM and recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc() 
end

CustomizableWeaponry:registerAttachment(att)