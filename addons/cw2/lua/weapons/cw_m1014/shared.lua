AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "M1014"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.1
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_4hot_xm1014.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-2.641, 0, 1.22)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.641, 3.5, 0.555)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.619, -6.2, 0.462)
	SWEP.EoTechAng = Vector(0.699, 0.1, 0)
	
	SWEP.AimpointPos = Vector(-2.641, 1.5, 0.275)
	SWEP.AimpointAng = Vector(0, 0, 0)
			
	SWEP.ACOGPos = Vector(-2.641, 1.0, 0.275)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-0.24, 0, -1.361)
	SWEP.SprintAng = Vector(-8.101, 48.599, -28.3)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.641, 1.0, -0.75), [2] = Vector(0, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", pos = Vector(-0.375, -6.8, -4.875), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", pos = Vector(-2.053, 0.184, 12.067), angle = Angle(-3.333, 90, 180), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Base", pos = Vector(-0.1, -0.75, 0.85), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Base", pos = Vector(-0.445, -5.65, -4.5), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", pos = Vector(0.5, 10.75, -0.75), angle = Angle(0, 90, 90), size = Vector(0.6, 0.6, 0.6)},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(-0.0, 0, 0.0)
	SWEP.LaserAngAdjust = Angle(0, 180, 1.5) 
end

SWEP.MuzzleVelocity = 381 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {900, -300}, atts = {"md_microt1", "md_aimpoint", "md_acog"}},
				   [2] = {header = "Rail", offset = {200, -300}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {-200, 300}, atts = {"am_slugrounds", "am_flechetterounds"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.325, sound = "CW_M1014_INSERT"}},
	
	after_reload = {{time = 0.1533, sound = "CW_M1014_PUMP"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_4hot_xm1014.mdl"
SWEP.WorldModel		= "models/weapons/w_4hot_xm1014.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_M1014_FIRE"
SWEP.Recoil = 3.4

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 9
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.45
SWEP.InsertShellTime = 0.65
SWEP.ReloadFinishWait = 1
SWEP.PumpMidReloadWait = 0.6
SWEP.ShotgunReload = true

SWEP.Chamberable = true