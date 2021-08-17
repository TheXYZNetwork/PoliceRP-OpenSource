AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "Serbu Shorty"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_shorty", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.45
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/cw2_super_shorty.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.PronePos = Vector(-7.397, -2.497, -1.551)
	SWEP.ProneAng = Vector(5.618, -49.056, -15.311)
	
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 2}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true

	SWEP.IronsightPos = Vector(4.276, 0, 2.306)
	SWEP.IronsightAng = Vector(1.093, 0, 0)
	
	SWEP.MicroT1Pos = Vector(4.277, 0, 1.603)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(2.039, 0, 0.479)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-2.386, 0.054, 2.203)
	SWEP.SprintAng = Vector(-17.784, -38.445, -0.484)
			
	SWEP.SwimPos = Vector(0, 0, 0)
	SWEP.SwimAng = Vector(-28.47, -36.313, 0)
			
	SWEP.CustomizePos = Vector(-5.304, -5.044, 0)
	SWEP.CustomizeAng = Vector(20.695, -48.665, -17.692)
	
	SWEP.CustomizationMenuScale = 0.01
	SWEP.ReticleInactivityPostFire = 0.9

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "yttohs", pos = Vector(-0.207, -0.215, 0.029), angle = Angle(0, 90, 180), size = Vector(0.5, 0.85, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "yttohs", pos = Vector(-0.02, -1.188, -1.494), angle = Angle(0, 0, 179.587), size = Vector(0.3, 0.3, 0.3)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.MuzzleVelocity = 381 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1"}},
	["+reload"] = {header = "Ammo", offset = {-200, 300}, atts = {"am_slugrounds", "am_flechetterounds"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	fire_aim = "shoot1",
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "end_reload",
	idle = "idle",
	draw = "draw2"}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "CW_SERBU_SHORTY_INSERT"}},
	
	end_reload = {{time = 0.62, sound = "CW_SERBU_SHORTY_PUMPBACK"},
	{time = 0.82, sound = "CW_SERBU_SHORTY_PUMPFORWARD"},
	{time = 1, sound = "CW_FOLEY_LIGHT"}},
	
	draw2 = {{time = 0.36, sound = "CW_SERBU_SHORTY_PUMPBACK"},
	{time = 0.59, sound = "CW_SERBU_SHORTY_PUMPFORWARD"}},
	
	shoot1 = {{time = 0.55, sound = "CW_SERBU_SHORTY_PUMPBACK"},
	{time = 0.92, sound = "CW_SERBU_SHORTY_PUMPFORWARD"}},
	
	shoot2 = {{time = 0.55, sound = "CW_SERBU_SHORTY_PUMPBACK"},
	{time = 0.92, sound = "CW_SERBU_SHORTY_PUMPFORWARD"}}
}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/cw2/shotguns/serbu_super_shorty.mdl"
SWEP.WorldModel		= "models/weapons/cw2_super_shorty.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.8
SWEP.FireSound = "CW_SERBU_SHORTY_FIRE"
SWEP.Recoil = 2
SWEP.FireAnimSpeed = 1.2

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.4
SWEP.MaxSpreadInc = 0.02
SWEP.ClumpSpread = 0.02
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.85
SWEP.Shots = 12
SWEP.Damage = 17
SWEP.DeployTime = 1
SWEP.ReloadSpeed = 1.1

SWEP.ReloadStartTime = 0.3
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 1
SWEP.PumpMidReloadWait = 1.1
SWEP.ShotgunReload = true
SWEP.DeployTimeNotFirst = 0.3

SWEP.Chamberable = true

function SWEP:drawAnimFunc()
	if not self.firstTimeDrawFinished then
		self:sendWeaponAnim("draw", self.DrawSpeed)
	else
		self:sendWeaponAnim("idle", self.DrawSpeed)
	end
	
	self.firstTimeDrawFinished = true
end

function SWEP:GetDeployTime()
	return self.firstTimeDrawFinished and self.DeployTimeNotFirst or self.DeployTime
end

function SWEP:fireAnimFunc()
	if self.dt.State == CW_AIMING then
		self:sendWeaponAnim("fire_aim", self.FireAnimSpeed)
	else
		self:sendWeaponAnim("fire", self.FireAnimSpeed)
	end
end