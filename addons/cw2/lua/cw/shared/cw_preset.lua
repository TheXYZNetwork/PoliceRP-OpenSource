AddCSLuaFile()

-- as with all other classes, don't remove this one
-- just set 'enabled' to false if you want to disable the preset system

CustomizableWeaponry.preset = {}
CustomizableWeaponry.preset.enabled = true -- set this to 'false' to disable preset saving/loading
CustomizableWeaponry.preset.delay = 1 -- amount of time in seconds to delay the ability to load a preset after the client did that just now
CustomizableWeaponry.preset.networkString = "CW20_PRESET_LOAD" -- the string that will be used for preset loading networking
CustomizableWeaponry.preset.presetSavedString = "CW20_PRESET_SAVED" -- the string that will be sent to the server to notify that we saved a preset
CustomizableWeaponry.preset.folder = CustomizableWeaponry.baseFolder .. "/presets/"
CustomizableWeaponry.preset.invalidSymbols = "[/.:;']"

-- setup directory to save files in

if not file.IsDir(CustomizableWeaponry.preset.folder, "DATA") then
	file.CreateDir(CustomizableWeaponry.preset.folder)
end

if CustomizableWeaponry.preset.enabled then
	if SERVER then
		net.Receive(CustomizableWeaponry.preset.networkString, function(len, ply)
			-- read and decode the received string
			local name_sv = net.ReadString()
			local data = net.ReadString()
			data = util.JSONToTable(data)
			if not data then return end
			
			local wep = ply:GetActiveWeapon()
			
			-- make sure we're trying to load the preset onto a CW 2.0 weapon
			if not IsValid(wep) or not wep.CW20Weapon then
				return
			end
			
			if (wep.ThisClass or wep:GetClass()) ~= data.wepClass then
				return
			end
			
			CustomizableWeaponry.preset.load(wep, data, name_sv)
		end)
		
		net.Receive(CustomizableWeaponry.preset.presetSavedString, function(len, ply)
			-- read and decode the received string
			local presetName = net.ReadString()
			
			local wep = ply:GetActiveWeapon()
			
			-- make sure we're trying to load the preset onto a CW 2.0 weapon
			if not IsValid(wep) or not wep.CW20Weapon then
				return
			end

			wep.LastPreset = presetName
		end)
		
		util.AddNetworkString(CustomizableWeaponry.preset.networkString)
		util.AddNetworkString(CustomizableWeaponry.preset.presetSavedString)
	end
end

--[[ ideally the save function should only be called on the client, since the load/save system works like this:
SAVE:
1. client attaches stuff on his weapon
2. client saves the preset on HIS COMPUTER
3. client tells the server that he saved a new preset

LOAD:
1. client decides to load a certain preset
2. client sends JSON string to server containing the preset
3. server decodes the preset
4. server attaches the attachments and networks it to the client

this is mainly to make presets independent from the server and not have a fuckton of preset files on the server
]]--

function CustomizableWeaponry.preset:getWeaponFolder()
	return CustomizableWeaponry.preset.folder .. (self.ThisClass or self:GetClass()) .. "/"
end

function CustomizableWeaponry.preset:postLoad(name)
	local dir = CustomizableWeaponry.preset.getWeaponFolder(self)
	local path = dir .. "colors/" .. name .. ".txt"
	
	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		data = util.JSONToTable(data)
		CustomizableWeaponry.preset.loadColors(self, data)
	end
	
	local path = dir .. "offsets/" .. name .. ".txt"
	
	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		data = util.JSONToTable(data)
		
		for key, value in pairs(data) do
			local modelData = self.AttachmentModelsVM[key]
			
			modelData.pos[modelData.adjustment.axis] = value
		end
	end	
end

function CustomizableWeaponry.preset:loadColors(data)
	-- welp, nothing to read
	if not data then
		return
	end
	
	for k, v in pairs(data) do
		CustomizableWeaponry.colorableParts.setColor(self, k, v)
	end
end

function CustomizableWeaponry.preset:save(name)
	if not CustomizableWeaponry.customizationEnabled then
		return false
	end
	
	-- can't save if presets are disabled
	if not CustomizableWeaponry.preset.enabled then
		return
	end
	
	-- can't save presets on a non-CW 2.0 weapon
	if not self.CW20Weapon then
		return
	end
	
	local dir = CustomizableWeaponry.preset.getWeaponFolder(self)
	
	-- make sure all the directories are present prior to saving
	if not file.IsDir(dir, "DATA") then
		file.CreateDir(dir) 
	end
	
	if not file.IsDir(dir .. "colors/", "DATA") then
		file.CreateDir(dir .. "colors/")
	end
	
	if not file.IsDir(dir .. "offsets/", "DATA") then
		file.CreateDir(dir .. "offsets/")
	end
	
	-- either save the preset with a specified name or with the amount of presets in the folder as it's name
	name = name or "preset" .. #file.Find(dir .. "preset_*", "DATA") + 1
	name = string.gsub(name, CustomizableWeaponry.preset.invalidSymbols, "")
	
	-- setup data to save
	local data = {}
	data.wepClass = (self.ThisClass or self:GetClass())
	data.grenadeType = self.Grenade40MM
	
	-- get attachments that are installed on the weapon and add them to the table for saving
	-- subtract by one since when the attachment check loop begins, it increments the 'position' value by 1
	for k, v in pairs(self.Attachments) do
		if v.last and v.last > 0 then
			data[k] = v.last
		end
	end
	
	local offsets = {}
	
	if self.AttachmentModelsVM then
		for k, v in pairs(self.AttachmentModelsVM) do
			if v.active and v.adjustment then
				offsets[k] = v.pos[v.adjustment.axis]
			end
		end
	end
	
	-- setup the reticle/beam/etc. colors to save
	local colors = {}
	
	-- save active sight colors
	for k, v in pairs(self.SightColors) do
		if v.last > 1 then
			colors[k] = v.last
			canWriteColors = true
		end
	end
	
	local encoded = util.TableToJSON(data)
	
	-- save the preset file
	file.Write(dir .. name .. ".txt", encoded)
	
	-- save the sight colors only if we have any of them modified
	if table.Count(colors) > 0 then
		local encodedColors = util.TableToJSON(colors)
		file.Write(dir .. "colors/" .. name .. ".txt", encodedColors)
	end
	
	-- save sight offsets
	if table.Count(offsets) > 0 then
		local encodedOffsets = util.TableToJSON(offsets)
		file.Write(dir .. "offsets/" .. name .. ".txt", encodedOffsets)
	end
	
	self.LastPreset = CustomizableWeaponry.preset.specifiedName
	CustomizableWeaponry.preset.specifiedName = nil
	
	if CLIENT then
		-- let the server know that we've saved a preset, so that when we try to remove it, it'll remove it rather than re-equip it
		net.Start(CustomizableWeaponry.preset.presetSavedString)
			net.WriteString(name)
		net.SendToServer()
	end
end

function CustomizableWeaponry.preset:delete(dir, fileName)
	if not CustomizableWeaponry.customizationEnabled then
		return false
	end
	
	dir = dir or CustomizableWeaponry.preset.getWeaponFolder(self)
	local targetFile = dir .. fileName .. ".txt"
	
	if file.Exists(targetFile, "DATA") then
		file.Delete(targetFile)
	end
	
	CustomizableWeaponry.preset.updateList(self, dir)
end

--[[ the load function should be called on the client
it'll send the desired attachment preset to the server, which will decode it, attach it (if possible) and network it to the client
]]--

function CustomizableWeaponry.preset:canSave()
	if not CustomizableWeaponry.customizationEnabled then
		return false
	end
	
	-- if the weapon has any attachments on it, that means that we can save a preset
	for k, v in pairs(self.ActiveAttachments) do
		if v then
			return true
		end
	end
	
	return false
end

function CustomizableWeaponry.preset:attemptDelete(entry)
	if not self.PresetResults then
		return false
	end
	
	entry = entry - 1
	
	local result = self.PresetResults[entry]
	
	if not result then
		return false
	end

	local dir = CustomizableWeaponry.preset.getWeaponFolder(self)
	
	if not file.Exists(dir .. result.name, "DATA") then
		return false
	end
	
	CustomizableWeaponry.preset.delete(self, dir, result.displayName)
	return true
end

function CustomizableWeaponry.preset:canDelete(fileName)
	if not file.Exists(CustomizableWeaponry.preset.getWeaponFolder(self) .. fileName, "DATA") then 
		return false
	end
	
	return true
end

function CustomizableWeaponry.preset:updateList(folder)
	folder = folder or CustomizableWeaponry.preset.getWeaponFolder(self)
	local result = file.Find(folder .. "*", "DATA")
	
	for k, v in pairs(result) do
		if file.IsDir(v, "DATA") then
			result[k] = nil
		else
			-- remove .txt format in advance to not do pointless string operations when drawing
			result[k] = {displayName = string.gsub(v, ".txt", ""), name = v}
		end
	end
	
	table.Sanitise(result)
	
	self.PresetResults = result
end

if CLIENT then
	function CustomizableWeaponry.preset:makeSavePopup()
		-- better save than sorry
		if not CustomizableWeaponry.preset.canSave(self) then
			return
		end
		
		CustomizableWeaponry.preset.specifiedName = nil
		
		local frame = vgui.Create("DFrame")
		frame:SetSize(220, 90)
		frame:SetTitle("Saving new preset")
		frame:Center()
		frame:MakePopup()
		
		function frame:Paint()
			local w, h = self:GetSize()
			
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawOutlinedRect(0, 0, w, h)
			surface.DrawRect(2, 2, w - 4, 21)
			
			surface.SetDrawColor(0, 0, 0, 200)
			surface.DrawRect(1, 1, w - 2, h - 2)
		end
		
		local textBox = vgui.Create("DTextEntry", frame)
		textBox:SetPos(20, 30)
		textBox:SetSize(180, 20)
		textBox:SetText("Enter preset name...")
		
		function textBox:OnMousePressed()
			self:SetText("")
		end
		
		function textBox:OnTextChanged()
			local text = self:GetText()
			
			if text == "" then
				CustomizableWeaponry.preset.specifiedName = nil
			else
				CustomizableWeaponry.preset.specifiedName = text
			end
		end
		
		textBox.OnEnter = function()
			CustomizableWeaponry.preset.save(self, CustomizableWeaponry.preset.specifiedName)
			CustomizableWeaponry.preset.updateList(self)
			frame:Close()
		end
		
		local saveButton = vgui.Create("DButton", frame)
		saveButton:SetPos(20, 60)
		saveButton:SetSize(80, 18)
		saveButton:SetText("Save")
		saveButton.DoClick = function()
			CustomizableWeaponry.preset.save(self, CustomizableWeaponry.preset.specifiedName)
			CustomizableWeaponry.preset.updateList(self)
			frame:Close()
		end
		
		local cancelButton = vgui.Create("DButton", frame)
		cancelButton:SetPos(120, 60)
		cancelButton:SetSize(80, 18)
		cancelButton:SetText("Cancel")
		cancelButton.DoClick = function()
			frame:Close()
		end
	end
end

function CustomizableWeaponry.preset:load(data, name_sv)
	if not CustomizableWeaponry.customizationEnabled then
		return false
	end
	
	-- can't load if preset system is disabled
	if not CustomizableWeaponry.preset.enabled then
		return
	end
	
	local CT = CurTime()
	
	-- anti-spam
	if CT < self.PresetLoadDelay then
		return
	end
	
	-- can't load a non-existing preset
	-- on the client, 'data' is the preset name
	-- on the server, 'data' is the decoded JSON string
	if not data then
		return
	end
	
	-- can't load a preset on a non-CW 2.0 weapon
	if not self.CW20Weapon then
		return
	end
	
	if CLIENT then
		local preset = file.Read(CustomizableWeaponry.preset.getWeaponFolder(self) .. data .. ".txt", "DATA")
		
		-- can't load a non-existant preset, or a blank file
		if not preset or preset == "" then
			return
		end
		
		net.Start(CustomizableWeaponry.preset.networkString)
			net.WriteString(data)
			net.WriteString(preset)
		net.SendToServer()
	end
	
	if SERVER then
		-- if our preset names don't match, that means we want to switch to a new one
		if self.LastPreset ~= name_sv then
			-- we need to set up a load order, since some attachments depend on others
			local loadOrder = {}
			
			for k, v in pairs(data) do
				local attCategory = self.Attachments[k]
				
				-- make sure we're loading a registered attachment
				if attCategory then
					local att = CustomizableWeaponry.registeredAttachmentsSKey[attCategory.atts[v]]
					
					if att then
						local pos = 1
						
						-- if the attachment has dependencies, put it in the back of the load order, and load ones that don't depend on anything
						if att.dependencies or attCategory.dependencies or (self.AttachmentDependencies and self.AttachmentDependencies[att.name]) then
							pos = #loadOrder + 1
						end
						
						table.insert(loadOrder, pos, {category = k, position = v})
					end
				end
			end
		
			-- don't forget to detach everything prior to loading an attachment preset
			self:detachAll()
			
			for k, v in pairs(loadOrder) do
				self:attach(v.category, v.position - 1)
			end
			
			CustomizableWeaponry.grenadeTypes.setTo(self, (data.grenadeType or 0), true)
			
			self.LastPreset = name_sv

			umsg.Start("CW20_PRESETSUCCESS", self.Owner)
				umsg.String(name_sv)
			umsg.End()
		else
			-- if they do, that means we just want to remove a preset
			self:detachAll()
			SendUserMessage("CW20_PRESETDETACH", self.Owner)
			
			-- reset the 40MM grenade type
			CustomizableWeaponry.grenadeTypes.setTo(self, 0, true)
		end
	end
	
	self.PresetLoadDelay = CT + CustomizableWeaponry.preset.delay
end