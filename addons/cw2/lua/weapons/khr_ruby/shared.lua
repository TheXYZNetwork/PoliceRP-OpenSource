AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "Pistolet Ruby"
	
	CustomizableWeaponry:registerAmmo(".32 ACP", ".32 ACP", 7.65, 17)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_ruby", "icons/killicons/khr_ruby", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_ruby")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .32
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	
	SWEP.EffectiveRange_Orig = 33 * 39.37
	SWEP.DamageFallOff_Orig = .48
	
	SWEP.IronsightPos = Vector(3.269, -2, 0.959)
	SWEP.IronsightAng = Vector(-0.12, -0.045, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-40, 0, 0)
	
	SWEP.CustomizePos = Vector(-6.191, -6.5, 1.44)
	SWEP.CustomizeAng = Vector(33.769, -43.619, -49.246)
	
	SWEP.AlternativePos = Vector(1.5, -2, -1)
	SWEP.AlternativeAng = Vector(0, 2.111, 5.627)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 2
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-.875, 0, 0)
	SWEP.BoltReloadOffset = Vector(.875, 0, 0)
	SWEP.EmptyBoltHoldAnimExclusion = "shoot_empty"
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.ReloadBoltBonePositionRecoverySpeed = 5
	SWEP.ReloadBoltBonePositionMoveSpeed = 15
	SWEP.StopReloadBoneOffset = .8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 2, roll = 4, forward = 1, pitch = 1}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {

	["md_tokasup"] = { type = "Model", model = "models/cw2/attachments/pbs1.mdl", bone = "body", rel = "", pos = Vector(-0.59, 5.86, .75), angle = Angle(90, 90, 90), size = Vector(0.48, 0.48, 0.48), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 320 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.FullAimViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Magazine", offset = {-600, -50}, atts = {"bg_dsmag"}},
	["+reload"] = {header = "Ammo", offset = {400, -100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1","shoot2","shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.10, sound = "RUBY_CLIPOUT"},
	[2] = {time = 1.4, sound = "RUBY_CLIPIN"},
	[3] = {time = 2.35, sound = "RUBY_SLIDEREL"}}}

SWEP.SpeedDec = 5

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
SWEP.ViewModel		= "models/khrcw2/v_khri_ruby.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_p228.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 9
SWEP.Primary.DefaultClip	= 9
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".32 ACP"

SWEP.FireDelay = 0.11
SWEP.FireSound = "RUBY_FIRE"
SWEP.FireSoundSuppressed = "RUBY_FIRE_SUPPRESSED"
SWEP.Recoil = .95
SWEP.FOVPerShot = 0.3

SWEP.HipSpread = 0.062
SWEP.AimSpread = 0.023
SWEP.VelocitySensitivity = .7	
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.3
SWEP.Shots = 1
SWEP.Damage = 19
SWEP.DeployTime = 0.1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 2
SWEP.ReloadHalt = 2

SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt_Empty = 2.7

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 33 * 39.37
	self.DamageFallOff = .48
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 4.95 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .072))
	end
end