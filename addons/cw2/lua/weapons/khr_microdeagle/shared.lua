AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	
	CustomizableWeaponry:registerAmmo(".380 ACP", ".380 ACP Rounds", 9, 17)
	SWEP.PrintName = "Micro Desert Eagle"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .45
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 0, y = 2, z = 0}
	
	SWEP.EffectiveRange_Orig = 34.2 * 39.37
	SWEP.DamageFallOff_Orig = .47
	
	SWEP.IronsightPos = Vector(3.7888, 0, 4.36)
	SWEP.IronsightAng = Vector(-4.1, 0.01, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-40, 0, 0)
	
	SWEP.CustomizePos = Vector(-4, -4.8889, 2.7778)
	SWEP.CustomizeAng = Vector(12.0805, -28.9933, -24.1611)
	
	SWEP.AlternativePos = Vector(1.3423, -2.2, 1.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1.5
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1, 0, 0)
	SWEP.BoltReloadOffset = Vector(.85, 0, 0)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.ReloadBoltBonePositionRecoverySpeed = 25
	SWEP.ReloadBoltBonePositionMoveSpeed = 999
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

SWEP.MuzzleVelocity = 300 -- in meter/s

SWEP.MagBGs = {main = 1, mag1 = 0, mag2 = 1}

SWEP.LuaViewmodelRecoil = false
SWEP.FullAimViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Magazine", offset = {-500, 50}, atts = {"bg_mdemag"}},
	["+reload"] = {header = "Ammo", offset = {400, -200}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1","shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "M92FS_DEPLOY"}},

	reload = {[1] = {time = 0.6, sound = "RUBY_CLIPOUT"},
	[2] = {time = 1.3, sound = "RUBY_CLIPIN"},
	[3] = {time = 2, sound = "RUBY_SLIDEREL"}}}
	

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

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/khrcw2/v_khri_microeagle.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_p228.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".380 ACP"

SWEP.FireDelay = 0.1
SWEP.FireSound = "RUBY_FIRE"
SWEP.FireSoundSuppressed = "RUBY_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1
SWEP.FOVPerShot = 0.3

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = .8
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.3
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = 0.1
SWEP.ADSFireAnim = true

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 1.9
SWEP.ReloadHalt = 1.9

SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt_Empty = 2.7

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 34.2 * 39.37
	self.DamageFallOff = .47
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.13 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0705))
	end
end