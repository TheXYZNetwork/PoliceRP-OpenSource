//Fixed & Optimized by AeroMatix || https://www.youtube.com/channel/UCzA_5QTwZxQarMzwZFBJIAw || http://steamcommunity.com/profiles/76561198176907257

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "H&K MP7A1"
CustomizableWeaponry:registerAmmo("4.6x30mm", "4.6x30mm NATO Rounds", 4.6, 30)

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 4, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_cw2_mp7.mdl"
	SWEP.WMPos = Vector(0.500, -1.200, -3.000)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.504, -4.731, 1.009)
	SWEP.IronsightAng = Vector(0, 0.079, 0)
	
	SWEP.BFReflexPos = Vector(-2.504, -6.25, 0.6)
	SWEP.BFReflexAng = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-2.504, -4.99, 0.361)
	SWEP.EoTech553Ang = Vector(0, 0, 0)
	
	SWEP.CoyotePos = Vector(-2.52, -5.6, 0.61)
	SWEP.CoyoteAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.51, -5.486, 0.467)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.CoD4ReflexPos = Vector(-2.504, -5.4, 0.709)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.504, -5.45, 0.759)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CoD4ACOGPos = Vector(-2.504, -5.1, 0.46)
	SWEP.CoD4ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, -0.3)
	SWEP.SprintAng = Vector(-8.903, 20.455, -15.112)

	SWEP.CustomizePos = Vector(3.46, -0.61, -0.902)
	SWEP.CustomizeAng = Vector(17.681, 29.917, 15.121)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CoD4ACOGAxisAlign = {right = 0, up = 180, forward = 0}
	
	SWEP.BaseArm = "L_Dummy"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.586, -17.57, 7), angle = Angle(0, -180, 180), size = Vector(0.899, 0.899, 0.899)},
		["md_fas2_eotech"] = {model = "models/c_fas2_eotech.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.804, -14.79, 2.394), angle = Angle(0, 90, 180), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.807, -11.068, 1.809), angle = Angle(180, 0, 0), size = Vector(0.3, 0.3, 0.3)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.82, -12.101, 4.907), angle = Angle(-180, -180, 0), size = Vector(0.449, 0.449, 0.449)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.934, -15.1, 1.98), angle = Angle(180, 90, 0), size = Vector(0.4, 0.4, 0.4)}
	}
	
	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 42.713, 0) },
		["Bip01 L Clavicle"] = {pos = Vector(-3.299, 1.235, -1.79), angle = Angle(-55.446, 11.843, 0) },
		["Bip01 L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 42.41) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 71.308, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.795, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.148, 0) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(6.522, 83.597, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(23.2, 16.545, 0) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 31.427, 0) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 29.565, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(9.491, 14.793, -15.926) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, -9.195, 0) },
		["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 10.164, 0) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.395, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(2.411, 57.007, 0) }
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {350, -400}, atts = {"md_microt1", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {-400, 100}, atts = {"md_saker"}},
	[3] = {header = "Laser", offset = {-70, -500}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {300, 250}, atts = {"am_matchgrade"}}}
	
	if CustomizableWeaponry_KK_HK416 then
		table.insert(SWEP.Attachments[1].atts, 5, "md_fas2_eotech")
end

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.13, sound = "CW_MP7_MAGOUT"},
	[2] = {time = 1.90, sound = "CW_MP7_MAGIN"}}}
	
 
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - SMGs"

SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_cw2_mp7.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_cw2_mp7.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "4.6x30mm"

SWEP.FireDelay = 0.07
SWEP.FireSound = "CW_MP7_FIRE"
SWEP.FireSoundSuppressed = "CW_MP7_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.120
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.090
SWEP.SpreadPerShot = 0.013
SWEP.SpreadCooldown = 0.032
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = 1.2

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 3.4
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt = 1.9
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = true