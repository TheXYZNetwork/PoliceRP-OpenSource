AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "Thompson 1928A1"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
    SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 4.5, y = 20, z = -2}
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87
	
	SWEP.IronsightPos = Vector(3.285, 1.108, 1.889)
	SWEP.IronsightAng = Vector(-2, -4.055, 0)
	
	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BoltBone = "boltthingy"
	SWEP.BoltShootOffset = Vector(3.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.LuaVMRecoilAxisMod = {vert = 2, hor = 3, roll = 2, forward = 2, pitch = 1}

	SWEP.AttachmentModelsVM = {
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Box01", rel = "", pos = Vector(-2.597, -0.35, -2.6), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.CustomizationMenuScale = 0.1

	SWEP.LaserPosAdjust = {x = 0, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = -1, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end



SWEP.BarrelBGs = {main = 2, sd = 1, k = 2, regular = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {
[1] = {header = "Barrel", offset = {200, -400}, atts = {"md_saker"}},
["+reload"] = {header = "Ammo", offset = {800, -50}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.33, sound = "CW_TMG_MAGOUT"},
	[2] = {time = 1.13, sound = "CW_TMG_MAGIN"},
	[3] = {time = 1.9, sound = "CW_TMG_BOLTBACK"},
	[4] = {time = 2.5, sound = "CW_TMG_BOLTCOCK"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Special"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_tommy_g.mdl"
SWEP.WorldModel		= "models/weapons/w_tommy_gun.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_tommy_gun.mdl"
SWEP.WMPos = Vector(-0, -0, -0.519)
SWEP.WMAng = Vector(1.169, 0, -180)

SWEP.ADSFireAnim = false
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["Box01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.185, 0), angle = Angle(-7.778, 1.11, 0) },
	["L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.556, 0, 0), angle = Angle(0, 0, 0) },
	["R_Forearm"] = { scale = Vector(1, 1.016, 1), pos = Vector(0, -0.186, -0.926), angle = Angle(0, 0, 0) }
}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 Auto ACP"
SWEP.Chamberable = false
SWEP.AimViewModelFOV = 75

SWEP.FireDelay = 0.0909090909
SWEP.FireSound = "CW_TMG_FIRE"
SWEP.FireSoundSuppressed = "CW_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 0.9

SWEP.HipSpread = 0.048
SWEP.AimSpread = 0.022
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.065
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.14
SWEP.Shots = 1
SWEP.Damage = 33
SWEP.DeployTime = 1.2

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.5