//Fixed & Optimized by AeroMatix || https://www.youtube.com/channel/UCzA_5QTwZxQarMzwZFBJIAw || http://steamcommunity.com/profiles/76561198176907257

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "AA12"
//SCK name: aa12
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	killicon.Add("cw_ws_aa12", "vgui/kill_icon/cw_ws_aa12", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kill_icon/cw_ws_aa12")
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0
	SWEP.InvertShellEjectAngle = true
	SWEP.ShellPosOffset = {x = 0, y = -0.5, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.6
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.65
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-4.7, 0, -0.83)
	SWEP.IronsightAng = Vector(0, -1, 0)

	SWEP.MicroT1Pos = Vector(-4.4, 0, -0.201)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-4.4, 0, -0.12)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-4.4, 0, -0.44)
	SWEP.AimpointAng = Vector(0, 0, 0)
			
	SWEP.ACOGPos = Vector(-4.54, 0, -0.5)
	SWEP.ACOGAng = Vector(0, -1.05, 0)

	
	//Knife Kitty's attachments'
	SWEP.CoD4ReflexPos = Vector(-4.4, 0, -0.141)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0) 
	
	//SWEP.HoloPos = Vector(-4.4, 0, -0.48)
	SWEP.HoloPos = Vector(-4.55, 0, -0.48)
	SWEP.HoloAng = Vector(0, -0.85, 0)
	
	SWEP.EoTech552Pos = Vector(-4.45, 0, -0.4)
	SWEP.EoTech552Ang = Vector(0, 0, 0)

	SWEP.EoTech553Pos = Vector(-4.4, 0, -0.101)
	SWEP.EoTech553Ang = Vector(0, 0, 0)
	
	SWEP.CoD4TascoPos = Vector(-4.5, 0, 0.4)
	SWEP.CoD4TascoAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-4.325, 0, 0)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.BackupReflexPos = Vector(-6.321, 0, 1.84)
	SWEP.BackupReflexAng = Vector(0, 0, -45)
	
	SWEP.CoD4ACOGPos = Vector(-4.4, 0, -0.4)
	SWEP.CoD4ACOGAng = Vector(0, 0, 0)
	SWEP.CoD4ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-4.54, 0, -1.961), [2] = Vector(0, -1.05, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "RW_Weapon", pos = Vector(25, -0.301, -1.201), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "RW_Weapon", pos = Vector(18.5, -1.101, 3.349), angle = Angle(0, 180, 90), size = Vector(0.699, 0.699, 0.699)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "RW_Weapon", pos = Vector(0, -0.151, 5.55), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), adjustment = {min = -2.2, max = 3, inverse = true, axis = "x", inverseOffsetCalc = true}},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "RW_Weapon", pos = Vector(-14, -0.45, -8.15), angle = Angle(0, 0, 0), size = Vector(1.25, 1.25, 1.25), adjustment = {min = -15.5, max = -12, inverse = true, axis = "x", inverseOffsetCalc = true}},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "RW_Weapon", pos = Vector(-9, 0.3, -3.201), angle = Angle(0, 90, 0), size = Vector(1.5, 1.5, 1.5), adjustment = {min = -10.65, max = -7.8, inverse = true, axis = "x", inverseOffsetCalc = true}},
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "RW_Weapon", rel = "", pos = Vector(3.5, -0.13, 4.675), angle = Angle(0, 0, 0), size = Vector(1.25, 1.25, 1.25), adjustment = {min = 2.2, max = 5.5, inverse = true, axis = "x", inverseOffsetCalc = true}},
		["md_backup_reflex_rail"] = { type = "Model", model = "models/c_angled_rails.mdl", bone = "RW_Weapon", rel = "", pos = Vector(18.5, 0.5, 3.2), angle = Angle(0, -180, -90), size = Vector(1.404, 1.404, 1.404)},
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint_rigged.mdl", bone = "RW_Weapon", rel = "", pos = Vector(5, -0.151, 4.25), angle = Angle(0, 0, 0), size = Vector(1.5, 1.5, 1.5), adjustment = {min = 2.5, max = 7, inverse = true, axis = "x", inverseOffsetCalc = true}},
		
		["md_fas2_holo_aim"] = { type = "Model", model = "models/v_holo_sight_orig_hx.mdl", bone = "RW_Weapon", rel = "", pos = Vector(-4, -0.101, -0.801), angle = Angle(0, 0, 0), size = Vector(1.1, 1.1, 1.1)},

		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "RW_Weapon", pos = Vector(-8, 0.3, -1.8), angle = Angle(0, 90, 0), size = Vector(1.25, 1.25, 1.25), adjustment = {min = -9, max = -6.5, inverse = true, axis = "x"}}
	}

	SWEP.CompM4SBoneMod = {
		["ard"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(31.445, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
	["ValveBiped.Bip01_L_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -118.889, 0) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -38.889, 12.222) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 80) },
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(25.555, -58.889, 1.11) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -41.112, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 12.222) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -21.112, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 1.667, -0.556), angle = Angle(0, 0, -14.445) },
	["ValveBiped.Bip01_L_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -112.223, 0) },
	["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -47.778, 0) },
	["ValveBiped.Bip01_L_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(32.222, -65.556, 0) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -27.778, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-30, 0, 32.222) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 2, forward = 1, pitch = 1,}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

//lua_run Entity(1):GetViewModel():SetBodygroup(4,1) 
//lua_run Entity(1):GetViewModel():SetBodygroup(2,1) 

SWEP.SightBGs = {main = 2, none = 1}
SWEP.BarrelBGs = {main = 8, long = 1, regular = 0}
SWEP.BagBGs = {main = 5, off = 0, on = 1}
SWEP.UnderRailBGs = {main = 4, off = 0, on = 1}
SWEP.MagBGs = {main = 3, regular = 0, drum = 1}
SWEP.GripBGs = {main = 1, regular = 0, grip = 1}
SWEP.AmmoHolderBGs = {main = 7, regular = 0, AmmoHolder = 1}
SWEP.LuaViewmodelRecoil = true
SWEP.ADSFireAnim = false

if CustomizableWeaponry_KK_HK416 then
SWEP.Attachments = {
	[1] = {header = "Sight", offset = {600, -500}, atts = {"md_microt1", "md_eotech", "md_fas2_eotech", "md_aimpoint", "md_fas2_aimpoint", "md_acog"}},
	[2] = {header = "Rail", offset = {-200, 0}, atts = {"md_anpeq15"}},
	[3] = {header = "Receiver", offset = {-200, -500}, atts = {"bg_aa12_longBarrel"}},
	[4] = {header = "Handguard", offset = {-200, 450}, atts = {"bg_aa12_grip", "md_foregrip"}},
	[5] = {header = "Magazine", offset = {600, 900}, atts = {"bg_aa12_drummag"}},
	[6] = {header = "Accessories", offset = {2000, 450}, atts = {"bg_aa12_ammobag"}},
	[7] = {header = "Frame", offset = {600, 500}, atts = {"bg_aa12_AmmoHolder"}},
	["impulse 100"] = {header = "Cameo", offset = {1100, 450}, atts = {"skin_aa12_digital"}}, //skin_aa12_buster
	["+reload"] = {header = "Ammo", offset = {1500, 0}, atts = {"am_slugrounds", "am_flechetterounds"}}}
	if CustomizableWeaponry_WS_AA12_BUSTER then
		table.insert( SWEP.Attachments["impulse 100"].atts, 2, "skin_aa12_buster" )
	end
else
SWEP.Attachments = {
	[1] = {header = "Sight", offset = {600, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Rail", offset = {-200, 0}, atts = {"md_anpeq15"}},
	[3] = {header = "Receiver", offset = {-200, -500}, atts = {"bg_aa12_longBarrel"}},
	[4] = {header = "Handguard", offset = {-200, 450}, atts = {"bg_aa12_grip", "md_foregrip"}},
	[5] = {header = "Magazine", offset = {600, 900}, atts = {"bg_aa12_drummag"}},
	[6] = {header = "Accessories", offset = {2000, 450}, atts = {"bg_aa12_ammobag"}},
	[7] = {header = "Frame", offset = {600, 500}, atts = {"bg_aa12_AmmoHolder"}},
	["impulse 100"] = {header = "Cameo", offset = {1100, 450}, atts = {"skin_aa12_digital"}},
	["+reload"] = {header = "Ammo", offset = {1500, 0}, atts = {"am_slugrounds", "am_flechetterounds"}}}
	if CustomizableWeaponry_WS_AA12_BUSTER then
		table.insert( SWEP.Attachments["impulse 100"].atts, 2, "skin_aa12_buster" )
	end
end

SWEP.Animations = {fire = "fire",
	//reload = "base_reloadpart",
	reload = "base_reload_Mag",
	//reload_empty = "base_reload",
	reload_empty = "base_reload_Mag2",
	idle = "idle",
	draw = "draw"
}
	
SWEP.Sounds = {
	draw = {{time = 0.05, sound = "CW_WS_AA12_DRAW"}},
	
	base_reload_Mag = {{time = 0.85, sound = "CW_WS_AA12_CLIPOUT"},
	{time = 4, sound = "CW_WS_AA12_CLIPIN"}},

	base_reload_Mag2 = {{time = 0.85, sound = "CW_WS_AA12_CLIPOUT"},
	{time = 3.25, sound = "CW_WS_AA12_CLIPIN"},
	{time = 4.15, sound = "CW_WS_AA12_BOLTPULL"},
	{time = 4.5, sound = "CW_WS_AA12_BOLTRELEASE"},
	},
	
	base_reloadpart = {{time = 0.85, sound = "CW_WS_AA12_CLIPOUT"},
	{time = 4, sound = "CW_WS_AA12_CLIPIN"}},

	base_reload = {{time = 0.85, sound = "CW_WS_AA12_CLIPOUT"},
	{time = 3.25, sound = "CW_WS_AA12_CLIPIN"},
	{time = 4.15, sound = "CW_WS_AA12_BOLTPULL"},
	{time = 4.5, sound = "CW_WS_AA12_BOLTRELEASE"},
	},
	
}

SWEP.AttachmentExclusions = {
["bg_aa12_drummag"] = {"bg_aa12_ammobag"},
["bg_aa12_ammobag"] = {"bg_aa12_drummag"},
} 


SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/cw2/v_ws_aa12.mdl"
SWEP.WorldModel		= "models/weapons/cw2/w_ws_aa12.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/cw2/w_ws_aa12.mdl"
SWEP.WMPos = Vector(-1, -1.5, 1)
SWEP.WMAng = Vector(0, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_WS_AA12_FIRE"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
//Do not forget to edit damage and add mag system
SWEP.Damage =  9 //25
SWEP.DeployTime = 1
SWEP.magType = "brMag"

SWEP.ReloadSpeed = 1.8
SWEP.ReloadTime = 7
SWEP.ReloadTime_Empty = 7
SWEP.ReloadHalt = 0
SWEP.ReloadHalt_Empty = 0
SWEP.SnapToIdlePostReload = false

SWEP.Chamberable = false

function SWEP:IndividualThink()
local ammo = self:Ammo1()
	if self.ActiveAttachments.bg_aa12_AmmoHolder then
		if ammo == 1 then
			self:setBodygroup(9,1)
			self:setBodygroup(10,0)
			self:setBodygroup(11,0)
			self:setBodygroup(12,0)
			self:setBodygroup(13,0)
			self:setBodygroup(14,0)
						if self.WMEnt then
				self.WMEnt:SetBodygroup(9,1)
				self.WMEnt:SetBodygroup(10,0) 
				self.WMEnt:SetBodygroup(11,0) 
				self.WMEnt:SetBodygroup(12,0) 
				self.WMEnt:SetBodygroup(13,0) 
				self.WMEnt:SetBodygroup(14,0) 
			end
		elseif ammo == 2 then
			self:setBodygroup(9,1)
			self:setBodygroup(10,1)
			self:setBodygroup(11,0)
			self:setBodygroup(12,0)
			self:setBodygroup(13,0)
			self:setBodygroup(14,0)
						if self.WMEnt then
				self.WMEnt:SetBodygroup(9,1)
				self.WMEnt:SetBodygroup(10,1) 
				self.WMEnt:SetBodygroup(11,0) 
				self.WMEnt:SetBodygroup(12,0) 
				self.WMEnt:SetBodygroup(13,0) 
				self.WMEnt:SetBodygroup(14,0) 
			end
		elseif ammo == 3 then
			self:setBodygroup(9,1)
			self:setBodygroup(10,1)
			self:setBodygroup(11,1)
			self:setBodygroup(12,0)
			self:setBodygroup(13,0)
			self:setBodygroup(14,0)
						if self.WMEnt then
				self.WMEnt:SetBodygroup(9,1)
				self.WMEnt:SetBodygroup(10,1) 
				self.WMEnt:SetBodygroup(11,1) 
				self.WMEnt:SetBodygroup(12,0) 
				self.WMEnt:SetBodygroup(13,0) 
				self.WMEnt:SetBodygroup(14,0) 
			end
		elseif ammo == 4 then
			self:setBodygroup(9,1)
			self:setBodygroup(10,1)
			self:setBodygroup(11,1)
			self:setBodygroup(12,1)
			self:setBodygroup(13,0)
			self:setBodygroup(14,0)
						if self.WMEnt then
				self.WMEnt:SetBodygroup(9,1)
				self.WMEnt:SetBodygroup(10,1) 
				self.WMEnt:SetBodygroup(11,1) 
				self.WMEnt:SetBodygroup(12,1) 
				self.WMEnt:SetBodygroup(13,0) 
				self.WMEnt:SetBodygroup(14,0) 
			end
		elseif ammo == 5 then
			self:setBodygroup(9,1)
			self:setBodygroup(10,1)
			self:setBodygroup(11,1)
			self:setBodygroup(12,1)
			self:setBodygroup(13,1)
			self:setBodygroup(14,0)
						if self.WMEnt then
				self.WMEnt:SetBodygroup(9,1)
				self.WMEnt:SetBodygroup(10,1) 
				self.WMEnt:SetBodygroup(11,1) 
				self.WMEnt:SetBodygroup(12,1) 
				self.WMEnt:SetBodygroup(13,1) 
				self.WMEnt:SetBodygroup(14,0) 
			end
		elseif ammo >= 6 then
			self:setBodygroup(9,1)
			self:setBodygroup(10,1)
			self:setBodygroup(11,1)
			self:setBodygroup(12,1)
			self:setBodygroup(13,1)
			self:setBodygroup(14,1)
			if self.WMEnt then
				self.WMEnt:SetBodygroup(9,1)
				self.WMEnt:SetBodygroup(10,1) 
				self.WMEnt:SetBodygroup(11,1) 
				self.WMEnt:SetBodygroup(12,1) 
				self.WMEnt:SetBodygroup(13,1) 
				self.WMEnt:SetBodygroup(14,1) 
			end
		else
			self:setBodygroup(9,0)
			self:setBodygroup(10,0)
			self:setBodygroup(11,0)
			self:setBodygroup(12,0)
			self:setBodygroup(13,0)
			self:setBodygroup(14,0)
			if self.WMEnt then
				self.WMEnt:SetBodygroup(9,0)
				self.WMEnt:SetBodygroup(10,0) 
				self.WMEnt:SetBodygroup(11,0) 
				self.WMEnt:SetBodygroup(12,0) 
				self.WMEnt:SetBodygroup(13,0) 
				self.WMEnt:SetBodygroup(14,0) 
			end
		end
	else
		self:setBodygroup(9,0)
		self:setBodygroup(10,0)
		self:setBodygroup(11,0)
		self:setBodygroup(12,0)
		self:setBodygroup(13,0)
		self:setBodygroup(14,0)
		if self.WMEnt then
			self.WMEnt:SetBodygroup(9,0)
			self.WMEnt:SetBodygroup(10,0) 
			self.WMEnt:SetBodygroup(11,0) 
			self.WMEnt:SetBodygroup(12,0) 
			self.WMEnt:SetBodygroup(13,0) 
			self.WMEnt:SetBodygroup(14,0) 
		end
	end

	if self.ActiveAttachments.bg_aa12_drummag then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(3,1) 
		end
		self.Animations.reload = "base_reloadpart"
		self.Animations.reload_empty = "base_reload"
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(3,0) 
		end
		self.Animations.reload = "base_reload_Mag"
		self.Animations.reload_empty = "base_reload_Mag2"
	end

	if self.ActiveAttachments.bg_aa12_ammobag then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(4,1) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(4,0) 
		end
	end

	if self.ActiveAttachments.bg_aa12_grip then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(1,1) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(1,0) 
		end
	end

	if self.ActiveAttachments.bg_aa12_longBarrel then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(8,1) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(8,0) 
		end
	end

	if self.ActiveAttachments.md_foregrip then
		self:setBodygroup(self.UnderRailBGs.main, self.UnderRailBGs.on)
	else
		self:setBodygroup(self.UnderRailBGs.main, self.UnderRailBGs.off)
	end

	if self.ActiveAttachments.bg_aa12_AmmoHolder and not self:isAttachmentActive("sights") then
		self:setBodygroup(6, 1)
	else
		self:setBodygroup(6, 0)
	end

	if self:isAttachmentActive("sights") or self.ActiveAttachments.bg_aa12_AmmoHolder then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(2,1) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(2,0) 
		end
	end

	if self.ActiveAttachments.md_microt1 then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(5,1) 
		end
	elseif self.ActiveAttachments.md_eotech or self.ActiveAttachments.md_fas2_eotech then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(5,2) 
		end
	elseif self.ActiveAttachments.md_aimpoint or self.ActiveAttachments.md_fas2_aimpoint then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(5,3) 
		end
	elseif self.ActiveAttachments.md_acog then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(5,4) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(5,0) 
		end
	end


	if self.ActiveAttachments.md_anpeq15 then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(6,1) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(6,0) 
		end
	end
	if self.ActiveAttachments.md_foregrip then
		if self.WMEnt then
			self.WMEnt:SetBodygroup(7,1) 
		end
	else
		if self.WMEnt then
			self.WMEnt:SetBodygroup(7,0) 
		end
	end

end

function SWEP:buildBoneTable()
local vm = self.CW_VM

for i = 0, vm:GetBoneCount() - 1 do
local boneName = vm:GetBoneName(i)
local bone

if boneName then
bone = vm:LookupBone(boneName)
end

-- some ins models have [__INVALIDBONE__]s so to prevent nilpointerexceptions bone = 1
self.vmBones[i + 1] = {boneName = boneName, bone = i, curPos = Vector(0, 0, 0), curAng = Angle(0, 0, 0), targetPos = Vector(0, 0, 0), targetAng = Angle(0, 0, 0)}
end
end