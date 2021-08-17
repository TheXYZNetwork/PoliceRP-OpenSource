--[[ attachment table structure:
1st index - table, which contains 1 table and 1 var: atts - the attachments table, last - the integer which indicates the last attachment which was attached
]]--
SWEP.AttachSoundDelay = 0

function SWEP:_attach(cur, curPos, inherit)
	self.LastPreset = nil
	local attTable = self.Attachments[cur]
	
	if SERVER then
		umsg.Start("CW20_ATTACH", self.Owner)
			umsg.Entity(self)
			umsg.String(cur)
			umsg.Short(curPos)
		umsg.End()
	end
	
	local att = inherit or CustomizableWeaponry:findAttachment(attTable.atts[curPos])
	
	if not att then
		return false
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "preAttachAttachment", cur, curPos)

	if attTable.last then
		local last = attTable.atts[attTable.last]
		
		if CLIENT then
			if self.AttachmentModelsVM then
				if self.AttachmentModelsVM[last] then
					self.AttachmentModelsVM[last].active = false
				end
			end
		end
		
		self:_detach(cur, attTable.last, true)
	end
	
	self:addStatModifiers(att.statModifiers)
	self.ActiveAttachments[att.name] = true
	self:checkAttachmentDependency()
	
	for varName, data in pairs(CustomizableWeaponry.knownVariableTexts) do
		if att[varName] then
			data.attachCallback(self, att)
		end
	end
	
	if att.attachFunc then
		att.attachFunc(self)
	end

	if CLIENT then
		-- if there is a model with the provided name, make it visible
		
		if self.AttachmentModelsVM then
			local model = self.AttachmentModelsVM[attTable.atts[curPos]]
			
			if model then
				model.active = true
			end
			
			-- if we're using a rail in conjunction with sights, make it visible upon attachment
			if att.isSight then
				self.AimPos = self[att.aimPos[1]]
				self.AimAng = self[att.aimPos[2]]
				self.ZoomAmount = att.FOVModifier or self.ZoomAmount
				
				--if the current attachment has backup sights, we can swap to them
				
				self.ActualSightPos = self.AimPos
				self.ActualSightAng = self.AimAng
				
				if self.BackupSights then
					local backUp = self.BackupSights[att.name]
						
					if backUp then
						self.SightBackUpPos = backUp[1]
						self.SightBackUpAng = backUp[2]
					else
						self.SightBackUpPos = nil
						self.SightBackUpAng = nil
					end
				end
				
				if self.SightWithRail then
					-- if the attachment disallows display of a rail, turn it off, otherwise, turn it on
					local state
					
					if att.withoutRail then
						state = false
					else
						state = true
					end

					local rail = self.AttachmentModelsVM.md_rail
					
					if rail then
						rail.active = state
					end

					if state then
						if self.RailBGs then
							self.CW_VM:SetBodygroup(self.RailBGs.main, self.RailBGs.on)
						end
					else
						if self.RailBGs then
							self.CW_VM:SetBodygroup(self.RailBGs.main, self.RailBGs.off)
						end
					end
				end
				
				-- apply this attachment's reticle draw function, if it has it
				self.reticleFunc = att.drawReticle
				self.renderTargetFunc = att.drawRenderTarget
				
				if not att.isBG then
					if self.SightBGs and self.SightBGs.none then
						self:setBodygroup(self.SightBGs.main, self.SightBGs.none)
					end
				end
			end
			
			if att.elementRender then
				self.elementRender[att.name] = att.elementRender
			end
		end
	end

	attTable.last = curPos
	
	if CLIENT then
		self:updateAttachmentPositions()
	end
	
	self:recalculateStats()
	
	CustomizableWeaponry.callbacks.processCategory(self, "postAttachAttachment", cur, curPos)
	
	return true
end

function SWEP:resetPostDetach(att, attCategory)
	-- reset things like aim FOV and reticle functions in case the detached attachment is a sight
	local attName = attCategory.atts[attCategory.last]
	
	CustomizableWeaponry.callbacks.processCategory(self, "preDetachAttachment", att, attCategory)
	
	if att.isSight then
		self.ZoomAmount = self.ZoomAmount_Orig
		self.reticleFunc = nil
		
		if self.SightWithRail then
			if self.AttachmentModelsVM.md_rail then
				-- make the rail inactive in case the weapon uses it for the sights
				self.AttachmentModelsVM.md_rail.active = false
			end
			
			if self.RailBGs then
				self.CW_VM:SetBodygroup(self.RailBGs.main, self.RailBGs.off)
			end
		end
		
		if self.SightBGs and self.SightBGs.none then
			self:setBodygroup(self.SightBGs.main, 0)
		end
		
		if CLIENT then
			self:resetAimToIronsights()
		end
	end
	
	if CLIENT then
		-- make attachment models inactive
		if self.AttachmentModelsVM then
			if self.AttachmentModelsVM[attName] then
				self.AttachmentModelsVM[attName].active = false
			end
		end
		
		-- remove any rendering functions it might have had
		self.elementRender[att.name] = nil
	end
	
	self.ActiveAttachments[att.name] = false
	attCategory.last = nil
	
	CustomizableWeaponry.callbacks.processCategory(self, "postDetachAttachment", att, attCategory)
end

function SWEP:_detach(category, pos, skipDependencyCheck)
	self.LastPreset = nil
	local att = self.Attachments[category]
	
	local foundAtt = CustomizableWeaponry:findAttachment(att.atts[pos])
	
	self:removeStatModifiers(foundAtt.statModifiers)

	for varName, data in pairs(CustomizableWeaponry.knownVariableTexts) do
		if foundAtt[varName] then
			data.detachCallback(self, foundAtt)
		end
	end

	if foundAtt.detachFunc then
		foundAtt.detachFunc(self)
	end
	
	self:resetPostDetach(foundAtt, att)
	
	-- only skip the dependency check if we're told to do so
	if not skipDependencyCheck then
		self:checkAttachmentDependency()
	end
	
	self:recalculateStats()
	
	if CLIENT then
		self:updateAttachmentPositions()
	end
end

function SWEP:detachAll()
	for k, v in pairs(self.Attachments) do
		if v.last then
			self:_detach(k, v.last)
		end
	end
	
	if SERVER then
		umsg.Start("CW20_DETACHALL", self.Owner)
			umsg.Entity(self)
		umsg.End()
		
		--SendUserMessage("CW20_DETACHALL", self.Owner)
	end
end

function SWEP:countActiveAttachments()
	local amount = 0
	
	for k, v in pairs(self.ActiveAttachments) do
		if v then
			amount = amount + 1
		end
	end
	
	return amount
end

-- this function is used when you just want to check whether an attachment of some kind can be attached
-- honestly this is some spaghetti point at this point, rip
-- ideally I should rewrite the entire base AGAIN, but fuck that lmao
function SWEP:canAttachSpecificAttachment(attachmentName, ply, imaginaryAttachments, imaginaryActiveAttachments, lookIn, attachmentCategoryData)
	local state, failureId, extraData = self:_canAttachSpecificAttachment(attachmentName, ply, imaginaryAttachments, imaginaryActiveAttachments, lookIn, attachmentCategoryData)
	local newState, newResult, newFailureId = CustomizableWeaponry.callbacks.processCategory(self, "canAttachSpecificAttachment", ply, attachmentName, state, result, failureId)
	
	if newState ~= nil then
		state = newState
	end
	
	if newResult ~= nil then
		result = newResult
	end
	
	if newFailureId ~= nil then
		failureId = newFailureId
	end
	
	return state, result, failureId
end

function SWEP:_canAttachSpecificAttachment(attachmentName, ply, imaginaryAttachments, imaginaryActiveAttachments, lookIn, attachmentCategoryData)
	ply = ply or self.Owner
	
	local result, failureID = nil
	
	if not attachmentCategoryData then
		for category, data in pairs(self.Attachments) do
			for key, attachment in ipairs(data.atts) do
				if attachment == attachmentName then
					attachmentCategoryData = data
					break
				end
			end
		end
	end
	
	result, failureID = self:performAttachmentEligibilityCheck(attachmentCategoryData, attachmentName, ply, imaginaryAttachments, imaginaryActiveAttachments, lookIn)
	
	return result, failureID
end

function SWEP:performAttachmentEligibilityCheck(attachmentCategoryData, attachmentName, playerObject, attachmentList, activeAttachmentList, playerOwnedAttachmentList)
	local att = CustomizableWeaponry.registeredAttachmentsSKey[attachmentName]
	
	if att.dependencies then
		local can, dependency = CustomizableWeaponry.canBeAttached(self, att, attachmentList)
		
		if not can then
			return false, self.UnavailableAttachmentEnum.NEED_ATTACHMENTS, dependency
		end
	end
	
	if attachmentCategoryData.exclusions then
		local has, exclusion = self:hasExcludedAttachment(attachmentCategoryData.exclusions, activeAttachmentList)
		
		if has then
			return true, self.UnavailableAttachmentEnum.INCOMPATIBILITY, exclusion
		end
	end
	
	-- checking whether it has dependencies or not saves us a loop
	if CustomizableWeaponry:hasAttachment(playerObject, att.name, playerOwnedAttachmentList) then
		local can, result, returnData = self:isAttachmentEligible(att.name, activeAttachmentList)

		if not can then
			return false, (result == self.AttachmentEligibilityEnum.ACTIVE_ATTACHMENT_EXCLUSION and self.UnavailableAttachmentEnum.INCOMPATIBLE_ATTACHMENT_PRESENT or self.UnavailableAttachmentEnum.DEPENDENT_ATTACHMENT_NOT_PRESENT), returnData -- -3 exclusion; -4 dependency
		end

		local can, result, returnData = self:isCategoryEligible(attachmentCategoryData.dependencies, attachmentCategoryData.exclusions, activeAttachmentList)
		
		if not can then
			return false, (result == self.AttachmentEligibilityEnum.ACTIVE_ATTACHMENT_EXCLUSION and self.UnavailableAttachmentEnum.INCOMPATIBLE_CATEGORY_PRESENT or self.UnavailableAttachmentEnum.DEPENDENT_CATEGORY_NOT_PRESENT), returnData -- -5 exclusion; -6 dependency
		end
		
		return true
	else
		return false, self.UnavailableAttachmentEnum.PLAYER_DOES_NOT_HAVE_ATTACHMENT
	end
	
	return false, self.UnavailableAttachmentEnum.MISC_FAILURE
end

if CLIENT then
	local function CW20_ATTACH(um)
		local wep = um:ReadEntity()
		local category = um:ReadString()
		local pos = um:ReadShort()
		
		local numberCategory = tonumber(category)
		
		if numberCategory then
			category = numberCategory
		end
		
		local ply = LocalPlayer()
		
		if not IsValid(wep) or not wep.CW20Weapon then
			return
		end
		
		if wep:_attach(category, pos) then
			if CustomizableWeaponry.playSoundsOnInteract then
				if CurTime() > wep.AttachSoundDelay then
					surface.PlaySound("cw/attach.wav")
					wep.AttachSoundDelay = CurTime() + FrameTime() * 3
				end
			end
		end
	end
	
	usermessage.Hook("CW20_ATTACH", CW20_ATTACH)
	
	local function CW20_DETACH(um)
		local wep = um:ReadEntity()
		local category = um:ReadString()
		local pos = um:ReadShort()
		
		local numberCategory = tonumber(category)
		
		if numberCategory then
			category = numberCategory
		end
		
		local ply = LocalPlayer()
		
		if not IsValid(wep) or not wep.CW20Weapon then
			return
		end
		
		wep:_detach(category, pos)
		
		if CustomizableWeaponry.playSoundsOnInteract then
			if CurTime() > wep.AttachSoundDelay then
				surface.PlaySound("cw/detach.wav")
				wep.AttachSoundDelay = CurTime() + FrameTime() * 3
			end
		end
	end
	
	usermessage.Hook("CW20_DETACH", CW20_DETACH)
	
	local function CW20_DETACHALL(data)
		local ply = LocalPlayer()
		local wep = data:ReadEntity()
		
		if not IsValid(wep) or not wep.CW20Weapon then
			return
		end
		
		CustomizableWeaponry.colorableParts.resetColors(wep)
		wep:detachAll(category, pos)
	end
	
	usermessage.Hook("CW20_DETACHALL", CW20_DETACHALL)
	
	local function CW20_PRESETSUCCESS(um)
		local presetName = um:ReadString()
		
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if not IsValid(wep) or not wep.CW20Weapon then
			return
		end
		
		CustomizableWeaponry.preset.postLoad(wep, presetName)
		wep.LastPreset = presetName
	end
	
	usermessage.Hook("CW20_PRESETSUCCESS", CW20_PRESETSUCCESS)
	
	local function CW20_PRESETDETACH(um)
		if CustomizableWeaponry.playSoundsOnInteract then
			surface.PlaySound("cw/detach.wav")
		end
	end
	
	usermessage.Hook("CW20_PRESETDETACH", CW20_PRESETDETACH)
end