local tab = {}
tab.name = "TAB_PRESETS"
tab.id = 3
tab.text = "PRESETS"
tab.switchToKey = "gm_showspare1"
tab.deletingPresets = false
tab.deletePos = nil

if CLIENT then
	tab.callback = function(self)
		CustomizableWeaponry.preset.updateList(self)
		tab.deletingPresets = false
		tab.deletePos = nil
	end

	function tab:processKey(b, p)
		if b == "+attack" then
			self:seekPresetPosition(1)
			return true
		elseif b == "+attack2" then
			self:seekPresetPosition(-1)
			return true
		elseif b == "+use" then
			if CustomizableWeaponry.preset.canSave(self) then
				CustomizableWeaponry.preset.makeSavePopup(self)
			end
			
			return true
		elseif b == "+reload" then
			tab.deletingPresets = !tab.deletingPresets
			tab.deletePos = nil
			
			return true
		elseif b:find("slot") then
			if not tab.deletingPresets then
				local pos = self:getDesiredPreset(b)
				
				self:attemptPresetLoad(pos)
				
				return true
			else
				local pos = self:getDesiredPreset(b)
				
				-- if there is no selected preset to delete, select one
				if not tab.deletePos then
					-- make sure we're trying to delete an existing preset
					
					if self.PresetResults[pos - 1] then
						tab.deletePos = pos
					end
				elseif pos ~= tab.deletePos then
					-- if we're selecting a preset that doesn't match the one we selected initially, reset the delete position
					tab.deletePos = nil
				else
					-- otherwise, it's time to delete (RIP preset ;_;)
					if CustomizableWeaponry.preset.attemptDelete(self, tab.deletePos) then
						CustomizableWeaponry.preset.updateList(self)
						tab.deletePos = nil
					end
				end
				
				return true
			end
		end
		
		return nil
	end
	
	local gradient = surface.GetTextureID("cw2/gui/gradient")
	
	local hud48 = "CW_HUD48"
	
	function tab:drawFunc()
		local baseX, baseY = -50, -50
		surface.SetDrawColor(0, 0, 0, 200)
		surface.SetTexture(gradient)
		
		surface.DrawTexturedRect(baseX, baseY - 120, 300, 250)
		
		local clrSave
		
		if not CustomizableWeaponry.preset.canSave(self) then
			clrSave = self.HUDColors.red
		else
			clrSave = self.HUDColors.white
		end
		
		local interactionText
		
		if tab.deletingPresets then
			if tab.deletePos then
				interactionText = "MODE: Deleting preset; tap again to DELETE"
				interactionColor = self.HUDColors.deepRed
			else
				interactionText = "MODE: Deleting preset; tap to SELECT"
				interactionColor = self.HUDColors.red
			end
		else
			interactionText = "MODE: Loading preset"
			interactionColor = self.HUDColors.green
		end
		
		draw.ShadowText(self:getKeyBind("+attack") .. " - cycle presets forward", hud48, baseX + 5, baseY - 95, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.ShadowText(self:getKeyBind("+attack2") .. " - cycle presets back", hud48, baseX + 5, baseY - 45, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.ShadowText(self:getKeyBind("+use") .. " - save new preset", hud48, baseX + 5, baseY + 5, clrSave, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
		local modeText = nil
		
		if tab.deletingPresets then 
			modeText = " - switch to LOAD PRESET mode"
		else
			modeText = " - switch to DELETE PRESET mode"
		end
		
			draw.ShadowText(self:getKeyBind("+reload") .. modeText, hud48, baseX + 5, baseY + 55, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.ShadowText(interactionText, hud48, baseX + 5, baseY + 105, interactionColor, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
		local presetCount = #self.PresetResults
		
		if presetCount > 0 then
			-- we use this to determine the size of the gradient
			local existingPresets = math.Clamp(presetCount - self.PresetPosition + 1, 1, 10)
			
			surface.DrawTexturedRect(baseX, baseY + 140, 300, existingPresets * 50 + 10)
			
			local entry, targetColor
			
			local curEntry = 1
			
			for i = self.PresetPosition, self.PresetPosition + 9 do
				entry = self.PresetResults[i]
				
				if entry then
					targetColor = nil
					
					if tab.deletePos then
						if tab.deletePos - 1 == i then
							targetColor = self.HUDColors.deepRed
						end
					end
					
					if targetColor == nil then
						if self.LastPreset == entry.displayName then
							targetColor = CustomizableWeaponry.textColors.COSMETIC
						else
							targetColor = CustomizableWeaponry.textColors.REGULAR
						end
					end
					
					draw.ShadowText("[" .. curEntry .. "] - Preset #" .. i .. " '" .. entry.displayName .. "'", hud48, baseX + 5, baseY + 5 + (curEntry - 1) * 50 + 165, targetColor, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				
				curEntry = curEntry + 1
			end
		end
		--end
	end
end

CustomizableWeaponry.interactionMenu:addTab(tab)