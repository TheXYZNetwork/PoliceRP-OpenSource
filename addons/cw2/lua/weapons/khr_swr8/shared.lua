AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	CustomizableWeaponry:registerAmmo(".357 Magnum", ".357 Magnum Rounds", 9, 33)
	SWEP.PrintName = "SW MP R8"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.EffectiveRange_Orig = 51.3 * 39.37
	SWEP.DamageFallOff_Orig = .37
	
	SWEP.IronsightPos = Vector(-1.7, 1, 0.32)
	SWEP.IronsightAng = Vector(0.2, 0.05, 0)
	
	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(12.009, 24.971, 16.669)

	SWEP.DocterPos = Vector(-1.7, -3, -0.178)
	SWEP.DocterAng = Vector(0.2, 0.05, 0)
	
	SWEP.RMRPos = Vector(-1.7, -3, -0.178)
	SWEP.RMRAng = Vector(0.2, 0.05, 0)
	
	SWEP.SprintPos = Vector(0, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(0, 0, -0.6)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 1, roll = 1, forward = .5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.DisableSprintViewSimulation = true
	SWEP.ReticleInactivityPostFire = .55
	
	SWEP.AttachmentModelsVM = {
    ["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "MR96", rel = "", pos = Vector(-0.03, 1.557, 3), angle = Angle(0, -90, 0), size = Vector(0.855, 0.855, 0.855), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "MR96", rel = "", pos = Vector(-0.301, -3.201, -1.55), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "MR96", rel = "", pos = Vector(0, 2.4, 1.87), angle = Angle(0, 90, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSAlign = {right = 1.25, up = -.06, forward = 0}
end

SWEP.LaserPosAdjust = Vector(0, -5, -1)
SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.MuzzleVelocity = 391 -- in meter/s

SWEP.BarrelBGs = {main = 1, norail = 0, rail = 1}
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[2] = {header = "Receiver", offset = {-150, -500}, atts = {"bg_r8rail"}},
[1] = {header = "Underbarrel", offset = {-650, -100}, atts = {"md_insight_x2"}},
[3] = {header = "Optics", offset = {450, -400}, atts = {"kry_docter_sight","md_rmr"}, dependencies = {bg_r8rail = true}},
["+reload"] = {header = "Ammo", offset = {450, 200}, atts = {"am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "RB_DRAW"}},

	reload = {[1] = {time = 0.2, sound = "38_CYLINDEROPEN"},
	[2] = {time = .8, sound = "38_ROUNDSOUT"},
	[3] = {time = 1.6, sound = "38_ROUNDSIN"},
	[4] = {time = 1.85, sound = "38_CYLINDERCLOSE"}}}

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

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_swr8.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".357 Magnum"

SWEP.FireDelay = 0.2
SWEP.FireSound = "R8_FIRE"
SWEP.Recoil = 2

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.0094
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 58
SWEP.DeployTime = 0.4
SWEP.FOVPerShot = 1
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 2.5

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.5

function SWEP:IndividualThink()
	self.EffectiveRange = 51.3 * 39.37
	self.DamageFallOff = .37
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 7.695 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0555))
	end
end