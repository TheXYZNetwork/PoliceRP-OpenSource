AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "smgMag"

SWEP.PrintName = "FMG-9"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.35
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.EffectiveRange_Orig = 36 * 39.37
	SWEP.DamageFallOff_Orig = .42

	SWEP.IronsightPos = Vector(-2.355, -4, 0.16)
	SWEP.IronsightAng = Vector(-0.77, 0.64, -1.3)

	SWEP.SprintPos = Vector(3.92, 0, -1.321)
	SWEP.SprintAng = Vector(-14.07, 24.622, -4.926)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.012
	SWEP.ViewModelMovementScale = .5
	
	SWEP.AttachmentModelsVM = {
	["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Barrel", rel = "", pos = Vector(0.039, 20.26, -2.651), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "fmg9_d", rel = "", pos = Vector(-0.601, 15.142, -1.9), angle = Angle(0, 90, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

end

SWEP.LaserPosAdjust = Vector(-.8, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 2.5, roll = 1, forward = 1.75, pitch = 1.75}
SWEP.MuzzleVelocity = 380 -- in meter/s
SWEP.LuaViewmodelRecoil = true


SWEP.Attachments = {[1] = {header = "Barrel", offset = {-650, -350}, atts = {"md_tundra9mm2"}},
[2] = {header = "Rail", offset = {400, -520}, atts = {"md_anpeq15"}},
["+reload"] = {header = "Ammo", offset = {-300, 200}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire1", "fire2"},
	reload = "reload_full",
	reload_empty = "reload_empty",
	idle = "idle1",
	draw = "draw1"}
	
SWEP.Sounds = {	draw1 = {[1] = {time = 0, sound = "FMG_DRAW"},
	[2] = {time = 1, sound = "FMG_CLOTH"}},

	reload_full = {[1] = {time = .3, sound = "FMG_MAGREL"},
	[2] = {time = .4, sound = "FMG_MAGOUT"},
	[3] = {time = 1, sound = "FMG_MAGIN"},
	[4] = {time = 1.7, sound = "FMG_CLOTH1"}},
	
	reload_empty = {[1] = {time = .3, sound = "FMG_MAGREL"},
	[2] = {time = .4, sound = "FMG_MAGOUT"},
	[3] = {time = 1.2, sound = "FMG_MAGIN"},
	[4] = {time = 2.3, sound = "FMG_BOLTBACK"},
	[5] = {time = 2.55, sound = "FMG_BOLTREL"},
	[6] = {time = 3, sound = "FMG_CLOTH1"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = false
SWEP.Chamberable = false

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - SMGs"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = 1
SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 70	
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_fmg.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_tmp.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.05
SWEP.FireSound = "MP5A4_FIRE"
SWEP.FireSoundSuppressed = "MP5A4_FIRE_SUPPRESSED"
SWEP.Recoil = .72

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = .8
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 26
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 3.4

function SWEP:IndividualThink()
	self.EffectiveRange = 36 * 39.37
	self.DamageFallOff = .42
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 9 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .105))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.4 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .063))
	end
end