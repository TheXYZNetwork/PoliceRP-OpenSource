AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "H&K G36C"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.CustomizationMenuScale = 0.012
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g36c", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -3, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.52
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.52
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/cw20_g36c.mdl"
	SWEP.WMPos = Vector(0, -0.5, 0.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.605, -4.496, 0.629)
	SWEP.IronsightAng = Vector(-0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.59, -4.351, -0.267)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.603, 0.5, 0.028)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.596, -3, -0.309)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)

	SWEP.ShortDotPos = Vector(-2.606, -4.875, 0.189)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.589, -3, -1.318), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.2, 0, -0.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Left_U_Arm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.M203HoldPos = {
		["Left_U_Arm"] = {pos = Vector(2.197, -2.123, -1.015), angle = Angle(0, 0, 0)}
	}
	
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(-8.2, 6.688, -0.28), angle = Angle(0, 3.332, -90), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "body", pos = Vector(-1.573, 0.902, 0.414), angle = Angle(-90, 0, -90), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(1.9, -4.746, -0.014), angle = Angle(90, 0, -90), adjustment = {min = 1.9, max = 3.8, axis = "x", inverseOffsetCalc = true}, size = Vector(0.4, 0.4, 0.4)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "body", pos = Vector(6.1, -4.533, 0.112), angle = Angle(180, 0, -90), size = Vector(0.449, 0.449, 0.449)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(-1.52, -2.649, -2.381), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(-2.7, 0.544, 0.317), angle = Angle(-90, 0, -90), size = Vector(0.899, 0.899, 0.899)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "body", pos = Vector(-1.162, -0.594, 0.259), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699)}
	}

	SWEP.ForeGripHoldPos = {
		["Left12"] = {pos = Vector(0, 0, 0), angle = Angle(52.786, -5.152, 0) },
		["Left4"] = {pos = Vector(0, 0, 0), angle = Angle(25.712, -6.266, -16.903) },
		["Left1"] = {pos = Vector(0, 0, 0), angle = Angle(25.437, 8.171, 0) },
		["Left6"] = {pos = Vector(0, 0, 0), angle = Angle(47.268, 0, 0) },
		["Left3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 74.572, 0) },
		["Left8"] = {pos = Vector(0, 0, 0), angle = Angle(27.87, 1.797, 0) },
		["Left15"] = {pos = Vector(0, 0, 0), angle = Angle(34.446, -2.81, 0) },
		["Left5"] = {pos = Vector(0, 0, 0), angle = Angle(24.264, 0, 0) },
		["Left7"] = {pos = Vector(0, 0, 0), angle = Angle(10.465, -7.058, -12.056) },
		["Left11"] = {pos = Vector(0, 0, 0), angle = Angle(21.985, -9.301, 0) },
		["Left9"] = {pos = Vector(0, 0, 0), angle = Angle(26.117, 0, 0) },
		["Left14"] = {pos = Vector(0, 0, 0), angle = Angle(-53.977, 0, 0) },
		["Left13"] = {pos = Vector(0, 0, 0), angle = Angle(3.716, -11.523, -7.351) },
		["Left10"] = {pos = Vector(0, 0, 0), angle = Angle(5.267, -7.495, 0) },
		["Left2"] = {pos = Vector(0, 0, 0), angle = Angle(8.8, 20.444, 0) },
		["Left_L_Arm"] = {pos = Vector(-0.049, -0.169, -0.216), angle = Angle(-19.792, 0.01, 81.132) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.MuzzleVelocity = 800 -- in meter/s, kind of a guess on the G36C here, since I can't find muzzle velocity of the G36C anywhere (only other models like G36, G36K, etc.)

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_microt1", "md_eotech", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-500, -600}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-500, -200}, atts = {"md_foregrip"}},
	[4] = {header = "Rail", offset = {-500, 200},  atts = {"md_anpeq15"}, dependencies = {md_microt1 = true, md_eotech = true, md_schmidt_shortdot = true, md_acog = true}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "Reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"},
	{time = 0.4, sound = "CW_G36C_SELECTFIRE"}},

	Reload = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 1, sound = "CW_G36C_MAGOUT"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"},
	{time = 1.6, sound = "CW_G36C_MAGIN"},
	{time = 2, sound = "CW_G36C_MAGDROP"},
	{time = 2.35, sound = "CW_G36C_BOLTBACK"},
	{time = 2.5, sound = "CW_G36C_BOLTFORWARD"},
	{time = 2, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 3
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
SWEP.ViewModel		= "models/cw2/rifles/g36c.mdl"
SWEP.WorldModel		= "models/weapons/cw20_g36c.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_G36C_FIRE"
SWEP.FireSoundSuppressed = "CW_G36C_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.042
SWEP.AimSpread = 0.0045
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 32
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.8
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 2.1
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true