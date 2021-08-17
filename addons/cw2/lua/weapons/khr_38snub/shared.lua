AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	CustomizableWeaponry:registerAmmo(".38 Special", ".38 Special Rounds", 9, 29.5)
	SWEP.PrintName = "SW Model 642"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_rgnbull", "icons/killicons/khr_rgnbull", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_rgnbull")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = true
	
	SWEP.EffectiveRange_Orig = 44.7 * 39.37
	SWEP.DamageFallOff_Orig = .39
	
	SWEP.IronsightPos = Vector(-1.698, 1, 0.91)
	SWEP.IronsightAng = Vector(-1.14, 0.07, 0)
	
	SWEP.SW38ShortPos = Vector(-1.69, 1, 0.87)
	SWEP.SW38ShortAng = Vector(-.93, 0.1, 0)

	SWEP.SW38MediumPos = Vector(-1.698, 1, 0.825)
	SWEP.SW38MediumAng = Vector(-0.725, 0.07, 0)

	SWEP.SW38LongPos = Vector(-1.698, 1, 0.8)
	SWEP.SW38LongAng = Vector(-0.59, 0.07, 0)

	SWEP.SW38TopkekPos = Vector(-1.698, 1, 0.75)
	SWEP.SW38TopkekAng = Vector(-0.4, 0.07, 0)
	
	SWEP.NXSPos = Vector(-1.7076, 1, -0.14)
	SWEP.NXSAng = Vector(-1.2, 0.07, 0)

	SWEP.CustomizePos = Vector(3.488, -2.627, -0.821)
	SWEP.CustomizeAng = Vector(12.009, 24.971, 16.669)
	
	SWEP.CSGOACOGPos = Vector(-1.835, -3, -.09)
	SWEP.CSGOACOGAng = Vector(0.603, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.AlternativePos = Vector(-0.1, 1, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = .5, forward = 2, pitch = 3}
	SWEP.CustomizationMenuScale = 0.014
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.AttachmentModelsVM = {
	["md_tundra9mm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "MR96", rel = "", pos = Vector(-0.02, 14.099, 1.22), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "MR96", rel = "", pos = Vector(-0.13, 0.209, 3.549), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_griplaser"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "MR96", rel = "", pos = Vector(-.5, -1.9, 1.557), angle = Angle(0, 90, 0), size = Vector(0.0001, 0.0001, 0.0001), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSAlign = {right = 1.25, up = -.06, forward = 0}
end

SWEP.LaserPosAdjust = Vector(0, -5, -1)
SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.MuzzleVelocity = 318 -- in meter/s

SWEP.BarrelBGs = {main = 1, snub = 0, short = 1, medium = 2, long = 3, topkek = 4}
SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = false
SWEP.FullAimViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-500, -450}, atts = {"bg_short38","bg_medium38","bg_long38"}},
[2] = {header = "Grip", offset = {500, -100}, atts = {"md_griplaser"}},
[3] = {header = "Stuff", offset = {250, 400}, atts = {"md_nightforce_nxs"}, dependencies = {bg_38 = true}},
[4] = {header = "More Stuff", offset = {250, 600}, atts = {"md_tundra9mm"}, dependencies = {bg_38 = true}},
["+reload"] = {header = "Ammo", offset = {450, -500}, atts = {"am_matchgrade"}},
--["+zoom"] = {header = "Type", offset = {4500, -1000}, atts = {"bg_38"}}
}

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
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.OverallMouseSens = 1
SWEP.ViewModel		= "models/khrcw2/v_khri_38snub.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".38 Special"

SWEP.FireDelay = 0.15
SWEP.FireSound = "38_FIRE"
SWEP.FireSoundSuppressed = "KhrisP345.Single_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.035
SWEP.SpreadCooldown = 0.3
SWEP.Shots = 1
SWEP.Damage = 50
SWEP.DeployTime = 0.4
SWEP.FOVPerShot = .9
SWEP.Chamberable = false
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 2.5

SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt_Empty = 2.5

function SWEP:IndividualThink()
	self.EffectiveRange = 44.7 * 39.37
	self.DamageFallOff = .39
	
	if self.ActiveAttachments.bg_short38 then
	self.EffectiveRange = ((self.EffectiveRange + 2.235 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0195))
	end
	if self.ActiveAttachments.bg_medium38 then
	self.EffectiveRange = ((self.EffectiveRange + 3.576 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0312))
	end
	if self.ActiveAttachments.bg_long38 then
	self.EffectiveRange = ((self.EffectiveRange + 4.47 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .039))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.364 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0468))
	end
end