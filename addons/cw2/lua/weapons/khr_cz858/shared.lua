AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"
	SWEP.PrintName = "CZ 858"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_cz858", "icons/killicons/khr_cz858", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_cz858")
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.FireMoveMod = 1
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.30
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 76.8 * 39.37
	SWEP.DamageFallOff_Orig = .35
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltBonePositionRecoverySpeed = 50
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	
	SWEP.IronsightPos = Vector(-1.124, 0, 0.519)
	SWEP.IronsightAng = Vector(-0.1, 0.01, 0)
	
	SWEP.EoTech553Pos = Vector(-1.13, -1, -0.51)
	SWEP.EoTech553Ang = Vector(-1, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-1.132, -1, -0.538)
	SWEP.CSGOACOGAng = Vector(-1, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.11, -1, -0.58)
	SWEP.KR_CMOREAng =  Vector(-1, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-1.13, -1, -0.41)
	SWEP.FAS2AimpointAng = Vector(-1, 0, 0)
	
	SWEP.ShortDotPos = Vector(-1.132, -1, -0.484)
	SWEP.ShortDotAng = Vector(-1, 0, 0)
	
	SWEP.AlternativePos = Vector(.5, 0, -.602)
	SWEP.AlternativeAng = Vector(0, .1, 0)
	
	SWEP.SprintPos = Vector(2.813, 0, 0)
	SWEP.SprintAng = Vector(-14.775, 28.141, 0.703)

	SWEP.CustomizationMenuScale = 0.024
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Vz58", rel = "", pos = Vector(-8.8, -0.02, 1.99), angle = Angle(0, 0, 0), size = Vector(0.55, 0.53, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Vz58", rel = "", pos = Vector(-8, 0.23, 1.059), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Vz58", rel = "", pos = Vector(-4.676, 0.039, 4.558), angle = Angle(0, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_pbs12"] = { type = "Model", model = "models/cw2/attachments/pbs1.mdl", bone = "Vz58", rel = "", pos = Vector(16.5, 0, 1.557), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Vz58", rel = "", pos = Vector(-2.8, 0, 3.9), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "Vz58", rel = "", pos = Vector(-4.571, 0.2, 3), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Vz58", rel = "", pos = Vector(-2.3, 0, 4.02), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Vz58", rel = "", pos = Vector(-5.715, 0.349, -0.219), angle = Angle(0, 90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-1.5, 0, -0.186), angle = Angle(-7.778, 7.777, 65.555) },
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.222, 10, 0) }}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 1, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 715 -- in meter/s
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[3] = {header = "Sight", offset = {600, -400},  atts = {"odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog"}},
	[2] = {header = "Barrel", offset = {100, -400}, atts = {"md_pbs12"}},
	[1] = {header = "Handguard", offset = {-400, -100}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {-450, 350}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire1","fire2","fire3"},
	reload = "reload1",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = .2, sound = "VZ58.Draw"}},

	reload1 = {[1] = {time = 1.1, sound = "KH47.Clipout"},
	[2] = {time = 1.5, sound = "KH47.Clipin"},
	[3] = {time = 2.5, sound = "VZ58.Bolt"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = .75, hor = .25, roll = .35, forward = .75, pitch = 1}

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

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_vz58.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.075
SWEP.FireSound = "VZ.Fire"
SWEP.FireSoundSuppressed = "KH47.SupFire"
SWEP.Recoil = 1.29

SWEP.OverallMouseSens = .8
SWEP.HipSpread = 0.047
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.DeployTime = .6
SWEP.RecoilToSpread = .8

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 3.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3.2
SWEP.ReloadHalt_Empty = 3.2

function SWEP:IndividualThink()
	self.EffectiveRange = 76.8 * 39.37
	self.DamageFallOff = .35
	
	if self.ActiveAttachments.md_pbs12 then
	self.EffectiveRange = ((self.EffectiveRange - 23.04 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .105))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 11.52 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0525))
	end
end