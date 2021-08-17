AddCSLuaFile()

------------------ 20 ROUND MAG

local att = {}
att.name = "bg_asval_20rnd"
att.displayName = "20 round mag"
att.displayNameShort = "20RND"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_20rndmag")
	att.description = {[1] = {t = "Increases mag size to 20 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round20)
	self:unloadWeapon()
	self.Primary.ClipSize = 20
	self.Primary.ClipSize_Orig = 20
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)

------------------ AS VAL VARIANT

local att = {}
att.name = "bg_asval"
att.displayName = "AS VAL variant"
att.displayNameShort = "AS VAL"
att.isBG = true

att.statModifiers = {DrawSpeedMult = 0.2,
OverallMouseSensMult = 0.15,
RecoilMult = 0.15,
FireDelayMult = -0.3333333333333}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_variant")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.asval)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.vss)
end

CustomizableWeaponry:registerAttachment(att)