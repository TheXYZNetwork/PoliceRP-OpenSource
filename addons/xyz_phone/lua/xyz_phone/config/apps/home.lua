local APP = {}

-- Base data
APP.name = "Home"
APP.id = "home"
APP.desc = "The base app" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = false -- Show the app on the home

-- Background
APP.Background = function(w, h)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(XYZShit.Image.GetMat(Phone.App.GetApp("settings").getSetting("phone_background") or "main_background"))
	surface.DrawTexturedRect(w*0.12, h*0.08, w*0.76, h*0.843)
end
APP.Icon = function(w, h)
	draw.RoundedBox(20, 0, 0, w, h, color_white)
end

-- Functionality
APP.Function = function(shell)
    local grid = vgui.Create("ThreeGrid", shell)
	grid:Dock(FILL)
	grid:InvalidateParent(true)
	grid:SetColumns(3)
	grid:SetVerticalMargin(4)
	grid:SetHorizontalMargin(4)
	grid:GetVBar():SetWide(0)
	grid:DockMargin(6, 6, 6, 6)
	grid:SetVerticalScrollbarEnabled(true)


	grid.PerformLayout = function(self, width, height)
		grid:Clear()
		for k, v in pairs(Phone.App.Mine) do
			local appData = Phone.App.GetApp(k)
			if not appData then continue end
			if not appData.show then continue end

			local pnl = vgui.Create("DButton")
			pnl:SetTall((width/3) - 4)
			pnl:DockMargin(0, 0, 5, 0)
			pnl:SetText("")
			grid:AddCell(pnl)
			pnl.Paint = function(self, w, h)
				appData.Icon(w, h)
			end
			pnl.DoClick = function()
				Phone.App.SetApp(k)
			end
		end
	end
end

Phone.App.Register(APP)