AddCSLuaFile()

CustomizableWeaponry.interactionMenu = {}
CustomizableWeaponry.interactionMenu.CUSTOMIZATION_TAB = 1
CustomizableWeaponry.interactionMenu.PRESET_TAB = 2
CustomizableWeaponry.interactionMenu.tabs = {}

function CustomizableWeaponry.interactionMenu:keyPressed(key, pressed)
	-- loop through customization menu tab key bindings and set to one of them in case we find something
	-- return TRUE to suppress key bindings
	-- return FALSE to not suppress key bindings but stop further key press processing
	-- return NIL to not suppress key bindings and allow further key press processing
	local found = nil
	
	for k, v in pairs(CustomizableWeaponry.interactionMenu.tabs) do
		if key == v.switchToKey then
			-- make sure we're not setting it to a tab we're already in
			if self.CustomizationTab ~= v.id then
				local curTab = CustomizableWeaponry.interactionMenu.tabs[self.CustomizationTab]
				
				if curTab and curTab.switchAway then -- check if there's a switchAway callback for the current tab, and if there is, call it
					curTab.switchAway(self)
				end
				
				self.CustomizationTab = v.id
				
				if v.callback then
					return v.callback(self, key)
				end
				
				found = true
				CustomizableWeaponry.interactionMenu.activeTab = v.id
				break
			else
				found = true
				break
			end
			
			-- no action done, suppress key binds
			found = true
			break
		else
			if v.id == self.CustomizationTab then
				if v.processKey then
					found = v.processKey(self, key, pressed)
				end
			end
		end
	end
	
	return found
end
	
function CustomizableWeaponry.interactionMenu:draw()
	local section = CustomizableWeaponry.interactionMenu.tabs[self.CustomizationTab]
	
	if section then
		if section.drawFunc then
			section.drawFunc(self)
		end
	end
end

function CustomizableWeaponry.interactionMenu:addTab(tab)
	local tabId = tab.id or #self.tabs + 1
	tab.id = tabId
	
	self[tab.name] = tabId
	self.tabs[tabId] = tab
end

local path = "cw/shared/menutabs/"

-- load menu interaction tab files

for k, v in pairs(file.Find("cw/shared/menutabs/*", "LUA")) do
	loadFile(path .. v)
end