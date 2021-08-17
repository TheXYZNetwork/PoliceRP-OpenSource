AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "smgMag"
SWEP.PrintName = "SR-2 Veresk"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.SuppressedOnEquip = false
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false
	SWEP.SightWithRail = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.FireMoveMod = 2
	
	SWEP.EffectiveRange_Orig = 40.6 * 39.37
	SWEP.DamageFallOff_Orig = .39

	SWEP.IronsightPos = Vector(-2.4476, -2, 1.41)
	SWEP.IronsightAng = Vector(0, 0.05, 0)
	
	SWEP.KR_CMOREPos = Vector(-2.45, -3.5, 0.74)
	SWEP.KR_CMOREAng = Vector(0, 0.05, 0)

	SWEP.FAS2AimpointPos = Vector(-2.429, -4, 0.868)
	SWEP.FAS2AimpointAng = Vector(0, 0.05, 0)

	SWEP.EoTech553Pos = Vector(-2.45, -3.5, 0.63)
	SWEP.EoTech553Ang = Vector(0, 0.05, 0)

	SWEP.MicroT1Pos = Vector(-2.46, -3.5, 0.85)
	SWEP.MicroT1Ang = Vector(0, 0.05, 0)
	
	SWEP.SprintPos = Vector(-0.5556, -0.5556, -1.6667)
	SWEP.SprintAng = Vector(-14, 26, -26)
	
	SWEP.CustomizePos = Vector(3.8889, -2.7778, 0)
	SWEP.CustomizeAng = Vector(14, 30, 18)
	
	SWEP.AlternativePos = Vector(-0.5556, -0.5556, 0.2)
	SWEP.AlternativeAng = Vector(0, 0.703, 0)
	
    SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.DisableSprintViewSimulation = false
	SWEP.FOVPerShot = 0.7
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1.25, hor = 0.2, roll = .75, forward = .65, pitch = 1.55}
	SWEP.CustomizationMenuScale = 0.015
	
	SWEP.AttachmentModelsVM = {
	["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-4.2, -15.5, 3.2), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.741, -11.948, 2.539), angle = Angle(-180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.767, -9.87, 1.87), angle = Angle(180, 0, 0), size = Vector(0.28, 0.28, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.567, -11.171, 3.545), angle = Angle(180, 90, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.75, -22, 4), angle = Angle(180, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.83, -9.91, 1.899), angle = Angle(180, -90, 0), size = Vector(0.189, 0.189, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Mp7_Body", rel = "", pos = Vector(-3.757, -12.5, 2.359), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.MuzzleVelocity = 423 -- in meter/s

SWEP.LaserPosAdjust = Vector(-.8, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = true

SWEP.Attachments = {[3] = {header = "Optic", offset = {300, -500}, atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint"}},
[2] = {header = "Barrel", offset = {-300, -600}, atts = {"md_tundra9mm2"}},
[1] = {header = "Rail", offset = {-625, -200}, atts = {"md_anpeq15"}},
["+reload"] = {header = "Ammo", offset = {-50, 350}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	fire = {"shoot1", "shoot2"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.45, sound = "VERESK_FOREGRIP"}},

	reload= {[1] = {time = 0.4, sound = "VERESK_MAGOUT"},
	[2] = {time = 1.7, sound = "VERESK_MAGIN"},
	[3] = {time = 1.8, sound = "VERESK_MAGIN2"},
	[4] = {time = 2.2, sound = "VERESK_BOLTREL"},
	[5] = {time = 2.7, sound = "VERESK_HANDLE"}}}

SWEP.SpeedDec = 25

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - SMGs"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "Rack slide. Face barrel towards enemy. Do not eat."

SWEP.OverallMouseSens = 1
SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_smg_sr2ve.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_tmp.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.084
SWEP.FireSound = "VERESK_FIRE"
SWEP.FireSoundSuppressed = "VERESK_SUPFIRE"
SWEP.Recoil = 0.85

SWEP.HipSpread = 0.046
SWEP.AimSpread = 0.0092
SWEP.VelocitySensitivity = .9
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.0915
SWEP.Damage = 28
SWEP.DeployTime = 1.5
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.4
SWEP.ReloadHalt = 3.4

SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt_Empty = 3.4

function SWEP:IndividualThink()
	self.EffectiveRange = 40.6 * 39.37
	self.DamageFallOff = .39
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 10.15 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .0975))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 6.09 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0585))
	end
end