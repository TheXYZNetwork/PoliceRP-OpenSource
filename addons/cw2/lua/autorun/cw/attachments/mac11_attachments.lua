AddCSLuaFile()

------------------ EXTENDED BARREL

local att = {}
att.name = "bg_mac11_extended_barrel"
att.displayName = "Extended barrel"
att.displayNameShort = "Ext"
att.isBG = true

att.statModifiers = {OverallMouseSensMult = -0.1,
	AimSpreadMult = -0.15,
	RecoilMult = 0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mac11_ext_barrel")
	att.description = {[1] = {t = "An extended barrel.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.extended)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)

------------------ UNFOLDED STOCK

local att = {}
att.name = "bg_mac11_unfolded_stock"
att.displayName = "Unfolded stock"
att.displayNameShort = "Unfold"
att.isBG = true

att.statModifiers = {DrawSpeedMult = -0.1,
OverallMouseSensMult = -0.1,
RecoilMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mac11_unfolded_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.unfolded)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.folded)
end

CustomizableWeaponry:registerAttachment(att)