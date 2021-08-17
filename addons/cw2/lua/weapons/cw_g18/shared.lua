AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "Glock 18"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true

	SWEP.SelectIcon = surface.GetTextureID("weaponicons/glock.vmt")
	killicon.Add("cw_g18", "weaponicons/glock", Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.NoShells = false
	SWEP.Shell = "smallshell"

	SWEP.ShellOffsetMul = 1
	SWEP.ShellScale = 0.5
	SWEP.ShellPosOffset = Vector(2,1,0) //Vector(2,1,-1)

	SWEP.IronsightPos = Vector(2.196, -1, 1.771)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(2.2, -1.81, 1.019)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.KobraPos = Vector(2.177, -8.7, 1.111)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-2.316, -5.095, -6.424)
	SWEP.SprintAng = Vector(49.231, -0.584, -1.984)

	//SWEP.CustomizePos = Vector(-9.74, -7.587, -1.78)
	//SWEP.CustomizeAng = Vector(35.25, -54.682, -21.025)
	SWEP.CustomizePos = Vector(-9.662, -7.15, 0.565)
	SWEP.CustomizeAng = Vector(25.156, -66.075, -16.382)

	SWEP.AlternativePos = Vector(0.763, 1.863, 0.791)
	SWEP.AlternativeAng = Vector(0.076, 0, 0)

	SWEP.ViewModelMovementScale = 0.2
	SWEP.FullAimViewmodelRecoil = true
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.61, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.HUD_MagText = "MAGAZINE: "

	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = 0, pitch = 0}
	SWEP.CustomizationMenuScale = 0.007
	SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "slide", pos = Vector(4.161, -3.151, 11.076), angle = Angle(0, 0, 90), size = Vector(0.4, 0.4, 0.4)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "frame", pos = Vector(3.812, -5.981, 15.444), angle = Angle(0, 0, 90), size = Vector(0.46, 0.372, 0.46)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "frame", pos = Vector(4.093, -4.432, 15.515), angle = Angle(-90, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "frame", pos = Vector(4.185, -4.182, 18.478), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5)}
	}

	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)


end

SWEP.ViewModelBoneMods = {
		["bullet"] = { scale = Vector(1, 1, 1), pos = Vector(-1.155, 0, 1.149), angle = Angle(0, 0, 0) },
		["mag"] = { scale = Vector(1, 0.744, 1), pos = Vector(0.657, 0, -0.295), angle = Angle(0, 0, 0) },
		["slide release"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.074), angle = Angle(0, 0, 0) }
}

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {600, -500}, atts = {"md_microt1","md_kobra"}},
	[2] = {header = "Tactical", offset = {200, 400}, atts = {"md_anpeq15"}},
	[3] = {header = "Barrel Extension", offset = {-400, 150}, atts = {"md_tundra9mm"}},
	[4] = {header = "Magazine", offset = {1000, 600}, atts = {"bg_g18_30rd_mag"}},
	["+reload"] = {header = "Ammo", offset = {1200, 200}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {fire = {"mac10_fire", "mac10_fire2","mac10_fire3"},
	reload = "mac10_reload",
	idle = "mac10_idle",
	draw = "mac10_draw"}

SWEP.Sounds = {

	mac10_reload = {
	[1] = {time = 0.3, sound = "CW_G18_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_G18_MAGIN"},
	[3] = {time = 2.4, sound = "CW_G18_BOLTRELEASE"}
	},

	mac10_draw = {
	[1] = {time = 0.1, sound = "CW_G18_BOLTRELEASE"}
	}

}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.AddSafeMode = false
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Andrew900460"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV = 63
SWEP.ViewModelFlip	= true
SWEP.ViewModel = "models/cw2_g18/v_dmg_glock.mdl"
SWEP.WorldModel = "models/cw2_g18/w_dmg_glock.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 17
SWEP.Primary.DefaultClip	= 17
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 60/800
SWEP.FireSound = "CW_G18_FIRE"
SWEP.FireSoundSuppressed = "CW_G18_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7
SWEP.RecoilToSpread = 0.5

SWEP.HipSpread = 0.015
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = 0.1
SWEP.Chamberable = true

SWEP.ReloadSpeed = 1.35
SWEP.ReloadTime = 2.19
SWEP.ReloadHalt = 2.19

SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true
