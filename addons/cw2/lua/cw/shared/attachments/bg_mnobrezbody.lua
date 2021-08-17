local att = {}
att.name = "bg_mnobrezbody"
att.displayName = "Obrez Body"
att.displayNameShort = "Obrez"

att.statModifiers = {
	OverallMouseSensMult = 0.2,
	RecoilMult = .85,
    AimSpreadMult = 1,
	HipSpreadMult = -.25,
	DamageMult = -.05,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mnobrezbody")
	att.description = {[1] = {t = "Gives your rifle a shoddy sawn-off style.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:setBodygroup(self.StockBGs.main, self.StockBGs.obrez)
				if self.WMEnt then
		self.WMEnt:SetBodygroup(self.StockBGs.main, self.StockBGs.obrez)
	end
	self.MuzzleEffect = "muzzle_center_M82"
	self.LuaViewmodelRecoil = true
	self.LuaViewmodelRecoilOverride = true
	self.FullAimViewmodelRecoil = true
end

function att:detachFunc()
    self:setBodygroup(self.StockBGs.main, self.StockBGs.full)
				if self.WMEnt then
		self.WMEnt:SetBodygroup(self.StockBGs.main, self.StockBGs.full)
	end
	self.MuzzleEffect = "muzzleflash_6"
	self.LuaViewmodelRecoil = false
	self.LuaViewmodelRecoilOverride = false
	self.FullAimViewmodelRecoil = true
end

CustomizableWeaponry:registerAttachment(att)