local att = {}
att.name = "md_makeshift"
att.displayName = "Makeshift Sight"
att.displayNameShort = "Makeshift"
att.aimPos = {"IronsightPos", "IronsightAng"}
att.isSight = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foldsight")
	att.description = {[1] = {t = "A primitive sight to assist aiming.", c = CustomizableWeaponry.textColors.COSMETIC}}

end

CustomizableWeaponry:registerAttachment(att)