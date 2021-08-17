local APP = {}

-- Base data
APP.name = "Rocket"
APP.id = "rocket"
APP.desc = "Browse the web" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Functions
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_rocket"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end

-- Functionality
local accent = Color(4, 141, 255)
local dark = Color(30, 30, 30)
APP.Function = function(shell)
	local window = vgui.Create("DHTML", shell)
	window:Dock(FILL)
	window:OpenURL("https://duckduckgo.com")

	local nav = vgui.Create("DTextEntry", shell)
	nav:Dock(TOP)
	nav:SetText("http://duckduckgo.com")
	nav:DockMargin(5, 5, 5, 5)
	nav.OnEnter = function(self, text)
		window:OpenURL(text)
	end
	nav.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, dark)
		self:DrawTextEntryText(color_white, accent, color_white)
	end
	nav.OnGetFocus = function()
		Phone.Menu:MakePopup()
	end
	nav.OnLoseFocus = function()
		Phone.Menu:SetKeyboardInputEnabled(false)
	end
end

Phone.App.Register(APP)