local att = {}
att.name = "md_dank3"
att.displayName = "Dank3"
att.displayNameShort = "Dank3"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_muzl")
	att.description = {[1] = {t = "Decreases recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)