local att = {}
att.name = "md_dank1"
att.displayName = "Dank1"
att.displayNameShort = "Dank1"


if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_muzl")
	att.description = {[1] = {t = "Decreases recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)