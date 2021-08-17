xLogs.Core.Menu = xLogs.Core.Menu or nil
net.Receive("xLogsOpenMenu", function()
	local frame = XYZUI.Frame("xLogs", Color(1, 68, 134), true, true)
	frame:SetSize(ScrH()*0.4, ScrH()*0.5)
	frame:Center()
	local shell = XYZUI.Container(frame)
	shell:SetPos(5, 5)
	shell:SetSize(frame:GetWide()-10, frame:GetTall()-10)
	local steam = XYZUI.ButtonInput(shell, "Steam Browser", function(self)
		gui.OpenURL("https://thexyznetwork.xyz/xlogs/")
		frame:Close()
	end)
	local ingame = XYZUI.ButtonInput(shell, "In-Game (not recommended)", function(self)
		if not IsValid(xLogs.Core.Menu) then
			xLogs.Core.GenerateMenu()
			xLogs.Core.Menu:Hide()
		end
		xLogs.Core.Menu:Show()
		frame:Close()
	end)
	steam:SetSize(shell:GetWide(), shell:GetTall()/2-5)
	ingame:SetSize(shell:GetWide(), shell:GetTall()/2-5)
	steam:Dock(TOP)
	ingame:Dock(BOTTOM)
end)

function xLogs.Core.GenerateMenu()
	if xLogs.Core.Menu then
		xLogs.Core.Menu:Remove()
	end

	xLogs.Core.Menu = XYZUI.Frame("xLogs", Color(35, 35, 35))
	xLogs.Core.Menu:SetSize(ScrW()*0.85, ScrH()*0.85)
	xLogs.Core.Menu:Center()
	xLogs.Core.Menu:SetDraggable(true)

	local webpage = vgui.Create("DHTML", xLogs.Core.Menu)
	webpage:Dock(FILL)
	webpage:OpenURL("https://thexyznetwork.xyz/xlogs/")
end