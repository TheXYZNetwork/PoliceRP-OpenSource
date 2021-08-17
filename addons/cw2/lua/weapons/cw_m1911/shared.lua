AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x18MM", "9x18MM Rounds", 9, 18)
SWEP.PrintName = "M1911"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}
	
	SWEP.IronsightPos = Vector(-2.01, 0.386, 0.34)
	SWEP.IronsightAng = Vector(0.4, 0, 0)
		
	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.RMRPos = Vector(-2.004, -3.22, -0.238)
	SWEP.RMRAng = Vector(0, 0, 0)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.392, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(1.5, 0, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 15
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.7
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = true
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "body", pos = Vector(7.498, -1.479, 0.002), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255)},
		["md_rail"] = {model = "models/cw2/attachments/slimpistolrail.mdl", bone = "body", pos = Vector(3.48, -0.452, 0), angle = Angle(0, 0, -90), size = Vector(0.1, 0.1, 0.1)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "body", pos = Vector(-0.464, 1.292, 0.216), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6)},
		["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "body", pos = Vector(2.299, -0.561, 0), angle = Angle(0, 180, 90), size = Vector(0.079, 0.079, 0.079), bodygroups = {[1] = 1}}
	}

	SWEP.LaserPosAdjust = Vector(0.5, 0, -1)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/cw_pist_m1911.mdl"
	SWEP.WMPos = Vector(-1, -1, -0.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.MagBGs = {main = 3, regular = 0, extended = 1}
end

SWEP.ShootWhileProne = true

SWEP.MuzzleVelocity = 251 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_cobram2"}},
	[2] = {header = "Sight", offset = {300, -300}, atts = {"md_rmr"}, exclusions = {md_insight_x2 = true}},
	[3] = {header = "Rail", offset = {-350, 200}, atts = {"md_insight_x2"}, exclusions = {md_rmr = true}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	fire = {"shoot1", "shoot2"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.3, sound = "CW_FOLEY_LIGHT"},
	{time = 0.75, sound = "CW_M1911_TRIGGER"}},

	reload = {{time = 0.51, sound = "CW_M1911_MAGOUT"},
	{time = 1.18, sound = "CW_M1911_MAGIN"},
	{time = 1.26, sound = "CW_M1911_SLIDEBACK"},
	{time = 1.62, sound = "CW_M1911_SLIDEFORWARD"}}
}

SWEP.SpeedDec = 7

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/m1911.mdl"
SWEP.WorldModel		= "models/weapons/cw_pist_m1911.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.15
SWEP.FireSound = "CW_M1911_FIRE"
SWEP.FireSoundSuppressed = "CW_M1911_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.25
SWEP.MaxSpreadInc = 0.036
SWEP.SpreadPerShot = 0.0125
SWEP.SpreadCooldown = 0.18
SWEP.Shots = 1
SWEP.Damage = 30
SWEP.DrawSpeed = 1.4
SWEP.DeployTime = 1.1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.58
SWEP.ReloadHalt = 1.85

SWEP.ReloadTime_Empty = 1.69
SWEP.ReloadHalt_Empty = 2.32

SWEP.SnapToIdlePostReload = true