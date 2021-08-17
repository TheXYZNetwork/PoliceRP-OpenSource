local att = {}
att.name = "bg_mncustombody"
att.displayName = "Sporterized Body"
att.displayNameShort = "Sport"

att.statModifiers = {
	RecoilMult = -.1,
	AimSpreadMult = -.15,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mncustombody")
	att.description = {[1] = {t = "Gives your rifle a slim sporterized style.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:setBodygroup(self.StockBGs.main, self.StockBGs.custom)
			if self.WMEnt then
		self.WMEnt:SetBodygroup(self.StockBGs.main, self.StockBGs.custom)
	end
end

function att:detachFunc()
    self:setBodygroup(self.StockBGs.main, self.StockBGs.full)
			if self.WMEnt then
		self.WMEnt:SetBodygroup(self.StockBGs.main, self.StockBGs.carbine)
	end
end

CustomizableWeaponry:registerAttachment(att)