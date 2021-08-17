AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "Ruger Mk3"
	
	CustomizableWeaponry:registerAmmo(".22LR", ".22LR Rounds", 5.6, 15.6)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rugermk3", "icons/killicons/khr_rugermk3", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_rugermk3")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .25
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	
	SWEP.EffectiveRange_Orig = 29.5 * 39.37
	SWEP.DamageFallOff_Orig = .22
	
	SWEP.IronsightPos = Vector(2.809, 0, 1.799)
	SWEP.IronsightAng = Vector(-0.1, -0.0334, 0)
	
	SWEP.DocterPos = Vector(2.809, 0, 1.599)
	SWEP.DocterAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-20.478, -14.407, 9.145)
	
	SWEP.CustomizePos = Vector(-4.222, -4.624, -0.805)
	SWEP.CustomizeAng = Vector(25.326, -19.698, -30.251)
	
	SWEP.AlternativePos = Vector(1, -2, 0.3)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
    SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.3
	SWEP.FullAimViewmodelRecoil = true
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-1.1, 0, 0)
	SWEP.EmptyBoltHoldAnimExclusion = "shoot_empty"
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.1
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.55, hor = 0.5, roll = 2, forward = 0, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.02
	SWEP.BoltBonePositionRecoverySpeed = 50 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
	
    ["md_docter"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "smdimport", rel = "", pos = Vector(-0.24, 2, 1.1), angle = Angle(0, 0, 0), size = Vector(1.014, 1.014, 1.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["md_rugersup"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "smdimport", rel = "", pos = Vector(0, -11, 0.07), angle = Angle(0, 0, 0), size = Vector(0.55, 1.728, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

	}
end

SWEP.MuzzleVelocity = 380 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[2] = {header = "Magazine", offset = {-600, 250}, atts = {"bg_rugerext"}},
[1] = {header = "Barrel", offset = {-600, -300}, atts = {"md_rugersup"}},
["+reload"] = {header = "Ammo", offset = {500, 200}, atts = {"am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	fire = {"shoot1","shoot2"},
	fire_dry = "shoot_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.40, sound = "RUBY_CLIPOUT"},
	[2] = {time = 1.5, sound = "RUBY_CLIPIN"},
	[3] = {time = 2.1, sound = "RUBY_SLIDEREL"}}}

SWEP.SpeedDec = 10

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
SWEP.Instructions	= "Rack slide. Face barrel towards enemy. Do not eat."

SWEP.ViewModelFOV	= 90
SWEP.AimViewModelFOV = 80
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/khrcw2/v_khri_rugermark.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_fiveseven.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".22LR"

SWEP.FireDelay = 0.1
SWEP.FireSound = "MK3_FIRE"
SWEP.FireSoundSuppressed = "MK3_FIRE_SUPPRESSED"
SWEP.Recoil = 0.08

SWEP.HipSpread = 0.030
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.025
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.01
SWEP.Damage = 15
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.9
SWEP.ReloadHalt = 2.9

SWEP.ReloadTime_Empty = 2.9
SWEP.ReloadHalt_Empty = 2.9

function SWEP:IndividualThink()
	self.EffectiveRange = 29.5 * 39.37
	self.DamageFallOff = .22
	
	if self.ActiveAttachments.md_rugersup then
	self.EffectiveRange = ((self.EffectiveRange - 5.9 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .044))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 7.375 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .055))
	end
end