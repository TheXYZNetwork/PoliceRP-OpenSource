AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "MP-153"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.35
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	
	SWEP.ShellPosOffset = {x = 1.2, y = -3, z = 0}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 38 * 39.37
	SWEP.DamageFallOff_Orig = .46
	
	SWEP.IronsightPos = Vector(-2.84, 0, 1.15)
	SWEP.IronsightAng = Vector(0.45, 0, 0.5)
	
	SWEP.MicroT1Pos = Vector(-2.842, -2, .932)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-2.85, -2, 0.765)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-1.8112, -1.5, 0.465)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-2.814, -1.5, .81)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.85, -1.5, 0.84)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.827, 0, 0.909)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-2.847, -2.3, 0.82985)
	SWEP.NXSAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.CustomizePos = Vector(5.711, -1.482, -1.5)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.AlternativePos = Vector(-0.6711, 0.6711, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.022
	SWEP.ReticleInactivityPostFire = 0

	SWEP.AttachmentModelsVM = {
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "MP-153", rel = "", pos = Vector(0.509, 0, 1.6), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "MP-153", rel = "", pos = Vector(0.569, -0.5, 1.139), angle = Angle(0, 180, 0), size = Vector(0.165, 0.165, 0.165), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "MP-153", rel = "", pos = Vector(0.583, 1, 0.769), angle = Angle(0, -90, 0), size = Vector(0.479, 0.479, 0.479), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "MP-153", rel = "", pos = Vector(0.689, 1, 0.15), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "MP-153", rel = "", pos = Vector(0.55, 0, 1.1), angle = Angle(0, -90, 0), size = Vector(0.135, 0.135, 0.135), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "MP-153", rel = "", pos = Vector(0.379, -3, -1.701), angle = Angle(0, -90, 0), size = Vector(0.479, 0.479, 0.479), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "MP-153", rel = "", pos = Vector(0.56, 1.7, 0.85), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_mchoke"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "MP-153", rel = "", pos = Vector(0.55, 24, -0), angle = Angle(0, 0, 0), size = Vector(0.34, 0.34, 0.34), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fchoke"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "MP-153", rel = "", pos = Vector(0.55, 24, -0), angle = Angle(0, 0, 0), size = Vector(0.34, 0.34, 0.34), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = .5}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = -.05, forward = 0}
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 350 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -250},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_nightforce_nxs"}},
	[2] = {header = "Barrel", offset = {-300, -400}, atts = {"md_mchoke", "md_fchoke"}},
	["+reload"] = {header = "Ammo", offset = {-400, 50}, atts = {"am_rifledslugs", "am_birdshot", "am_flechetterounds2", "am_shortbuck"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "after_reload",
	draw = "draw"}
	
SWEP.AttachmentExclusions = {
["md_mchoke"] = {"am_rifledslugs"},
["md_fchoke"] = {"am_rifledslugs", "am_birdshot"},
["am_rifledslugs"] = {"md_mchoke", "md_fchoke"},
["am_birdshot"] = {"md_fchoke"}
}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "K620_INSERT"}},
	
	after_reload = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0.1, sound = "CW_FOLEY_MEDIUM"}}}
	

SWEP.SpeedDec = 55

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_bmp153.mdl"
SWEP.WorldModel		= "models/weapons/w_shot_m3super90.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.OverallMouseSens = .85

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 60/240
SWEP.FireSound = "MP153_FIRE"
SWEP.Recoil = 4.4

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.0087
SWEP.VelocitySensitivity = 1.70
SWEP.MaxSpreadInc = 0.075
SWEP.ClumpSpread = 0.021
SWEP.SpreadPerShot = 0.025
SWEP.SpreadCooldown = 0.53
SWEP.Shots = 10
SWEP.Damage = 11
SWEP.DeployTime = .86
SWEP.RecoilToSpread = .8

SWEP.ReloadStartTime = .65
SWEP.InsertShellTime = 0.75
SWEP.ReloadFinishWait = .7
SWEP.ShotgunReload = true

SWEP.Chamberable = false

function SWEP:IndividualThink()
	self.EffectiveRange = 38 * 39.37
	self.DamageFallOff = .46
	self.ClumpSpread = .021
	self.Primary.ClipSize = 6
	self.Primary.ClipSize_Orig = 6
	self.RecoilToSpread = .8
	
	if self.ActiveAttachments.am_rifledslugs then
	self.EffectiveRange = ((self.EffectiveRange + 24.9 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .102))
	self.ClumpSpread = nil
	end
	if self.ActiveAttachments.am_birdshot then
	self.EffectiveRange = ((self.EffectiveRange - 14.04 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .39))
	self.ClumpSpread = ((self.ClumpSpread + .01))
	self.Shots = 67
	end
	if self.ActiveAttachments.am_flechetterounds2 then
	self.ClumpSpread = ((self.ClumpSpread - .0096))
	self.EffectiveRange = ((self.EffectiveRange - 3.12 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .046))
	end
	if self.ActiveAttachments.md_mchoke then
	self.ClumpSpread = ((self.ClumpSpread * .9))
	end
	if self.ActiveAttachments.md_fchoke then
	self.ClumpSpread = ((self.ClumpSpread * .8))
	end
	if self.ActiveAttachments.am_shortbuck then
	self.Primary.ClipSize = 8
	self.Primary.ClipSize_Orig = 8
	self.RecoilToSpread = ((self.RecoilToSpread - .15))
	end
end