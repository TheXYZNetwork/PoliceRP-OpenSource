AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "GSh-18"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_gsh18", "icons/killicons/khr_gsh18", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_gsh18")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .3
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = .2, y = -.2, z = 0}
	
	SWEP.EffectiveRange_Orig = 36 * 39.37
	SWEP.DamageFallOff_Orig = .45

	SWEP.IronsightPos = Vector(-2.441, 0.3, 0.744)
	SWEP.IronsightAng = Vector(-0.277, -4.1, 0)

	SWEP.RMRPos = Vector(-2.012, -6, -0.2)
	SWEP.RMRAng = Vector(0, -4.4, 0)
	
	SWEP.DocterPos = Vector(-2.012, -6, -0.25)
	SWEP.DocterAng = Vector(0, -4.25, 0)
	
	SWEP.MicroT1Pos = Vector(-2.012, -6, -0.42)
	SWEP.MicroT1Ang = Vector(0, -4.25, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 6.96, 0)
	
	SWEP.CustomizePos = Vector(4.28, -2, -2.161)
	SWEP.CustomizeAng = Vector(15.477, 21.809, 15.477)
	
	SWEP.AlternativePos = Vector(-0.921, -1.2, -0.72)
	SWEP.AlternativeAng = Vector(0, -4.926, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.BoltBone = "GHS18_Slide"
	SWEP.BoltShootOffset = Vector(-1.3, -.09, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 2, roll = 2, forward = 1.5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.015
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
    ["md_tundra9mm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "GHS18_Body", rel = "", pos = Vector(0, -5.715, 1.05), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "GHS18_Body", rel = "", pos = Vector(0.219, 1.557, -0.721), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "GHS18_Body", rel = "", pos = Vector(0.016, -2.35, 2.946), angle = Angle(0, 90, 0), size = Vector(0.74, 0.74, 0.74), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/slimpistolrail.mdl", bone = "GHS18_Body", rel = "", pos = Vector(0, -1, 0.717), angle = Angle(0, -90, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "GHS18_Body", rel = "", pos = Vector(0, -1.698, 2.799), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 370 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[2] = {header = "Optic", offset = {150, -450}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
[1] = {header = "Barrel Extension", offset = {-550, -500}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {350, -50}, atts = {"am_7n31", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {reload = {[1] = {time = 0.30, sound = "GSH_MAGOUT"},
	[2] = {time = 1.3, sound = "GSH_MAGIN"},
	[3] = {time = 1.7, sound = "GSH_SLIDEREL"}},
	
	draw = {[1] = {time = 0.30, sound = "GSH_BOLTPULL"},
	[2] = {time = 0, sound = "GSH_CLOTH"}}}

SWEP.SpeedDec = 20

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
SWEP.ViewModel		= "models/khrcw2/v_khri_gsh1.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_glock18.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 18
SWEP.Primary.DefaultClip	= 18
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.12
SWEP.FireSound = "GSH_FIRE"
SWEP.FireSoundSuppressed = "GSH_FIRE_SUPPRESSED"
SWEP.Recoil = .8
SWEP.FOVPerShot = 0.2

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 1.15
SWEP.MaxSpreadInc = 0.067
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.23
SWEP.Shots = 1
SWEP.Damage = 22
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.6
SWEP.ReloadHalt = 2.6

SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadHalt_Empty = 2.6

function SWEP:IndividualThink()
	self.EffectiveRange = 36 * 39.37
	self.DamageFallOff = .45
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 10.8 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .135))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.4 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0675))
	end
end