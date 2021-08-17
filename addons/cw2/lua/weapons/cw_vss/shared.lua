AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x39MM", "9x39MM", 9, 39)

SWEP.PrintName = "VSS Vintorez"

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
	SWEP.WM = "models/cw2/rifles/w_vss.mdl"
	SWEP.WMPos = Vector(1, -9, 1.2)
	SWEP.WMAng = Vector(0, 180, 180)

	SWEP.PSOPos = Vector(-2.304, 1.417, 0.402)
	SWEP.PSOAng = Vector(0, 0, 0)
		
	SWEP.SR3MPos = Vector(-2.494, -2.722, 1.157)
	SWEP.SR3MAng = Vector(1.098, 0, 0)

	SWEP.IronsightPos = Vector(-2.491, -2.954, 1.759)
	SWEP.IronsightAng = Vector(0.052, 0, 0)
	
	SWEP.KobraPos = Vector(-2.587, -3.539, 0.509)
	SWEP.KobraAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.527, -3.054, -0.385)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.541, -3.504, -0.233)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.517, -3.504, -0.166)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.CustomizePos = Vector(12.121, -4.907, -0.461)
	SWEP.CustomizeAng = Vector(17.232, 58.485, 19.311)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.021, -4.864, -1.122), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(0, 1, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(-6.141, 19.972, 0) },
		["Bip01 L Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, -7.212, 0) },
		["Bip01 L UpperArm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 2.257, 21.444) },
		["Bip01 L Clavicle"] = {pos = Vector(-6.691, 4.309, 0.462), angle = Angle(0, 23.016, -25.094) },
		["Bip01 L Finger22"] = {pos = Vector(0, 0, 0), angle = Angle(0, 72.48, 0) },
		["Bip01 L Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(0, -3.277, 0) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 78.357, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 22.827, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(-5.815, -9.587, 0) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-9.544, 48.951, -5.665) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 62.164, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(8.01, 3.112, -9.921) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, 24.069, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-2.405, 32.501, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(7.236, 22.563, 55.094) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 23.079, 0) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 48.407, 0) }
	}
	
	SWEP.ForeGripOffsetCycle_Reload = 0.75
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Object01", pos = Vector(-0.234, -6.67, -2.567), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Object01", pos = Vector(0.282, -11.613, -8.844), angle = Angle(3.332, -90, 0), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Object01", pos = Vector(-0.232, -0.908, 0.637), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Object01", pos = Vector(0.09, -6.288, -1.887), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Object01", pos = Vector(-0.32, -6.019, -2.675), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Object01", pos = Vector(0.4, -0.965, -1.775), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "ak47_control", pos = Vector(0.001, 12.855, -1.339), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "ak47_control", pos = Vector(-0.403, -4.705, -3.195), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	SWEP.BoltBone = "ak46_bolt"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
end

SWEP.MuzzleVelocity = 292 -- in meter/s

SWEP.MagBGs = {main = 4, round30 = 2, round20 = 1, regular = 0}
SWEP.VariantBGs = {main = 2, sr3m = 1, vss = 0}
SWEP.StockBGs = {main = 3, foldable = 1, vss = 0}
	
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -450},  atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_pso1"}},
	[2] = {header = "Magazine", offset = {0, 350},  atts = {"bg_asval_20rnd", "bg_asval_30rnd"}},
	[3] = {header = "Variant", offset = {0, -450},  atts = {"bg_asval", "bg_sr3m"}},
	[4] = {header = "Stock", offset = {1400, -50}, atts = {"bg_vss_foldable_stock"}},
	[5] = {header = "Barrel", offset = {0, -50}, atts = {"md_pbs1"}, dependencies = {bg_sr3m = true}},
	[6] = {header = "Front", offset = {800, -50}, atts = {"md_foregrip"}, dependencies = {bg_sr3m = true}},
	["+reload"] = {header = "Ammo", offset = {1400, 350}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"ak47_fire1", "ak47_fire2", "ak47_fire3"},
	reload = "ak47_reload",
	reload_empty = "ak47_reloadempty",
	idle = "ak47_idle",
	draw = "ak47_draw"}
	
SWEP.Sounds = {ak47_draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.41, sound = "CW_VSS_BOLTBACK"},
	{time = 0.79, sound = "CW_VSS_BOLTFORWARD"}},

	ak47_reload = {{time = 0.4, sound = "CW_FOLEY_LIGHT"},
	{time = 0.7, sound = "CW_G3A3_HANDLE"},
	{time = 0.98, sound = "CW_VSS_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 2.1, sound = "CW_VSS_MAGIN"}},
	
	ak47_reloadempty = {{time = 0.4, sound = "CW_FOLEY_LIGHT"},
	{time = 0.7, sound = "CW_G3A3_HANDLE"},
	{time = 0.98, sound = "CW_VSS_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 2.1, sound = "CW_VSS_MAGIN"},
	{time = 2.5, sound = "CW_FOLEY_MEDIUM"},
	{time = 3.53, sound = "CW_VSS_BOLTBACK"},
	{time = 3.77, sound = "CW_VSS_BOLTFORWARD"},
	{time = 4, sound = "CW_FOLEY_LIGHT"}},
}

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
SWEP.ViewModel		= "models/cw2/rifles/vss.mdl"
SWEP.WorldModel		= "models/cw2/rifles/w_vss.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39MM"

SWEP.FireDelay = 0.11
SWEP.FireSound = "CW_VSS_FIRE"
SWEP.FireSoundSuppressed = "CW_VSS_FIRE"
SWEP.Recoil = 1.25

SWEP.SuppressedOnEquip = true

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.004
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.045
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 1.2

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 2.63
SWEP.ReloadTime_Empty = 3.92
SWEP.ReloadHalt = 3.6
SWEP.ReloadHalt_Empty = 4.7