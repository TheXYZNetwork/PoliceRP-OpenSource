surface.CreateFont("CW_HUD72", {font = "Prototype", size = 72, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD60", {font = "Prototype", size = 60, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD52", {font = "Prototype", size = 52, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD48", {font = "Prototype", size = 48, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD40", {font = "Prototype", size = 40, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD38", {font = "Prototype", size = 38, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD36", {font = "Prototype", size = 36, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD32", {font = "Prototype", size = 32, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD28", {font = "Prototype", size = 28, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD24", {font = "Prototype", size = 24, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD22", {font = "Prototype", size = 22, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD20", {font = "Prototype", size = 20, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD16", {font = "Prototype", size = 16, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD14", {font = "Prototype", size = 14, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_HUD12", {font = "Prototype", size = 12, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_KillIcons", {font = "csd", size = ScreenScale(20), weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_SelectIcons", {font = "csd", size = ScreenScale(60), weight = 500, blursize = 0, antialias = true, shadow = false})

surface.CreateFont("CW_KillIcons2", {font = "HalfLife2", size = ScreenScale(30), weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CW_SelectIcons2", {font = "HalfLife2", size = ScreenScale(60), weight = 500, blursize = 0, antialias = true, shadow = false})

local Deploy, UnDeploy = surface.GetTextureID("cw2/gui/bipod_deploy"), surface.GetTextureID("cw2/gui/bipod_undeploy")
local deployedOnObject = surface.GetTextureID("cw2/gui/deployonobject")
local scopeTemplate = surface.GetTextureID("cw2/gui/scope_template")

SWEP.CrossAmount = 0
SWEP.CrossAlpha = 255
SWEP.FadeAlpha = 0
SWEP.AimTime = 0

local ClumpSpread = surface.GetTextureID("cw2/gui/clumpspread_ring")
local Bullet = surface.GetTextureID("cw2/gui/bullet")
local GLCrosshair = surface.GetTextureID("cw2/gui/crosshair_gl")
local Vignette = surface.GetTextureID("cw2/effects/vignette")

local White, Black = Color(255, 255, 255, 255), Color(0, 0, 0, 255)
local x, y, x2, y2, lp, size, FT, CT, tr, x3, x4, y3, y4, UCT, sc1, sc2
local td = {}

local surface = surface
local math = math
local draw = draw
local dst = draw.SimpleText

SWEP.HUD_HealthTextColor = Color(255, 255, 255, 255)
SWEP.HUD_MagTextColor = Color(255, 255, 255, 255)
SWEP.HUD_ReserveTextColor = Color(255, 255, 255, 255)
SWEP.HUD_MagText = "MAG: "
SWEP.HUD_BreathAlpha = 1

function draw.ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
	dst(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
	dst(text, font, x, y, colortext, xalign, yalign)
end

-- pre-define strings to not generate them every frame and make life unbearable for gc
local cwhud24 = "CW_HUD24"
local cwhud22 = "CW_HUD22"
local cwhud20 = "CW_HUD20"
local cwhud16 =	"CW_HUD16"
local cwhud14 = "CW_HUD14"


function SWEP:crosshairVisible()
	-- not visible if we're aiming
	if self.dt.State == CW_AIMING and self.FadeCrosshairOnAim then
		return false
	end
	
	-- or are in an inactive state (action in progress/running)
	if self.InactiveWeaponStates[self.dt.State] then
		return false
	end

	-- or have safety turned on
	if self.dt.Safe then
		return false
	end
	
	-- or are in a vehicle
	if self.Owner:InVehicle() then
		return false 
	end
	
	-- or are near a wall
	if self.NearWall then
		return false
	end
	
	-- or are reloading the weapon
	if (self.IsReloading or self.IsFiddlingWithSuppressor) and self.Cycle <= 0.9 then
		return false
	end
	
	-- or are reloading the M203
	if self.reloadingM203 then
		return false
	end

	return true
end

function SWEP:drawClumpSpread(x, y, spread, alpha)
	if not spread then
		return
	end
	
	local size = math.ceil(spread * 2500)
	surface.SetDrawColor(0, 0, 0, alpha)
	surface.SetTexture(ClumpSpread)
	surface.DrawTexturedRect(x - size * 0.5 - 1, y - size * 0.5 - 1, size + 2, size + 2)
			
	surface.SetDrawColor(255, 255, 255, alpha)
	surface.DrawTexturedRect(x - size * 0.5, y - size * 0.5, size, size)
end

function SWEP:DrawHUD()
	FT, CT, x, y = FrameTime(), CurTime(), ScrW(), ScrH()
	UCT = UnPredictedCurTime()
	
	if self.dt.State == CW_AIMING then
		-- if we have M203 mode enabled, but have no rounds in it, OR if we don't have M203 enabled, let us draw the overlays
		if (self.dt.M203Active and (not self.M203Chamber or CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM))) or not self.dt.M203Active then
			local simpleTelescopics = not self:canUseComplexTelescopics()
			
			local hasZoom = (self.SimpleTelescopicsFOV)
			local canUseSimpleTelescopics = (simpleTelescopics and hasZoom)
			
			if UCT > self.AimTime or self.InstantDissapearOnAim then
				if self.DrawBlackBarsOnAim or canUseSimpleTelescopics then
					surface.SetDrawColor(0, 0, 0, 255)
					
					if self.ScaleOverlayToScreenHeight then
						x3 = (x - y) / 2
						y3 = y / 2
						x4 = x - x3
						y4 = y - y3
						
						surface.DrawRect(0, 0, x3, y)
						surface.DrawRect(x4, 0, x3, y)
					else
						x3 = (x - 1024) / 2
						y3 = (y - 1024) / 2
						x4 = x - x3
						y4 = y - y3
						
						surface.DrawRect(0, 0, x3, y)
						surface.DrawRect(x4, 0, x3, y)
						surface.DrawRect(0, 0, x, y3)
						surface.DrawRect(0, y4, x, y3)
					end
				end
			end
			
			if self.AimOverlay or canUseSimpleTelescopics then
				if UCT > self.AimTime or self.InstantDissapearOnAim then
					surface.SetDrawColor(255, 255, 255, 255)
					
					if canUseSimpleTelescopics then
						surface.SetTexture(scopeTemplate)
						surface.DrawTexturedRect(x * 0.5 - 512, y * 0.5 - 512, 1024, 1024)
					else
						surface.SetTexture(self.AimOverlay)
					end
					
					if self.StretchOverlayToScreen then
						if canUseSimpleTelescopics then
							for k, v in ipairs(self.ZoomTextures) do
								if v.color then
									surface.SetDrawColor(v.color)
								else
									surface.SetDrawColor(255, 255, 255, 255)
								end
								
								surface.SetTexture(v.tex)
								surface.DrawTexturedRect(v.offset[1], v.offset[2], x, y)
							end
						else
							surface.DrawTexturedRect(0, 0, x, y)
						end
						
					elseif self.ScaleOverlayToScreenHeight then
						if canUseSimpleTelescopics then
							for k, v in ipairs(self.ZoomTextures) do
								surface.SetTexture(v.tex)
								surface.DrawTexturedRect(x * 0.5 - y * 0.5 + v.offset[1], y * 0.5 - y * 0.5 + v.offset[2], y, y)
							end
						else
							surface.DrawTexturedRect(x * 0.5 - y * 0.5, y * 0.5 - y * 0.5, y, y)
						end
					else
						if canUseSimpleTelescopics then
							for k, v in ipairs(self.ZoomTextures) do
								local xSize, ySize = 1024, 1024
								
								if v.size then
									xSize, ySize = v.size[1], v.size[2]
								end
								
								
								if v.color then
									surface.SetDrawColor(v.color)
								else
									surface.SetDrawColor(255, 255, 255, 255)
								end
								
								surface.SetTexture(v.tex)
								surface.DrawTexturedRect(x * 0.5 - xSize * 0.5 + v.offset[1], y * 0.5 - ySize * 0.5 + v.offset[2], xSize, ySize)
							end
						else
							surface.DrawTexturedRect(x * 0.5 - 512, y * 0.5 - 512, 1024, 1024)
						end
					end
				end
			end
			
			if self.FadeDuringAiming or canUseSimpleTelescopics then
				if UCT < self.AimTime then
					self.FadeAlpha = math.Approach(self.FadeAlpha, 255, FT * 1500)
				else
					self.FadeAlpha = LerpCW20(FT * 10, self.FadeAlpha, 0)
				end
				
				surface.SetDrawColor(0, 0, 0, self.FadeAlpha)
				surface.DrawRect(0, 0, x, y)
			end
		end
	else
		self.FadeAlpha = 0
	end
	
	if not self.dt.BipodDeployed then 
		if self.BipodInstalled then
			if self:CanRestWeapon(self.BipodDeployHeightRequirement) then
				draw.ShadowText("[USE KEY]", cwhud24, x / 2, y / 2 + 100, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
				surface.SetTexture(Deploy)
				
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawTexturedRect(x / 2 - 47, y / 2 + 126, 96, 96)
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(x / 2 - 48, y / 2 + 125, 96, 96)
			end
		else
			if self.dt.State == CW_AIMING then
				if self.CanRestOnObjects then
					if self:CanRestWeapon(self.WeaponRestHeightRequirement) then
						surface.SetTexture(deployedOnObject)
						
						surface.SetDrawColor(0, 0, 0, 255)
						surface.DrawTexturedRect(x / 2 - 47, y / 2 + 150, 96, 96)
						
						surface.SetDrawColor(255, 255, 255, 255)
						surface.DrawTexturedRect(x / 2 - 48, y / 2 + 150, 96, 96)
					end
				end
			end
		end
	else
		draw.ShadowText("[USE KEY]", cwhud24, x / 2, y / 2 + 100, White, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
		surface.SetTexture(UnDeploy)
			
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawTexturedRect(x / 2 - 47, y / 2 + 126, 96, 96)
			
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x / 2 - 48, y / 2 + 125, 96, 96)
	end
	
	if self.AimBreathingEnabled then
		self.HUD_BreathAlpha = LerpCW20(FT * 10, self.HUD_BreathAlpha, (1 - self.BreathLeft))

		if self.BreathLeft < 1 then
			surface.SetDrawColor(0, 0, 0, 255 * self.HUD_BreathAlpha)
			surface.SetTexture(Vignette)
			surface.DrawTexturedRect(0, 0, x, y)
		end
		
		if self.dt.State == CW_AIMING then
			if self.Owner:GetVelocity():Length() < self.BreathHoldVelocityMinimum then
				local finalColorMain = White
				local finalColorSecondary = White
				
				if self.noBreathHoldingUntilKeyRelease then
					finalColorMain = self.HUDColors.deepRed
				end
				
				if not self.holdingBreath and self.BreathLeft < 0.5 then
					finalColorSecondary = self.HUDColors.red
				end
				
				draw.ShadowText(self:getKeyBind("+speed") .. " - steady aim", cwhud24, x / 2, y / 2 + 120, finalColorMain, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.ShadowText(math.Round(self.BreathLeft * 100) .. "%", cwhud24, x / 2, y / 2 + 140, finalColorSecondary, Black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		else
			if self.holdingBreath then
				self:stopHoldingBreath(nil, nil, 0)
			end
		end
	end
	
	local disableCrosshair, disableCustomHUD, disableTabDisplay = CustomizableWeaponry.callbacks.processCategory(self, "suppressHUDElements", customHUD)
	
	if not disableCrosshair then
		if self.CrosshairEnabled and GetConVarNumber("cw_crosshair") > 0 then
			lp = self.Owner:ShouldDrawLocalPlayer()
			
			if lp or self.freeAimOn then
				td.start = self.Owner:GetShootPos()
				td.endpos = td.start + (self.Owner:EyeAngles() + self.Owner:GetPunchAngle()):Forward() * 16384
				td.filter = self.Owner
				
				tr = util.TraceLine(td)
				
				x2 = tr.HitPos:ToScreen()
				x2, y2 = x2.x, x2.y
			else
				x2, y2 = math.Round(x * 0.5), math.Round(y * 0.5)
			end
			
			if not self:crosshairVisible() then
				self.CrossAlpha = LerpCW20(FT * 15, self.CrossAlpha, 0)
			else
				self.CrossAlpha = LerpCW20(FT * 15, self.CrossAlpha, 255)
			end
			
			if self.dt.M203Active and self.M203Chamber then
				local curGrenade = CustomizableWeaponry.grenadeTypes:get(self.Grenade40MM)
				
				if self.dt.State == CW_AIMING then
					if not curGrenade or not curGrenade.clumpSpread then
						surface.SetTexture(GLCrosshair)
						surface.SetDrawColor(255, 255, 255, 255 - self.CrossAlpha)
						surface.DrawTexturedRect(x2 - 16, y2, 32, 32)
					end
				end
				
				if curGrenade and curGrenade.clumpSpread and self.M203Chamber then
					self:drawClumpSpread(x2, y2, curGrenade.clumpSpread, self.CrossAlpha * 0.35)
				end
			end
			
			self:drawClumpSpread(x2, y2, self.ClumpSpread, self.CrossAlpha)

			self.CrossAmount = LerpCW20(FT * 10, self.CrossAmount, (self.CurCone * 350) * (90 / (math.Clamp(GetConVarNumber("fov_desired"), 75, 90) - self.CurFOVMod)))
			surface.SetDrawColor(0, 0, 0, self.CrossAlpha * 0.75) -- BLACK crosshair parts
			
			if self.CrosshairParts.left then
				surface.DrawRect(x2 - 13 - self.CrossAmount, y2 - 1, 12, 3) -- left cross
			end
			
			if self.CrosshairParts.right then
				surface.DrawRect(x2 + 3 + self.CrossAmount, y2 - 1, 12, 3) -- right cross
			end
			
			if self.CrosshairParts.upper then
				surface.DrawRect(x2 - 1, y2 - 13 - self.CrossAmount, 3, 12) -- upper cross
			end
			
			if self.CrosshairParts.lower then
				surface.DrawRect(x2 - 1, y2 + 3 + self.CrossAmount, 3, 12) -- lower cross
			end
			
			surface.SetDrawColor(255, 255, 255, self.CrossAlpha) -- WHITE crosshair parts
			
			if self.CrosshairParts.left then
				surface.DrawRect(x2 - 12 - self.CrossAmount, y2, 10, 1) -- left cross
			end
			
			if self.CrosshairParts.right then
				surface.DrawRect(x2 + 4 + self.CrossAmount, y2, 10, 1) -- right cross
			end
			
			if self.CrosshairParts.upper then
				surface.DrawRect(x2, y2 - 12 - self.CrossAmount, 1, 10) -- upper cross
			end
			
			if self.CrosshairParts.lower then
				surface.DrawRect(x2, y2 + 4 + self.CrossAmount, 1, 10) -- lower cross
			end
		end
	end
	
	if not disableCustomHUD then
		local customHUD = GetConVarNumber("cw_customhud") >= 1
		
		if not customHUD and GetConVarNumber("cw_customhud_ammo") <= 0 then
			if self.FireModeDisplayPos == "right" then
				sc1, sc2 = ScreenScale(35), ScreenScale(44)
				draw.ShadowText(self.FireModeDisplay, cwhud16, x - sc1 - self.BulletDisplay * 20, y - sc2 - 20, White, Black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				
				if self.BulletDisplay and self.BulletDisplay > 0 then
					surface.SetDrawColor(0, 0, 0, 255)
					surface.SetTexture(Bullet)
					
					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRect(x - sc1 - (i - 1) * 20 - 5, y - sc2 - 25, 16, 16)
					end
					
					surface.SetDrawColor(255, 255, 255, 255)
					
					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRect(x - sc1 - (i - 1) * 20 - 6, y - sc2 - 26, 16, 16)
					end
				end
			elseif self.FireModeDisplayPos == "middle" then
				draw.ShadowText(self.FireModeDisplay, cwhud16, x * 0.5, y - 100, White, Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
				local grenades = self.Owner:GetAmmoCount("Frag Grenades")
				
				-- only display the frag ammo count if we have any grenades in reserve
				if grenades > 0 then
					draw.ShadowText(grenades .. "x FRAG", cwhud16, x * 0.5, y - 120, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				
				if self.BulletDisplay and self.BulletDisplay > 0 then
					surface.SetDrawColor(0, 0, 0, 255)
					surface.SetTexture(Bullet)
					
					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRect(x * 0.5 - 20 * i + self.BulletDisplay * 10 + 1, y - 89, 16, 16)
					end
					
					surface.SetDrawColor(255, 255, 255, 255)
					
					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRect(x * 0.5 - 20 * i + self.BulletDisplay * 10, y - 90, 16, 16)
					end
				end
			elseif self.FireModeDisplayPos == "left" then
				sc1, sc2 = ScreenScale(35), ScreenScale(44)
				draw.ShadowText(self.FireModeDisplay, cwhud16, sc1, y - sc2 - 20, White, Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				
				if self.BulletDisplay and self.BulletDisplay > 0 then
					surface.SetDrawColor(0, 0, 0, 255)
					surface.SetTexture(Bullet)
					
					surface.SetFont(cwhud16)
					local size = surface.GetTextSize(self.FireModeDisplay)
					
					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRect(sc1 + (i - 1) * 20 + size + 15, y - sc2 - 25, 16, 16)
					end
					
					surface.SetDrawColor(255, 255, 255, 255)
					
					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRect(sc1 + (i - 1) * 20 - 1 + size + 15, y - sc2 - 26, 16, 16)
					end
				end
			end
			
			if self.dt.M203Active then
				self.HUDColors.red.a = 255
				self.HUDColors.black.a = 255
				self.HUDColors.white.a = 255
				
				if not self.M203Chamber then
					draw.ShadowText("M203 EMPTY", cwhud24, x * 0.5, y - 170, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.ShadowText("M203 READY", cwhud24, x * 0.5, y - 170, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				
				local curGrenade = CustomizableWeaponry.grenadeTypes.getGrenadeText(self)
				
				draw.ShadowText(self.Owner:GetAmmoCount("40MM") .. "x RESERVE", cwhud22, x * 0.5, y - 150, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.ShadowText("TYPE" .. curGrenade, cwhud22, x * 0.5, y - 130, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	
		if customHUD then
			self:drawCustomHUD()
		end
	end
	
	if not disableTabDisplay then
		if self.dt.State == CW_CUSTOMIZE then
			self:drawTabDisplay()
		end
		
		CustomizableWeaponry.callbacks.processCategory(self, "drawToHUD", customHUD)
	end
end


SWEP.HUDColors = {white = Color(255, 255, 255, 255),
red = Color(255, 150, 150, 255),
deepRed = Color(255, 110, 110, 255),
black = Color(0, 0, 0, 255),
green = Color(200, 255, 200, 255)}

local gradient = surface.GetTextureID("cw2/gui/gradient")

function SWEP:drawTabDisplay()
	local x, y = ScrW(), ScrH()

	local entryCount = #CustomizableWeaponry.interactionMenu.tabs
	local baseHeight = entryCount * 22 + 10
	surface.SetDrawColor(0, 0, 0, 200)
	surface.SetTexture(gradient)
	surface.DrawTexturedRectRotated(x - 245, y - 175 - baseHeight * 0.5, 300, baseHeight, 180)
			
	for k, v in ipairs(CustomizableWeaponry.interactionMenu.tabs) do
		local clr
		
		if self.CustomizationTab == v.id then
			clr = self.HUDColors.green
		else
			clr = self.HUDColors.white
		end
		
		draw.ShadowText(self:getKeyBind(v.switchToKey) .. " - " .. v.text, cwhud24, x - 100, y - 202 - (k - 1) * 23, clr, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
	end
end

function SWEP:drawCustomHUD()
	local FT = FrameTime()
	
	local x, y = ScrW(), ScrH()
	
	self.HUDColors.white.a = 255
	self.HUDColors.black.a = 255
	local baseX, baseY = 100, y - 150
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.SetTexture(gradient)
	surface.DrawTexturedRect(baseX - 5, baseY - 15, 300, 90)
	
	-- draw the bottom-left part of the HUD; aka health and armor
	draw.ShadowText("HEALTH: ", cwhud24, baseX, baseY, self.HUD_HealthTextColor, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText("ARMOR: ", cwhud24, baseX, baseY + 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	local hp = self.Owner:Health()
	local arm = self.Owner:Armor()
	
	-- approach the health and armor values rather than snapping, so that the pips fill up gradually
	self.HUD_LastHealth = math.Approach(self.HUD_LastHealth, hp, FT * 100)
	self.HUD_LastArmor = math.Approach(self.HUD_LastArmor, arm, FT * 100)
	
	-- draw the health and armor text
	draw.ShadowText(hp .. "%", cwhud24, baseX + 100, baseY, self.HUD_HealthTextColor, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText(arm .. "%", cwhud24, baseX + 100, baseY + 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	local healthPips = math.Clamp(math.floor(self.HUD_LastHealth / 5), 1, 20)
	local armorPips = math.Clamp(math.floor(self.HUD_LastArmor / 5), 0, 20)
	
	-- black health and armor pips (to avoid unnecessary SetDrawColor calls)
	surface.SetDrawColor(0, 0, 0, 255)
	
	for i = 1, healthPips do
		surface.DrawRect(baseX + (i - 1) * 12 + 2, baseY + 16, 5, 10)
	end
	
	for i = 1, armorPips do
		surface.DrawRect(baseX + (i - 1) * 12 + 2, baseY + 36, 5, 10)
	end
	
	-- colored health pips
	for i = 1, healthPips do
		surface.SetDrawColor(240 - i * 10, i * 12.75, i * 4, 255)
		surface.DrawRect(baseX + (i - 1) * 12 + 1, baseY + 15, 5, 10)
	end
	
	-- colored armor pips
	for i = 1, armorPips do
		surface.SetDrawColor(0, 125 + i * 6.5, 200 + i * 2.75, 255)
		surface.DrawRect(baseX + (i - 1) * 12 + 1, baseY + 35, 5, 10)
	end
	
	-- draw the 2D variant of the custom HUD in case the 3D variant was disabled by the user
	if GetConVarNumber("cw_customhud_ammo") <= 0 then
		local baseXAMMO, baseYAMMO = x - 117, y - 150
		
		surface.SetDrawColor(0, 0, 0, 200)
		surface.SetTexture(gradient)
		surface.DrawTexturedRectRotated(baseXAMMO - 128, baseYAMMO + 30, 300, 90, 180)
		
		-- display the M203 section if we're in M203 mode
		if self.dt.M203Active then
			surface.DrawTexturedRectRotated(baseXAMMO - 128, baseYAMMO - 60, 300, 70, 180)
			
			if not self.M203Chamber then
				draw.ShadowText("M203 EMPTY", cwhud24, baseXAMMO + 15, baseY - 80, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			else
				draw.ShadowText("M203 READY", cwhud24, baseXAMMO + 15, baseY - 80, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			end
			
			local curGrenade = CustomizableWeaponry.grenadeTypes.getGrenadeText(self)
			
			draw.ShadowText(self.Owner:GetAmmoCount("40MM") .. "x RESERVE", cwhud22, baseXAMMO + 15, baseY - 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			
			draw.ShadowText("TYPE" .. curGrenade, cwhud22, baseXAMMO + 15, baseY - 40, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	
		local mag = self:Clip1()
		local ammoCount, magCount, targetColor = self:getReserveAmmoText()
		
		if not targetColor then
			if ammoCount <= self.Primary.ClipSize then -- make the reserve text red if we only have 1 mag (or less) in reserve left
				self.HUD_ReserveTextColor = LerpColor(FT * 10, self.HUD_ReserveTextColor, self.HUDColors.deepRed)
			else
				self.HUD_ReserveTextColor = LerpColor(FT * 10, self.HUD_ReserveTextColor, White)
			end
		else
			self.HUD_ReserveTextColor = LerpColor(FT * 10, self.HUD_ReserveTextColor, targetColor)
		end
		
		local reloadProgress = self:getReloadProgress()
		
		-- if we're reloading or are low on ammo, make the text red
		if reloadProgress or mag <= self.Primary.ClipSize * 0.25 then
			self.HUD_MagTextColor = LerpColor(FT * 10, self.HUD_MagTextColor, self.HUDColors.red)
		else
			self.HUD_MagTextColor = LerpColor(FT * 10, self.HUD_MagTextColor, White)
		end
		
		-- display either the reload progress or the ammo in mag
		if reloadProgress then
			draw.ShadowText("RELOADING  " .. reloadProgress .. "%", "CW_HUD32", baseXAMMO + 15, baseYAMMO, self.HUD_MagTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		else
			draw.ShadowText(self.HUD_MagText .. self:getMagCapacity(), "CW_HUD32", baseXAMMO + 15, baseYAMMO, self.HUD_MagTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
		
		local grenades = self.Owner:GetAmmoCount("Frag Grenades")
		local ammoText = "RESERVE: " .. ammoCount
		
		-- display the amount of frag grenades only if we have some
		if grenades > 0 then
			surface.SetFont(cwhud24)
			
			local textSize = surface.GetTextSize(ammoText)
			
			draw.ShadowText(grenades .. "x FRAG, ", cwhud20, baseXAMMO - textSize + 15, baseYAMMO + 25, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
		
		draw.ShadowText(ammoText, cwhud24, baseXAMMO + 15, baseYAMMO + 25, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		draw.ShadowText(self.FireModeDisplay, cwhud22, baseXAMMO + 15, baseYAMMO + 45, White, Black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		
		-- display the firemode section
		if self.BulletDisplay and self.BulletDisplay > 0 then
			surface.SetDrawColor(0, 0, 0, 255)
			surface.SetTexture(Bullet)
			
			surface.SetFont(cwhud24)
			local xSize = surface.GetTextSize(self.FireModeDisplay)
			
			-- draw the shadow of the bullets and the regular bullets in 2 separate loops, to do only (2 SetDrawColor) calls instead of (BulletDisplay * 2 SetDrawColor) calls
			for i = 1, self.BulletDisplay do
				surface.DrawTexturedRect(baseXAMMO - (i - 1) * 20 - xSize, baseYAMMO + 39, 16, 16)
			end
			
			surface.SetDrawColor(255, 255, 255, 255)
			
			for i = 1, self.BulletDisplay do
				surface.DrawTexturedRect(baseXAMMO - (i - 1) * 20 - 1 - xSize, baseYAMMO + 38, 16, 16)
			end
		end
		
		draw.ShadowText(self.Primary.Ammo, cwhud14, baseXAMMO + 15, baseYAMMO + 62, White, Black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	if self.SelectIcon then
		surface.SetDrawColor(255, 210, 0, 255)
		surface.SetTexture(self.SelectIcon)
		surface.DrawTexturedRect(x + tall * 0.2, y, tall, tall)
	else
		draw.SimpleText(self.IconLetter, self.SelectFont, x + wide / 2, y + tall * 0.2, Color(255, 210, 0, alpha), TEXT_ALIGN_CENTER)
	end
end