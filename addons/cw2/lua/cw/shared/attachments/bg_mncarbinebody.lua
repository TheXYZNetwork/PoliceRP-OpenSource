local att = {}
att.name = "bg_mncarbinebody"
att.displayName = "Carbine Body"
att.displayNameShort = "Carbine"

att.statModifiers = {
	OverallMouseSensMult = 0.1,
	RecoilMult = .25,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mncarbinebody")
	att.description = {[1] = {t = "Gives your rifle an M44 Carbine style.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:setBodygroup(self.StockBGs.main, self.StockBGs.carbine)
		if self.WMEnt then
		self.WMEnt:SetBodygroup(self.StockBGs.main, self.StockBGs.carbine)
	end
	self.MuzzleEffect = "muzzleflash_ak47"
end

function att:detachFunc()
    self:setBodygroup(self.StockBGs.main, self.StockBGs.full)
		if self.WMEnt then
		self.WMEnt:SetBodygroup(self.StockBGs.main, self.StockBGs.full)
	end
		self.MuzzleEffect = "muzzleflash_6"
end

CustomizableWeaponry:registerAttachment(att)