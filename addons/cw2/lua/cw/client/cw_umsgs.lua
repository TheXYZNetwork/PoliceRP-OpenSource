local function CW20_LOSTATTACHMENTS()
	local ply = LocalPlayer()

	CustomizableWeaponry.postSpawn(ply)
end

usermessage.Hook("CW20_LOSTATTACHMENTS", CW20_LOSTATTACHMENTS)

-- this event removes previous attachments and adds new ones
net.Receive("CW20_OVERWRITEATTACHMENTS", function()
	local ply = LocalPlayer()
	
	ply.CWAttachments = ply.CWAttachments or {}
	local ply = LocalPlayer()
	local str = net.ReadString()
	
	-- remove previous attachments
	for k, v in pairs(ply.CWAttachments) do
		ply.CWAttachments[k] = nil
	end

	CustomizableWeaponry.decodeAttachmentString(ply, str)
end)

net.Receive("CW20_NEWATTACHMENTS", function()
	local ply = LocalPlayer()
	local str = net.ReadString()

	CustomizableWeaponry.decodeAttachmentString(ply, str)
end)

local comma = ", "

net.Receive("CW20_NEWATTACHMENTS_NOTIFY", function()
	local ply = LocalPlayer()
	local str = net.ReadString()
	
	-- decode the string
	local attNames = string.Explode(" ", str)
	
	-- figure out how many attachments we're missing
	local missingAttachments = CustomizableWeaponry:countMissingAttachments(ply, attNames)
	
	local final = ""
	local arraySize = #attNames
	
	local found = false
	
	-- assemble the attachment names
	for k, v in ipairs(attNames) do
		local target = CustomizableWeaponry.registeredAttachmentsSKey[v]
		
		-- make sure the player has the attachment and the specified attachment actually exists
		if target and not ply.CWAttachments[v] then
			if k == arraySize then
				final = final .. target.displayName
			else
				-- if only 1 attachment is missing, we shouldn't place a comma
				if missingAttachments == 1 then
					final = final .. target.displayName
				else
					final = final .. target.displayName .. comma
				end
			end
			
			-- add the attachments to the clientside table
			ply.CWAttachments[v] = true
			
			found = true
		end
	end
	
	if found then
		-- print the attachments we got
		chat.AddText(Color(255, 255, 255, 255), "Got new attachments: ", Color(0, 175, 255, 255), final, Color(255, 255, 255, 255), ".")
	else
		-- if there are none, let the player know (this shouldn't happen, since he shouldn't be able to pick up a package the contents of which he already has anyway)
		chat.AddText(Color(255, 175, 175, 255), "Got no new attachments from package.")
	end
end)