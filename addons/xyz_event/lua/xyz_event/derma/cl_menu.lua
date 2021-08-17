net.Receive("EventSystem:Invite", function()
	-- They're already event team
	if LocalPlayer():Team() == TEAM_EVENT then return end
	if LocalPlayer():Team() == TEAM_EVENTTEAM then return end

	local title = net.ReadString()
	local desc = net.ReadString()
	local credits = net.ReadUInt(32)

	local frame = XYZUI.Frame("An Event Is Starting", EventSystem.Config.Color, nil, nil, true)
	frame:SetSize(ScrH()*0.6, 260)
	frame:SetPos((ScrW()*0.5) - (frame:GetWide()*0.5), 0)

	local title = XYZUI.PanelText(frame, title, 45, TEXT_ALIGN_CENTER)
	title:Dock(TOP)
	local prize = XYZUI.PanelText(frame, "Prize: "..string.Comma(credits).." Credits", 30, TEXT_ALIGN_CENTER)
	prize:Dock(TOP)
	local desc = XYZUI.WrappedText(frame, desc, 30)

	local join = XYZUI.ButtonInput(frame, "Join Event", function()
		net.Start("EventSystem:Invite:Accept")
		net.SendToServer()
		
		frame:Close()
	end)
	join:Dock(BOTTOM)


	timer.Simple(60, function()
		if not IsValid(frame) then return end

		frame:Close()
	end)
end)


function EventSystem.Core.MessageUI(msg)
	local frame = XYZUI.Frame("A message from the Gamemasters!", EventSystem.Config.Color, nil, nil, true)
	frame:SetSize(ScrW()*0.9, 150)
	frame:SetPos(ScrW()*0.05, 15)

	local text = XYZUI.PanelText(frame, msg, 50, TEXT_ALIGN_CENTER)
	text:Dock(FILL)

	timer.Simple(10, function()
		if not IsValid(frame) then return end

		frame:Close()
	end)
end