AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "OTs-33 Pernach"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_ots33", "icons/killicons/khr_ots33", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_ots33")
	
	SWEP.MuzzleEffect = "muzzleflash_OTS"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .3
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -1}
	
	SWEP.EffectiveRange_Orig = 34.8 * 39.37
	SWEP.DamageFallOff_Orig = .46

	SWEP.IronsightPos = Vector(-2.535, -2, 0.795)
	SWEP.IronsightAng = Vector(0.4, 0.05, 0)
	
	SWEP.SprintPos = Vector(0.602, -0.202, 0)
	SWEP.SprintAng = Vector(-16.961, 13.517, 0)
	
	SWEP.DocterPos = Vector(-2.54, -4, 0)
	SWEP.DocterAng = Vector(0.3, 0.019, 0)
	
	SWEP.RMRPos = Vector(-2.53, -4, 0)
	SWEP.RMRAng = Vector(0.3, 0.019, 0)
	
	SWEP.MicroT1Pos = Vector(-2.54, -4, -.27)
	SWEP.MicroT1Ang = Vector(0.3, 0.019, 0)
	
	SWEP.CustomizePos = Vector(3.015, -4.222, -0.805)
	SWEP.CustomizeAng = Vector(24.622, 28.141, 24.622)
	
	SWEP.AlternativePos = Vector(-.5, -1, -.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "Object001"
	SWEP.BoltShootOffset = Vector(-.9, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1.25, hor = .7, roll = .7, forward = 1, pitch = 3}
	SWEP.FOVPerShot = 0.4
	SWEP.CustomizationMenuScale = 0.010
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
	
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "OTS-33_Low", rel = "", pos = Vector(0.0, 0, 1.1), angle = Angle(0, 90, 0), size = Vector(0.11, 0.11, 0.11), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "OTS-33_Low", rel = "", pos = Vector(-0, 4.675, 1.059), angle = Angle(0, 180, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "OTS-33_Low", rel = "", pos = Vector(0, -0.519, 2.595), angle = Angle(0, 180, 0), size = Vector(0.34, 0.34, 0.34), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "OTS-33_Low", rel = "", pos = Vector(-0.01, 0.189, 2.697), angle = Angle(0, -90, 0), size = Vector(0.759, 0.759, 0.759), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "OTS-33_Low", rel = "", pos = Vector(-0.26, -4.2, -1.471), angle = Angle(0, -90, 0), size = Vector(0.689, 0.689, 0.689), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "OTS-33_Low", rel = "", pos = Vector(0, -1, 0.33), angle = Angle(0, 90, 0), size = Vector(0.129, 0.129, 0.129), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 330 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-800, -200}, atts = {"md_insight_x2"}},
[3] = {header = "Barrel Extension", offset = {-350, -600}, atts = {"md_tundra9mm2"}},
[2] = {header = "Magazine", offset = {-600, 300}, atts = {"bg_ots_extmag"}},
[4] = {header = "Sight", offset = {300, -550}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
["+reload"] = {header = "Ammo", offset = {450, -50}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.LaserPosAdjust = Vector(0, -5, -1.2)
SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.Animations = {fire = {"shoot1", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.6, sound = "OTS_SLIDEREL"}},

	reload = {[1] = {time = 0.60, sound = "OTS_MAGOUT"},
	[2] = {time = 2, sound = "OTS_MAGIN"},
	[3] = {time = 2.45, sound = "OTS_SLIDEREL"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Pistols"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "Rack slide. Face barrel towards enemy. Do not eat."

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_ots.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_glock18.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 27
SWEP.Primary.DefaultClip	= 27
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.0666666666666667
SWEP.FireSound = "OTS_FIRE"
SWEP.FireSoundSuppressed = "OTS_FIRE_SUPPRESSED"
SWEP.Recoil = .65

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.014
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.070
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.RecoilToSpread = 1
SWEP.DeployTime = 1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 3
SWEP.ReloadHalt = 3

SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3

function SWEP:IndividualThink()
	self.EffectiveRange = 34.8 * 39.37
	self.DamageFallOff = .46
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 10.44 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .138))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.22 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .069))
	end
end