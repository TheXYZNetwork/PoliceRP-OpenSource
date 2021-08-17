AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo(".338 Lapua", ".338 Lapua", 8.58, 69.20)
SWEP.PrintName = "L115"
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
	SWEP.ShellPosOffset = {x = 0, y = -2, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	SWEP.OverrideAimMouseSens = 0.2
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cstm_l96.mdl"
	SWEP.WMPos = Vector(-1, 0, 1.75)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.678, -1, 0.15)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AimBreathingEnabled = true
	SWEP.CrosshairEnabled = false
	SWEP.AimViewModelFOV = 40
	
	SWEP.HipFireFOVIncrease = false

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.RTAlign = {right = 1.2, up = 0.25, forward = 0}
	
	SWEP.OverallMouseSens = 0.7
end

SWEP.MuzzleVelocity = 936 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true
SWEP.PreventQuickScoping = true
SWEP.QuickScopeSpreadIncrease = 0.2

SWEP.Attachments = {}

SWEP.Animations = {fire = {"shot"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {shot = {{time = 0.5, sound = "CW_L96_BOLTUP"},
		{time = 0.7, sound = "CW_L96_BOLTPULL"},
		{time = 1, sound = "CW_L96_BOLTPUSH"},
		{time = 1.35, sound = "CW_L96_BOLTDOWN"}},

	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {{time = 0.17, sound = "CW_L96_BOLTUP"},
		{time = 0.29, sound = "CW_L96_BOLTPULL"},
		
	{time = 1.1, sound = "CW_L96_MAGOUT"},
	{time = 1.47, sound = "CW_FOLEY_LIGHT"},
	{time = 2, sound = "CW_L96_MAGIN"},
	{time = 2.86, sound = "CW_L96_BOLTPUSH"},
	{time = 3.15, sound = "CW_L96_BOLTDOWN"},
	{time = 3.3, sound = "CW_FOLEY_LIGHT"}}
}

SWEP.SpeedDec = 50

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
SWEP.ViewModel		= "models/cw2/rifles/l96.mdl"
SWEP.WorldModel		= "models/weapons/w_cstm_l96.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay = 1.5
SWEP.FireSound = "CW_L96_FIRE"
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 2.5
SWEP.MaxSpreadInc = 0.2
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 1.55
SWEP.Shots = 1
SWEP.Damage = 110
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.42
SWEP.ReloadTime_Empty = 2.42
SWEP.ReloadHalt = 3.48
SWEP.ReloadHalt_Empty = 3.48

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