local att = {}
att.name = "skin_aa12_digital"
att.displayName = "Multi-scale camouflage"
att.displayNameShort = "Digital Camo"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/skin_aa12_digital")
	att.description = {[1] = {t = "Multi-scale camouflage for your weapon.", c = CustomizableWeaponry.textColors.COSMETIC}}
end


function att:attachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(1)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(1)
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