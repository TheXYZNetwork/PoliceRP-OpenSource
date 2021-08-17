net.Receive("xyz_partner_open", function()
	local frame = XYZUI.Frame("Select a Partner", Color(100, 40, 160))
	frame:SetSize(ScrH()*0.5, ScrH()*0.85)
	frame:Center()

	local _, membersList = XYZUI.Lists(frame, 1)
		for k, v in pairs(player.GetAll()) do
			if not table.HasValue(XYZShit.Jobs.Government.Police, v:Team()) then continue end
			if v == LocalPlayer() then continue end
			if v == XYZPartner.CurrentPartner then continue end


			local t = XYZUI.Card(membersList, 56)
			t:DockMargin(0, 0, 0, 5)
			t:Dock(TOP)
			t.Think = function()
				if not IsValid(v) then
					t:Remove()
				end
			end

			local a = XYZUI.Title(t, v:Name(), v:getJobTable().name, 30)
			a:Dock(FILL)
			a:DockMargin(5, 0, 0, 0)

			local j = XYZUI.ButtonInput(t, "Request Partnership", function(container)
				net.Start("xyz_partner_request")
					net.WriteEntity(v)
				net.SendToServer()
				frame:Close()
			end)
			j:SetWide(180)
			j:DockMargin(10, 10, 10, 10)
			j:Dock(RIGHT)
		end
end)

net.Receive("xyz_partners_open", function()
	local partners = net.ReadTable()

	local frame = XYZUI.Frame("View partners", Color(100, 40, 160))
	frame:SetSize(ScrH()*0.5, ScrH()*0.85)
	frame:Center()

	local _, membersList = XYZUI.Lists(frame, 1)
		for k, v in pairs(partners) do
			local t = XYZUI.Card(membersList, 56)
			t:DockMargin(0, 0, 0, 5)
			t:Dock(TOP)
			t.Think = function()
				if (not IsValid(v[1])) or (not IsValid(v[2])) then
					t:Remove()
				end
			end

			local a = XYZUI.Title(t, v[1]:Name(), v[2]:Name(), 30)
			a:Dock(FILL)
			a:DockMargin(5, 0, 0, 0)
		end
end)



net.Receive("xyz_partner_request_send", function()
	local partner = net.ReadEntity()

	if not partner then return end

	local frame = XYZUI.Frame("Partner Request", Color(100, 40, 160), nil, nil, true)
	frame:SetSize(300, 170)
	frame:SetPos(ScrW()-frame:GetWide(), (ScrH()/2)-(frame:GetTall()/2))
	frame.Think = function()
		if !IsValid(partner) then
			frame:Close()
		end
	end

	local shell = XYZUI.Container(frame)
	shell:DockPadding(10, 0, 10, 10)

	XYZUI.Title(shell, partner:GetName(), "would like to be your partner!", 30, 20, true)
	:SetTall(50)


	local accept = XYZUI.ButtonInput(shell, "Accept", function()
		if not partner then return end
		net.Start("xyz_partner_request_accept")
			net.WriteEntity(partner)
		net.SendToServer()
		frame:Close()
	end)
	accept:Dock(LEFT)
	accept:SetWide(frame:GetWide()/2-30)
	local deny = XYZUI.ButtonInput(shell, "Deny", function()
		if not partner then return end
		net.Start("xyz_partner_request_deny")
			net.WriteEntity(partner)
		net.SendToServer()
		frame:Close()
	end)
	deny:Dock(RIGHT)
	deny:SetWide(frame:GetWide()/2-30)
end)