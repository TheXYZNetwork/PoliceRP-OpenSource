AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "HK MP5"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87
	
	SWEP.IronsightPos = Vector(2.032, -3.323, 0.759)
	SWEP.IronsightAng = Vector(0.388, -0.051, 0)
	
	SWEP.PronePos = Vector(-7.397, -2.497, -1.551)
	SWEP.ProneAng = Vector(5.618, -49.056, -15.311)
	
	-- MP5SD variant ironsight pos
	SWEP.SDPos = Vector(2.032, -3.323, 0.759)
	SWEP.SDAng = Vector(0.338, -0.005, 0)
		
	-- MP5K variant ironsight pos
	SWEP.KPos = Vector(2.032, -3.323, 0.759)
	SWEP.KAng = Vector(0.187, -0.005, 0)

	SWEP.MicroT1Pos = Vector(2.042, -0.2, 0.66)
	SWEP.MicroT1Ang = Vector(-1.668, 0, 0)	
		
	SWEP.EoTechPos = Vector(2.042, -5.042, 0.014)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(2.03, -5.14, 0.171)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(2.028, -5.613, -0.113)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
		
	SWEP.ShortDotPos = Vector(2.009, -5.844, 0.263)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 3, roll = 1, forward = 1, pitch = 1}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintViewNormals = {x = 1, y = -1, z = 1}

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "gun", pos = Vector(-0.042, -0.2, 2.809), angle = Angle(0, 0, 0), adjustment = {min = -1.5, max = -0.2, axis = "y", inverse = true}, size = Vector(0.349, 0.349, 0.349)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "gun", pos = Vector(-0.304, 10.126, -8.047), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "gun", pos = Vector(0.2, 5, -2.425), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "gun", pos = Vector(0.284, 4.372, -2.46), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "gun", pos = Vector(-0.038, -12.216, 0.305), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "gun", pos = Vector(0.224, 3.98, -1.884), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)}
	}
	
	SWEP.ForegripOverridePos = {
		["bg_mp5_sdbarrel"] = {
			["Bip01 R Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(-4.029, 14.069, 0) },
			["Bip01 R Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(0, -8.988, 0) }
		},
		
		["bg_mp5_kbarrel"] = {
			["Bip01 R Hand"] = {pos = Vector(0, 0, 0), angle = Angle(0.263, 23.951, -31.754) },
			["Bip01 R Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-0.894, 32.728, 3.026) },
			["Bip01 R Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 12.1, 0) },
			["Bip01 R Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.451, 0) },
			["Bip01 R Clavicle"] = {pos = Vector(-6.856, 2.325, 2.252), angle = Angle(48.464, 28.256, 12.512) },
			["Bip01 R Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 14.687) },
			["Bip01 R Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-1.813, 71.625, 0) },
			["Bip01 R Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, -26.932, 0) },
			["Bip01 R Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(0, -16.4, 0) },
			["Bip01 R Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 89.527, 0) },
			["Bip01 R Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.952, 11.305) },
			["Bip01 R Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(-15.782, -6.495, 33.964) },
			["Bip01 R Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 54.675, -4.284) },
			["Bip01 R Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 67.799, 0) }
		}
	}
	
	SWEP.AttachmentPosDependency = {["md_tundra9mm"] = {["bg_mp5_kbarrel"] = Vector(-0.038, -10.749, 0.324)}}

	SWEP.LaserPosAdjust = {x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = 2, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.MuzzleVelocity = 400 -- in meter/s

SWEP.BarrelBGs = {main = 2, sd = 1, k = 2, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, retractable = 1, none = 2}
SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.MagBGs = {main = 4, round15 = 0, round30 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}, exclusions = {bg_mp5_sdbarrel = true}},
[3] = {header = "Handguard", offset = {-400, -400}, atts = {"bg_mp5_kbarrel", "bg_mp5_sdbarrel"}},
[4] = {header = "Magazine", offset = {-400, 100}, atts = {"bg_mp530rndmag"}},
[5] = {header = "Stock", offset = {700, 350}, atts = {"bg_retractablestock", "bg_nostock"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reloadfull",
	reload_empty = "reloadempty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reloadfull = {[1] = {time = 1.1, sound = "CW_MP5_MAGOUT"},
	[2] = {time = 1.4, sound = "CW_MP5_MAGIN"}},
	
	reloadempty = {[1] = {time = 0.4, sound = "CW_MP5_BOLTBACK"},
	[2] = {time = 1.5, sound = "CW_MP5_MAGOUT"},
	[3] = {time = 1.8, sound = "CW_MP5_MAGIN"},
	[4] = {time = 2.6, sound = "CW_MP5_BOLTFORWARD"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/cw2/smgs/mp5.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_mp5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_MP5_FIRE"
SWEP.FireSoundSuppressed = "CW_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.5