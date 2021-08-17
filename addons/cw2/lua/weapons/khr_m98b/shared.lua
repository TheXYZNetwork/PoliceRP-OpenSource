AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "Barrett M98B"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_sr25"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.CrosshairEnabled = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	SWEP.AimBreathingEnabled = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_barret_m98_bravo.mdl"
	SWEP.WMPos = Vector(-0.5, 0, 1.1)
	SWEP.WMAng = Vector(-9, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.204, -4.724, 0.753)
	SWEP.IronsightAng = Vector(-0.68, 0, 0)

	SWEP.IsightsPos = Vector(-2.733, -4.121, 0.536)
	SWEP.IsightsAng = Vector(0.207, 0.045, 0)
	
	SWEP.EoTechPos = Vector(-2.224, -5.218, 0.493)
	SWEP.EoTechAng = Vector(1.697, -0.021, 0)

	SWEP.LeupoldPos = Vector(-2.214, -3.941, 0.734)
	SWEP.LeupoldAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.210, -4.539, 0.929)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.207, -3.958, 0.851)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.M98BPos = Vector(-2.204, -2.862, 0.986)
	SWEP.M98BAng = Vector(0, 0, 0)

	SWEP.CoD4ReflexPos = Vector(-2.208, -3.958, 0.964)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-2.199, -4.539, 0.829)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.182, -2.688, 0.816)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.407, 0, 0)
	SWEP.SprintAng = Vector(-19.341, 35.276, -16.581)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-1.606, -1.107, -1.5), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.CSGOACOGAxisAlign = {right = -0.1, up = -0.1, forward = -40}
	SWEP.LeupoldAxisAlign = {right = 1, up = 0, forward = 0}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}
	SWEP.M98BAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.M203Pos = Vector(0, -1, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.ReticleInactivityPostFire = 2
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = {pos = Vector(4.461, 0.308, -2.166), angle = Angle(0, 0, 0)}
	}

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.213, -16.285, -3.567), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "M98_Body", rel = "", pos = Vector(0.248, -21.625, -9.738), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		--["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -15.169, -1.492), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_fas2_leupold"] = {model = "models/v_fas2_leupold.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.029, -12.386, 2.029), angle = Angle(0, -90, 0), size = Vector(1.5, 1.5, 1.5)},
		["md_fas2_leupold_mount"] = {model = "models/v_fas2_leupold_mounts.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.029, -12.386, 2.029), angle = Angle(0, -90, 0), size = Vector(1.5, 1.5, 1.5)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.003, -12.025, 1.169), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "G3SG1", pos = Vector(-3.34, 7.82, -5.904), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "M98_Body", rel = "", pos = Vector(0.949, -0.982, 1.174), angle = Angle(-180, 90, -90), size = Vector(0.8, 0.8, 0.8)},
		--["md_csgo_scope_ssg"] = {model = "models/kali/weapons/csgo/eq_optic_scope_ssg08.mdl", bone = "M98_Body", rel = "", pos = Vector(0.052, -10.711, 0.819), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_m98b_scope"] = {model = "models/attachments/98b_scope.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.04, -11.74, 2.058), angle = Angle(0, -90, 0), size = Vector(0.449, 0.449, 0.449)},
		--["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.004, 17.627, -0.825), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_hk416_bipod"] = {model = "models/c_bipod.mdl", bone = "M98_Body", rel = "", pos = Vector(0.052, -0.299, -1.377), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_pgm_bipod"] = {model = "models/attachments/pgm_hecate_bipod.mdl", bone = "gun-main", rel = "", pos = Vector(13.217, 0.291, -0.339), angle = Angle(0, 0, -90), size = Vector(0.4, 0.4, 0.4)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "M98_Body", rel = "", pos = Vector(0.039, -16.928, -2.418), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "G3SG1", pos = Vector(-0.583, 3.305, -1.293), angle = Angle(2.538, -90, 0), size = Vector(1, 1, 1), animated = true},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "M98_Body", rel = "", pos = Vector(0.119, -5, 0.839), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}
	}
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(-8.907, 29.332, 27.155) },
		["Bip01 L Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, 3.367, 0) },
		["Bip01 L Clavicle"] = {pos = Vector(4.335, -6.652, -3.984), angle = Angle(-42.875, 42.837, 0) },
		["Bip01 L Finger22"] = {pos = Vector(0, 0, 0), angle = Angle(0, -13.565, 0) },
		["Bip01 L Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(0, 9.633, 0) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 96.544, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.826, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(-3.777, 13.736, 42.478) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-4.395, 78.736, 22.27) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 58.242, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(5.883, 57.971, -2.382) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.07, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(33.303, 1.07, 0) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, 28.163, 0) },
		["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.208, 0) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 19.94, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-5.336, 58.977, 28.6) }
	}
	

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.LaserPosAdjust = Vector(0.15, 5, 1.7)
	SWEP.LaserAngAdjust = Angle(-0.1, 0.5, 0)

end

SWEP.LaserPosAdjust = Vector(0, 0, 0)
SWEP.LaserAngAdjust = Angle(0, 0, 0)

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_m98b_scope"}},
	--[2] = {header = "Barrel", offset = {-500, -400},  atts = {"md_csgo_silencer_rifle"}},
	--[3] = {header = "Handguard", offset = {-500, -0}, atts = {"md_hk416_bipod"}},
	[2] = {header = "Rail", offset = {0, -400}, atts = {"md_anpeq15"}},
	--["+attack2"] = {header = "Perks", offset = {-500, 500}, atts = {"pk_sleightofhand", "pk_light"}},
	["+reload"] = {header = "Ammo", offset = {600, 200}, atts = {"am_magnum", "am_matchgrade"}}
	}

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	shoot1 = {[1] = {time = 0.76, sound = "CW_BARRETT_M98B_BOLTBACK"},
	[2] = {time = 0.96, sound = "CW_BARRETT_M98B_BOLTFORWARD"}},

	reload = {[1] = {time = 1.27, sound = "CW_BARRETT_M98B_MAGOUT"},
	[2] = {time = 2.26, sound = "CW_BARRETT_M98B_MAGIN"}},

	reload_empty = {[1] = {time = 1.27, sound = "CW_BARRETT_M98B_MAGOUT"},
	[2] = {time = 2.26, sound = "CW_BARRETT_M98B_MAGIN"},
	[3] = {time = 3.59, sound = "CW_BARRETT_M98B_BOLTBACK"},
	[4] = {time = 4.17, sound = "CW_BARRETT_M98B_BOLTFORWARD"}}}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Ranged Rifles"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_barret_m98_bravo.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_barret_m98_bravo.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = false

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"
SWEP.OverallMouseSens = .9
SWEP.FireDelay = 60/37
SWEP.FireSound = "CW_BARRETT_M98B_FIRE"
SWEP.FireSoundSuppressed = "CW_BARRETT_M98B_FIRE_SUPPRESSED"
SWEP.Recoil = 3

SWEP.HipSpread = 0.135
SWEP.AimSpread = 0.0006
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.35
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 82
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.35
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 5.2
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 5.2