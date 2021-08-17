AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"
	SWEP.PrintName = "SKS-D"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_sks", "icons/killicons/khr_sks", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_sks")
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.28
	SWEP.FireMoveMod = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 71 * 39.37
	SWEP.DamageFallOff_Orig = .36
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltBonePositionRecoverySpeed = 75
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	
	SWEP.IronsightPos = Vector(-1.125, -2, 0.899)
	SWEP.IronsightAng = Vector(0, 0.01, 0)
	
	SWEP.EoTech553Pos = Vector(-1.111, -1, 0.23)
	SWEP.EoTech553Ang = Vector(-1, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-1.108, -1, 0.275)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.121, -1, 0.53)
	SWEP.MicroT1Ang = Vector(-1, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.111, -1, 0.3)
	SWEP.KR_CMOREAng =  Vector(-1, 0, 0)
	
	SWEP.ShortDotPos = Vector(-1.132, -1, 0.312)
	SWEP.ShortDotAng = Vector(-1, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-1.121, -1, 0.53)
	SWEP.FAS2AimpointAng = Vector(-1, 0, 0)
	
	SWEP.KobraPos = Vector(-1.121, -1.905, 0.119)
	SWEP.KobraAng = Vector(0, 0, 0)
	
	SWEP.PSOPos = Vector(-1.115, -.5, 0.1)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(.75, 0, -.302)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.020
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Vz58", rel = "", pos = Vector(-4.676, 0.05, 3.64), angle = Angle(0, 0, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_uecw_csgo_acog"] = {model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Vz58", pos = Vector(-9.431, -0.047, 0.829), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
	["md_fas2_eotech"] = {model = "models/c_fas2_eotech.mdl", bone = "Vz58", pos = Vector(-2.497, -0.018, 3.19), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
	["md_pbs12"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Vz58", pos = Vector(14.699, 0, 2.029), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649)},
	["md_microt1kh"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Vz58", pos = Vector(-4.676, -0.02, 3.635), angle = Angle(0, -90, 0), size = Vector(0.26, 0.26, 0.26)},
	["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Vz58", pos = Vector(-5.02, 0.21, 1.899), angle = Angle(0, 0, 0), size = Vector(0.569, 0.899, 0.899)},
	["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Vz58", pos = Vector(-5.792, 0.086, 1.297), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6)},
	["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Vz58", pos = Vector(-4, -0.331, 1.25), angle = Angle(0, -90, 0), size = Vector(0.425, 0.425, 0.425)},
	["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint.mdl", bone = "Vz58", pos = Vector(-2.597, -0.01, 2.97), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
	["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Vz58", pos = Vector(-6.2, 0.34, 0), angle = Angle(0, 90, 0), size = Vector(0.649, 0.649, 0.649)},
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Vz58", rel = "", pos = Vector(-8.832, 0.266, -0.419), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ForeGripHoldPos = {
	["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-18.889, 7.777, 7.777) },
	["l_middle_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(27.777, 18.888, 0) },
	["l_ring_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 10) },
	["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(23.333, 0, 0) },
	["l_ring_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(41.111, -14.445, 0) },
	["l_thumb_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.332, 18.888, 0) },
	["l_middle_tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(43.333, 0, 0) },
	["l_thumb_tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.444, 61.111, 0) },
	["l_middle_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 0, 0) },
	["l_pinky_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-14.445, -7.778, 0) },
	["l_ring_tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(83.333, -38.889, 0) },
	["l_pinky_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, -10, -23.334) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2, 0, -0.186), angle = Angle(-7.778, 7.777, 65.555) },
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.222, 10, 0) }}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 1, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 735 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -600},  atts = {"md_kobra", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog", "md_pso1"}},
	[2] = {header = "Barrel", offset = {100, -400}, atts = {"md_pbs12"}},
	[3] = {header = "Handguard", offset = {-350, 0}, atts = {"md_foregrip"}},
	[4] = {header = "Firemode", offset = {800, -200},  atts = {"md_bfstock"}},
	["+reload"] = {header = "Ammo", offset = {-300, 400}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = "KSKS.Deploy"}},

	reload = {[1] = {time = 1.2, sound = "KSKS.Clipout"},
	[2] = {time = 1.727, sound = "KSKS.Clipin"},
	[3] = {time = 2.4, sound = "KSKS.Boltback"},
	[4] = {time = 2.6, sound = "KSKS.Boltforward"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .5, roll = .25, forward = .75, pitch = 1.5}

SWEP.SpeedDec = 35

SWEP.OverallMouseSens = .85
SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_sks.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 60/550
SWEP.FireSound = "KSKS.Fire"
SWEP.FireSoundSuppressed = "KSKS.SupFire"
SWEP.Recoil = 1.38

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.0058
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.0065
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 40
SWEP.DeployTime = 0.55

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.5
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 3.5

function SWEP:IndividualThink()
	self.EffectiveRange = 71 * 39.37
	self.DamageFallOff = .36
	
	if self.ActiveAttachments.md_pbs12 then
	self.EffectiveRange = ((self.EffectiveRange - 21.3 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .108))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 10.65 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .054))
	end
end