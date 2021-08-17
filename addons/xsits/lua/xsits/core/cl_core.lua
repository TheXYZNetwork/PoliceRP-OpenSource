local _
local actionMenu = nil
--xSits.Core.Menu:Close()
function xSits.Core.Popup(ply, reason)
	if not IsValid(xSits.Core.Menu) then
		xSits.Core.Menu = XYZUI.Frame("Open Sits", Color(2, 108, 254), true, nil, true)
		xSits.Core.Menu:SetSize(ScrW()*0.15, ScrH()*0.3)
		xSits.Core.Menu:SetPos(0, (ScrH()*0.5) - (xSits.Core.Menu:GetTall()*0.5))
		_, xSits.Core.Menu.List = XYZUI.Lists(xSits.Core.Menu, 1)
	else
		xSits.Core.Menu:Show()
	end

	if IsValid(actionMenu) then
		xSits.Core.Menu:Hide()
	end

	local plyButton = vgui.Create("DPanel", xSits.Core.Menu.List)
	plyButton:SetText("")
	plyButton:Dock(TOP)
	plyButton:DockMargin(4, 4, 4, 2)
	plyButton:SetTall(40)
	plyButton.Paint = function() end
	plyButton.headerColor = team.GetColor(ply:Team())
	plyButton.info = {ply = ply, reason = reason, opened = os.time()}
	plyButton.id = ply:SteamID64()

	plyButton.icon = vgui.Create("AvatarImage", plyButton)
	plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
	plyButton.icon:Dock(LEFT)
	plyButton.icon:SetPlayer(ply, 64)

	local btn = XYZUI.ButtonInput(plyButton, XYZUI.CharLimit(ply:Name(), 15), function()
		xSits.Core.InfoUI(plyButton.info.ply, plyButton.info.reason, plyButton.info.opened)
	end)
	btn.Think = function()
		if not IsValid(plyButton.info.ply) then return end
		btn.disText = XYZUI.CharLimit(plyButton.info.ply:Name(), 15).." ["..string.FormattedTime(os.time() - plyButton.info.opened, "%01i:%02i").."]"
	end
end

function xSits.Core.InfoUI(ply, reason, opened)
	if IsValid(actionMenu) then return end
	if not IsValid(ply) then return end
	local frame = XYZUI.Frame("Sit Report", Color(2, 108, 254))
	frame:SetSize(ScrW()*0.3, ScrH()*0.3)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local info = XYZUI.PanelText(shell, "Report Info", 40, TEXT_ALIGN_LEFT)
	XYZUI.PanelText(shell, "Reporter: "..ply:Name(), 25, TEXT_ALIGN_LEFT)
	XYZUI.PanelText(shell, "Opened: "..string.NiceTime(os.time() - opened).." ago", 25, TEXT_ALIGN_LEFT)
	XYZUI.WrappedText(shell, "Reason: "..reason, 25)


	local claimBtn = XYZUI.ButtonInput(frame, "Claim Case", function(self)
		if not IsValid(ply) then return end

		self.headerColor = Color(175, 175, 175)
		self.disText = "You have claimed this case"

		net.Start("xSitsSitClaim")
			net.WriteEntity(ply)
		net.SendToServer()

		frame:Close()
		-- xSits.Core.ActionUI(ply, reason)
	end)
	claimBtn.headerColor = Color(10, 175, 30)
	claimBtn:DockMargin(0, 5, 0, 0)
	claimBtn:Dock(BOTTOM)
end

-- %s is the steamid64
local actions = {
	{name = "Bring", command = "xadmin bring %s", id = "bring"},
	{name = "Go To", command = "xadmin goto %s", id = "goto"},
	{name = "Return", command = "xadmin return %s", id = "return"},
	{name = "Revive", command = "xadmin revive %s", id = "revive"},
	{name = "Revive & Bring", command = "xadmin revtp %s", id = "revtp"},
	{name = "100% Health", command = "xadmin hp %s 100", id = "hp"},
	{name = "100% Armor", command = "xadmin armor %s 100", id = "armor"},
	{name = "Respawn", command = "xadmin respawn %s", id = "respawn"},
}
function xSits.Core.ActionUI(ply, reason)
	actionMenu = XYZUI.Frame("Action Menu", Color(2, 108, 254), true, nil, true)
	actionMenu:SetSize(ScrW()*0.15, ScrH()*0.5)
	actionMenu:SetPos(ScrW()-actionMenu:GetWide(), (ScrH()*0.5) - (actionMenu:GetTall()*0.5))
	actionMenu.Think = function()
		if IsValid(ply) then return end
		if not IsValid(actionMenu) then return end

		actionMenu:Close()
		XYZShit.Msg("xSits", Color(46, 170, 200), "The sit creator has disconnected!")
	end

	XYZUI.PanelText(actionMenu, "Name: "..XYZUI.CharLimit(ply:Name(), 15), 25, TEXT_ALIGN_LEFT)
	if reason then
		local w = XYZUI.WrappedText(actionMenu, "Reason: "..reason, 25)
		w:Dock(TOP)
	end

	local shell = XYZUI.Container(actionMenu)

	for k, v in ipairs(actions) do
		if not xAdmin.CommandCache[v.id] then continue end

		local b = XYZUI.ButtonInput(shell, v.name, function(self)
			LocalPlayer():ConCommand(string.format(v.command, ply:SteamID64()))
		end)
		b:DockMargin(0, 0, 0, 5)
	end


	local closeBtn = XYZUI.ButtonInput(actionMenu, "Close Case", function(self)
		net.Start("xSitsSitClose")
			net.WriteEntity(ply)
		net.SendToServer()

		if IsValid(actionMenu) then
			actionMenu:Close()
			actionMenu = nil
		end


		if IsValid(xSits.Core.Menu) then
			xSits.Core.Menu:Show()
		end
	end)
	closeBtn.headerColor = Color(175, 10, 30)
	closeBtn:DockMargin(0, 5, 0, 0)
	closeBtn:Dock(BOTTOM)
end

local gold = Color(212, 175, 55)

function xSits.Core.RateSit(id)
	local frame = XYZUI.Frame("Rate Your Sit", Color(2, 108, 254), true, nil, true)
	frame:SetSize(345, 180)
	frame:SetPos(ScrW()-frame:GetWide(), (ScrH()*0.5) - (frame:GetTall()*0.5))

	local shell = XYZUI.Container(frame)
	shell.Paint = function() end

	local curRating = 3
	for i=1, 5 do
		local star = vgui.Create("DButton", shell)
		star:SetText("")
		star:Dock(LEFT)
		star.DoClick = function()
			curRating = i
		end
		star.Paint = function(self, w, h)
			surface.SetMaterial(XYZShit.Image.GetMat("main_star"))
			surface.SetDrawColor(i <= curRating and gold or color_white )

			surface.DrawTexturedRectRotated(w*0.5, h*0.5, w-10, h-10, 0)
		end
	end

	local submit = XYZUI.ButtonInput(frame, "Submit", function(self)
		net.Start("xSitsSitRate")
			net.WriteInt(id, 32)
			net.WriteInt(curRating, 4)
		net.SendToServer()

		if curRating >= 4 then
			surface.PlaySound("vo/ravenholm/cartrap_better.wav")
		elseif curRating <= 2 then
			surface.PlaySound("vo/ravenholm/monk_kill06.wav")
		end

		timer.Remove("xSits:Rate")
		frame:Close()
	end)
	submit:DockMargin(0, 10, 0, 0)
	submit:Dock(BOTTOM)

	timer.Create("xSits:Rate", xSits.Config.RateTimeout, 1, function()
		if not IsValid(frame) then return end
		frame:Close()
	end)
end


local sounds = {}
sounds["Voice 1"] = "vo/ravenholm/monk_helpme05.wav"
sounds["Voice 2"] = "vo/ravenholm/monk_helpme02.wav"
sounds["Voice 3"] = "vo/ravenholm/monk_coverme05.wav"
sounds["Bell 1"] = "ui/hint.wav"
sounds["Bell 2"] = "ambient/alarms/warningbell1.wav"
sounds["Bell 3"] = "HL1/fvox/bell.wav"
net.Receive("xSitsSitOpened", function()
	if LocalPlayer():HasPower(92) and (not XYZSettings.GetSetting("xsits_show", true)) then return end

	local ply = net.ReadEntity()
	local reason = net.ReadString()

	if not IsValid(ply) then return end
	if ply == LocalPlayer() then return end

	if XYZSettings.GetSetting("xsits_toggle_sound", true) then
		surface.PlaySound(sounds[XYZSettings.GetSetting("xsits_sound", "Voice 1")])
	end
	xSits.Core.Popup(ply, reason)

	system.FlashWindow()
end)

net.Receive("xSitsSitClaimed", function()
	if not IsValid(xSits.Core.Menu) or not IsValid(xSits.Core.Menu.List) then return end

	local target = net.ReadString()
	if not target then return end

	local sits = xSits.Core.Menu.List:GetChildren()[1]:GetChildren()
	local sitCount = table.Count(sits)
	for k, v in pairs(sits) do
		if v.id == target then
			sitCount = sitCount - 1
			v:Remove()
		end
	end

	if sitCount <= 0 then
		xSits.Core.Menu:Remove()
	end
end)
net.Receive("xSitsSitYouClaimed", function()
	local target = net.ReadEntity()
	local reason = net.ReadString()
	if not target then return end

	xSits.Core.ActionUI(target, reason)

	if IsValid(xSits.Core.Menu) then xSits.Core.Menu:Hide() end
end)

net.Receive("xSitsSitRequestRating", function()
	local id = net.ReadInt(32)
	if not id then return end
	xSits.Core.RateSit(id)
end)

concommand.Add("xsits_open_top", function()
	if not IsValid(xSits.Core.Menu) or not IsValid(xSits.Core.Menu.List) then return end

	local sits = xSits.Core.Menu.List:GetChildren()[1]:GetChildren()
	if #sits <= 0 then return end -- No sits open
	if not sits[1] then return end
	if not sits[1].info then return end

	xSits.Core.InfoUI(sits[1].info.ply, sits[1].info.reason, sits[1].info.opened)
end)