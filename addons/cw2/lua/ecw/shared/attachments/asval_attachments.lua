AddCSLuaFile()

------------------ 20 ROUND MAG

local att = {}
att.name = "bg_asval_20rnd"
att.displayName = "20 round mag"
att.displayNameShort = "20RND"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.05,
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

------------------ 30 ROUND MAG

local att = {}
att.name = "bg_asval_30rnd"
att.displayName = "30 round mag"
att.displayNameShort = "30RND"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_30rndmag")
	att.description = {[1] = {t = "Increases mag size to 30 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round30)
	self:unloadWeapon()
	self.Primary.ClipSize = 30
	self.Primary.ClipSize_Orig = 30
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

att.statModifiers = {FireDelayMult = -0.3333333333333}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_variant")
end

function att:detachFunc()
	self:setBodygroup(self.VariantBGs.main, self.VariantBGs.vss)
end

CustomizableWeaponry:registerAttachment(att)

------------------ SR-3M VARIANT

local att = {}
att.name = "bg_sr3m"
att.displayName = "SR-3M variant"
att.displayNameShort = "SR-3M"
att.isBG = true
att.overrideSuppressorStatus = false -- it will override the weapon's default suppressor status to FALSE
att.SpeedDec = -3

att.statModifiers = {OverallMouseSensMult = 0.1,
RecoilMult = -0.1,
AimSpreadMult = 0.6,
FireDelayMult = -0.3333333333333}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/sr3m_variant")
end

function att:attachFunc()
	self:setBodygroup(self.VariantBGs.main, self.VariantBGs.sr3m)
	self:updateSoundTo("CW_SR3M_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
	self:updateSoundTo("CW_SR3M_FIRE_SUPPRESSED", CustomizableWeaponry.sounds.SUPPRESSED)
	self:setupCurrentIronsights(self.SR3MPos, self.SR3MAng)
	self.dt.Suppressed = false
	self.SuppressedOnEquip = false
	
	if not self:isAttachmentActive("sights") then
		self:updateIronsights("SR3M")
	end
end

function att:detachFunc()
	self:setBodygroup(self.VariantBGs.main, self.VariantBGs.vss)
	self:restoreSound()
	self:revertToOriginalIronsights()
	self.dt.Suppressed = true
	self.SuppressedOnEquip = true
end

CustomizableWeaponry:registerAttachment(att)

------------------ FOLDABLE STOCK

local att = {}
att.name = "bg_vss_foldable_stock"
att.displayName = "Foldable stock"
att.displayNameShort = "Fold"
att.isBG = true
att.SpeedDec = -3

att.statModifiers = {DrawSpeedMult = 0.2,
OverallMouseSensMult = 0.15,
RecoilMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_foldable_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.foldable)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.vss)
end

CustomizableWeaponry:registerAttachment(att)