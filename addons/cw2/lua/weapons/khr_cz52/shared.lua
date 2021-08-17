AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	
	CustomizableWeaponry:registerAmmo("7.62x25MM", "7.62x25MM Tokarev", 7.62, 25)
	CustomizableWeaponry.shells:addNew("545x18", "models/shells/5_45x18mm.mdl", "CW_SHELL_SMALL")
	CustomizableWeaponry.shells:addNew("9x19", "models/shells/9x19mm.mdl", "CW_SHELL_SMALL")
	SWEP.PrintName = "CZ 52"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_cz52", "icons/killicons/khr_cz52", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_cz52")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/pistols/w_cz52.mdl"
	SWEP.WMPos = Vector(-1.5, 4.5, 1.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.Shell = "545x18"
	SWEP.ShellScale = .95
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = -.85, y = .5, z = 8}

	SWEP.IronsightPos = Vector(-1.967, 0, 0.3477)
	SWEP.IronsightAng = Vector(-0.2, 0.05, 0)
	
	SWEP.CompactPos = Vector(-1.967, 0, 0.43)
	SWEP.CompactAng = Vector(-0.122, 0.05, 0)

	SWEP.CustomizePos = Vector(5.1111, -3.5556, -1.2)
	SWEP.CustomizeAng = Vector(16, 34, 14)
	
	SWEP.AlternativePos = Vector(-.25, -1, -.555)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.5556, 0.5556, -0.5556)
	SWEP.SprintAng = Vector(-18, 14, -10)

	SWEP.EffectiveRange_Orig = 42.38 * 39.37
	SWEP.DamageFallOff_Orig = .44
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 1.83, 0)
	SWEP.BoltBonePositionRecoverySpeed = 35
	SWEP.EmptyBoltHoldAnimExclusion = "base_firelast"
    SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.014
	
		function SWEP:RenderTargetFunc()
		if self.ActiveAttachments.md_tritiumis then
					self.AttachmentModelsVM.tritfront.active = true
					self.AttachmentModelsVM.tritback.active = true
					else
					self.AttachmentModelsVM.tritfront.active = false
					self.AttachmentModelsVM.tritback.active = false
				end
		if self.ActiveAttachments.md_tritiumispmm then
					self.AttachmentModelsVM.tritfrontpmm.active = true
					self.AttachmentModelsVM.tritbackpmm.active = true
					else
					self.AttachmentModelsVM.tritfrontpmm.active = false
					self.AttachmentModelsVM.tritbackpmm.active = false
				end
				

        end
	end
	
			SWEP.AttachmentPosDependency = {
		["md_gemtechmm"] = {
			["bg_cz52compact"] = Vector(2.06, -17.3, 3.28),
		},
	}
	
	SWEP.AttachmentDependencies = { 
	["md_tritiumispmm"] = {"bg_cz52compact"},
}
SWEP.AttachmentExclusions = {
	["md_tritiumis"] = {"bg_cz52compact"},
}
	
	SWEP.AttachmentModelsVM = {
	["md_gemtechmm"] = { type = "Model", model = "models/khrcw2/attachments/9mmsuppressor.mdl", bone = "Weapon", rel = "", pos = Vector(2.06, -16.1, 3.28), angle = Angle(0, -90, 0), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritfront"] = { type = "Model", model = "models/khrcw2/attachments/tritfront.mdl", bone = "Slide", rel = "", pos = Vector(1.656, -11.38, .775), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritback"] = { type = "Model", model = "models/khrcw2/attachments/tritback.mdl", bone = "Slide", rel = "", pos = Vector(1.66, -12.30, -1.705), angle = Angle(12.857, -90, .45), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritfrontpmm"] = { type = "Model", model = "models/khrcw2/attachments/tritfront.mdl", bone = "Slide", rel = "", pos = Vector(1.656, -12.64, .665), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritbackpmm"] = { type = "Model", model = "models/khrcw2/attachments/tritback.mdl", bone = "Slide", rel = "", pos = Vector(1.66, -12.30, -1.805), angle = Angle(12.857, -90, .45), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

SWEP.MuzzleVelocity = 480 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.MagBGs = {main = 1, none = 0, ext = 1}
SWEP.BodyBGs = {main = 0, full = 0, compact = 1}

SWEP.Attachments = {[3] = {header = "Suppressor", offset = {-150, -500}, atts = {"md_gemtechmm"}},
[5] = {header = "Ironsight", offset = {300, -250}, atts = {"md_tritiumis","md_tritiumispmm"}},
[6] = {header = "Round", offset = {700, -350}, atts = {"md_cz52barrel"}},
[4] = {header = "Style", offset = {150, 400}, atts = {"md_cz52silver", "md_cz52chrome"}},
[1] = {header = "Model", offset = {-550, -300}, atts = {"bg_cz52compact"}},
[2] = {header = "Magazine", offset = {-350, 150}, atts = {"bg_cz52ext"}},
["+reload"] = {header = "Ammo", offset = {550, 150}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"base_fire","base_fire2","base_fire3"},
    fire_dry = "base_firelast",
	reload_empty = "base_reloadempty",
	reload = "base_reload",
	idle = "base_idle",
	draw = "base_ready"}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_FOLEY_LIGHT"},
		{time = 10/30, sound = "KHRMAK_SAFETY"},
		{time = 13/30, sound = "KHRMAK_BOLTBACK"},
		{time = 19/30, sound = "KHRMAK_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_FOLEY_LIGHT"},
	},

	base_reload = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
	},

	base_reload_extmag = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
	},

	base_reloadempty = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
		{time = 71/30, sound = "KHRMAK_BOLTRELEASE"},
	},

	base_reloadempty_extmag = {
		{time = 8/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 14/30, sound = "KHRMAK_MAGOUT"},
		{time = 39/30, sound = "KHRMAK_MAGIN"},
		{time = 60/30, sound = "KHRMAK_MAGHIT"},
		{time = 71/30, sound = "KHRMAK_BOLTRELEASE"},
	},
}

SWEP.SpeedDec = 10

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
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/pistols/cz52.mdl"
SWEP.WorldModel		= "models/khrcw2/pistols/w_cz52.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x25MM"

SWEP.FireDelay = 60/500
SWEP.FireSound = "KHRCZ_FIRE"
SWEP.FireSoundSuppressed = "KHRCZ_FIRE_SUPPRESSED"
SWEP.Recoil = 1.03
SWEP.FOVPerShot = 0.25

SWEP.HipSpread = 0.037
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.0085
SWEP.SpreadCooldown = 0.24
SWEP.Shots = 1
SWEP.Damage = 25
SWEP.DeployTime = 1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.45
SWEP.ReloadHalt = 2.45

SWEP.ReloadTime_Empty = 2.75
SWEP.ReloadHalt_Empty = 2.75

SWEP.SnapToIdlePostReload = false

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