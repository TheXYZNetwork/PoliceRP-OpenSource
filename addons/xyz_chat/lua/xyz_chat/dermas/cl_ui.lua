XYZChat.SendHistory = {}
XYZChat.SendHistoryCounter = 0


-- Cache
local scrw = ScrW
local scrh = ScrH
local localplayer = LocalPlayer
local color = Color
local draw_box = draw.RoundedBox
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated

-- Colors
local background = color(18, 18, 18)
local backgroundShaded = color(20, 20, 20)
local white = color(255, 255, 255)
local whiteShaded = color(155, 155, 155)
local headerDefault = color(2, 88, 154)
local headerShader = color(0, 0, 0, 55)
local healthRed = color(200, 0, 55)
local ArmorRed = color(0, 100, 200)
local healthSegments = color(31, 31, 31, 155)
local headerCloseShader = color(0, 0, 0, 100)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")
local gradientCenter = Material("gui/center_gradient")

local gradientSize = 10
function XYZChat.CreateChat()
	if IsValid(XYZChat.ChatBox) then
		XYZChat.ChatBox:Close()
	end
	-- The main chat box
	XYZChat.ChatBox = vgui.Create("DFrame")
	if not IsValid(XYZChat.ChatBox) then return end
	XYZChat.ChatBox:SetSize(GetConVar("xyz_chat_w"):GetInt(), GetConVar("xyz_chat_h"):GetInt())
	XYZChat.ChatBox:SetPos(GetConVar("xyz_chat_x"):GetInt(), GetConVar("xyz_chat_y"):GetInt())
	XYZChat.ChatBox:ShowCloseButton(false)
	XYZChat.ChatBox:SetDraggable(true)
	XYZChat.ChatBox:SetSizable(true)
	XYZChat.ChatBox:SetTitle("")
	XYZChat.ChatBox:DockPadding(5, 34, 5, 5)
	XYZChat.ChatBox.Alpha = 0
	XYZChat.ChatBox.Paint = function(self, w, h)
		if not XYZChat.ChatBox.Displayed then return end
		draw_box(0, 0, 0, w, h, background)
		draw_box(0, 5, 5, w-10, 24, headerDefault)
		draw_box(0, 5, 17, w-10, 12, headerShader)

		XYZUI.DrawText(GetHostName(), 20, 10, 17, white, TEXT_ALIGN_LEFT)
	end

	XYZChat.ChatBox.Messages = {}

	-- Close button
	XYZChat.ChatBox.CloseButton = vgui.Create("DButton", XYZChat.ChatBox)
	XYZChat.ChatBox.CloseButton:SetPos(XYZChat.ChatBox:GetWide(), 5)
	XYZChat.ChatBox.CloseButton:SetSize(24, 24)
	XYZChat.ChatBox.CloseButton:SetText("")
	XYZChat.ChatBox.CloseButton.Paint = function(self, w, h)
		if not XYZChat.ChatBox.Displayed then return end
		draw_box(0, 0, 0, w, h, headerCloseShader)
		if self:IsHovered() then
			XYZUI.DrawText("X", 35, w/2, h/2, white)
		else
			XYZUI.DrawText("X", 35, w/2, h/2, whiteShaded)
		end
	end
	XYZChat.ChatBox.CloseButton.DoClick = function()
		XYZChat.ChatBox:ChatHide()
	end
	function XYZChat.ChatBox.CloseButton.Think()
		if not XYZChat.ChatBox.Displayed then return end
		if gui.IsGameUIVisible() then
			XYZChat.ChatBox:ChatHide()
			gui.HideGameUI()
		end
	end
	XYZChat.ChatBox.CloseButton:SetAlpha(0)

	-- Settings button
	XYZChat.ChatBox.SettingsButton = vgui.Create("DButton", XYZChat.ChatBox)
	XYZChat.ChatBox.SettingsButton:SetPos(XYZChat.ChatBox:GetWide()-50, 5)
	XYZChat.ChatBox.SettingsButton:SetSize(24, 24)
	XYZChat.ChatBox.SettingsButton:SetText("")
	XYZChat.ChatBox.SettingsButton.Paint = function(self, w, h)
		if not XYZChat.ChatBox.Displayed then return end
		draw_box(0, 0, 0, w, h, headerCloseShader)
		if self:IsHovered() then
			XYZUI.DrawText("S", 35, w/2, h/2, white)
		else
			XYZUI.DrawText("S", 35, w/2, h/2, whiteShaded)
		end
	end
	XYZChat.ChatBox.SettingsButton.DoClick = function()
		XYZSettings.UI()
		XYZChat.ChatBox:ChatHide()
	end
	XYZChat.ChatBox.SettingsButton:SetAlpha(0)


	XYZChat.ChatBox.PerformLayout = function()
		local w, h = XYZChat.ChatBox:GetSize()
		local x, y = XYZChat.ChatBox:GetPos()

		GetConVar("xyz_chat_w"):SetInt(w)
		GetConVar("xyz_chat_h"):SetInt(h)
		GetConVar("xyz_chat_x"):SetInt(x)
		GetConVar("xyz_chat_y"):SetInt(y)

		XYZChat.ChatBox.CloseButton:SetPos(w-29, 5)
		XYZChat.ChatBox.SettingsButton:SetPos(w-53, 5)

		for k, v in pairs(XYZChat.ChatBox.Messages) do
			v:Dock(TOP)
		end
	end

	-- The core shell
	XYZChat.ChatBox.Shell = vgui.Create("DPanel", XYZChat.ChatBox)
	XYZChat.ChatBox.Shell:Dock(FILL)
	XYZChat.ChatBox.Shell.Paint = function() end

	-- The input shell
	XYZChat.ChatBox.Shell.Input = vgui.Create("DPanel", XYZChat.ChatBox.Shell)
	XYZChat.ChatBox.Shell.Input:Dock(BOTTOM)
	XYZChat.ChatBox.Shell.Input.Paint = function() end
	XYZChat.ChatBox.Shell.Input:SetAlpha(0)

		-- The input box
		XYZChat.ChatBox.Shell.Input.TextEntry, container = XYZUI.TextInput(XYZChat.ChatBox.Shell.Input, nil, 15)
		container.headerColor = headerDefault
		container:Dock(FILL)
		container:DockMargin(0, 0, 5, 0)
		XYZChat.ChatBox.Shell.Input.TextEntry:RequestFocus()
		XYZChat.ChatBox.Shell.Input.TextEntry.PerformLayout = function()
			gamemode.Call("ChatTextChanged", XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
		end
		XYZChat.ChatBox.Shell.Input.TextEntry.OnEnter = function()
			if not (XYZChat.ChatBox.Shell.Input.TextEntry:GetValue() == "") then
				if XYZChat.ChatBox.Team then
					--RunConsoleCommand("say_team", XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
					LocalPlayer():ConCommand("say_team \""..XYZChat.ChatBox.Shell.Input.TextEntry:GetValue().."\"")
				else
					--RunConsoleCommand("say", XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
					LocalPlayer():ConCommand("say \""..XYZChat.ChatBox.Shell.Input.TextEntry:GetValue().."\"")
				end
				table.insert(XYZChat.SendHistory, 1, XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
			end
			XYZChat.ChatBox.Shell.Input.TextEntry:SetText("")
			XYZChat.ChatBox:ChatHide()
		end

		local historyCooldown = 0
		XYZChat.ChatBox.Shell.Input.TextEntry.Think = function()
			if not XYZChat.ChatBox.Displayed then return end
			if historyCooldown > CurTime() then return end
			if input.IsKeyDown(KEY_UP) then
				historyCooldown = CurTime() + 0.3
				XYZChat.SendHistoryCounter = XYZChat.SendHistoryCounter + 1
				if XYZChat.SendHistoryCounter > #XYZChat.SendHistory then
					XYZChat.SendHistoryCounter = 0
				end

				local text = XYZChat.SendHistory[XYZChat.SendHistoryCounter] or ""
				XYZChat.ChatBox.Shell.Input.TextEntry:SetText(text)
				XYZChat.ChatBox.Shell.Input.TextEntry:SetCaretPos(string.len(text))
			elseif input.IsKeyDown(KEY_DOWN) then
				historyCooldown = CurTime() + 0.3
				XYZChat.SendHistoryCounter = XYZChat.SendHistoryCounter - 1
				if XYZChat.SendHistoryCounter < 0 then
					XYZChat.SendHistoryCounter = #XYZChat.SendHistory
				end

				local text = XYZChat.SendHistory[XYZChat.SendHistoryCounter] or ""
				XYZChat.ChatBox.Shell.Input.TextEntry:SetText(text)
				XYZChat.ChatBox.Shell.Input.TextEntry:SetCaretPos(string.len(text))
			end
		end


		XYZChat.ChatBox.Shell.Input.TextEntry:RequestFocus()

	
		-- The submit box
		XYZChat.ChatBox.Shell.Input.Submit = vgui.Create("DButton", XYZChat.ChatBox.Shell.Input)
		XYZChat.ChatBox.Shell.Input.Submit:Dock(RIGHT)
		XYZChat.ChatBox.Shell.Input.Submit:SetText("")
		XYZChat.ChatBox.Shell.Input.Submit.Paint = function(self, w, h)
			if not XYZChat.ChatBox.Displayed then return end
			draw_box(0, 0, 0, w, h, headerDefault)
			draw_box(0, 0, 0, w, 2, headerShader)
			draw_box(0, 0, h-2, w, 2, headerShader)
			draw_box(0, 0, 2, 2, h-4, headerShader)
			draw_box(0, w-2, 2, 2, h-4, headerShader)
			XYZUI.DrawText("Say", 20, w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		XYZChat.ChatBox.Shell.Input.Submit.DoClick = function()
			if XYZChat.ChatBox.Team then
				--RunConsoleCommand("say_team", XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
				LocalPlayer():ConCommand("say_team \""..XYZChat.ChatBox.Shell.Input.TextEntry:GetValue().."\"")
			else
				--RunConsoleCommand("say", XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
				LocalPlayer():ConCommand("say \""..XYZChat.ChatBox.Shell.Input.TextEntry:GetValue().."\"")
			end
			if not (XYZChat.ChatBox.Shell.Input.TextEntry:GetValue() == "") then
				table.insert(XYZChat.SendHistory, 1, XYZChat.ChatBox.Shell.Input.TextEntry:GetValue())
			end
			XYZChat.ChatBox.Shell.Input.TextEntry:SetText("")
		end


	-- Main chat area
	throwawayvar, XYZChat.ChatBox.Shell.ScrollPanel = XYZUI.Lists(XYZChat.ChatBox.Shell, 1) --vgui.Create("DScrollPanel", XYZChat.ChatBox.Shell)
	XYZChat.ChatBox.Shell.ScrollPanel:Dock(FILL)
	XYZChat.ChatBox.Shell.ScrollPanel:DockMargin(0, 0, 0, 5)
	XYZChat.ChatBox.Shell.ScrollPanel:DockPadding(5, 0, 5, 0)
	local oldPaint = XYZChat.ChatBox.Shell.ScrollPanel.Paint
	XYZChat.ChatBox.Shell.ScrollPanel.Paint = function(self, w, h)
		if not XYZChat.ChatBox.Displayed then return end
		oldPaint(self, w, h)
	end

	local scr = XYZChat.ChatBox.Shell.ScrollPanel:GetVBar()
	scr.PerformLayout = function()
		local Wide = scr:GetWide()
		local Scroll = scr:GetScroll() / scr.CanvasSize
		local BarSize = math.max(scr:BarScale() * scr:GetTall(), 10)
		local Track = scr:GetTall() - BarSize
		Track = Track + 1

		Scroll = Scroll * Track

		scr.btnGrip:SetPos(0, Scroll)
		scr.btnGrip:SetSize(Wide, BarSize)

		scr.btnUp:SetPos(0, 0, Wide, Wide)
		scr.btnUp:SetSize(Wide, 0)

		scr.btnDown:SetPos(0, scr:GetTall(), Wide, Wide)
		scr.btnDown:SetSize(Wide, 0)
	end

	scr.Paint               = function() end
	scr.btnUp.Paint         = function() end
	scr.btnDown.Paint       = function() end
	scr.btnGrip.Paint       = function() draw.RoundedBox(0, 2, 0, scr.btnGrip:GetWide()-4, scr.btnGrip:GetTall()-2, ColorAlpha(headerDefault, XYZChat.ChatBox.Alpha-55)) end 

	function XYZChat.ChatBox:ChatHide()
		if not self.Displayed then return end
		self.Displayed = false
		self:ApplyAlpha()
		self:SetMouseInputEnabled(false)
		self:SetKeyboardInputEnabled(false)
		gamemode.Call("FinishChat")
		gamemode.Call("ChatTextChanged", "")

		self.Shell.Input.TextEntry:SetText("")

		for k, v in pairs(self.Messages) do
			if CurTime() < v.data.fadeAt then continue end
			v:SetAlpha(0)
		end
		XYZChat.SendHistoryCounter = 0
	end
	
	function XYZChat.ChatBox:ChatShow()
		self.Displayed = true
		self:ApplyAlpha()
		self:MakePopup()
		--self:SetMouseInputEnabled(true)
		--self:SetKeyboardInputEnabled(true)
		self.Shell.Input.TextEntry:RequestFocus()

		for k, v in pairs(self.Messages) do
			v:SetAlpha(255)
		end
		gamemode.Call("StartChat")
		XYZChat.SendHistoryCounter = 0
	end

	function XYZChat.ChatBox:ApplyAlpha()
		if self.Displayed == true then
			self.Alpha = 255
		else
			self.Alpha = 0
		end
		XYZChat.ChatBox.CloseButton:SetAlpha(self.Alpha)
		XYZChat.ChatBox.SettingsButton:SetAlpha(self.Alpha)
		XYZChat.ChatBox.Shell.Input:SetAlpha(self.Alpha)
	end
	XYZChat.ChatBox:ChatHide()
end

local slightlyInvis = Color(0, 0, 0, 255-85)
function XYZChat.AddMessage(info)
	if not IsValid(XYZChat.ChatBox) then
		XYZChat.CreateChat()
	end

	local line = vgui.Create("DPanel", XYZChat.ChatBox.Shell.ScrollPanel)
	line:SetSize(XYZChat.ChatBox.Shell.ScrollPanel:GetWide(), 10)
	line:Dock(TOP)
	line:DockMargin(5, 0, 5, 0)
	line.Paint = function(self, w, h)
		if XYZChat.ChatBox.Displayed then line:SetAlpha(255) return end
		if line.data.timeUp then return end
		--XYZShit.DermaBlurPanel(self, 3)
		draw.RoundedBox(0, 0, 0, w, h, slightlyInvis)
	end
	--line:LerpPositions(1, true)
	line:SetAlpha(0)
	line:AlphaTo(255, 0.4)
	line:InvalidateLayout(true)

	timer.Simple(10, function()
		if not IsValid(line) then return end
		if XYZChat.ChatBox.Displayed then line:SetAlpha(255) return end
		line:AlphaTo(0, 0.3, 0) 
		line.data.timeUp = true
	end)

	line.text = vgui.Create("RichText", line)
	line.text:SetPos(0, 0)
	--line.text:Dock(FILL)
	line.text:SetWide(line:GetWide()-6)
	line.text:InsertColorChange(215, 215, 215, 255)
	line.text:SetWrap(true)

	function line.PerformLayout()
		line.text:SetFontInternal("xyz_font_18_static")
		line.text:SetVerticalScrollbarEnabled(false)
		line.text:SetToFullHeight()
		line.text:SetWide(line:GetWide()-6)
		line:SizeToChildren(false, true)
		
		line:InvalidateParent()
	end

	line.data = {}
	line.data.timeUp = false
	line.data.fadeAt = CurTime() + 10
	line.data.time = os.date("%X", os.time())

	if XYZSettings.GetSetting("textbox_show_timestamps", true) then 
		line.text:InsertColorChange(215, 215, 215, 255)
		line.text:AppendText(line.data.time.." - ")
	end

	for k, v in ipairs(info) do
		if type(v) == "Player" then
			line.data.ply = v

 			line.data.rank = {}

 			if XYZSettings.GetSetting("textbox_show_rank_tags", true) then 
				if XYZShit.Staff.All[v:GetUserGroup()]  then
					line.data.rank.text = "Staff"
					line.data.rank.color = Color(4, 165, 185)
					line.text:InsertColorChange(line.data.rank.color.r, line.data.rank.color.g, line.data.rank.color.b, 255)
					line.text:AppendText("["..line.data.rank.text.."] ")
				elseif (v:GetUserGroup() == "elite") or (v:GetSecondaryUserGroup() == "elite" ) then
					line.data.rank.text = "Elite"
					line.data.rank.color = Color(0, 255, 255)
					line.text:InsertColorChange(line.data.rank.color.r, line.data.rank.color.g, line.data.rank.color.b, 255)
					line.text:AppendText("["..line.data.rank.text.."] ")
 				elseif (v:GetUserGroup() == "vip") or (v:GetSecondaryUserGroup() == "vip") then
					line.data.rank.text = "VIP"
					line.data.rank.color = Color(255, 255, 0)
					line.text:InsertColorChange(line.data.rank.color.r, line.data.rank.color.g, line.data.rank.color.b, 255)
					line.text:AppendText("["..line.data.rank.text.."] ")
				end
			end

			if (not (v:GetNWString("xyz_tag_string", "") == "")) and XYZSettings.GetSetting("textbox_show_custom_tags", true) then
				line.data.tag = {}
				line.data.tag.text = v:GetNWString("xyz_tag_string", "")
				line.data.tag.color = v:GetNWVector("xyz_tag_Color", Vector(30, 100, 160))
				line.text:InsertColorChange(line.data.tag.color.r, line.data.tag.color.g, line.data.tag.color.b, 255)
				line.text:AppendText("["..line.data.tag.text.."] ")
			end

			line.data.col = team.GetColor(v:Team())
			line.text:InsertColorChange(line.data.col.r, line.data.col.g, line.data.col.b, 255)
			line.text:AppendText(v:Nick())
			line.text:InsertColorChange(215, 215, 215, 255)
			--line.text:AppendText(": ")
		elseif type(v) == "string" then
			line.text:AppendText(v)
		elseif type(v) == "number" then
			line.text:AppendText(v)
		elseif type(v) == "table" then
			line.text:InsertColorChange(v.r, v.g, v.b, 255)
		end
	end	

	if not IsValid(line.data) then
		line.data.col = Color(210, 210, 210)
		line:InvalidateLayout(true)
	end

	table.insert(XYZChat.ChatBox.Messages, 1, line)
	if #XYZChat.ChatBox.Messages > tonumber(XYZSettings.GetSetting("textbox_history_length", 50)) then
		XYZChat.ChatBox.Messages[tonumber(XYZSettings.GetSetting("textbox_history_length", 50))+1]:Remove()
		table.remove(XYZChat.ChatBox.Messages, tonumber(XYZSettings.GetSetting("textbox_history_length", 50))+1)
	end

	
	if XYZChat.ChatBox.Displayed then return end

	XYZChat.ChatBox.Shell.ScrollPanel.VBar:AnimateTo(XYZChat.ChatBox.Shell.ScrollPanel.pnlCanvas:GetTall(), 0.5, 0, 0.5);

	local y = XYZChat.ChatBox.Shell.ScrollPanel.pnlCanvas:GetTall()
	local w, h = line:GetSize()
	
	y = y + h * 0.5;
	y = y - XYZChat.ChatBox.Shell.ScrollPanel:GetTall() * 0.5;

	XYZChat.ChatBox.Shell.ScrollPanel.VBar:AnimateTo(y, 0.5, 0, 0.5);

end