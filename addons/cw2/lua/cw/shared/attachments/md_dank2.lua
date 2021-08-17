local att = {}
att.name = "md_dank2"
att.displayName = "Dank2"
att.displayNameShort = "Dank2"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_muzl")
	att.description = {[1] = {t = "Decreases recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)