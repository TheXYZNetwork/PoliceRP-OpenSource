AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("7.62×54mmR", "7.62×51mm", 8.58, 69.20)

SWEP.PrintName = "SV-98"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "r"
	killicon.AddFont("cw_l115", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.ZoomTextures = {{tex = surface.GetTextureID("sprites/scope_leo"), offset = {0, 1}}}
	SWEP.SimpleTelescopicsFOV = 75
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellDelay = 0.7
	SWEP.ShellPosOffset = {x = 3, y = -3, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	SWEP.OverrideAimMouseSens = 0.667
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_sv98_scopeless.mdl"
	SWEP.WMPos = Vector(-1, 0, 1.75)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.77, -3.701, 1.299)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-2.77, -0.5, 0.75)
	SWEP.NXSAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.77, -2.5, 0.45)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.77, -1, 0.6)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.756, 0.236, 0.236)
	SWEP.SprintAng = Vector(-14.606, 52.638, 0.275)
	
	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.77, -3.701, 1.299), [2] = Vector(0, -0.008, 0)}}
	
	SWEP.AimBreathingEnabled = true
	SWEP.CrosshairEnabled = false
	SWEP.AimViewModelFOV = 40
	
	SWEP.HipFireFOVIncrease = false

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.RTAlign = {right = 1.2, up = 0.25, forward = 0}
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.OverallMouseSens = 0.7
	
	SWEP.AttachmentModelsVM = {
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Base", pos = Vector(-0.071, -1, 1.35), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Base", pos = Vector(-0.322, -5.5, -5), angle = Angle(0, -90, 0), size = Vector(0.93, 0.93, 0.93)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", pos = Vector(-0.042, 0, -2.55), angle = Angle(0, 0, 0), size = Vector(0.785, 1.25, 0.785)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Base", pos = Vector(-0.352, -5.5, -5.5), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_bipod"] = {model = "models/wystan/attachments/bipod.mdl", bone = "Base", pos = Vector(0.05, 7.75, -2.55), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), bodygroup = {[1] = 1}}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

end



SWEP.MuzzleVelocity = 936 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true
SWEP.PreventQuickScoping = true
SWEP.QuickScopeSpreadIncrease = 0.2

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_schmidt_shortdot", "md_acog", "md_nightforce_nxs"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_saker"}},
	[3] = {header = "Ammo", offset = {800, 200}, atts = {"am_svmatch", "am_svmag"}}}

SWEP.Animations = {fire = {"fire"},
	reload = "full_reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {fire = {{time = 0.3, sound = "CW_SV98_BOLTUP"},
		{time = 0.6, sound = "CW_SV98_BOLTPULL"},
		{time = 0.9, sound = "CW_SV98_BOLTDOWN"}},

		draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

		reload = {{time = 0.4, sound = "CW_SV98_MAGOUT"},
		{time = 0.7, sound = "CW_SV98_LATCH"},
		{time = 1.47, sound = "CW_FOLEY_LIGHT"},
		{time = 2, sound = "CW_SV98_MAGIN"},
		{time = 2.86, sound = "CW_SV98_BOLTPUSH"},
		{time = 3.15, sound = "CW_SV98_BOLTPULL"},
		{time = 3.3, sound = "CW_FOLEY_LIGHT"}},
	
		full_reload = {{time = 0.4, sound = "CW_SV98_MAGOUT"},
		{time = 0.7, sound = "CW_SV98_LATCH"},
		{time = 1.47, sound = "CW_FOLEY_LIGHT"},
		{time = 2, sound = "CW_SV98_MAGIN"}},}
--omg sound is FUBAR what did i do

SWEP.SpeedDec = 55

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_sv98_scopeless.mdl"
SWEP.WorldModel		= "models/weapons/w_sv98_scopeless.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54mmR"

SWEP.FireDelay = 1.5
SWEP.FireSound = "CW_SV98_FIRE"
SWEP.FireSoundSuppressed = "CW_SV98_FIRE_SUPPRESSED"
SWEP.Recoil = 2.65

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 2.5
SWEP.MaxSpreadInc = 0.2
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 1.55
SWEP.Shots = 1
SWEP.Damage = 160
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 3.25
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 3.25
SWEP.ReloadHalt_Empty = 3.5

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("sprites/scope_leo")

	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true

	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 3
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false

	function SWEP:RenderTargetFunc()
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self.dt.State == CW_AIMING then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()

		ang = self:getTelescopeAngles()
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.RTAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.RTAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.RTAlign.forward)
		end
		
		local size = self:getRenderTargetSize()

		cd.w = size
		cd.h = size
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, size, size)
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

--Crotch Gun Fix
SWEP.Offset = {
Pos = {
Up = 0,
Right = 1,
Forward = -3,
},
Ang = {
Up = 0,
Right = 0,
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