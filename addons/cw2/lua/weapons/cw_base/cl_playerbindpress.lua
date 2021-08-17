SWEP.DoubleUseKeyTime = 0
SWEP.DoubleUseKeyPresses = 0
SWEP.SubCustomizationCycleTime = nil
SWEP.AntiAttachmentSwitchSpam = 0
SWEP.InteractionMenuInteractWait = 0
SWEP.SubCustomizationTriggerTime = 0.25

local wep, CT

function SWEP.PlayerBindPress(ply, b, p)
	if p then
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			if wep.dt then
				if wep.dt.State == CW_AIMING then
					if wep.AdjustableZoom then
						CT = CurTime()
						
						if b == "invprev" then
							CT = CurTime()
							
							if CT > wep.ZoomWait then
								if wep.ZoomAmount > wep.MinZoom then
									wep.ZoomAmount = math.Clamp(wep.ZoomAmount - 15, wep.MinZoom, wep.MaxZoom)
									surface.PlaySound("weapons/zoom.wav")
									wep.ZoomWait = CT + 0.15

								end
							end
							
							return true
						elseif b == "invnext" then
							CT = CurTime()
							
							if CT > wep.ZoomWait then
								if wep.ZoomAmount < wep.MaxZoom then
									wep.ZoomAmount = math.Clamp(wep.ZoomAmount + 15, wep.MinZoom, wep.MaxZoom)
									surface.PlaySound("weapons/zoom.wav")
									wep.ZoomWait = CT + 0.15
								end
							end
							
							return true
						end
					end
					
					if wep.SightBackUpPos then
						if b == "+use" then
							CT = CurTime()
							
							if CT > wep.DoubleUseKeyTime then
								wep.DoubleUseKeyPresses = 1
							else
								wep.DoubleUseKeyPresses = wep.DoubleUseKeyPresses + 1
							end
							
							-- if we press our use key twice quickly, let us use sights
							if wep.DoubleUseKeyPresses >= 2 then
								if wep.AimPos == wep.SightBackUpPos then
									-- swap back to the sights in case we were already using backup sights
									wep.AimPos = wep.ActualSightPos
									wep.AimAng = wep.ActualSightAng
								else
									-- swap to backup sights
									wep.AimPos = wep.SightBackUpPos
									wep.AimAng = wep.SightBackUpAng
									wep.DoubleUseKeyPresses = 0
								end
							end
							
							wep.DoubleUseKeyTime = CT + 0.2
						end
					end
				else
					if wep.dt.State == CW_CUSTOMIZE then
						--[[if wep.CustomizationTab == CustomizableWeaponry.interactionMenu.CUSTOMIZATION_TAB then
							if wep.processSlotKeyPress(wep, b, p) then
								return true
							end
							
						elseif wep.CustomizationTab == CustomizableWeaponry.interactionMenu.PRESET_TAB then
							if b == "+attack" then
								wep:seekPresetPosition(1)
								return true
							elseif b == "+attack2" then
								wep:seekPresetPosition(-1)
								return true
							elseif b == "+use" then
								if CustomizableWeaponry.preset.canSave(wep) then
									CustomizableWeaponry.preset.makeSavePopup(wep)
								end
								
								return true
							elseif b:find("slot") then
								local pos = wep:getDesiredPreset(b)
								
								if wep:attemptPresetLoad(pos) then
									return true
								end
							end
						end]]--
						
						local result = CustomizableWeaponry.interactionMenu.keyPressed(wep, b, p)
						
						-- if it's true, that means we need to suppress the current key bind
						-- if it's false, that means that we don't need to suppress the current key bind, but we have to stop the key bind processing
						-- if it's nil, that means we shouldn't stop processing nor suppress the key bind here

						if result ~= nil then
							return result
						end
					end
					
					if b == CustomizableWeaponry.customizationMenuKey then
						if CustomizableWeaponry.canOpenInteractionMenu then
							return wep.attemptToggleInteractionMenu(wep)
						end
					end
				end
			end
		end
	else
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			if wep.dt then
				if wep.dt.State == CW_CUSTOMIZE then
					return wep.processSlotKeyPress(wep, b, p)
				end
			end
		end
	end
end

hook.Add("PlayerBindPress", "SWEP.PlayerBindPress (CW 2.0)", SWEP.PlayerBindPress)

function SWEP:processSlotKeyPress(bind, pressed)
	-- figure out which key was pressed

	local num = bind
	local category
	
	if bind:find("slot") then
		num = tonumber(string.Right(bind, 1))
		category = self.Attachments[num]
	else
		category = self.Attachments[num]
	end
	
	if category then
		if pressed then
			local lastAtt = category.last
			
			-- if the key was pressed and there is a sight that can have it's sight color changed, attempt to do so
			if lastAtt then
				local attName = category.atts[category.last]
				local sightColor = self.SightColors[attName]
				
				if sightColor then
					self.SightColorTarget = sightColor
					self.SubCustomizationCycleTime = UnPredictedCurTime() + self.SubCustomizationTriggerTime
				else
					local att = CustomizableWeaponry.registeredAttachmentsSKey[attName]
					
					if att and att.isGrenadeLauncher then
						self.GrenadeTarget = true
						self.SubCustomizationCycleTime = UnPredictedCurTime() + self.SubCustomizationTriggerTime
					else
						self:attemptAttach(num)
					end
				end
			else
				self:attemptAttach(num)
			end
		else
			if self.SubCustomizationCycleTime then
				if UnPredictedCurTime() < self.SubCustomizationCycleTime then
					self:attemptAttach(num)
					self.SubCustomizationCycleTime = nil
					self.SightColorTarget = nil
				end
			end
		end
		
		-- prevent key presses
		return true
	end
	
	-- or not, if it's not a 'slot' key
	return false
end

function SWEP:attemptToggleInteractionMenu()
	if CurTime() < self.InteractionMenuInteractWait then
		return nil
	end
	
	if self:canOpenInteractionMenu() then
		if self.dt.State ~= CW_CUSTOMIZE then
			self.CustomizationTab = CustomizableWeaponry.interactionMenu.CUSTOMIZATION_TAB
			self:setPresetPosition(1, true)
		end
		
		RunConsoleCommand("cw_customize")
		self:delayEverything(self.CUSTOMIZATION_MENU_TOGGLE_WAIT)
		self.InteractionMenuInteractWait = CurTime() + 0.2
		return true
	end
	
	return nil
end

function SWEP:attemptAttach(num)
	if CurTime() < self.AntiAttachmentSwitchSpam then
		return
	end
	
	if self.Attachments[num] then
		RunConsoleCommand("cw_attach", num)
		
		self.AntiAttachmentSwitchSpam = CurTime() + 0.1
		self.JustAttached = true
	end
end