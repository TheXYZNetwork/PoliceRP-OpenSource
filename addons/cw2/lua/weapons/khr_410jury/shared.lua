AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	CustomizableWeaponry:registerAmmo(".410 Bore", ".410 Bore Shells", 4, 10)
	CustomizableWeaponry:registerAmmo(".45 Long Colt", ".45LC Rounds", 11.48, 33)
	SWEP.PrintName = "Taurus Public Defender"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.EffectiveRange_Orig = 18 * 39.37
	SWEP.DamageFallOff_Orig = .5
	
	SWEP.IronsightPos = Vector(-1.844, 1, 0.897)
	SWEP.IronsightAng = Vector(-1.4, 0.03, 0)
	
	SWEP.JudgeLongPos = Vector(-1.844, 1, 0.818)
	SWEP.JudgeLongAng = Vector(-.95, 0.03, 0)
	
	SWEP.JudgeLongerPos = Vector(-1.844, 1, 0.785)
	SWEP.JudgeLongerAng = Vector(-0.7, 0.03, 0)

	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.SprintPos = Vector(0, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(-0.4, 1, -0.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)

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
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "weapon", rel = "", pos = Vector(0, 0.949, -3.636), angle = Angle(90, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.MuzzleVelocity = 259 -- in meter/s

SWEP.MagBGs = {main = 2, shell2 = 1, shell = 0}
SWEP.BarrelBGs = {main = 1, one = 0, two = 1, three = 2}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-650, -300}, atts = {"bg_judgelong","bg_judgelonger"}},
["+reload"] = {header = "Ammo", offset = {350, -150}, atts = {"am_flechette410","am_45lc"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "RB_DRAW"}},

	reload = {[1] = {time = 0.25, sound = "RB_OUT"},
	[2] = {time = .8, sound = "RB_EJECT"},
	[3] = {time = 2.5, sound = "RB_INSERT"},
	[4] = {time = 3.25, sound = "RB_IN"}}}

SWEP.SpeedDec = 15

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
SWEP.AimViewModelFOV = 80
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_410jury.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".410 Bore"

SWEP.FireDelay = 0.2
SWEP.FireSound = "410_FIRE"
SWEP.Recoil = 2

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.08
SWEP.MaxSpreadInc = 0.075
SWEP.SpreadPerShot = 0.02
SWEP.ClumpSpread = .019
SWEP.SpreadCooldown = 0.33
SWEP.Shots = 4
SWEP.Damage = 30
SWEP.DeployTime = 0.6
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4
SWEP.ReloadHalt = 4

SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt_Empty = 4

function SWEP:IndividualThink()
	self.EffectiveRange = 18 * 39.37
	self.DamageFallOff = .5
	self.ClumpSpread = .019
	
	if self.ActiveAttachments.bg_judgelong then
	self.EffectiveRange = ((self.EffectiveRange + 2 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .05))
	self.ClumpSpread = ((self.ClumpSpread - .002))
	end
	if self.ActiveAttachments.bg_judgelonger then
	self.EffectiveRange = ((self.EffectiveRange + 3.96 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .09))
	self.ClumpSpread = ((self.ClumpSpread - .004))
	end
	if self.ActiveAttachments.am_45lc then
	self.EffectiveRange = ((self.EffectiveRange + 35 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .1))
	self.ClumpSpread = nil
	end
end