AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "Neostead 2000"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.4
	
	SWEP.EffectiveRange_Orig = 23.6 * 39.37
	SWEP.DamageFallOff_Orig = .5
	
	SWEP.ShellPosOffset = {x = 1.2, y = -3, z = 0}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
	
	SWEP.IronsightPos = Vector(-2.122, 0, -0.1)
	SWEP.IronsightAng = Vector(1.2, 0, 0)

	SWEP.KR_CMOREPos = Vector(-2.122, -2, -0.71)
	SWEP.KR_CMOREAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-2.116, -2, -0.515)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.EoTech553Pos = Vector(-2.11, -2, -0.81)
	SWEP.EoTech553Ang = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.122, -2, -0.63)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.786, -2, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(5.711, -1.482, -1.5)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.AlternativePos = Vector(-0, 1.2, -.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.017
	SWEP.ReticleInactivityPostFire = 1.1

	SWEP.AttachmentModelsVM = {
	
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Neostead 2000", rel = "", pos = Vector(0, -3.675, 0), angle = Angle(180, -180, 90), size = Vector(0.33, 0.33, 0.33), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Neostead 2000", rel = "", pos = Vector(-0.218, -1.9, -0.77), angle = Angle(90, -90, 0), size = Vector(0.699, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Neostead 2000", rel = "", pos = Vector(-0.013, -3, -2.701), angle = Angle(-90, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Neostead 2000", rel = "", pos = Vector(0.056, -3.636, 0), angle = Angle(-90, 90, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Neostead 2000", rel = "", pos = Vector(-0.02, -3.201, -2.901), angle = Angle(-90, 0, -90), size = Vector(0.819, 0.819, 0.819), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0, pitch = 1.5}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 1.5, forward = 0}
end

SWEP.MuzzleVelocity = 350 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -250},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint"}},
	["+reload"] = {header = "Ammo", offset = {-400, 50}, atts = {"am_slugroundsneo", "am_flechetterounds2", "am_shortbuck"}}}

SWEP.Animations = {fire = {"shoot1","shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "after_reload",
	draw = "draw"}
	
SWEP.Sounds = {shoot1 = {[1] = {time = 0.3, sound = "NEO2K_PUMPF"},
	[2] = {time = .45, sound = "NEO2K_PUMPB"}},

    shoot2 = {[1] = {time = .33, sound = "NEO2K_PUMPF"},
	[2] = {time = .45, sound = "NEO2K_PUMPB"}},
	
	start_reload = {{time = 0.2, sound = "NEO2K_OPEN"}},
	
	insert = {{time = 0.25, sound = "NEO2K_INSERT"}},
	
	after_reload = {[1] = {time = 0.25, sound = "NEO2K_CLOSE"},
	[2] = {time = .85, sound = "NEO2K_PUMPF"},
	[3] = {time = 1, sound = "NEO2K_PUMPB"},
	[4] = {time = 1.15, sound = "NEO2K_SHOULDER"}},
	
	draw = {[1] = {time = 0, sound = "NEO2K_DRAW"},
	[2] = {time = 1.25, sound = "NEO2K_SHOULDER"}}}
	

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_shot_neostead2.mdl"
SWEP.WorldModel		= "models/weapons/w_shot_m3super90.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.OverallMouseSens = .8

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.AmmoPerShot            = 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 60/60
SWEP.FireSound = "NEO2K_FIRE"
SWEP.Recoil = 6

SWEP.HipSpread = 0.077
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.08
SWEP.ClumpSpread = 0.031
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 1.1
SWEP.Shots = 20
SWEP.Damage = 6
SWEP.DeployTime = 1

SWEP.ReloadSpeed     = .8
SWEP.ReloadStartTime = .8
SWEP.InsertShellTime = 0.75
SWEP.ReloadFinishWait = .01
SWEP.ShotgunReload = true

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 23.6 * 39.37
	self.DamageFallOff = .5
	self.ClumpSpread = .031
	self.Primary.ClipSize = 5
	self.Primary.ClipSize_Orig = 5
	
	if self.ActiveAttachments.am_slugroundsneo then
	self.EffectiveRange = ((self.EffectiveRange + 11.8 * 39.37))
	self.ClumpSpread = ((self.ClumpSpread - .024))
	end
	if self.ActiveAttachments.am_flechetterounds2 then
	self.ClumpSpread = ((self.ClumpSpread - .0124))
	self.EffectiveRange = ((self.EffectiveRange - 2.36 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .05))
	self.Shots = 40
	end
	if self.ActiveAttachments.am_shortbuck then
	self.Primary.ClipSize = 7
	self.Primary.ClipSize_Orig = 7
	self.Shots = 12
	end
end