net.Receive("XYZDoctor:Derma", function()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame("The Doctor", XYZDoctor.Config.Color)
	frame:SetSize(ScrH()*0.8, ScrH()*0.4)
	frame:Center()

	local navBar = XYZUI.NavBar(frame)
	local _, shell = XYZUI.Lists(frame, 1)

	XYZUI.AddNavBarPage(navBar, shell, "Examination", function(container)
		for k, v in ipairs(XYZDoctor.Config.Examinations) do
			local card = XYZUI.Card(container, 60)
			local title = XYZUI.Title(card, v.name, v.desc.." - "..DarkRP.formatMoney(XYZDoctor.Config.Discount(LocalPlayer(), v.price, true)), 35, 20)
			title:Dock(FILL)


			local buy = XYZUI.ButtonInput(card, "Buy", function()
				net.Start("XYZDoctor:Purchase:Examination")
					net.WriteEntity(npc)
					net.WriteUInt(k, 3)
				net.SendToServer()
				frame:Close()
			end)
			buy:DockMargin(10, 10, 10, 10)
			buy:Dock(RIGHT)
		end
	end)

	XYZUI.AddNavBarPage(navBar, shell, "Under The Table", function(container)
		for k, v in ipairs(XYZDoctor.Config.Entities) do
			local card = XYZUI.Card(container, 60)
			local title = XYZUI.Title(card, v.name, v.desc.." - Single: "..DarkRP.formatMoney(XYZDoctor.Config.Discount(LocalPlayer(), v.price)).. " | Bulk: "..DarkRP.formatMoney(XYZDoctor.Config.Discount(LocalPlayer(), v.price)*v.max), 35, 20)
			title:Dock(FILL)

			local model = vgui.Create("DModelPanel", card)
			model:Dock(LEFT)
			model:SetModel(v.model)
			-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
			local mn, mx = model.Entity:GetRenderBounds()
			local size = 0
			size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
			size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
			size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
			model:SetFOV(40)
			model:SetCamPos(Vector(size+4, size+4, size+4))
			model:SetLookAt((mn + mx)*0.5)

			local buy = XYZUI.ButtonInput(card, "Buy", function()
				net.Start("XYZDoctor:Purchase:Entity")
					net.WriteEntity(npc)
					net.WriteUInt(k, 3)
					net.WriteBool(false)
				net.SendToServer()
				frame:Close()
			end)
			buy:DockMargin(10, 10, 10, 10)
			buy:Dock(RIGHT)

			if v.bulkBuy then
				local bulkBuy = XYZUI.ButtonInput(card, "Bulk Buy", function()
					net.Start("XYZDoctor:Purchase:Entity")
						net.WriteEntity(npc)
						net.WriteUInt(k, 3)
						net.WriteBool(true)
					net.SendToServer()
					frame:Close()
				end)
				bulkBuy:DockMargin(10, 10, 0, 10)
				bulkBuy:Dock(RIGHT)
				bulkBuy:SetWide(80)
				bulkBuy.headerColor = Color(123, 193, 240)
			end
		end
	end)
end)
