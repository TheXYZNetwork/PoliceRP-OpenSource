net.Receive("Election:UI", function()
	local ent = net.ReadEntity()

	local frame = XYZUI.Frame("Presidential Election", Election.Config.Color)
	frame:SetSize(ScrH()*0.4, ScrH()*0.16)
	frame:Center()

		local shell = XYZUI.Container(frame)
		shell:DockPadding(10, 10, 10, 10)

		local title = XYZUI.Title(shell, "Enter the Presidential election", nil, 38, 0, true)

		local enterButton = XYZUI.ButtonInput(shell, "Join Election!", function()
			net.Start("Election:JoinElection")
				net.WriteEntity(ent)
			net.SendToServer()
			frame:Close()
		end)
		enterButton:DockMargin(0, 10, 0, 0)
		enterButton:Dock(BOTTOM)
end)

net.Receive("Election:StartVote", function()
	local votees = net.ReadTable()

	local frame = XYZUI.Frame("Presidential Election", Election.Config.Color, true, nil, true)
	frame:SetSize(ScrW()*0.15, ScrH()*0.3)
	frame:SetPos(ScrW()-frame:GetWide(), (ScrH()*0.5) - (frame:GetTall()*0.5))
	timer.Simple(Election.Config.VoteTime, function()
		if not IsValid(frame) then return end
		frame:Close()
	end)

		_, shell = XYZUI.Lists(frame, 1)

		for ply, v in pairs(votees) do
			if not IsValid(ply) then continue end
			local plyButton = vgui.Create("DPanel", shell)
			plyButton:SetText("")
			plyButton:Dock(TOP)
			plyButton:DockMargin(4, 4, 4, 2)
			plyButton:SetTall(40)
			plyButton.Paint = function() end
			plyButton.headerColor = team.GetColor(ply:Team())
			plyButton.id = ply:SteamID64()
		
			plyButton.icon = vgui.Create("AvatarImage", plyButton)
			plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
			plyButton.icon:Dock(LEFT)
			plyButton.icon:SetPlayer(ply, 64)
		
			local btn = XYZUI.ButtonInput(plyButton, XYZUI.CharLimit(ply:Name(), 15), function()
				net.Start("Election:SubmitVote")
					net.WriteEntity(ply)
				net.SendToServer()

				frame:Close()
			end)
		end
end)


net.Receive("Election:UI:Pres", function()
	local ent = net.ReadEntity()

	local frame = XYZUI.Frame("Choose a Vice President", Election.Config.Color)
	frame:SetSize(ScrW()*0.2, ScrH()*0.7)
	frame:Center()

		_, shell = XYZUI.Lists(frame, 1)

		for k, v in ipairs(player.GetAll()) do
			if v == LocalPlayer() then continue end

			local plyButton = vgui.Create("DPanel", shell)
			plyButton:SetText("")
			plyButton:Dock(TOP)
			plyButton:DockMargin(4, 4, 4, 2)
			plyButton:SetTall(40)
			plyButton.Paint = function() end
			plyButton.headerColor = team.GetColor(v:Team())
			plyButton.id = v:SteamID64()
		
			plyButton.icon = vgui.Create("AvatarImage", plyButton)
			plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
			plyButton.icon:Dock(LEFT)
			plyButton.icon:SetPlayer(v, 64)
		
			local btn = XYZUI.ButtonInput(plyButton, XYZUI.CharLimit(v:Name(), 15), function()
				net.Start("Election:VicePres")
					net.WriteEntity(ent)
					net.WriteEntity(v)
				net.SendToServer()

				frame:Close()
			end)
		end
end)

net.Receive("Election:VicePres:Ask", function()
	local frame = XYZUI.Frame("Vice-President", Election.Config.Color, nil, nil, true)
	frame:SetSize(ScrH()*0.5, ScrH()*0.15)
	frame:SetPos((ScrW()*0.5)-(frame:GetWide()*0.5), ScrH()-frame:GetTall())

		local shell = XYZUI.Container(frame)
		shell:DockPadding(10, 10, 10, 10)

		local title = XYZUI.Title(shell, "You have been asked to become Vice-President", nil, 30, 0, true)

		local acceptButton = XYZUI.ButtonInput(shell, "Accept Invite!", function()
			net.Start("Election:VicePres:Accept")
			net.SendToServer()
			frame:Close()
		end)
		acceptButton:DockMargin(0, 0, 0, 0)
		acceptButton:Dock(FILL)
end)