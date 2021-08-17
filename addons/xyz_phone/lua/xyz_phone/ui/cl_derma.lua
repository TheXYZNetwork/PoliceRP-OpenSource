local barBlack = Color(50, 50, 50)
function Phone.Core.Menu()
	if IsValid(Phone.Menu) then 
		if Phone.Menu.open then
			Phone.Menu:MoveTo((ScrW() * 0.85) - Phone.Menu:GetWide(), ScrH(), 1)
			Phone.Menu:SetMouseInputEnabled(false)
			Phone.Menu:SetKeyboardInputEnabled(false)
		else
			Phone.Menu:MoveTo((ScrW() * 0.85) - Phone.Menu:GetWide(), ScrH() - Phone.Menu:GetTall(), 1)
			Phone.Menu:MakePopup()
			Phone.Menu:SetKeyboardInputEnabled(false)
			Quest.Core.NetworkProgress("new_comer", 4)
		end

		Phone.Menu.open = not Phone.Menu.open
		return
	end

	-- Used for calculating size
	local unitSize = math.Clamp(ScrH(), 300, ScrH()*0.3)
	unitSize = unitSize/25

	local frame = vgui.Create("DFrame")
	Phone.Menu = frame
	frame:SetSize(unitSize*25, unitSize*48)
	frame.Paint = nil
	frame:SetTitle("")
	frame:DockMargin(0, 0, 0, 0)
	frame:DockPadding(0, 0, 0, 0)
	frame:ShowCloseButton(false)
	frame:SetPos((ScrW() * 0.85) - Phone.Menu:GetWide(), ScrH())
	--frame:MakePopup()
	frame.open = false
	frame.Think = function()
		if not frame.open then return end
		if input.IsButtonDown(KEY_UP) then
			if XYZShit.CoolDown.Check("Phone:Open", 0.5, ply) then return end
			Phone.Core.Menu()
		end
	end


	-- The Background
	frame.background = vgui.Create("DPanel", frame)
	frame.background:Dock(FILL)
	frame.background.Paint = function(self, w, h)
		-- Background
		if Phone.Menu.App and Phone.Menu.App.Background then
			Phone.Menu.App.Background(w, h)
		else
			draw.RoundedBox(0, w*0.12, h*0.08, w*0.76, h*0.843, barBlack)
		end
		-- Top Bar
		XYZUI.DrawScaleText(os.date("%H:%M"), 6, w*0.21, h*0.075, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	-- The phone frame
	frame.skin = vgui.Create("DPanel", frame)
	frame.skin:Dock(FILL)
	frame.skin.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(XYZShit.Image.GetMat(Phone.App.GetApp("settings").getSetting("phone_model") or "phone_frame_uphone"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
	frame.skin:SetDrawOnTop(true)

	-- The phone frame
	frame.shell = vgui.Create("DPanel", frame)
	frame.shell:SetPos(frame:GetWide()*0.125, frame:GetTall()*0.105)
	frame.shell:SetSize(frame:GetWide()*0.754, frame:GetTall()*0.818)
	frame.shell.Paint = nil
	frame.shell:SetFocusTopLevel(true)

	frame.skin.home = vgui.Create("DButton", frame.skin)
	frame.skin.home:SetPos(frame:GetWide() - (frame:GetWide()*0.32), frame:GetTall()*0.075)
	frame.skin.home:SetText("")
	frame.skin.home.Paint = function(self, w, h)
		XYZUI.DrawScaleText("Home", 6, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	frame.skin.home.DoClick = function()
		Phone.App.SetApp("home")
	end


	function Phone.Menu:SetApp(appID)
		Phone.Menu.App = Phone.App.GetApp(appID)

		frame.shell:Clear()

		if Phone.Menu.App.Function then
			Phone.Menu.App.Function(frame.shell)
		end
	end

	-- Set the phone to be the home page
	Phone.App.SetApp("home")
end

hook.Add("HUDPaint", "Phone:Load", function()
	hook.Remove("HUDPaint", "Phone:Load")

	-- Give them the default apps
	Phone.App.Install("home") 
	Phone.App.Install("rocket")
	Phone.App.Install("snapper")
	Phone.App.Install("gallery")
	Phone.App.Install("contacts")
	Phone.App.Install("bubble")
	Phone.App.Install("call")
	Phone.App.Install("settings")

	Phone.Core.Menu()
end)


hook.Add("PlayerButtonDown", "Phone:Open", function(ply, button)
	if not (button == KEY_UP) then return end
	if XYZShit.CoolDown.Check("Phone:Open", 0.5, ply) then return end

	Phone.Core.Menu()
end)

--Phone.App.Install("home") 
--Phone.App.Install("rocket")
--Phone.App.Install("snapper")
--Phone.App.Install("gallery")
--Phone.App.Install("contacts")
--Phone.App.Install("bubble")
--Phone.App.Install("call")
--Phone.Core.Menu() 
--Phone.App.SetApp("call")