AddCSLuaFile()

local makarov_ext_mag = {}
makarov_ext_mag.name = "bg_makarov_extmag"
makarov_ext_mag.displayName = "Extended magazine"
makarov_ext_mag.displayNameShort = "Ext mag"
makarov_ext_mag.isBG = true

makarov_ext_mag.statModifiers = {ReloadSpeedMult = -0.1,
	DrawSpeedMult = -0.05,
	OverallMouseSensMult = -0.05}

if CLIENT then
	makarov_ext_mag.displayIcon = surface.GetTextureID("atts/makarov_extmag")
	makarov_ext_mag.description = {[1] = {t = "Increases mag size to 12 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function makarov_ext_mag:attachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = 12
	self.Primary.ClipSize_Orig = 12
	
	if CLIENT then
		self:setBodygroup(self.MagBGs.main, self.MagBGs.extended)
	end
end
	

function makarov_ext_mag:detachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	
	if CLIENT then
		self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	end
end

CustomizableWeaponry:registerAttachment(makarov_ext_mag)

local pb = {}
pb.name = "bg_makarov_pb6p9"
pb.displayName = "PB variant"
pb.displayNameShort = "PB"
pb.isBG = true
pb.isSight = true

pb.statModifiers = {RecoilMult = -0.1,
	AimSpreadMult = -0.2,
	DrawSpeedMult = -0.05,
	DamageMult = 0.1,
	FireDelayMult = 0.2}

if CLIENT then
	pb.displayIcon = surface.GetTextureID("atts/pb6p9")
	pb.description = {[1] = {t = "The PB/6P9 variant of the Makarov pistol.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

function pb:attachFunc()
	if CLIENT then
		self:setBodygroup(self.SlideBGs.main, self.SlideBGs.pb)
		self:setupBoltBone("__nmBar_0")
		self:setupCurrentIronsights(self.PBIronsightsPos, self.PBIronsightsAng)
		self:updateIronsights("PBIronsights")
	end
	
	self:updateSoundTo("CW_MAKAROV_FIRE_SUPPRESSED_PB", CustomizableWeaponry.sounds.SUPPRESSED)
end

function pb:detachFunc()
	if CLIENT then
		self:setBodygroup(self.SlideBGs.main, self.SlideBGs.pm)
		self:setupBoltBone()
		self:revertToOriginalIronsights()
	end
	
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(pb)

local pb_supp = {}
pb_supp.name = "bg_makarov_pb_suppressor"
pb_supp.displayName = "PB Suppressor"
pb_supp.displayNameShort = "Suppress"
pb_supp.isBG = true

pb_supp.statModifiers = {RecoilMult = -0.1,
	OverallMouseSensMult = -0.05,
	DamageMult = -0.15}

if CLIENT then
	pb_supp.displayIcon = surface.GetTextureID("atts/pb_suppressor")
	pb_supp.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function pb_supp:attachFunc()
	self.dt.Suppressed = true
	
	if CLIENT then
		self:setBodygroup(self.SuppressorBGs.main, self.SuppressorBGs.pb)
	end
end

function pb_supp:detachFunc()
	self.dt.Suppressed = false
	
	if CLIENT then
		self:setBodygroup(self.SuppressorBGs.main, self.SuppressorBGs.none)
	end
end

CustomizableWeaponry:registerAttachment(pb_supp)

local pm_supp = {}
pm_supp.name = "bg_makarov_pm_suppressor"
pm_supp.displayName = "PM Suppressor"
pm_supp.displayNameShort = "Suppress"
pm_supp.isBG = true

pm_supp.statModifiers = {RecoilMult = -0.1,
	OverallMouseSensMult = -0.05,
	DamageMult = -0.1}

if CLIENT then
	pm_supp.displayIcon = surface.GetTextureID("atts/pm_suppressor")
	pm_supp.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function pm_supp:attachFunc()
	self.dt.Suppressed = true
	
	if CLIENT then
		self:setBodygroup(self.SuppressorBGs.main, self.SuppressorBGs.pm)
	end
end

function pm_supp:detachFunc()
	self.dt.Suppressed = false
	
	if CLIENT then
		self:setBodygroup(self.SuppressorBGs.main, self.SuppressorBGs.none)
	end
end

CustomizableWeaponry:registerAttachment(pm_supp)