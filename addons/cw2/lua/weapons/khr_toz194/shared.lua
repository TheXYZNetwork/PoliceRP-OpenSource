AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "TOZ-194"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.5
	
	SWEP.IconLetter = "k"
	killicon.Add( "khr_toz194", "icons/select/khr_toz194", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_toz194")
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.1
	
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
	
	SWEP.EffectiveRange_Orig = 32 * 39.37
	SWEP.DamageFallOff_Orig = .49
	
	SWEP.IronsightPos = Vector(-2.008, 0, 0.92)
	SWEP.IronsightAng = Vector(-0.065, 0.023, 0)
	
	SWEP.MicroT1Pos = Vector(-2.016, 0, .62)
	SWEP.MicroT1Ang = Vector(-1, 0.023, 0)
	
	SWEP.EoTech553Pos = Vector(-2, 0, .52)
	SWEP.EoTech553Ang = Vector(-1, .023, 0)	
	
	SWEP.CSGOACOGPos = Vector(0, 0, 0)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-2.008, 0, .568)
	SWEP.KR_CMOREAng =  Vector(-1, .018, 0)
	
	SWEP.ShortDotPos = Vector(0, 0, 0)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(0, 0, 0)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.6, 0, -1.601)
	SWEP.SprintAng = Vector(-12.664, 22.513, -9.146)
		
	SWEP.CustomizePos = Vector(4.36, 0, -3.36)
	SWEP.CustomizeAng = Vector(19.697, 22.513, 10.553)
	
	SWEP.AlternativePos = Vector(.5, 0, -.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.022
	SWEP.ReticleInactivityPostFire = .6

	SWEP.AttachmentModelsVM = {
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Weapon", rel = "", pos = Vector(0.157, -2.401, 0.05), angle = Angle(0, 90, 0), size = Vector(0.68, 0.68, 0.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Weapon", rel = "", pos = Vector(0, -3, 1.399), angle = Angle(0, 180, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Weapon", rel = "", pos = Vector(-0.051, -3, 1.35), angle = Angle(0, -90, 0), size = Vector(0.165, 0.165, 0.165), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Weapon", rel = "", pos = Vector(0.009, -1.5, 1.029), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fchoke"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Weapon", rel = "", pos = Vector(0, 16, 0.18), angle = Angle(0, 0, 0), size = Vector(0.389, 0.389, 0.389), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_mchoke"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Weapon", rel = "", pos = Vector(0, 16, 0.18), angle = Angle(0, 0, 0), size = Vector(0.389, 0.389, 0.389), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.MuzzleVelocity = 335 -- in meter/s
SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -250},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech"}},
	[2] = {header = "Barrel", offset = {-500, -400}, atts = {"md_mchoke", "md_fchoke"}},
	["+reload"] = {header = "Ammo", offset = {-500, 250}, atts = {"am_slugrounds2k", "am_flechetterounds2", "am_shortbuck"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.AttachmentExclusions = {
["md_mchoke"] = {"am_slugrounds2k"},
["md_fchoke"] = {"am_slugrounds2k"},
["am_slugrounds2k"] = {"md_mchoke", "md_fchoke"}
}
	
SWEP.Sounds = {shoot1 = {[1] = {time = 0.0, sound = "TOZ194.PUMPB"},
	[2] = {time = .17, sound = "TOZ194.PUMPF"}},
	
	start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "K620_INSERT"}},
	
	after_reload = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {[1] = {time = 0, sound = "KHRFAL.Draw"},
	[2] = {time = 0.7, sound = "TOZ194.PUMPB"},
	[3] = {time = 0.95, sound = "TOZ194.PUMPF"}}}
	

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_khrtoz194.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_khrtoz194.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 60/110
SWEP.FireSound = "TOZ194_FIRE"
SWEP.Recoil = 4.22

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.014
SWEP.VelocitySensitivity = 1.4
SWEP.MaxSpreadInc = 0.08
SWEP.ClumpSpread = 0.025
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.75
SWEP.RecoilToSpread = 1
SWEP.Shots = 5
SWEP.Damage = 17
SWEP.DeployTime = 1.5

SWEP.ReloadSpeed = .7
SWEP.ReloadStartTime = 0.3
SWEP.InsertShellTime = 0.47
SWEP.ReloadFinishWait = .4
SWEP.ShotgunReload = true

SWEP.Chamberable = false

SWEP.Offset = {
Pos = {
Up = 1,
Right = 1,
Forward = 0,
},
Ang = {
Up = 0,
Right = -6,
Forward = 180,
}
}

function SWEP:DrawWorldModel( )
        local hand, offset, rotate

        local pl = self:GetOwner()

        if IsValid( pl ) then
                        local boneIndex = pl:LookupBone( "ValveBiped.Bip01_R_Hand" )
                        if boneIndex then
                                local pos, ang = pl:GetBonePosition( boneIndex )
                                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up

                                ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
                                ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
                                ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )

                                self:SetRenderOrigin( pos )
                                self:SetRenderAngles( ang )
                                self:DrawModel()
                        end
        else
                self:SetRenderOrigin( nil )
                self:SetRenderAngles( nil )
                self:DrawModel()
        end
end

function SWEP:IndividualThink()
	self.EffectiveRange = 32 * 39.37
	self.DamageFallOff = .49
	self.ClumpSpread = .025
	self.Primary.ClipSize = 7
	self.Primary.ClipSize_Orig = 7
	
	if self.ActiveAttachments.am_slugrounds2k then
	self.EffectiveRange = ((self.EffectiveRange + 12.85 * 39.37))
	self.ClumpSpread = nil
	end
	if self.ActiveAttachments.am_flechetterounds2 then
	self.ClumpSpread = ((self.ClumpSpread - .0112))
	self.EffectiveRange = ((self.EffectiveRange - 2.57 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .049))
	end
	if self.ActiveAttachments.md_mchoke then
	self.ClumpSpread = ((self.ClumpSpread * .9))
	end
	if self.ActiveAttachments.md_fchoke then
	self.ClumpSpread = ((self.ClumpSpread * .8))
	end
	if self.ActiveAttachments.am_shortbuck then
	self.Primary.ClipSize = 10
	self.Primary.ClipSize_Orig = 10
	end
end