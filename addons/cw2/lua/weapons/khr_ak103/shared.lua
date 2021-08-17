AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"
	SWEP.PrintName = "AK-103"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_ak103", "icons/killicons/khr_ak103", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_ak103")
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.25
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -.5, y = 0, z = 3}
	SWEP.ForeGripOffsetCycle_Draw = .8
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 77.6 * 39.37
	SWEP.DamageFallOff_Orig = .35
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltBonePositionRecoverySpeed = 50
	SWEP.BoltShootOffset = Vector(2, 0, 0)
	
	SWEP.IronsightPos = Vector(-1.65, -1.5, 0.5)
	SWEP.IronsightAng = Vector(0.65, 0.02, 0)
	
	SWEP.MicroT1Pos = Vector(-1.625, -1.5, -0.769)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-1.617, -2, -0.927)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-1.629, -1.5, -0.802)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.KR_CMOREPos = Vector(-1.625, -1.5, -0.91)
	SWEP.KR_CMOREAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-1.609, -0.5, -0.8423)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.EoTech553Pos = Vector(-1.632, -1.5, -1.04)
	SWEP.EoTech553Ang = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-1.64, -1, 0)
	SWEP.KobraAng = Vector(0, 0, 0)
	
	SWEP.PSOPos = Vector(-1.663, 0.5, 0.201)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0.5, .5, -.2)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.02
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	["md_pbs12"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Base", pos = Vector(-15.905, 0.189, -0.991), angle = Angle(0, 90, 0), size = Vector(0.755, 0.755, 0.755)},
	["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Base", pos = Vector(4.9, 1.258, -0.101), angle = Angle(-90, 90, 0), size = Vector(0.6, 0.6, 0.6)},
	["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Base", pos = Vector(2.557, 1.658, 0.4), angle = Angle(-90, 90, 0), size = Vector(0.5, 0.5, 0.5)},
	["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", pos = Vector(4.675, 2.5, -0.301), angle = Angle(90, -90, 0), size = Vector(0.6, 0.6, 0.6)},
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Base", rel = "", pos = Vector(7, 0.709, 0.075), angle = Angle(0, 180, 90), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Base", rel = "", pos = Vector(0, -1.833, 0.043), angle = Angle(0, 180, 90), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(2.5, -2.33, 0.039), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "Base", rel = "", pos = Vector(2.299, -0.561, -0.179), angle = Angle(90, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Base", rel = "", pos = Vector(0, -1.601, 0.039), angle = Angle(0, -180, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Base", rel = "", pos = Vector(6.4, 1.769, -0.21), angle = Angle(0, 180, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Base", rel = "", pos = Vector(2, -2.3, -0.026), angle = Angle(0, 180, 90), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ForeGripHoldPos = {
	["v_weapon.Left_Index02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -25.556, 0) },
	["v_weapon.Left_Ring01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 16.666, 0) },
	["v_weapon.Left_Index01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-7.778, -21.112, 0) },
	["v_weapon.Left_Middle02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
	["v_weapon.Left_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, -1.223, 23.333) },
	["v_weapon.Left_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.556, 0.185, 0), angle = Angle(-12.223, 5.556, 65.555) },
	["v_weapon.Left_Thumb02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-23.334, -36.667, 34.444) },
	["v_weapon.Left_Thumb03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-32.223, 21.111, 0) },
	["v_weapon.Left_Thumb01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, 21.111, -14.445) }}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 715 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[3] = {header = "Sight", offset = {600, -400},  atts = {"md_microt1kh","md_kobra","odec3d_cmore_kry","md_fas2_eotech","md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog", "md_pso1"}},
	[2] = {header = "Barrel", offset = {100, -400}, atts = {"md_pbs12"}},
	[1] = {header = "Handguard", offset = {-400, -100}, atts = {"md_foregrip"}},
	[4] = {header = "Reciever", offset = {1100, 0}, atts = {"md_ak101"}},
	["+reload"] = {header = "Ammo", offset = {-450, 350}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"ak47_fire1", "ak47_fire2", "ak47_fire3"},
	reload = "ak47_reload",
	idle = "ak47_idle",
	draw = "ak47_draw"}
	
SWEP.Sounds = {	ak47_draw = {{time = .2, sound = "KH47.Boltpull"}},

	ak47_reload = {[1] = {time = .5, sound = "KH47.Clipout"},
	[2] = {time = .9, sound = "KH47.Clipin"},
	[3] = {time = 1.6, sound = "KH47.Boltpull"}}}

SWEP.HoldBoltWhileEmpty = false
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = .75, hor = .25, roll = .35, forward = .55, pitch = 1.55}

SWEP.SpeedDec = 40

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
SWEP.FireMoveMod = 1
SWEP.OverallMouseSens = .84
SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_kh47.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "KH47.Fire"
SWEP.FireSoundSuppressed = "KH47.SupFire"
SWEP.Recoil = 1.33

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.075
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.RecoilToSpread = 1
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 2.7

function SWEP:IndividualThink()
	self.EffectiveRange = 77.6 * 39.37
	self.DamageFallOff = .35
	
	if self.ActiveAttachments.md_pbs12 then
	self.EffectiveRange = ((self.EffectiveRange - 23.28 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .105))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 11.64 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0525))
	end
	if self.ActiveAttachments.md_ak101 then
	self.EffectiveRange = ((self.EffectiveRange + 17.83 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0803))
	end
end