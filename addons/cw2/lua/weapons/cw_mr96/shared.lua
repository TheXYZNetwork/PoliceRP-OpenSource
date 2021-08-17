AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "MR96"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-1.731, 1, 0.36)
	SWEP.IronsightAng = Vector(0, 0, -0.977)
	
	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.ShootWhileProne = true

SWEP.MuzzleVelocity = 414 -- in meter/s, assuming round is a 165 grain JHP

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-250, -75},  atts = {"bg_regularbarrel", "bg_longbarrelmr96"}},
	["+reload"] = {header = "Ammo", offset = {500, -75}, atts = {"am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.2, sound = "CW_MR96_CYLINDEROPEN"},
	[2] = {time = 0.8, sound = "CW_MR96_ROUNDSOUT"},
	[3] = {time = 1.5, sound = "CW_MR96_ROUNDSIN"},
	[4] = {time = 2.05, sound = "CW_MR96_CYLINDERCLOSE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/mr96.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_MR96_FIRE_SHORT"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.039
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.35
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 50
SWEP.DeployTime = 0.7
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 1.6
SWEP.ReloadHalt_Empty = 2.7