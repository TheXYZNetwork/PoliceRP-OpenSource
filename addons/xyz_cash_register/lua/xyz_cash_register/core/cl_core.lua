net.Receive("CashRegister:Confirm:Purchase", function()
	local item = net.ReadEntity()

	XYZUI.Confirm("Purchase - "..DarkRP.formatMoney(item:GetPrice()), CashRegister.Config.Color, function()
		net.Start("CashRegister:Action:Purchase")
			net.WriteEntity(item)
		net.SendToServer()
	end)
end)