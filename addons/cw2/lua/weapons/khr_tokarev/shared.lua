AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "TT-33 Tokarev"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_tokarev", "icons/killicons/khr_tokarev", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_tokarev")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	
	SWEP.DrawTraditionalWorldModel = true
	SWEP.WM = "models/weapons/w_khri_tt33tokar.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .32
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 0}

	SWEP.IronsightPos = Vector(-2.28, 0, 0.109)
	SWEP.IronsightAng = Vector(1.1, 0.05, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.CustomizePos = Vector(5.427, -3.418, -2.01)
	SWEP.CustomizeAng = Vector(19.697, 27.437, 24.622)
	
	SWEP.AlternativePos = Vector(-0.4, -1.5, -.8)
	SWEP.AlternativeAng = Vector(0, 0.703, 0)

	SWEP.EffectiveRange_Orig = 42.38 * 39.37
	SWEP.DamageFallOff_Orig = .44
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.5, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = .75, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {

	["md_gemtechmm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "body", rel = "", pos = Vector(0, 6.5, 0.039), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 480 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel Extension", offset = {-600, -450}, atts = {"md_gemtechmm"}},
[2] = {header = "Magazine", offset = {-600, 150}, atts = {"bg_dsmag"}},
["+reload"] = {header = "Ammo", offset = {400, -100}, atts = {"am_magnum", "am_matchgrade"}}}


SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw2"}
	
SWEP.Sounds = {draw2 = {{time = .4, sound = "TT_SLIDE"}},

	reload = {[1] = {time = 0.40, sound = "TT_CLIPOUT"},
	[2] = {time = 1.15, sound = "TT_CLIPIN"},
	[3] = {time = 1.6, sound = "TT_SLIDE"}}}

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
SWEP.Instructions	= "Rack slide. Face barrel towards enemy. Do not eat."

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_tt33tokar.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_p228.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.FireDelay = 60/500
SWEP.FireSound = "TT_FIRE"
SWEP.FireSoundSuppressed = "TT_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05
SWEP.FOVPerShot = 0.2

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.0114
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.0075
SWEP.SpreadCooldown = 0.23
SWEP.Shots = 1
SWEP.Damage = 25
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.4
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 2.5

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.5

function SWEP:IndividualThink()
	self.EffectiveRange = 42.38 * 39.37
	self.DamageFallOff = .44
	
	if self.ActiveAttachments.md_gemtechmm then
	self.EffectiveRange = ((self.EffectiveRange - 12.714 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .132))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 6.357 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .066))
	end
end