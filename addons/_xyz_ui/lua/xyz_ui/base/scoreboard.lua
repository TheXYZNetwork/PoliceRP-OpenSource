-- Cache
local color = Color
local isvalid = IsValid
local draw_box = draw.RoundedBox
local hook_remove = hook.Remove
local hook_add = hook.Add
local timer_simple = timer.Simple
local table_sorybymember = table.SortByMember
local _pairs = pairs

-- Color cache
local white = color(255, 255, 255)
local headerShader = color(0, 0, 0, 55)


timer_simple(0.1, function()
	hook_remove("ScoreboardHide", "FAdmin_scoreboard")
	hook_remove("ScoreboardShow", "FAdmin_scoreboard")
end)
hook_add("Initialize", "RemoveGamemodeFunctions", function()
	GAMEMODE.ScoreboardShow = nil
	GAMEMODE.ScoreboardHide = nil
end)

function XYZUI.BuildScoreBoard()
	local frame = XYZUI.Frame(GetHostName(), color(2, 88, 154), true)
	frame:SetSize(ScrH()*0.9, ScrH()*0.9)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local _, column = XYZUI.Lists(shell, 1)

	shell.Paint = function() end
	--column.Paint = function() end
	column:GetVBar():SetWide(0)

	local card = XYZUI.Card(shell, 30)
	card:Dock(TOP)
	card:DockMargin(0, -2, 0, 0)
	local playerCount = XYZUI.PanelText(card, "Player Count: "..player.GetCount().."/"..game.MaxPlayers().." ", 25, TEXT_ALIGN_RIGHT)
	playerCount:DockMargin(0, 2, 0, 0)
	playerCount:Dock(RIGHT)
	playerCount:SetWidth(frame:GetWide()*0.4)
	if XYZShit.Version then
		local versionID = XYZUI.PanelText(card, "Version: "..CURRENTVERSION, 25, TEXT_ALIGN_LEFT)
		versionID:DockMargin(0, 2, 0, 0)
		versionID:Dock(LEFT)
		versionID:SetWidth(frame:GetWide()*0.4)
	end

	local members = {}
	for k, v in _pairs(RPExtraTeams) do
		local playersOnTeam = team.GetPlayers(k)

		table.Add(members, playersOnTeam)
	end

	for k, v in _pairs(members) do
		local body, header, mainCont = XYZUI.ExpandableCard(column, nil, 35)
		mainCont:SetTall(35)
		header:SetTall(35)

		mainCont.Think = function()
			if not IsValid(v) then
				mainCont:Remove()
			end
		end

		mainCont:DockMargin(2, 2, 2, 3)

		local color = team.GetColor(v:Team()) or headerShader
		local plyName = v:GetName() or "Unknown (Loading)"
		local plyTeam = v:getDarkRPVar("job") or team.GetName(v:Team()) or "Unknown (Loading)"



		local avatar = vgui.Create("AvatarImage", header)
		avatar:SetPos(0, 0)	
		avatar:SetSize(header:GetTall(), header:GetTall())
		avatar:SetPlayer(v, 64)

		function header.Paint(self, w, h)
			draw_box(0, h, 0, w-h, h, color)
			draw_box(0, h, 0, w-h, 5, headerShader)
			draw_box(0, h, h-5, w-h, 5, headerShader)
			draw_box(0, h, 5, 5, h-10, headerShader)
			draw_box(0, w-5, 5, 5, h-10, headerShader)

			XYZUI.DrawText(plyName, 25, h+10, h/2, white, TEXT_ALIGN_LEFT)
			XYZUI.DrawText(plyTeam, 25, w-10, h/2, white, TEXT_ALIGN_RIGHT)
		end

		local linksTitle = XYZUI.PanelText(body, "Links", 30, TEXT_ALIGN_LEFT)
		linksTitle:DockMargin(5, 5, 0, -5)

		XYZUI.AddToExpandableCardBody(mainCont, linksTitle)

		local btnCnt = vgui.Create("DPanel", body)
		btnCnt.Paint = function() end
		btnCnt:Dock(TOP)
		btnCnt:DockMargin(0, 0, 0, 0)
		btnCnt:SetTall(55)

		XYZUI.AddToExpandableCardBody(mainCont, btnCnt)

		local steam = XYZUI.ButtonInput(btnCnt, "Steam", function()
			v:ShowProfile()
		end)
		steam.headerColor = Color(55, 55, 55)
		steam:SetWide(100)
		steam:Dock(LEFT)
		steam:DockMargin(10, 10, 10, 10)

		local xsuite = XYZUI.ButtonInput(btnCnt, "Profile", function()
			gui.OpenURL("https://thexyznetwork.xyz/profile/"..v:SteamID64())
		end)
		xsuite.headerColor = Color(155, 0, 255)
		xsuite:SetWide(100)
		xsuite:Dock(LEFT)
		xsuite:DockMargin(10, 10, 10, 10)

		local lookup = XYZUI.ButtonInput(btnCnt, "Lookup", function()
			gui.OpenURL("https://thexyznetwork.xyz/lookup/"..v:SteamID64())
		end)
		lookup.headerColor = Color(100, 155, 0)
		lookup:SetWide(100)
		lookup:Dock(LEFT)
		lookup:DockMargin(10, 10, 10, 10)

		local copyID64 = XYZUI.ButtonInput(btnCnt, "SteamID64", function()
			SetClipboardText(v:SteamID64())
		end)
		copyID64.headerColor = Color(55, 0, 55)
		copyID64:SetWide(100)
		copyID64:Dock(LEFT)
		copyID64:DockMargin(10, 10, 10, 10)

		local muteToggle = XYZUI.ButtonInput(btnCnt, "Mute", function(self)
			v:SetMuted(not v:IsMuted())
			if v:IsMuted() then
				self.disText = "Unmute"
			else
				self.disText = "Mute"
			end
		end)
		if v:IsMuted() then
			muteToggle.disText = "Unmute"
		end
		muteToggle.headerColor = Color(0, 55, 55)
		muteToggle:SetWide(100)
		muteToggle:Dock(LEFT)
		muteToggle:DockMargin(10, 10, 10, 10)

		if not (v:SteamID64() == nil) and not table.IsEmpty(v:GetBadges()) then
			local linksTitle = XYZUI.PanelText(body, "Badges", 30, TEXT_ALIGN_LEFT)
			linksTitle:DockMargin(5, 0, 0, -5)

			XYZUI.AddToExpandableCardBody(mainCont, linksTitle)

			local btnCnt = vgui.Create("DIconLayout", body)
			btnCnt.Paint = function() end
			btnCnt:Dock(TOP)
			btnCnt:SetSpaceY(5)
			btnCnt:SetSpaceX(5)

			XYZUI.AddToExpandableCardBody(mainCont, btnCnt)
	
			for k, v in SortedPairs(v:GetBadges()) do
				local badgeData = XYZBadges.Config.Badges[k]
				if not badgeData then continue end
				local badge = btnCnt:Add("DPanel")
				badge:SetSize(60, 60)
				badge:SetTooltip(badgeData.name.." - "..badgeData.desc)
				badge.Paint = function() end
	
				local badgeImage = vgui.Create("DImage", badge)
				badgeImage:SetSize(badge:GetTall()-10, badge:GetTall()-10)
				badgeImage:SetPos(5, 5)
				badgeImage:SetImage("data/xyzcommunity/badges/"..k..".png")
			end
		end
	end

	return frame
end

local sb = nil
hook_add("ScoreboardShow", "DarkRP.custom.scoreboard.show", function()
	if isvalid(sb) then
		sb:Remove()
	else
		sb = XYZUI.BuildScoreBoard()
	end
end)

hook_add("ScoreboardHide", "DarkRP.custom.scoreboard.hide", function()
	if isvalid(sb) then
		sb:Remove()
	end
end)

concommand.Add("xyz_scoreboard", function()
	if isvalid(sb) then
		sb:Remove()
	else
		sb = XYZUI.BuildScoreBoard()
	end
end)