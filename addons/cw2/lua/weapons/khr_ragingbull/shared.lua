AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "Taurus Raging Bull"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.EffectiveRange_Orig = 56.7 * 39.37
	SWEP.DamageFallOff_Orig = .36
	
	SWEP.IronsightPos = Vector(-1.841, 2, 0.56)
	SWEP.IronsightAng = Vector(0.3403, 0, 0)
	
	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.NXSPos = Vector(-1.841, 0, .18)
	SWEP.NXSAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(0, 2, 0)
	SWEP.AlternativeAng = Vector(0, 1, 0)

	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "hammer"
	SWEP.BoltShootOffset = Vector(0, -.25, 0)
	SWEP.BoltBonePositionRecoverySpeed = 3
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 1, roll = 1, forward = .5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.012
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.AttachmentModelsVM = {
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "weapon", rel = "", pos = Vector(-0.101, -2.35, 1.5), angle = Angle(90, 0, -90), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.NXSAlign = {right = 0, up = -90, forward = 0}

end

SWEP.MuzzleVelocity = 460 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {--[1] = {header = "Sight", offset = {600, -250},  atts = {"md_nightforce_nxs"}},
	["+reload"] = {header = "Ammo", offset = {-350, 100}, atts = {"am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "RB_DRAW"}},

	reload = {[1] = {time = 0.25, sound = "RB_OUT"},
	[2] = {time = .8, sound = "RB_EJECT"},
	[3] = {time = 2.5, sound = "RB_INSERT"},
	[4] = {time = 3.25, sound = "RB_IN"}}}

SWEP.SpeedDec = 35

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Revolvers"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_ragingbull.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay = 0.25
SWEP.FireSound = "29_FIRE"
SWEP.Recoil = 2.8

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.35
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.35
SWEP.Shots = 1
SWEP.Damage = 70
SWEP.DeployTime = 0.7
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4
SWEP.ReloadHalt = 4

SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt_Empty = 4

function SWEP:IndividualThink()
	self.EffectiveRange = 56.7 * 39.37
	self.DamageFallOff = .36
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 8.5 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .054))
	end
end