AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "brMag"
	SWEP.PrintName = "FN FAL"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.2
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_fnfal", "icons/killicons/khr_fnfal", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_fnfal")
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.35
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = .8
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85
	SWEP.FireMoveMod = 2
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.024
	
	SWEP.EffectiveRange_Orig = 148.7 * 39.37
	SWEP.DamageFallOff_Orig = .25
	
	SWEP.M203OffsetCycle_Reload = .75
	SWEP.M203OffsetCycle_Reload_Empty = .75
	SWEP.M203OffsetCycle_Draw = .5
	
	SWEP.IronsightPos = Vector(-2.481, 0, 0.879)
	SWEP.IronsightAng = Vector(-0.401, 0.04, 0)
	
	SWEP.MicroT1Pos = Vector(-2.4865, -2, 0.380)
	SWEP.MicroT1Ang = Vector(-0.401, 0.013, 0)
	
    SWEP.EoTech553Pos = Vector(-2.4865, -2, 0.19)
	SWEP.EoTech553Ang = Vector(-0.401, 0.013, 0)
	
	SWEP.CSGOACOGPos = Vector(-2.491, -1.5, 0.245)
	SWEP.CSGOACOGAng = Vector(-0.401, 0.013, 0)
	
	SWEP.KR_CMOREPos =  Vector(-2.4865, -2, 0.19)
	SWEP.KR_CMOREAng =  Vector(-0.401, 0.013, 0)
	
	SWEP.ShortDotPos = Vector(-2.486, -1.5, 0.3165)
	SWEP.ShortDotAng = Vector(-0.401, 0.013, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.4865, -2, 0.345)
	SWEP.FAS2AimpointAng = Vector(-0.401, 0.013, 0)
	
	SWEP.CustomizePos = Vector(5, -3, -2.5)
	SWEP.CustomizeAng = Vector(20.402, 26.03, 15.477)
	
	SWEP.SprintPos = Vector(4.786, 0, -3)
	SWEP.SprintAng = Vector(-13.778, 37.573, -15)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0, 0, -.2)
	SWEP.AlternativeAng = Vector(0, .5, 0)
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "L UpperArm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "Weapon", pos = Vector(2.124, -8.801, 3.9), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), animated = true},
	    ["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Weapon", rel = "", pos = Vector(0.029, -9.4, 0.259), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Weapon", rel = "", pos = Vector(0.009, -2.201, 2.4), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Weapon", rel = "", pos = Vector(-0.06, -4.77, 3.059), angle = Angle(0, -90, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker222"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Weapon", rel = "", pos = Vector(0, 7.791, -0.801), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Weapon", rel = "", pos = Vector(0.009, -5.3, 3.079), angle = Angle(0, 180, 0), size = Vector(0.28, 0.28, 0.28), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Weapon", rel = "", pos = Vector(0.014, -2.597, 2.63), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Weapon", rel = "", pos = Vector(0.212, -2.8, 1.22), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.952), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Weapon", rel = "", pos = Vector(-0.238, -8.44, -0.731), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Weapon", rel = "", pos = Vector(-0.301, -1.558, -0.7), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "Weapon", rel = "", pos = Vector(0, 10.909, 0.5), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
		SWEP.M203HoldPos = {
		["L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0.555, -0.926, -2.037), angle = Angle(0, 0, -1.111)	}
	}

	SWEP.ForeGripHoldPos = {
		["L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.111, 23.333, 0) },
		["L ForeTwist2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 23.333) },
		["l_armtwist_1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -21.112) },
		["l_armtwist_2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -16.667) },
		["L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.111, -16.667, 58.888) },
		["L ForeTwist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 74.444) },
		["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 18.888, 0) },
		["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 10, 0) },
		["L ForeTwist5"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -16.667) },
		["L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0.899, -1.556, -0.826), angle = Angle(5.556, 0, 0) },
		["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, 47.777, 0) },
		["L ForeTwist4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 5.556) },
		["L ForeTwist1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -32.223) },
		["L ForeTwist6"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 34.444) },
		["L Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 36.666) },
		["L ForeTwist3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -18.889) }
	
	}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = .4, up = 0, forward = 0}
 
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 0, roll = 1, forward = 0, pitch = 1}
end

SWEP.MuzzleVelocity = 840 -- in meter/s
SWEP.LaserPosAdjust = Vector(0.1, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[3] = {header = "Sight", offset = {750, -50},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog"}},
	[2] = {header = "Barrel", offset = {280, -300}, atts = {"md_saker222"}},
	[1] = {header = "Handguard", offset = {-550, -150}, atts = {"md_foregrip","md_bipod","md_m203"}},
	["+reload"] = {header = "Ammo", offset = {100, 450}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "KHRFAL.Draw"},
	[2] = {time = .6, sound = "KHRFAL.Boltback"},
	[3] = {time = .9, sound = "KHRFAL.Boltrelease"}},

	
	reload = {[1] = {time = 0.55, sound = "KHRFAL.Magout"},
	[2] = {time = 0.6, sound = "KHRFAL.Magrattle"},
	[3] = {time = 2.2, sound = "KHRFAL.Magin"},
	[4] = {time = 3, sound = "KHRFAL.Boltback"},
	[5] = {time = 3.3, sound = "KHRFAL.Boltrelease"}}}
	
SWEP.SpeedDec = 45

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = .82
SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_fnfal.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_g3sg1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 60/620
SWEP.FireSound = "KHRFAL_FIRE"
SWEP.FireSoundSuppressed = "KHRFAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.73
SWEP.FOVPerShot = .85

SWEP.HipSpread = 0.042
SWEP.AimSpread = 0.0026
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.011
SWEP.RecoilToSpread = .7
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 48
SWEP.DeployTime = 1.32

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 4	
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt = 4
SWEP.ReloadHalt_Empty = 4

function SWEP:IndividualThink()
	self.EffectiveRange = 148.7 * 39.37
	self.DamageFallOff = .25
	self.RecoilToSpread = .7
	
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 49.071 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .0625))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 22.305 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0375))
	end
	if self.ActiveAttachments.am_magnum then
	self.RecoilToSpread = ((self.RecoilToSpread + .5))
	end
end