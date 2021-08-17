local att = {}
att.name = "md_mnolddark"
att.displayName = "Old - Dark"
att.displayNameShort = "Dark"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mnolddark")
	att.description = {[1] = {t = "Dark and menacing finish.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(3)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(3)
	end
end

function att:detachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(0)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(0)
	end
end

CustomizableWeaponry:registerAttachment(att)