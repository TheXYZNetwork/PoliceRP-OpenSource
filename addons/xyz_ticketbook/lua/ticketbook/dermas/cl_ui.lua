net.Receive("ticketbook_open", function()
	TicketBook.MainMenu(net.ReadEntity())
end)

function TicketBook.MainMenu(target)
	if not target then return end
	
	local frame = XYZUI.Frame("Ticket Someone", TicketBook.Config.Color)
	frame:SetSize(ScrH()*0.4, ScrH()*0.5)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell:DockPadding(5, 5, 5, 5)

	local stateCache = {}
	local _, ticketList = XYZUI.Lists(shell, 1)
	for k, v in ipairs(TicketBook.Config.Reasons) do
		local t = XYZUI.Card(ticketList, 30)
		t:DockMargin(0, 0, 0, 5)
		t:Dock(TOP)

		local a = XYZUI.PanelText(t, v.name, 20, TEXT_ALIGN_LEFT)
		a:Dock(FILL)

		local s, container = XYZUI.ToggleInput(t)
		container:Dock(RIGHT)
		container:SetSize(30, 30)
		container:DockMargin(5, 6, 0, 0)
		s:SetSize(20, 20)
		s.key = k
		table.insert(stateCache, s)
	end

	local custom = XYZUI.Card(ticketList, 60)
	custom:DockMargin(0, 0, 0, 5)

	local cpanel = vgui.Create("DPanel", custom)
	cpanel:Dock(FILL)
	cpanel.Paint = function() end
	cpanel.headerColor = custom.headerColor

	local customname, cn = XYZUI.TextInput(cpanel, false, 20)
	customname.placeholder = "Custom Reason"
	cn:Dock(FILL)

	local customfine, cf = XYZUI.TextInput(cpanel, false, 20)
	customfine.placeholder = "Custom Fine"
	customfine:SetNumeric(true)
	cf:DockMargin(5, 0, 0, 0)
	cf:Dock(RIGHT)
	timer.Simple(0.1, function()
		cf:SetWide(cpanel:GetWide()*0.3)
	end)
	

	local ticket = XYZUI.ButtonInput(shell, "Ticket", function(container)
		local tickets = {}
		for k, v in ipairs(stateCache) do
			if v.state then
				tickets[k] = true
			end
		end

		if customname:GetValue() ~= "" and customfine:GetValue() ~= "" then
			-- next line will error if customfine is text due to user error, not a bug, just how gmod handles the nil.
			tickets["custom"] = {name = customname:GetValue(), fine = customfine:GetInt()}
		end

		net.Start("ticketbook_ticket")
		net.WriteEntity(target)
		net.WriteTable(tickets)
		net.SendToServer()

		frame:Close()

	end)
	ticket:DockMargin(0, 5, 0, 0)
	ticket:Dock(BOTTOM)
end

net.Receive("ticketbook_ticket", function()
	local ticket = net.ReadTable()
	printReceipt(ticket)

	local frame = XYZUI.Frame("Ticket", TicketBook.Config.Color, true)
	frame:SetSize(ScrW()*0.5, ScrH()*0.5)
	frame:Center()
	local shell = XYZUI.Container(frame)

	local _, reasons = XYZUI.Lists(shell, 1)
	reasons:Dock(FILL)
	reasons:DockMargin(10, 0, 10, 5)
	for k, v in pairs(ticket.reasons) do
		if k == "custom" then 
			print("Custom: "..v.name.." ("..v.fine..")")
			XYZUI.PanelText(reasons, v.name..": "..DarkRP.formatMoney(v.fine), 30, TEXT_ALIGN_CENTER)

			continue
		end
		XYZUI.PanelText(reasons, TicketBook.Config.Reasons[k].name..": "..DarkRP.formatMoney(TicketBook.Config.Reasons[k].ticket), 30, TEXT_ALIGN_CENTER)
	end

	XYZUI.PanelText(shell, "Total: "..DarkRP.formatMoney(ticket.amount), 45, TEXT_ALIGN_CENTER)
	XYZUI.PanelText(shell, "Officer: "..ticket.ticketer:Nick(), 30, TEXT_ALIGN_CENTER)

	local decline = XYZUI.ButtonInput(shell, "Decline Ticket", function()
		net.Start("ticketbook_decline")
		net.SendToServer()
		frame:Close()
	end)
	decline:Dock(BOTTOM)
	decline:DockMargin(10, 0, 10, 0)
	decline.headerColor = Color(255, 0, 64)
	local pay = XYZUI.ButtonInput(shell, "Pay Ticket", function()
		net.Start("ticketbook_pay")
		net.SendToServer()
		frame:Close()
	end)
	pay:Dock(BOTTOM)
	pay:DockMargin(10, 5, 10, 10)
end)

function printReceipt(ticket)
	print("--------------------------")
	print("You have been ticketed!")
	print("Officer Involved: " .. ticket.ticketer:Nick() .. " (" .. ticket.ticketer:SteamID64() .. ")")
	print("Reason(s) for ticket:")
	for k, v in pairs(ticket.reasons) do
		if k == "custom" then 
			print("Custom: "..v.name.." ("..v.fine..")")
			continue
		end
		print(TicketBook.Config.Reasons[k].name..": $"..TicketBook.Config.Reasons[k].ticket)
	end
	print("Total: $"..ticket.amount)
	print("--------------------------")
end