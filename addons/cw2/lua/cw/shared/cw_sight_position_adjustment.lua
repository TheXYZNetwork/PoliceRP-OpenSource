AddCSLuaFile()

if CLIENT then
	CustomizableWeaponry.sightAdjustment = {}
	CustomizableWeaponry.sightAdjustment.adjustAmount = 0.15 -- percentage of maximum offset to move the sight by
	CustomizableWeaponry.sightAdjustment.currentAttData = nil
	CustomizableWeaponry.sightAdjustment.currentAttConfigData = nil
	CustomizableWeaponry.sightAdjustment.currentModelData = nil
	CustomizableWeaponry.sightAdjustment.folder = CustomizableWeaponry.baseFolder .. "/default_offsets/"
	CustomizableWeaponry.sightAdjustment.notificationAlpha = 0
	CustomizableWeaponry.sightAdjustment.notificationTime = 0
	CustomizableWeaponry.sightAdjustment.notificationText = nil
	
	function CustomizableWeaponry.sightAdjustment:adjust(wep, direction, adjustAmount)
		adjustAmount = adjustAmount or self.adjustAmount
		direction = adjustAmount * direction
		
		local modelData = self:getModelConfig(self.currentAttConfigData)
		local adjustRange = self.currentAttConfigData.adjustment
		local range = math.abs(adjustRange.min - adjustRange.max)
		
		if adjustRange.inverse then
			direction = -direction
		end
		
		local lastOffset = math.floor(self:getOffset(self.currentAttConfigData, self.currentAttConfigData.adjustment) * 20) -- floor + multiply by 20 to achieve increases in the value every 5
		
		modelData.pos[adjustRange.axis] = math.Clamp(modelData.pos[adjustRange.axis] + range * direction, adjustRange.min, adjustRange.max)
		
		local curOffset = math.floor(self:getOffset(self.currentAttConfigData, self.currentAttConfigData.adjustment) * 20)
		
		if CustomizableWeaponry.playSoundsOnInteract then
			if lastOffset ~= curOffset then -- only play the adjust sound if we actually changed the position
				wep:EmitSound("CW_ADJUST_SIGHT_POSITION")
			end
		end
	end
	
	function CustomizableWeaponry.sightAdjustment:setCurrentAttachment(attData, attData2, modelData)
		self.currentAttData = attData
		self.currentAttConfigData = attData2
		self.currentModelData = modelData
	end
	
	function CustomizableWeaponry.sightAdjustment:getCurrentAttachment()
		return self.currentAttData, self.currentModelData
	end
	
	function CustomizableWeaponry.sightAdjustment:getAdjustmentModelData(modelData, adjustment)
		if modelData.models then
			print("blaze")
			
			if modelData.adjustment.index then
				modelData = modelData.models[modelData.adjustment.index]
				print("wew")
			else
				modelData = modelData.models[1]
				print("dayum", modelData)
			end
		end
	end
	
	function CustomizableWeaponry.sightAdjustment:canSetAttachment(wep, category)
		if not wep.AttachmentModelsVM then
			return false, nil
		end
		
		local attCategory = wep.Attachments[category]
		
		if attCategory then -- if there is one, check if there is an active attachment
			local attachment = nil
			
			if attCategory.last then
				attachment = attCategory.atts[attCategory.last] -- get the current attachment
			end
			
			if attachment then
				local attData = wep.AttachmentModelsVM[attachment]
				
				if attData and attData.adjustment then -- if there is an attachment like this, and it can be adjusted, set it as the current adjustable attachment
					local modelData = attData
					
					if modelData.models then
						print("blaze")
						
						if attData.adjustment.index then
							modelData = modelData.models[attData.adjustment.index]
							print("wew")
						else
							modelData = modelData.models[1]
							print("dayum", modelData)
						end
					end
					
					return attCategory, attData, modelData
				end
			end
		end
	end
	
	function CustomizableWeaponry.sightAdjustment:attemptSetAttachment(wep, category)
		local attData, attData2, modelData = self:canSetAttachment(wep, category)
		
		if attData and modelData then
			CustomizableWeaponry.sightAdjustment:setCurrentAttachment(attData, attData2, modelData)
			return true
		end
		
		return nil
	end
	
	function CustomizableWeaponry.sightAdjustment:getOffset(attData, adjustRange)
		local range = math.abs(adjustRange.min - adjustRange.max)
		
		attData = self:getModelConfig(attData)
		
		local curPos = attData.pos[adjustRange.axis]
		return math.abs(curPos - (adjustRange.inverseOffsetCalc and adjustRange.min or adjustRange.max)) / range
	end
	
	function CustomizableWeaponry.sightAdjustment:getIntendedRange(data, wep, offset)
		local curAtt = data.atts[data.last]
		
		if not wep.AttachmentModelsVM[curAtt].adjustment then
			return nil
		end
		
		if offset >= 0.66 then
			return "(LONG RANGE)"
		elseif offset >= 0.33 then
			return "(MID RANGE)"
		else
			return "(CLOSE RANGE)"
		end
	end
	
	function CustomizableWeaponry.sightAdjustment:setDefaultOffset(wep)
		local baseDir = CustomizableWeaponry.sightAdjustment.folder
		
		if not file.IsDir(baseDir, "DATA") then
			file.CreateDir(baseDir)
		end
		
		local name = wep.ThisClass or wep:GetClass()
		local fileName = baseDir .. name .. ".txt"
		local offsets = nil
		
		if file.Exists(fileName, "DATA") then -- if we currently have a file that contains default offsets, load it up so that we can append more data to it
			offsets = util.JSONToTable(file.Read(fileName, "DATA"))
		else -- otherwise we just create a new table that we'll write data to
			offsets = {}
		end
		
		local attData, attCfg = self.currentAttData, self.currentAttConfigData
		local modelData = self:getModelConfig(attCfg)
		local curAttName = attData.atts[attData.last]
		
		offsets[curAttName] = modelData.pos[attCfg.adjustment.axis] -- set the default offset
		file.Write(fileName, util.TableToJSON(offsets)) -- write to file
		self:setNotification("Saved offset successfully!", 2, 255)
	end
	
	function CustomizableWeaponry.sightAdjustment:setNotification(text, duration, startAlpha)
		self.notificationText = text
		self.notificationTime = CurTime() + duration
		self.notificationAlpha = startAlpha
	end
	
	function CustomizableWeaponry.sightAdjustment:getModelConfig(attData)
		if attData.models then
			if attData.adjustment.index then
				return attData.models[attData.adjustment.index]
			else
				return attData.models[1]
			end
		end
		
		return attData
	end
	
	function CustomizableWeaponry.sightAdjustment:loadDefaultOffsets(wep)
		local baseDir = CustomizableWeaponry.sightAdjustment.folder
		
		local name = wep.ThisClass or wep:GetClass()
		local fileName = baseDir .. name .. ".txt"
		
		if file.Exists(fileName, "DATA") then -- if we currently have a file that contains default offsets, load it up so that we can append more data to it
			local offsets = util.JSONToTable(file.Read(fileName, "DATA"))
			
			for attName, offset in pairs(offsets) do
				local att = wep.AttachmentModelsVM[attName]
				
				if att and att.adjustment then -- check for adjustment in case an adjustment for some attachment gets removed in later versions
					local modelData = self:getModelConfig(att)
					
					modelData.pos[att.adjustment.axis] = offset
				end
			end
		end
	end
	
	CustomizableWeaponry.callbacks:addNew("initialize", function(wep)
		local ply = LocalPlayer()
		
		-- make sure: 1) the weapon is valid, 2) it has an owner, 3) we're the owner, 4) we don't have this weapon yet
		if wep and wep.Owner and wep.Owner == ply and not ply:HasWeapon(wep:GetClass()) then
			CustomizableWeaponry.sightAdjustment:loadDefaultOffsets(wep)
		end
	end)
	
	local emptyString = ""
	local hud16 = "CW_HUD32"
	local hud18 = "CW_HUD38"
	local hud20 = "CW_HUD40"
	local hud36 = "CW_HUD48"
	local hud24 = "CW_HUD48"
	
	function CustomizableWeaponry.sightAdjustment:draw(wep)
		wep.HUDColors.white.a = 255 * wep.CustomizeMenuAlpha
		wep.HUDColors.black.a = 255 * wep.CustomizeMenuAlpha
				
		if not self.currentModelData then
			local validAdjustments = 0 -- amount of sights/attachments that can have their position adjusted
			
			for k, v in pairs(wep.Attachments) do
				local attCategoryData, attData, modelData = self:canSetAttachment(wep, k)
				
				if attCategoryData and modelData then
					-- first index of 'offset' table is X, second is Y
					local x, y = v.offset[1], v.offset[2]
					
					draw.ShadowText(v.keyText .. " - Adjust "  .. v.header .. " category", hud36, x, y + 6, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					local offset = self:getOffset(attData, attData.adjustment)
					
					local rangeText = self:getIntendedRange(v, wep, offset)
			
					draw.ShadowText("Current offset: " .. math.floor(offset * 100) .. "% " .. (rangeText or ""), hud18, x, y + 50, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					validAdjustments = validAdjustments + 1
				end
			end
			
			if validAdjustments == 0 then
				draw.ShadowText("None of the currently active attachments can be adjusted.", hud36, 200, -300, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		else
			local attCategoryData, attData, modelData = self.currentAttData, self.currentAttConfigData, self.currentModelData
			local x, y = attCategoryData.offset[1], attCategoryData.offset[2]
			
			local dist = self:getOffset(attData, attData.adjustment)
			
			draw.ShadowText("Adjusting category: " .. attCategoryData.header, hud36, x, y + 6, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.ShadowText("Current offset: " .. math.floor(dist * 100) .. "% ", hud18, x, y + 50, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(0, 0, 0, 255 * wep.CustomizeMenuAlpha)
			
			-- left side, black shadow
			surface.DrawRect(x, y + 80, 8, 50)
			surface.DrawRect(x + 8, y + 80, 10, 6)
			surface.DrawRect(x + 8, y + 124, 10, 6)
			
			surface.DrawRect(x + 10, y + 94, 300 * dist, 20) -- offset "progress bar"
			
			-- right side
			surface.DrawRect(x + 312, y + 80, 8, 50)
			surface.DrawRect(x + 302, y + 80, 10, 6)
			surface.DrawRect(x + 302, y + 124, 10, 6)
			
			surface.SetDrawColor(255, 255, 255, 255 * wep.CustomizeMenuAlpha)
			
			-- left side, white base
			surface.DrawRect(x - 2, y + 80, 8, 49)
			surface.DrawRect(x + 6, y + 80, 10, 6)
			surface.DrawRect(x + 6, y + 123, 10, 6)
			
			surface.DrawRect(x + 310, y + 80, 8, 49)
			surface.DrawRect(x + 300, y + 80, 10, 6)
			surface.DrawRect(x + 300, y + 123, 10, 6)
			
			surface.DrawRect(x + 10, y + 94, 298 * dist, 18)
			
			local rangeText = self:getIntendedRange(self.currentAttData, wep, dist)
			
			if rangeText then
				draw.ShadowText(rangeText, hud36, x + 330, y + 103, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			
			local catOffset = 200
			
			if not wep.Owner:KeyDown(IN_ATTACK) then
				draw.ShadowText(wep:getKeyBind("+attack") .. " - Hold to begin adjusting", hud18, x, y + 160, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				draw.ShadowText(wep:getKeyBind("+attack") .. " - Release to stop adjusting", hud18, x, y + 160, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				draw.ShadowText("Move mouse horizontally to adjust", hud18, x, y + 200, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				catOffset = 240
			end
			
			draw.ShadowText(wep:getKeyBind("+attack2") .. " - Deselect category", hud18, x, y + catOffset, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.ShadowText(wep:getKeyBind("+reload") .. " - Save current offset as default offset", hud18, x, y + catOffset + 40, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
			if CurTime() > self.notificationTime then
				self.notificationAlpha = math.Approach(self.notificationAlpha, 0, FrameTime() * 200)
			end
			
			if self.notificationAlpha > 0 then
				wep.HUDColors.green.a = self.notificationAlpha
				wep.HUDColors.black.a = self.notificationAlpha
				
				draw.ShadowText(self.notificationText, hud36, x, y + catOffset + 80, wep.HUDColors.green, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
		
		wep.HUDColors.white.a = 255
		wep.HUDColors.black.a = 255
		wep.HUDColors.green.a = 255
	end
	
	CustomizableWeaponry:addRegularSound("CW_ADJUST_SIGHT_POSITION", {"cw/switch1.wav", "cw/switch2.wav", "cw/switch3.wav"}) -- we only need this sound on the client
end