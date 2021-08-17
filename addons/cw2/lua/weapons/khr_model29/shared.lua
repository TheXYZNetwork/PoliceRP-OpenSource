AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "SW Model 29"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.EffectiveRange_Orig = 52 * 39.37
	SWEP.DamageFallOff_Orig = .38
	
	SWEP.IronsightPos = Vector(-1.6333, 1, 1)
	SWEP.IronsightAng = Vector(-1.7, -0.35, -0.3)
	
	SWEP.M29ShortPos = Vector(-1.6333, 1, 0.9)
	SWEP.M29ShortAng = Vector(-1.1, -0.35, -0.3)
	
    SWEP.M29LongPos = Vector(-1.636, 1, 0.866)
	SWEP.M29LongAng = Vector(-0.9, -0.35, -0.3)
	
	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.CSGOACOGPos = Vector(-1.835, -3, -.09)
	SWEP.CSGOACOGAng = Vector(0.603, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(0, -0.55, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "hammer"
	SWEP.BoltShootOffset = Vector(0, 0, -.25)
	SWEP.BoltBonePositionRecoverySpeed = 5
	SWEP.FullAimViewmodelRecoil = false
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 1, roll = 1, forward = .5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.016
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.AttachmentModelsVM = {
}
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 410 -- in meter/s

SWEP.BarrelBGs = {main = 1, snub = 0, short = 1, long = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-500, -200},  atts = {"bg_4inchsw29","bg_6inchsw29"}},
	["+reload"] = {header = "Ammo", offset = {450, 0}, atts = {"am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.2, sound = "29_CYLINDERCLOSE"}},

	reload = {[1] = {time = 0.15, sound = "29_CYLINDEROPEN"},
	[2] = {time = 0.8, sound = "29_ROUNDSOUT"},
	[3] = {time = 2, sound = "29_ROUNDSIN"},
	[4] = {time = 2.7, sound = "29_CYLINDERCLOSE"}}}

SWEP.SpeedDec = 30

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

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_model29.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay = 0.275
SWEP.FireSound = "29_FIRE"
SWEP.Recoil = 2.7

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.016
SWEP.VelocitySensitivity = 1.35
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 55
SWEP.DeployTime = .8
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 3.4
SWEP.ReloadHalt = 3.4

SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt_Empty = 3.4

function SWEP:IndividualThink()
	self.EffectiveRange = 52 * 39.37
	self.DamageFallOff = .38
	
	if self.ActiveAttachments.bg_4inchsw29 then
	self.EffectiveRange = ((self.EffectiveRange + 5.2 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .038))
	end
	if self.ActiveAttachments.bg_6inchsw29 then
	self.EffectiveRange = ((self.EffectiveRange + 7.8 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .057))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 7.8 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .057))
	end
end