AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "Ruger P345"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.SightWithRail = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_p345", "icons/killicons/khr_p345", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_p345")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.FireMoveMod = 2
	SWEP.PosBasedMuz = true
	
	SWEP.EffectiveRange_Orig = 40 * 39.37
	SWEP.DamageFallOff_Orig = .49
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.FOVPerShot = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 6, y = -4, z = 0}

	SWEP.IronsightPos = Vector(-8.04, 4, 3.4)
	SWEP.IronsightAng = Vector(-0.13, 0, 0)
	
	SWEP.SprintPos = Vector(0.602, -0.202, 2)
	SWEP.SprintAng = Vector(-11.961, 3.517, 0)
	
	SWEP.DocterPos = Vector(-8.04, -12, 1.45)
	SWEP.DocterAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(-7.98, -12, 1.5)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-8.04, -12, .85)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.CustomizePos = Vector(7.488, -5.627, -1.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.AlternativePos = Vector(-2.5, 0, 0)
	SWEP.AlternativeAng = Vector(0, 1, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1.2
	SWEP.BoltBone = "p_slide"
	SWEP.BoltShootOffset = Vector(0, 3.2, 0)
	SWEP.BoltReloadOffset = Vector(0, -3.7, 0)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.EmptyBoltHoldAnimExclusion = "shoot_empty"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 22
	SWEP.ReloadBoltBonePositionMoveSpeed = 999
	SWEP.StopReloadBoneOffset = .8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 2, hor = .2, roll = .3, forward = 5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.03
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
	
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "p_frame", rel = "", pos = Vector(0, 5.869, -0.32), angle = Angle(0, 90, -0), size = Vector(0.30, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_cobram22"] = { type = "Model", model = "models/cw2/attachments/cobra_m2.mdl", bone = "p_frame", rel = "", pos = Vector(0.059, 17.7, 2.4), angle = Angle(-180, -90, 180), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "p_frame", rel = "", pos = Vector(0, 3.936, -1.558), angle = Angle(0, 90, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "p_frame", rel = "", pos = Vector(-0.02, 6.752, 4.82), angle = Angle(0, -90, 0), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "p_frame", rel = "", pos = Vector(-0.601, -4, -5.5), angle = Angle(0, -90, 0), size = Vector(1.7, 1.7, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "p_frame", rel = "", pos = Vector(0.029, 5, 4.474), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 260 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = false
SWEP.FullAimViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Rail", offset = {-700, -140}, atts = {"md_insight_x2"}},
[2] = {header = "Barrel Extension", offset = {-350, -550}, atts = {"md_cobram22"}},
[3] = {header = "Sight", offset = {200, -450}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
["+reload"] = {header = "Ammo", offset = {550, -50}, atts = {"am_magnum", "am_matchgrade"}}}

	SWEP.LaserPosAdjust = Vector(0, 0, -3.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "real_idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.40, sound = "Weapon_KhrisP345.Clipout"},
	[2] = {time = 1.9, sound = "Weapon_KhrisP345.Clipin"},
	[3] = {time = 2.47, sound = "Weapon_KhrisP345.Sliderelease"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Pistols"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_rugerp345.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_usp.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.109
SWEP.FireSound = "Weapon_KhrisP345.Single"
SWEP.FireSoundSuppressed = "KhrisP345.Single_SUPPRESSED"
SWEP.Recoil = 1.11

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 30
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadHalt = 2.4

SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 40 * 39.37
	self.DamageFallOff = .49
	
	if self.ActiveAttachments.md_cobram22 then
	self.EffectiveRange = ((self.EffectiveRange - 12 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .147))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 6 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0735))
	end
end