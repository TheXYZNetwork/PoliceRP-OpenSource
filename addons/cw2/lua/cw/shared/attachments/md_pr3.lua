local att = {}
att.name = "md_pr3"
att.displayName = ""
att.displayNameShort = ""

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_pr3")
	att.description = {[1] = {t = "", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:updateSoundTo("RUBY_FIRE3", CustomizableWeaponry.sounds.UNSUPPRESSED)
end

function att:detachFunc()
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)