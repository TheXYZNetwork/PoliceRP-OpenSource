net.Receive("XYZ911:StartCall", function()
	local caller = net.ReadEntity()
	local callID = net.ReadUInt(32)
	local reason = net.ReadString()

	XYZ911.UI.Popup(caller, callID, reason)
end)

function XYZ911.UI.Popup(caller, callID, reason)
	local frame = XYZUI.Frame("911 Call #"..tostring(callID), XYZ911.Config.Color, nil, nil, true)
	frame:SetSize(400, 165)
	frame:SetPos((ScrW()*0.5) - (frame:GetWide()*0.5), ScrH() - (frame:GetTall()) - 5)

	local name = XYZUI.PanelText(frame, caller:Name() or "Unknown", 30, TEXT_ALIGN_CENTER)
	local reasonText = XYZUI.PanelText(frame, reason or "Unknown", 20, TEXT_ALIGN_CENTER)

	local button = XYZUI.ButtonInput(frame, "Take Call", function()
		net.Start("XYZ911:Respond")
			net.WriteUInt(callID, 32)
		net.SendToServer()

		frame:Close()
	end)
	button:Dock(BOTTOM)

	timer.Simple(XYZ911.Config.ClaimTime, function()
		if not IsValid(frame) then return end

		frame:Close()
	end)
end