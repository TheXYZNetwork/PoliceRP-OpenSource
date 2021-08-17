APG_panels = APG_panels or {}

local pull = include("cl_utils.lua")
local utils = pull.utils or {}
local menu = pull.menu or {}

local function showNotice(notifyLevel, notifyMessage)
	if string.Trim(notifyMessage) == "" then return end
	icon = notifyLevel == 0 and NOTIFY_GENERIC or notifyLevel == 1 and NOTIFY_CLEANUP or notifyLevel == 2 and NOTIFY_ERROR

	notification.AddLegacy(notifyMessage, icon, 3 + (notifyLevel * 3))

	if APG.cfg[ "notifySounds" ].value then
		surface.PlaySound(notifyLevel == 1 and "buttons/button10.wav" or notifyLevel == 2 and "ambient/alarms/klaxon1.wav" or "buttons/lightswitch2.wav") -- Maybe let the player choose the sound?
	end

	MsgC( notifyLevel == 0 and Color( 0, 255, 0 ) or Color( 255, 191, 0 ), "[APG] ", Color( 255, 255, 255 ), notifyMessage,"\n")
end

net.Receive( "apg_notice_s2c", function()
	local notifyLevel = net.ReadUInt( 3 )
	local notifyMessage = net.ReadString()
	showNotice(notifyLevel, notifyMessage)
end)

local function APGBuildHomePanel()
	local panel = APG_panels[ "home" ]
	panel.Paint = function( i, w, h ) end

	local github = "https://github.com/NanoAi/gm_apg"

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:switch( 568, 20, "Welcome to APG! ( https://git.io/fjCQK )")
	menu:switch( 568, 20, "Remember to check the github for updates! (Click to Copy)", function()
		SetClipboardText( github )
		showNotice(0, "Github URL copied to clipboard!")
	end)
	menu:switch( 568, 20, "<-- Select a Module to Configure!")
	menu:switch( 568, 20, "To see this menu again just say \"!apg\"")
	menu:switch( 568, 20, "For more help the wiki is available on the Github! (Click to Copy)", function()
		SetClipboardText( github .. "/wiki" )
		showNotice(0, "Github URL copied to clipboard!")
	end)
	menu:switch( 568, 20, "Sorry for the bad home page, this is hopefully a placeholder. : )")
	menu:panelDone()
end

local function APGBuildStackPanel()
	local panel = APG_panels[ "stack_detection" ]
	panel.Paint = function( i, w, h ) end

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:numSlider( 568, 20, "Maximum stacked ents", "stackMax", 3, 50, 0 )
	menu:numSlider( 568, 20, "Stack distance (gmod units)", "stackArea", 5, 50, 0 )
	menu:numSlider( 568, 20, "Maximum stacked fading doors", "fadingDoorStackMax", 5, 50, 0 )
	menu:switch( 568, 20, "Notify player when their fading door is removed.", "fadingDoorStackNotify" )
	menu:panelDone()
end

local function APGBuildToolsPanel()
	local panel = APG_panels[ "tools" ]
	panel.Paint = function( i, w, h ) end

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:switch( 568, 20, "Should tools be blocked on APG_CantPickup", "checkCanTool" )
	menu:switch( 568, 20, "Block players from spamming the toolgun", "blockToolSpam" )
	menu:numSlider( 568, 20, "Max click's per second(s)", "blockToolRate", 1, 15, 0 ) -- It's really hard to click more then 15 times a second.
	menu:numSlider( 568, 20, "The aforementioned second(s)", "blockToolDelay", 1, 5, 0 )
	menu:switch( 568, 20, "Prevent using the toolgun on the world", "blockToolWorld" )
	menu:switch( 568, 20, "Prevent the toolgun from unfreezing props", "blockToolUnfreeze" )
	menu:switch( 568, 20, "Block the Creator Tool? (Requires OSS)", "blockCreatorTool" )
	menu:switch( 568, 20, "Review entities near tool use", "checkTooledEnts" )
	menu:panelDone()
end

local function APGBuildMiscPanel()
	local panel = APG_panels[ "misc" ]
	panel.Paint = function( i, w, h ) end

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:switch( 568, 20, "Override Server Settings? (OSS)", "touchServerSettings" )
	menu:switch( 568, 20, "Auto freeze over time", "autoFreeze" )
	menu:numSlider( 568, 20, "Auto freeze delay(seconds)", "autoFreezeTime", 5, 600, 0 )
	menu:switch( 568, 20, "Disable vehicle damages", "vehDamage" )
	menu:switch( 568, 20, "Disable vehicle collisions (with players)", "vehNoCollide" )
	menu:numSlider(575, 20, "Physgun maxrange (how far they can reach in gmod units)", "physGunMaxRange", 128, 8192, 0)
	menu:switch( 568, 20, "Block GravGun throwing", "blockGravGunThrow" )
	menu:switch( 568, 20, "Block Physgun Reload", "blockPhysgunReload" )
	menu:switch( 568, 20, "Block players from moving contraptions", "blockContraptionMove" )
	menu:switch( 568, 20, "Inject custom hooks into Fading Doors", "fadingDoorHook" )
	menu:switch( 568, 20, "Activate FRZR9K (Sleepy Physics)", "sleepyPhys" )
	menu:switch( 568, 20, "Hook FRZR9K into collision (Experimental)", "sleepyPhysHook" )
	menu:switch( 568, 20, "Allow prop killing", "allowPK" )
	menu:switch( 568, 20, "Activate Turbo Physics (Requires OSS)", "setTurboPhysics" )
	menu:switch(568, 20, "Fading Door Materials - " .. APG.cfg.fdMat.desc, "fdMat")
	menu:panelDone()
end

local function APGBuildLagPanel()
	local panel = APG_panels[ "lag_detection" ]
	panel.Paint = function( i, w, h ) end

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:numSlider( 568, 20, "Lag threshold (%)", "lagTrigger", 5, 200, 0 )
	menu:numSlider( 568, 20, "Frames lost", "lagsCount", 1, 20, 0 )
	menu:numSlider( 568, 20, "Heavy lag trigger (seconds)", "bigLag", 1, 5, 1 )
	menu:comboBox( 568, 20, "Lag fix function", "lagFunc", APG_lagFuncs )
	menu:numSlider( 568, 20, "Lag func. delay (seconds)", "lagFuncTime", 1, 300, 0 )
	menu:panelDone()
end

local function APGBuildNotificationPanel()
	local panel = APG_panels[ "notification" ]
	panel.Paint = function( i, w, h ) end

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:switch( 568, 20, "Notification Sounds", "notifySounds" )
	menu:comboBox( 568, 20, "Notification Level", "notifyLevel", APG_notifyLevels )
	menu:switch( 570, 20, "Do you want to show what lag function ran?", "notifyLagFunc" )
	menu:switch( 568, 20, "Developer logs (shows a notification, is spammy)", "developerDebug" )
	menu:panelDone()
end

local function APGBuildLogsPanel()
	local panel = APG_panels[ "logs" ]
	panel.Paint = function( i, w, h ) end

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:switch( 568, 20, "Should we log when there is lag detected?", "logLagDetected" )
	menu:switch( 568, 20, "Should we log when a player attempts to crash the server", "logStackCrashAttempt" )
	menu:panelDone()
end

local function APGBuildGhostPanel()
	local panel = APG_panels[ "ghosting" ]

	panel.Paint = function( i, w, h)
		draw.RoundedBox( 0, 0, 37, 170, 135, Color( 38, 38, 38, 255 ) )
		draw.DrawText( "Ghosting color:", "APG_element_font", 5, 37, Color( 189, 189, 189 ), 3 )
		--draw.RoundedBox(cornerRadius, x, y, width, height, color)
		draw.RoundedBox( 0, 175, 37, 500, 300, Color( 38, 38, 38, 255) )
		draw.DrawText( "Bad entities:", "APG_element_font", 180, 37, Color( 189, 189, 189), 3 )
		draw.DrawText( "(Right-Click to Toggle)", "APG_title2_font", 280, 38, Color( 189, 189, 189), 3 )
		--draw.DrawText(text, font="DermaDefault", x=0, y=0, color=Color(255,255,255,255), xAlign=TEXT_ALIGN_LEFT)
		draw.DrawText( "Good entities:", "APG_element_font", 180, 230, Color( 189, 189, 189), 3 )
		draw.DrawText( "(Right-Click to Toggle)", "APG_title2_font", 285, 232, Color( 189, 189, 189), 3 )
	end

	menu:initPanel( panel, 0, 180, 0, 35 )
	menu:switch( 170, 20, "Always frozen", "alwaysFrozen" )
	menu:switch( 170, 20, "Fading Doors", "fadingDoorGhosting" )
	menu:switch( 170, 20, "Ignore Vehicles", "vehAntiGhost" )
	menu:switch( 170, 20, "Enable Color", "ghostColorToggle")
	local offsets = menu:panelDone()

	local Mixer = vgui.Create( "CtrlColor", panel )
	Mixer:SetPos( 5, 55 )
	Mixer:SetSize( 160, 110 )
	Mixer.Mixer.ValueChanged = function( self, color )
		APG.cfg[ "ghostColor" ].value = Color( color.r, color.g, color.b, color.a)
	end

	local badList = vgui.Create( "DListView", panel )
	badList:Clear()
	badList:SetPos( 180, 55 )
	badList:SetSize( panel:GetWide() - 185, panel:GetTall() / 2.5 )
	badList:SetMultiSelect( false )
	badList:SetHideHeaders( false )
	badList:AddColumn( "Class" )
	badList:AddColumn( "Exact" )

	function badList:OnRowRightClick( id, line )
		local key = line:GetColumnText(1)
		local value = not tobool(line:GetColumnText(2))
		line:SetColumnText( 2, value )
		APG.cfg[ "badEnts" ].value[key] = value
	end

	local goodList = vgui.Create( "DListView", panel )
	goodList:Clear()
	goodList:SetPos( 180, 250 )
	goodList:SetSize( panel:GetWide() - 185, panel:GetTall() / 2.5 )
	goodList:SetMultiSelect( false )
	goodList:SetHideHeaders( false )
	goodList:AddColumn( "Class" )
	goodList:AddColumn( "Exact" )

	function goodList:OnRowRightClick( id, line )
		local key = line:GetColumnText(1)
		local value = not tobool(line:GetColumnText(2))
		line:SetColumnText( 2, value )
		APG.cfg[ "unGhostingWhitelist" ].value[key] = value
	end


	local function updateTab()

		badList:Clear()
		for class,complete in pairs(APG.cfg[ "badEnts" ].value) do
			badList:AddLine(class, complete)
		end

		goodList:Clear()
		for class,complete in pairs(APG.cfg[ "unGhostingWhitelist" ].value) do
			goodList:AddLine(class, complete)
		end

	end
	updateTab()

	badList.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 150, 150, 150, 255 ) )
	end

	badList.VBar.Paint = function(i,w,h)
		surface.SetDrawColor( 88, 110, 110, 240 )
		surface.DrawRect( 0, 0, w, h )
	end

	badList.VBar.btnGrip.Paint = function(i,w,h)
		surface.SetDrawColor( 255, 83, 13, 50 )
		surface.DrawRect( 0, 0, w, h )
		draw.RoundedBox( 0, 1, 1, w - 2, h / 2, Color( 72, 89, 89, 255 ) )
	end

	badList.VBar.btnUp.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 72, 89, 89, 240 ) )
	end

	badList.VBar.btnDown.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 72, 89, 89, 240 ) )
	end

	goodList.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 150, 150, 150, 255 ) )
	end

	goodList.VBar.Paint = function(i,w,h)
		surface.SetDrawColor( 88, 110, 110, 240 )
		surface.DrawRect( 0, 0, w, h )
	end

	goodList.VBar.btnGrip.Paint = function(i,w,h)
		surface.SetDrawColor( 255, 83, 13, 50 )
		surface.DrawRect( 0, 0, w, h )
		draw.RoundedBox( 0, 1, 1, w - 2, h / 2, Color( 72, 89, 89, 255 ) )
	end

	goodList.VBar.btnUp.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 72, 89, 89, 240 ) )
	end

	goodList.VBar.btnDown.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 72, 89, 89, 240 ) )
	end

	local BadTextEntry = vgui.Create( "DTextEntry", panel )
	BadTextEntry:SetPos( offsets.x, panel:GetTall() - 100 )
	BadTextEntry:SetSize( 100, 20 )
	BadTextEntry:SetText( "Bad Entity class" )
	BadTextEntry.OnEnter = function( self )
		chat.AddText( self:GetValue() )
	end

	local BadAdd = vgui.Create( "DButton" , panel)
	BadAdd:SetPos( offsets.x + 100, panel:GetTall() - 100 )
	BadAdd:SetSize( 75,20 )
	BadAdd:SetText( "Add" )
	BadAdd.DoClick = function()
		if BadTextEntry:GetValue() == "Bad Entity class" then return end
		utils.addBadEntity( BadTextEntry:GetValue() )
		updateTab()
	end

	BadAdd:SetTextColor( Color(255, 255, 255) )
	BadAdd.Paint = function( i, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 44, 55, 55, 255 ) )
		draw.RoundedBox( 0, 1, 1, w-2, h-2, Color( 58, 58, 58, 255 ) )
	end

	local BadRemove = vgui.Create( "DButton" , panel)
	BadRemove:SetPos( offsets.x, panel:GetTall() - 80 )
	BadRemove:SetSize( 175, 20 )
	BadRemove:SetText( "Remove selected" )
	BadRemove.DoClick = function()
		for k, v in pairs(badList:GetSelected()) do
			local key = v:GetValue(1)
			APG.cfg[ "badEnts" ].value[key] = nil
			updateTab()
		end
	end

	BadRemove:SetTextColor( Color( 255, 255, 255 ) )
	BadRemove.Paint = function( i, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 58, 58, 58, 255 ) )
		draw.RoundedBox( 0, 0, 0, w, 1, Color( 30, 30, 30, 125 ) )
	end

	local GoodTextEntry = vgui.Create( "DTextEntry", panel )
	GoodTextEntry:SetPos( offsets.x, panel:GetTall() - 45 )
	GoodTextEntry:SetSize( 100, 20 )
	GoodTextEntry:SetText( "Good Entity class" )
	GoodTextEntry.OnEnter = function( self )
		chat.AddText( self:GetValue() )
	end

	local GoodAdd = vgui.Create( "DButton" , panel)
	GoodAdd:SetPos( offsets.x + 100, panel:GetTall() - 45 )
	GoodAdd:SetSize( 75,20 )
	GoodAdd:SetText( "Add" )
	GoodAdd.DoClick = function()
		if GoodTextEntry:GetValue() == "Good Entity class" then return end
		utils.addGoodEntity( GoodTextEntry:GetValue() )
		updateTab()
	end

	local GoodRemove = vgui.Create( "DButton" , panel)
	GoodRemove:SetPos( offsets.x, panel:GetTall() - 25 )
	GoodRemove:SetSize( 175, 20 )
	GoodRemove:SetText( "Remove selected" )
	GoodRemove.DoClick = function()
		for k, v in pairs(goodList:GetSelected()) do
			local key = v:GetValue(1)
			APG.cfg[ "unGhostingWhitelist" ].value[key] = nil
			updateTab()
		end
	end

	GoodRemove:SetTextColor( Color( 255, 255, 255 ) )
	GoodRemove.Paint = function( i, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 58, 58, 58, 255 ) )
		draw.RoundedBox( 0, 0, 0, w, 1, Color( 30, 30, 30, 125 ) )
	end
end

local function APGBuildAdvDupePanel()
	local panel = APG_panels[ "advdupe" ]

	menu:initPanel( panel, 0, 40, 0, 35 )
	menu:numSlider( panel:GetWide(), 20, "Max scale of AdvDupe props", "maxScale", 1, 100, 0 )
	menu:switch( panel:GetWide(), 20, "Disable rope protection (Stops annoying white rope)", "ropeSpam" )
	menu:panelDone()
end

local main_color = Color( 32, 255, 0, 255 )
local main_color_red = Color( 96, 0, 0, 255 )
local main_color_darker = Color( 51, 91, 51, 255 )

local function setScrollerTheme( scroller )
	scroller:SetSize(1, 0)
	scroller:SetHideButtons(true)

	function scroller:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, 1, h, main_color_darker )
	end

	function scroller.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, 1, h, main_color )
	end
end

local function openMenu( len )
	len = net.ReadUInt( 32 )
	if len == 0 then return end
	local settings = net.ReadData( len )
	settings = util.Decompress( settings )
	settings = util.JSONToTable( settings )

	APG.cfg = settings.cfg
	table.Merge(APG, settings)

	local APG_Main = vgui.Create( "DFrame" )
	APG_Main:SetSize( 800, 450 )
	APG_Main:SetPos( 800 - APG_Main:GetWide() / 2, 450 - APG_Main:GetTall() / 2)
	APG_Main:SetTitle( "" )
	APG_Main:SetVisible( true )
	APG_Main:SetDraggable( true )
	APG_Main:MakePopup()
	APG_Main:ShowCloseButton( false )
	APG_Main.Paint = function(i,w,h)
		draw.RoundedBox(4,0,0,w,h,Color(34, 34, 34, 255))
		draw.RoundedBox(0,0,23,w,1,main_color)

		local name = "A.P.G. - Anti Prop Griefing Solution"
		draw.DrawText( name, "APG_title_font",8, 5, Color( 204, 204, 204, 255 ), 3 )
	end

	local closeButton = vgui.Create( "DButton",APG_Main )
	closeButton:SetPos( APG_Main:GetWide() - 20, 4 )
	closeButton:SetSize( 18, 18 )
	closeButton:SetText(" ")
	closeButton.DoClick = function()
		APG_Main:Hide()
		APG_Main:Remove()
	end

	closeButton.Paint = function(i,w,h)
		draw.RoundedBox( 0,0,0,w,h, Color( 91, 51, 51, 255 ) )
		draw.DrawText( "✕", "APG_sideBar_font", 1, -1, Color( 204, 204, 204, 255 ), TEXT_ALIGN_TOP )
	end

	local saveButton = vgui.Create( "DButton", APG_Main )
	saveButton:SetPos( APG_Main:GetWide() - 117, 4 )
	saveButton:SetSize( 77, 18 )
	saveButton:SetText("             ")

	saveButton.DoClick = function()
		if not LocalPlayer():IsSuperAdmin() then return end
		local settings = APG
		settings = util.TableToJSON( settings )
		settings = util.Compress( settings )
		net.Start( "apg_settings_c2s")
			net.WriteUInt( settings:len(), 32 ) -- Write the length of the data (up to {{ user_id | 76561197972967270 }})
			net.WriteData( settings, settings:len() ) -- Write the data
		net.SendToServer()
		showNotice(1, "APG Settings saved!")
	end

	saveButton.Paint = function(i,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 51, 91, 51, 255 ) )
		draw.DrawText( "Save Settings", "APG_title2_font",w/2, 1, Color( 204, 204, 204, 255 ), 1 )
	end

	-- Side bar
	local sidebar = vgui.Create( "DScrollPanel", APG_Main )
	setScrollerTheme( sidebar:GetVBar() )

	sidebar:SetSize( APG_Main:GetWide() / 4 , APG_Main:GetTall() - 35)
	sidebar:SetPos( 0, 30 )
	sidebar.Paint = function( i, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 33, 33, 33, 255 ) )
		draw.RoundedBox( 0, w-1, 0, 1, h, main_color_darker)
	end

	local x, y = (APG_Main:GetWide() - sidebar:GetWide()) - 19, APG_Main:GetTall() - 35
	local px, py = sidebar:GetWide() + 15, 30
	local first = true

	local modules = APG.modules

	-- Attempt to force essential modules to be enabled.
	modules["home"] = true
	modules["canphysgun"] = true

	for k, v in next, APG.modules do
		if k == "canphysgun" then continue end -- This module doesn't have UI, so it doesn't need a UI button.

		local panel = vgui.Create( "DScrollPanel", APG_Main )
		setScrollerTheme( panel:GetVBar() )

		panel:SetSize( x, y )
		panel:SetPos( px, py )
		panel:SetVisible( first )

		panel.Paint = function() end
		APG_panels[k] = panel
		first = false

		local button = vgui.Create( "DButton", panel )
		button:SetPos( 0, 0 )
		button:SetSize( panel:GetWide(), 35 )
		button:SetText("")

		button.UpdateColours = function( label, skin )
			label:SetTextStyleColor( Color( 189, 189, 189 ) )
		end

		button.Paint = function( slf, w, h )
			local enabled = APG.modules[k]
			draw.RoundedBox( 0, 0, h * 0.85, w-5, 1, enabled and main_color or main_color_red )

			local text = utils.getNiceName(k) .. " module "
			draw.DrawText( text, "APG_mainPanel_font", 5, 8, Color( 189, 189, 189 ), 3 )
			menu:mainSwitch( w * 0.90, (h * 0.5) - 16, enabled )
		end

		button.DoClick = function()
			APG.modules[k] = not APG.modules[k]
		end
	end

	local i = 0
	local height = ( sidebar:GetTall()/5 )

	for k, v in next, APG.modules do
		if k == "canphysgun" then continue end

		local button = sidebar:Add( "DButton" )
		button:SetPos( 5, (height + 5) * i)
		button:SetSize( sidebar:GetWide() - 10 , height )
		button:SetText("")

		button.DoClick = function()
			for l,m in next, APG_panels do
				if k ~= l then
					APG_panels[l]:SetVisible( false )
				else
					APG_panels[l]:SetVisible( true )
				end
			end
		end

		local size = sidebar:GetWide()
		button.Paint = function( _, w, h )
			local name = utils.getNiceName( k )
			if button.Hovered then
				draw.RoundedBox( 5, 0, 0, w, h, Color( 48, 48, 48, 255 ) )
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, Color( 36, 36, 36, 255 ) )
			end
			if APG_panels[k]:IsVisible()  then
				draw.RoundedBox( 0, 0, 0, w, h, Color( 51, 51, 51, 255 ) )
				draw.RoundedBox( 0, w * 0.10, h * 0.60, w * 0.8, 2, main_color_darker )
			end

			draw.DrawText( name, "APG_sideBar_font", ( size - name:len() ) / 2, h * 0.35, Color( 189, 189, 189 ), 1)
		end

		if k == "home" then
			button:DoClick()
		end

		i = i + 1
	end

	-- Build all the expected panels.
	APGBuildAdvDupePanel()
	APGBuildHomePanel()
	APGBuildMiscPanel()
	APGBuildToolsPanel()
	APGBuildGhostPanel()
	APGBuildLagPanel()
	APGBuildStackPanel()
	APGBuildLogsPanel()
	APGBuildNotificationPanel()
end

net.Receive( "apg_menu_s2c", openMenu )

properties.Add( "apgoptions", {
	MenuLabel = "APG Options", -- Name to display on the context menu
	Order = 9999, -- The order to display this property relative to other properties
	MenuIcon = "icon16/fire.png", -- The icon to display next to the property

	Filter = function( self, ent, ply ) -- A function that determines whether an entity is valid for this property
		if not ply:IsSuperAdmin() then return false end
		if not IsValid(ent) then return false end
		if not ent:GetClass() then return false end
		if ent:EntIndex() < 0 then return false end

		return true
	end,
	MenuOpen = function( self, option, ent, tr )
		local submenu = option:AddSubMenu()
		local function addoption( str, data )
			local menu = submenu:AddOption( str, data.callback )

			if data.icon then
				menu:SetImage( data.icon )
			end

			return menu
		end

		addoption( "Sleep entities of this Class", {
			icon = "icon16/clock.png",
			callback = function() self:APGcmd( ent, "sleepclass" ) end,
		})

		addoption( "Freeze entities of this Class", {
			icon = "icon16/bell_delete.png",
			callback = function() self:APGcmd( ent, "freezeclass" ) end,
		})

		submenu:AddSpacer()

		addoption( "Cleanup Owner - Unfrozens", {
			icon = "icon16/cog_delete.png",
			callback = function() self:APGcmd( ent, "clearunfrozen" ) end,
		})

		addoption( "Cleanup Owner", {
			icon = "icon16/bin_closed.png",
			callback = function() self:APGcmd( ent, "clearowner" ) end,
		})

		submenu:AddSpacer()

		addoption( "Get Owner SteamID", {
			icon = "icon16/user.png",
			callback = function() self:APGcmd( ent, "getownerid" ) end,
		})

		addoption( "Get Owner Entity Count", {
			icon = "icon16/brick.png",
			callback = function() self:APGcmd( ent, "getownercount" ) end,
		})

		submenu:AddSpacer()

		addoption( "Add this entity class to the Ghosting List", {
			icon = "icon16/cross.png",
			callback = function() self:APGcmd( ent, "addghost" ) end,
		})

		addoption( "Remove this entity class from the Ghosting List", {
			icon = "icon16/tick.png",
			callback = function() self:APGcmd( ent, "remghost" ) end,
		})

		submenu:AddSpacer()

		addoption( "Ghost this entity", {
			icon = "icon16/tick.png",
			callback = function() self:APGcmd( ent, "ghost" ) end,
		})

	end,
	Action = function( self, ent ) end,
	APGcmd = function( self, ent, cmd )
		if cmd == "getownerid" then
			local owner, _ = ent:CPPIGetOwner()
			if IsValid( owner ) then
				local id = tostring( owner:SteamID() )
				local name = tostring( owner:Nick() )
				SetClipboardText( id )
				showNotice(0, name .. " [ " ..  id .. " ]" .. " has been copied to your clipboard.")
			else
			   showNotice(0, "\nOops, that's not a Player!")
			end
		elseif cmd == "getentname" then
			showNotice(0, ent:GetClass())
		elseif IsValid( ent ) and ent.EntIndex() then
			net.Start( "apg_context_c2s" )
				net.WriteString( cmd )
				net.WriteEntity( ent )
			net.SendToServer()
		end
	end,
})