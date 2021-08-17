net.Receive("xyz_ups_menu", function()
	local deliveries = net.ReadTable()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame("UPS", UPS.Config.Color)
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell.Paint = function() end

	local _, contList = XYZUI.Lists(shell, 1)
	contList:DockPadding(5, 5, 5, 5)
	local cooldownColor = Color(255, 0, 0, 5)

	for k, v in pairs(deliveries) do
		local card = XYZUI.Card(contList, 80)
		card:DockMargin(0, 0, 0, 5)
		if v.cooldown then 
			card.PaintOver = function()
				surface.SetDrawColor(cooldownColor)
				card:DrawFilledRect()
			end
		end
		
		local deliveryTitle = XYZUI.Title(card, "Delivery - "..v.name, string.format("%sm away - %s reward", string.Comma(math.Round(v.pos:Distance(LocalPlayer():GetPos()))), DarkRP.formatMoney(v.reward)), 30, 30)
		deliveryTitle:Dock(FILL)

		local selectDelivery = XYZUI.ButtonInput(card, (v.cooldown and "Cooldown" or "Select"), function()
			if v.cooldown then return end
			net.Start("xyz_ups_select")
				net.WriteEntity(npc)
				net.WriteInt(k, 32)
			net.SendToServer()

			frame:Close()
		end)
		selectDelivery:Dock(RIGHT)
		selectDelivery:SetWide(frame:GetWide()/5)
		selectDelivery:DockMargin(10, 10, 10, 10)
	end
end)