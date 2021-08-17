local att = {}
att.name = "am_gdcw"
att.displayName = "GDCW rounds"
att.displayNameShort = "GDCW"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {[1] = {t = "Generic Default's bullet", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc() -- When this attachment is added to this SWep
	self.gdcw = 1
end

function att:detachFunc() -- When this attachment is removed from this SWep
	self.gdcw = 0
end

CustomizableWeaponry:registerAttachment(att)