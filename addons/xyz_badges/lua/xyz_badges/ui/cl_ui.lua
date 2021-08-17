concommand.Add("badge_ui", function(ply, cmd, args)
	if not XYZShit.Staff.All[LocalPlayer():GetUserGroup()] then return end
	local frame = vgui.Create("xyz_frame")
	frame:SetSize(300, 115)
	frame:Center()
	frame:ShowCloseButton(false)
	
	local shell = vgui.Create("DPanel", frame)
	shell:SetSize(frame:GetWide()-10, frame:GetTall()-10)
	shell:SetPos(5, 5)
	shell.Paint = function() end

	local steamID = vgui.Create("DTextEntry", shell)
	steamID:SetSize(shell:GetWide()-10, 20)
	steamID:SetPos(5, 5)
	steamID:SetText(LocalPlayer():SteamID64())

	local badge = vgui.Create("DComboBox", shell)
	badge:SetSize(shell:GetWide()-10, 20)
	badge:SetPos(5, 30)
	badge:SetText("Badge to give")
	for k, v in pairs(XYZBadges.Config.Badges) do
		badge:AddChoice(v.name, k)
	end

	local submit = vgui.Create("DButton", shell)
	submit:SetSize(shell:GetWide()-10, 20)
	submit:SetPos(5, 55)
	submit:SetText("Submit")
	submit.DoClick = function()
		net.Start("xyz_badge_admin_give")
			net.WriteString(steamID:GetText())
			net.WriteString(badge:GetOptionData(badge:GetSelectedID()))
		net.SendToServer()
		frame:Close()
	end

	local cancel = vgui.Create("DButton", shell)
	cancel:SetSize(shell:GetWide()-10, 20)
	cancel:SetPos(5, 80)
	cancel:SetText("Cancel")
	cancel.DoClick = function()
		frame:Close()
	end
end)