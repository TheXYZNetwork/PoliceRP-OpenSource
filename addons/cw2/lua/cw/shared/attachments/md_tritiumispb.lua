local att = {}
att.name = "md_tritiumispb"
att.displayName = "Night Sights"
att.displayNameShort = "Night"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_tritiumis")
	att.description = {[1] = {t = "Assists aiming in dark environments.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)