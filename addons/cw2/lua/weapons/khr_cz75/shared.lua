AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "CZ-75B"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.SightWithRail = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_cz75", "icons/killicons/khr_cz75", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_cz75")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.FireMoveMod = 1
	
	SWEP.EffectiveRange_Orig = 37 * 39.37
	SWEP.DamageFallOff_Orig = .45
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .35

	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.IronsightPos = Vector(-2.636, -1, 0.98)
	SWEP.IronsightAng = Vector(0.6, 0.019, 0)
	
	SWEP.SprintPos = Vector(0, -1, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.RMRPos = Vector(-2.64, -7, .4)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.DocterPos = Vector(-2.647, -7, .41)
	SWEP.DocterAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.65, -7, .205)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(2.8, -3.418, -2.321)
	SWEP.CustomizeAng = Vector(21.106, 18.995, 16.18)
	
	SWEP.AlternativePos = Vector(-.7, -2, .1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.BoltBone = "sig_slide"
	SWEP.BoltShootOffset = Vector(0, 1.4, 0)
	SWEP.BoltReloadOffset = Vector(0, -1.4, 0)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.ReloadBoltBonePositionRecoverySpeed = 12
	SWEP.ReloadBoltBonePositionMoveSpeed = 999
	SWEP.StopReloadBoneOffset = .8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = .75, hor = .5, roll = 1, forward = 3.5, pitch = 0}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.BoltBonePositionRecoverySpeed = 35
	
	SWEP.AttachmentModelsVM = {
	["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "sig_frame", rel = "", pos = Vector(-0.01, 2.9, 2.809), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "sig_frame", rel = "", pos = Vector(0, 2.299, 2.69), angle = Angle(0, 180, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "sig_frame", rel = "", pos = Vector(0, 1.799, 0.619), angle = Angle(0, 90, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "sig_frame", rel = "", pos = Vector(0.007, 7.199, 1.185), angle = Angle(0, 180, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "sig_frame", rel = "", pos = Vector(-0.231, -1.101, -0.82), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "sig_frame", rel = "", pos = Vector(0, 2.7, 1.259), angle = Angle(0, 90, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 380 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Rail", offset = {-800, 0}, atts = {"md_insight_x2"}},
[2] = {header = "Barrel Extension", offset = {-450, -520}, atts = {"md_tundra9mm2"}},
[3] = {header = "Optic", offset = {150, -500}, atts = {"kry_docter_sight", "md_rmr", "md_microt1kh"}},
["+reload"] = {header = "Ammo", offset = {350, -50}, atts = {"am_magnum", "am_matchgrade"}}}

	SWEP.LaserPosAdjust = Vector(0, -1, -1.2)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "KZ75_DRAW"}},

	reload = {[1] = {time = 0.5, sound = "KZ75_CLIPOUT"},
	[2] = {time = 1.3, sound = "KZ75_CLIPIN"},
	[3] = {time = 1.75, sound = "KZ75_SHOVE"},
	[4] = {time = 2.2, sound = "KZ75_SLIDE"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Pistols"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "Rack slide. Face barrel towards enemy. Do not eat."

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_cz75.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_p228.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 16
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "KZ75_FIRE"
SWEP.FireSoundSuppressed = "KZ75_FIRE_SUPPRESSED"
SWEP.Recoil = .8
SWEP.FOVPerShot = 0.25

SWEP.HipSpread = 0.033
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.21
SWEP.Shots = 1
SWEP.Damage = 22
SWEP.DeployTime = .5
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadHalt = 2
SWEP.ReloadTime_Empty = 2.3
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 37 * 39.37
	self.DamageFallOff = .45
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 11.1 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .135))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.55 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0675))
	end
end