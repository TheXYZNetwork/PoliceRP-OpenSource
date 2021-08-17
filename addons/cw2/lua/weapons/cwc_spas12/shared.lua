//Made by AeroMatix || https://www.youtube.com/channel/UCzA_5QTwZxQarMzwZFBJIAw || http://steamcommunity.com/profiles/76561198176907257

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "SPAS-12"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "q"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_shotgun"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_franchi_spas12.mdl"
	SWEP.WMPos = Vector(-1, 1.5, -1.2)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.ShellPosOffset = {x = 0, y = 1, z = -1}
	SWEP.ForeGripOffsetCycle_Draw = 0.1
	SWEP.ForeGripOffsetCycle_Reload = 1
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.1
	SWEP.FireMoveMod = 1
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	SWEP.M203Pos = Vector(-0.6, -1.0, 0.9)
	SWEP.M203Ang = Vector(0, 0, 0)
		
	SWEP.IronsightPos = Vector(-2.603, -3, 1.58)
	SWEP.IronsightAng = Vector(0.026, 0.083, 0)
	
	SWEP.MicroT1Pos = Vector(-2.618, -4.803, 0.25)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.613, -4.803, -0.06)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.613, -4.803, 0.064)
	SWEP.AimpointAng = Vector(0, 0, 0)
			
	SWEP.ACOGPos = Vector(-2.599, -4.803, -0.109)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(5.724, 0, 1.139)
	SWEP.SprintAng = Vector(-20.15, 36.56, -6.604)
		
	SWEP.CustomizePos = Vector(4.001, 0, 0.125)
	SWEP.CustomizeAng = Vector(6.234, 29.319, 0)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.274, -2.335, -1.85), [2] = Vector(0, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	
	SWEP.AlternativePos = Vector(-0.8, 0, -0.3)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.LuaViewmodelRecoil = true
	SWEP.LuaVMRecoilAxisMod = {vert = 0.2, hor = -1, roll = 3, forward = 2, pitch = -0.2}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.BoltBone = "Spas_Bolt"
	SWEP.BoltShootOffset = Vector(-5, 0, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		-- ["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Spas_Bolt", rel = "", pos = Vector(-0.452, -2.556, -1.428), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_surefire"] = {model = "models/weapons/upgraded/a_flashlight_rail.mdl", bone = "Spas_Foregrip", pos = Vector(-2.25, -21, 3.8), angle = Angle(0, 90, 180), size = Vector(1.1, 1.1, 1.1)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Spas_Foregrip", pos = Vector(-1.3, -20, 3), angle = Angle(0, -90, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "Spas_Foregrip", pos = Vector(0, -1, 0.47), angle = Angle(0, 90, 180), size = Vector(1, 1, 1), animated = true},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.325, -12, 0), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699)}
	}
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.3, 2, 1.86), angle = Angle(0, 0, 0) }
	}
	
		-- SWEP.ForeGripHoldPos = {
		-- ["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 42.713, 0) },
		-- ["Bip01 L Clavicle"] = {pos = Vector(1, 2.5, -0.79), angle = Angle(-45, 11.843, 0) },
		-- ["Bip01 L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		-- ["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 71.308, 0) },
		-- ["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.795, 0) },
		-- ["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.148, 0) },
		-- ["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(6.522, 83.597, 0) },
		-- ["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(23.2, 16.545, 0) },
		-- ["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 31.427, 0) },
		-- ["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 29.565, 0) },
		-- ["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(9.491, 34.793, 25.926) },
		-- ["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, -9.195, 0) },
		-- ["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 10.164, 0) },
		-- ["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.395, 0) },
		-- ["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(2.411, 57.007, 0) }
	-- }
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Silencer", offset = {800, -300}, atts = {"md_saker"}},
	[2] = {header = "LAM", offset = {-400, -500}, atts = {"md_anpeq15"}},
	[3] = {header = "", offset = {150, 400}, atts = {"md_m203"}},
	["+reload"] = {header = "Ammo", offset = {-300, 300}, atts = {"am_slugrounds", "am_flechetterounds"}}}

SWEP.Animations = {fire1 = {"shoot1"},
	fire1_aim = {"shoot2"},
	fire1_alt = "idle",
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CWC_FOLEY_LIGHT"}},

	insert = {{time = 0.0, sound = "CWC_FOLEY_TOSS"},
	{time = 0.15, sound = "CWC_SPAS12_INSERT"}},

	shoot1 = {{time = 0.24, sound = "CWC_SPAS12_PUMPBACK"},
	{time = 0.45, sound = "CWC_SPAS12_PUMPFORWARD"}},

	shoot2 = {{time = 0.27, sound = "CWC_SPAS12_PUMPBACK"},
	{time = 0.45, sound = "CWC_SPAS12_PUMPFORWARD"}},
	
	after_reload = {{time = 0.15, sound = "CWC_SPAS12_PUMPBACK"},
	{time = 0.35, sound = "CWC_SPAS12_PUMPFORWARD"},
	{time = 0.6, sound = "CWC_FOLEY_LIGHT"}},
	
	draw = {{time = 0, sound = "CWC_FOLEY_MEDIUM"},
	{time = 0.1, sound = "CWC_SPAS12_DRAW"},
	{time = 0.55, sound = "CWC_SPAS12_PUMPBACK"},
	{time = 0.76, sound = "CWC_SPAS12_PUMPFORWARD"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= "AeroMatix"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_franchi_spas12.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_franchi_spas12.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.6
SWEP.FireSound = "CWC_SPAS12_FIRE"
SWEP.FireSoundSuppressed = "CWC_SPAS12_FIRESIL"
SWEP.Recoil = 2

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.03
SWEP.SpreadPerShot = 0.24
SWEP.SpreadCooldown = 0.1
SWEP.Shots = 12
SWEP.Damage = 15
SWEP.DeployTime = 0.7

SWEP.ReloadSpeed = 1.5
SWEP.ReloadStartTime = 0.6
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 0.7
SWEP.ShotgunReload = true

SWEP.Chamberable = false
SWEP.FullAimViewmodelRecoil = true


function SWEP:IndividualThink()

		if self.ActiveAttachments.md_m203 then
		self.ADSSpeed = 0.5
		self.AlternativePos = Vector(-1, -1, -1)
		self.AlternativeAng = Vector(0, 0, 0)
		self.ReloadSpeed = 1.2
		self.Trivia = {text = "BECAUSE WHY NOT.", x = -450, y = 180}
		else
		self.ADSSpeed = 1.3
		self.AlternativePos = Vector(-0.8, 0, -0.3)
		self.AlternativeAng = Vector(0, 0, 0)
		self.ReloadSpeed = 1.5
		self.Trivia = {text = "", x = -50000, y = -360}
		end

if self.ActiveAttachments.md_surefire then
	self.LaserPosAdjust = Vector(0, 0, -0.7)
	self.LaserAngAdjust = Angle(0, 0, 0) 
else
	self.LaserPosAdjust = Vector(1, 0, 0)
	self.LaserAngAdjust = Angle(0, 180, 0) 
end

	if self.FireMode == "semi" then
		self.BoltShootOffset = Vector(-5, 0, 0)
		self.SpreadPerShot = 0.3
		self.ShellDelay = 0.0
		self.FireDelay = 0.2
		self.LuaViewmodelRecoil = true
		self.ADSFireAnim = false
		self.LuaViewmodelRecoilOverride = false
	else
		self.BoltShootOffset = Vector(0, 0, 0)
		self.SpreadPerShot = 0.24
		self.ShellDelay = 0.3
		if self.ActiveAttachments.md_m203 then
		self.FireDelay = 1.3
		else
		self.FireDelay = 0.65
		end
		self.LuaViewmodelRecoil = true
		self.ADSFireAnim = true
		self.LuaViewmodelRecoilOverride = true
	end
	
	if self:isAiming() then
		self.NormalHoldType = "ar2"
		if self.FireMode == "semi" then
		self.LuaVMRecoilAxisMod = {vert = 0, hor = 0.3, roll = 0, forward = 0.3, pitch = -0.5}
		else
		self.LuaVMRecoilAxisMod = {vert = 0, hor = 0.2, roll = 3, forward = -1, pitch = -1}
		end
	else
		self.NormalHoldType = "shotgun"
		if self.FireMode == "semi" then
		self.LuaVMRecoilAxisMod = {vert = 0, hor = 3, roll = 0, forward = 1.8, pitch = 1.8}
		else
		self.LuaVMRecoilAxisMod = {vert = 0, hor = 3, roll = 0, forward = 1.5, pitch = 1.5}
		end
	end
end



function SWEP:fireAnimFunc()
	clip = self:Clip1()
	if self.ActiveAttachments.md_m203 then
	cycle = 0
	rate = 0.72
	else
	cycle = 0
	rate = 1.2
	end
	anim = "safe"
	prefix = ""
	suffix = ""
	
	if self.FireMode == "semi" then
		suffix = suffix .. "_alt"
		cycle = self.ironFireAnimStartCycle
	end
	
	if self:isAiming() then
	clip = self:Clip1()
	if self.ActiveAttachments.md_m203 then
	cycle = 0
	rate = 0.7
	else
	cycle = 0
	rate = 1
	end
	anim = "safe"
	prefix = ""
	if self.FireMode == "semi" then
	suffix = "_alt"
	else
	suffix = "_aim"
	end
	end
	
	self:sendWeaponAnim(prefix .. "fire1" .. suffix, rate, cycle)
end //*/