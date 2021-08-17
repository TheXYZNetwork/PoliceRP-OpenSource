function SWEP:attachSpecificAttachment(attachmentName)
	-- since we don't know the category, we'll just have to iterate over all attachments, find the one we want, and attach it there
	for category, data in pairs(self.Attachments) do
		for key, attachment in ipairs(data.atts) do
			if attachment == attachmentName then
				self:attach(category, key - 1, false)
			end
		end
	end
end

function SWEP:attach(category, desiredPos, isPreset)
	-- reset the last preset entry in case what we're attaching isn't a preset
	if not isPreset then
		self.LastPreset = nil
	end
	
	desiredPos = desiredPos or nil

	if not category then
		return
	end
	
	local cur = self.Attachments[category]
	
	if not cur then
		return
	end
	
	-- check whether we've reached the end of the category
	
	if cur.last and cur.last == #cur.atts then
		-- if we have, detach what's currently attached
		
		self:detach(category)
	else
		-- if we haven't, attach the next attachment in the category
		local amt = #cur.atts
		local curPos = desiredPos and desiredPos or (cur.last or 0)
		
		-- loop forward until we find the end of the category
		-- we need this 'while true do' loop to loop through from current position to end position to switch attachments consistently, in case we didn't have some attachment in this category before
		
		while true do
			curPos = curPos + 1
			local targetAtt = cur.atts[curPos]
			
			if targetAtt then
				-- once we've found it, attach it, if we can
				local canAttach = self:canAttachSpecificAttachment(targetAtt, self.Owner, nil, nil, nil, cur)
				
				if canAttach then
					-- yes, preventAttachment is separate from canAttachSpecificAttachment, this is because attaching and prevention are two different things
					if CustomizableWeaponry.callbacks.processCategory(self, "preventAttachment", self.Attachments, curPos, cur, targetAtt) then
						return
					end
					
					self:_attach(category, curPos, CustomizableWeaponry.registeredAttachmentsSKey[cur.atts[curPos]])
					break
				end
				
				-- local att = CustomizableWeaponry.registeredAttachmentsSKey[cur.atts[curPos]]

				-- local can = true
	
				-- can = CustomizableWeaponry.canBeAttached(self, att, nil)
				
				-- if cur.exclusions and can then
					-- can = not self:hasExcludedAttachment(cur.exclusions)
				-- end
				
				-- -- checking whether it has dependencies or not saves us a loop
				-- if can then
					-- if CustomizableWeaponry:hasAttachment(self.Owner, att.name) then
						-- if self:isAttachmentEligible(att.name) and self:isCategoryEligible(cur.dependencies, cur.exclusions) then
							-- self:_attach(category, curPos, att)
							-- break
						-- end
					-- end
				-- end
			else
				self:detach(category)
				break
			end
		end
	end
end

function SWEP:detach(category)
	self.LastPreset = nil
	
	if not category then
		return
	end
	
	local att = self.Attachments[category]
	
	if not att or not att.last then
		return
	end
	
	local last = att.last
	
	self:_detach(category, last)
	
	umsg.Start("CW20_DETACH", self.Owner)
		umsg.Entity(self)
		umsg.String(category)
		umsg.Short(last)
	umsg.End()
	
	-- call the default reset function (to reset shit like FOV, etc.) 
	--self:resetPostDetach(foundAtt, att)
end

function SWEP:cycle40MMGrenades()
	CustomizableWeaponry.grenadeTypes.cycleGrenades(self)
	
	umsg.Start("CW20_GRENADETYPE", self.Owner)
		umsg.Short(self.Grenade40MM)
	umsg.End()
end

function SWEP:toggleCustomization()
	if self.dt.State ~= CW_CUSTOMIZE then
		self.dt.State = CW_CUSTOMIZE
		self.dt.M203Active = false
	else
		self.dt.State = CW_IDLE
	end
	
	self:delayEverything(self.CUSTOMIZATION_MENU_TOGGLE_WAIT)
end

local function CW20_Attach(ply, com, args)
	if not CustomizableWeaponry.canOpenInteractionMenu or not CustomizableWeaponry.customizationEnabled then
		return
	end
	
	if not ply:Alive() then
		return
	end
	
	local wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) or not wep.CW20Weapon or not wep.dt.State == CW_CUSTOMIZE then
		return
	end
	
	if CustomizableWeaponry.callbacks.processCategory(wep, "disableInteractionMenu") then
		return
	end
	
	local category = args[1]
	
	if not category then
		return
	end
	
	local numberCategory = tonumber(category) -- attempt to turn the category into a string
	
	-- if it's possible, assign the category to the number variant of the string argument (compatibility with numerical and string categories)
	if numberCategory then
		category = numberCategory
	end
	
	wep:attach(category)
end

concommand.Add("cw_attach", CW20_Attach)

local function CW20_CycleGrenadeTypes(ply, com, args)
	if not CustomizableWeaponry.canOpenInteractionMenu or not CustomizableWeaponry.customizationEnabled then
		return
	end
	
	if not ply:Alive() then
		return
	end
	
	local wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) or not wep.CW20Weapon or not wep.dt.State == CW_CUSTOMIZE then
		return
	end
	
	if CustomizableWeaponry.callbacks.processCategory(wep, "disableInteractionMenu") then
		return
	end
	
	wep:cycle40MMGrenades()
end

concommand.Add("cw_cycle40mm", CW20_CycleGrenadeTypes)

local function CW20_Customize(ply, com, args)
	if not CustomizableWeaponry.canOpenInteractionMenu or not CustomizableWeaponry.customizationEnabled then
		return
	end
	
	if not ply:Alive() then
		return
	end
	
	local wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) or not wep.CW20Weapon then
		return
	end
	
	if wep:canCustomize() then
		wep:toggleCustomization()
	end
end

concommand.Add("cw_customize", CW20_Customize)