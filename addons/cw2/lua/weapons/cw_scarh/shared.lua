AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "FN SCAR-H"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/rifles/w_scarh.mdl"
	SWEP.WMPos = Vector(0, -0.5, 0.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.023, -4.479, 0.104)
	SWEP.IronsightAng = Vector(0.128, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.033, -4.864, 0.157)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.033, -4.864, 0.375)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.025, 0, 0.46)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.021, -4.864, -0.013)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ShortDotPos = Vector(-2.017, -5.564, 0.495)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.021, -4.864, -1.122), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Left_U_Arm"
	SWEP.BaseArmBoneOffset = Vector(-500, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.M203HoldPos = {
		["Left_U_Arm"] = {pos = Vector(2.197, -2.123, -1.015), angle = Angle(0, 0, 0)}
	}
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "scar", pos = Vector(-0.233, -6.4, -2.172), angle = Angle(0, 0, 0), adjustment = {min = -6.4, max = -4, axis = "y", inverseOffsetCalc = true}, size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "scar", pos = Vector(0.273, -11.3, -8.363), angle = Angle(3.332, -90, 0), adjustment = {min = -11.3, max = -9, axis = "y", inverseOffsetCalc = true}, size = Vector(1, 1, 1)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "scar", pos = Vector(-0.172, 7.369, 2.819), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "scar", pos = Vector(-0.392, -3.997, -1.839), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "scar", pos = Vector(0.016, -1.2, 3.079), angle = Angle(0, 180, 0), adjustment = {min = -1.2, max = 4, axis = "y", inverseOffsetCalc = true}, size = Vector(0.4, 0.4, 0.4)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "scar", pos = Vector(0, 2.413, -0.743), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "scar", pos = Vector(2.316, -9.063, 3.388), angle = Angle(1.07, -90, 0), size = Vector(1, 1, 1), animated = true},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "scar", pos = Vector(-0.364, -4.625, -2.806), angle = Angle(0, 0, 0), adjustment = {min = -4.625, max = -2.3, axis = "y", inverseOffsetCalc = true}, size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "scar", pos = Vector(-0.281, -4.494, -1.621), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)}
	}

	SWEP.ForeGripHoldPos = {
		["Left12"] = {pos = Vector(0, 0, 0), angle = Angle(11.357, -2.181, 0) },
		["Left1"] = {pos = Vector(0, 0.74, 0), angle = Angle(0, -9.094, 0) },
		["Left3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 70.535, 0) },
		["Left8"] = {pos = Vector(0, 0, 0), angle = Angle(25.916, -11.879, 0) },
		["Left5"] = {pos = Vector(0, 0, 0), angle = Angle(46.38, -15.816, -10.117) },
		["Left11"] = {pos = Vector(0, 0, 0), angle = Angle(24.169, -5.834, 0) },
		["Left9"] = {pos = Vector(0, 0, 0), angle = Angle(20.329, 0, 0) },
		["Left_L_Arm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 88.917) },
		["Left14"] = {pos = Vector(0, 0, 0), angle = Angle(19.552, -13.228, 0) },
		["Left2"] = {pos = Vector(0, 0.74, 0), angle = Angle(0.127, 45.395, 0) },
		["Left_Hand"] = {pos = Vector(0, 0, 0), angle = Angle(-19.973, 0, 25.535) },
		["Left_U_Arm"] = {pos = Vector(1.812, 0.024, -1.239), angle = Angle(0, 0, 0) }
	}
	
	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.BoltBone = "charger"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.MuzzleVelocity = 714 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {100, -300},  atts = {"md_anpeq15"}},
	[4] = {header = "Handguard", offset = {-400, 150}, atts = {"md_foregrip", "md_m203"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {{time = 0.4, sound = "CW_SCARH_MAGOUT"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"},
	{time = 1.1, sound = "CW_SCARH_MAGIN"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 1.5, sound = "CW_SCARH_MAGSLAP"},
	{time = 1.85, sound = "CW_SCARH_BOLT"},
	{time = 2, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/rifles/scarh.mdl"
SWEP.WorldModel		= "models/cw2/rifles/w_scarh.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 0.09
SWEP.FireSound = "CW_SCARH_FIRE"
SWEP.FireSoundSuppressed = "CW_G3A3_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.048
SWEP.AimSpread = 0.0025
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.065
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 40
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 0.9
SWEP.ReloadTime = 1.7
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 1.8
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = true