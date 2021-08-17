AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "Desert Eagle"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true

	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_deagle", "icons/killicons/khr_deagle", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_deagle")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"
	SWEP.PosBasedMuz = false
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.IronsightPos = Vector(-2.06, 0, 0.31)
	SWEP.IronsightAng = Vector(0.2, -1.56, 2.813)
	
	SWEP.ShortDotPos = Vector(-1.861, -6, -.176)
	SWEP.ShortDotAng = Vector(0, -1.601, 2.813)
	
	SWEP.CSGOACOGPos = Vector(-1.86, -6, -.323)
	SWEP.CSGOACOGAng = Vector(0, -1.601, 2.813)
	
	SWEP.FAS2AimpointPos = Vector(-1.897, -6, -.116)
	SWEP.FAS2AimpointAng = Vector(0, -1.601, 2.813)
	
	SWEP.CustomizePos = Vector(3, -2.403, -1.65)
	SWEP.CustomizeAng = Vector(23.92, 16.884, 23.92)
	
	SWEP.SprintPos = Vector(0.66, 0, -0.64)
	SWEP.SprintAng = Vector(-22.514, 21.809, -17.588)
	
	SWEP.AlternativePos = Vector(-0.5, 0, -0.44)
	SWEP.AlternativeAng = Vector(0, 0, 2)
	
	SWEP.EffectiveRange_Orig = 58 * 39.37
	SWEP.DamageFallOff_Orig = .34
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.6
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, 0)
	SWEP.BoltReloadOffset = Vector(-2.15, 0, 0)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.EmptyBoltHoldAnimExclusion = "shoot_empty"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 12
	SWEP.ReloadBoltBonePositionMoveSpeed = 999
	SWEP.StopReloadBoneOffset = .6
	SWEP.HoldBoltWhileEmpty = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 3, forward = 1, pitch = 2}
	SWEP.CustomizationMenuScale = 0.014
	SWEP.BoltBonePositionRecoverySpeed = 40 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "weapon", rel = "", pos = Vector(2.7, 1.87, 0.07), angle = Angle(180, 0, -90), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "weapon", rel = "", pos = Vector(1.299, 2.549, -0.233), angle = Angle(0, 180, 90), size = Vector(0.72, 0.72, 0.72), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "weapon", rel = "", pos = Vector(-5.901, -0.801, 0), angle = Angle(0, -180, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
		SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
		SWEP.SchmidtShortDotAxisAlign = {right = 0.2, up = -.15, forward = -3}
	
end

SWEP.MuzzleVelocity = 470 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = false
SWEP.CanRestOnObjects = false


SWEP.Attachments = {[1] = {header = "Optic", offset = {350, -400}, atts = {"md_fas2_aimpoint", "md_schmidt_shortdot"}},
["+reload"] = {header = "Ammo", offset = {-500, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1"},
	fire_dry = "shoot_empty",
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "50EAGLE_DRAW"}},

	reload = {[1] = {time = 0.3, sound = "50EAGLE_MAGOUT"},
	[2] = {time = 1.1, sound = "50EAGLE_MAGIN"},
	[3] = {time = 1.6, sound = "50EAGLE_SLIDEF"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Pistols"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_deserte.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_deagle.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".50 AE"

SWEP.FireDelay = 0.15
SWEP.FireSound = "50EAGLE_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.0091
SWEP.VelocitySensitivity = 1.36
SWEP.OverallMouseSens = .7
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.03
SWEP.SpreadCooldown = 0.32
SWEP.Shots = 1
SWEP.Damage = 60
SWEP.DeployTime = .5
SWEP.ADSFireAnim = true
--SWEP.Chamberable = false

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 1.3
SWEP.ReloadHalt = 1.3
SWEP.ReloadTime_Empty = 1.8
SWEP.ReloadHalt_Empty = 1.8

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 58 * 39.37
	self.DamageFallOff = .34
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 8.7 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .051))
	end
end