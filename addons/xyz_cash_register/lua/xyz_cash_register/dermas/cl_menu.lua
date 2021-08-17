net.Receive("CashRegister:UI", function()
	local cashRegister = net.ReadEntity()
	local holding = net.ReadUInt(32)
	local totalProcessed = net.ReadUInt(32)
	local transactionsMade = net.ReadUInt(32)
	local open = net.ReadBool()
	local itemsListed = net.ReadTable()

	CashRegister.Core.OpenMenu(cashRegister, holding, totalProcessed, transactionsMade, open, itemsListed)
end)


function CashRegister.Core.OpenMenu(cashRegister, holding, processed, tranTotal, open, itemsListed)
	local frame = XYZUI.Frame("Cash Register", CashRegister.Config.Color)
	frame:SetSize(ScrW()*0.5, ScrH()*0.6)
	frame:Center()
	local navBar = XYZUI.NavBar(frame, true)
	local shell = XYZUI.Container(frame)
	shell.Paint = nil

	XYZUI.AddNavBarPage(navBar, shell, "Dashboard", function()
		local currentlyHolding = XYZUI.Card(shell, 76)
		currentlyHolding:SetWide(shell:GetWide() * 0.49)
		currentlyHolding:DockMargin(0, 0, 0, 10)
		currentlyHolding.text = XYZUI.Title(currentlyHolding, "Currently Holding", DarkRP.formatMoney(holding), 40, 28, true)
		currentlyHolding.text:Dock(FILL)

		local stats = XYZUI.Card(shell, 70)
		stats:Dock(TOP)
		stats.Paint = nil
			local totalEarned = XYZUI.Card(stats, 70)
			totalEarned:Dock(LEFT)
			totalEarned:SetWide(shell:GetWide() * 0.49)
			totalEarned.text = XYZUI.Title(totalEarned, "Total Earned", DarkRP.formatMoney(processed), 40, 28, true)

			local totalProcessed = XYZUI.Card(stats, 70)
			totalProcessed:Dock(RIGHT)
			totalProcessed:SetWide(shell:GetWide() * 0.49)
			totalProcessed.text = XYZUI.Title(totalProcessed, "Transactions Made", string.Comma(tranTotal), 40, 28, true)


		local misc = XYZUI.Card(shell, 70)
		misc:Dock(TOP)
		misc:DockMargin(0, 10, 0, 0)
		misc.Paint = nil
			local openState = XYZUI.Card(misc, 70)
			openState:Dock(LEFT)
			openState:SetWide(shell:GetWide() * 0.49)
			openState.text = XYZUI.Title(openState, "Items Currently Listed", table.Count(itemsListed), 40, 28, true)
			local openState = XYZUI.Card(misc, 70)

			openState:Dock(RIGHT)
			openState:SetWide(shell:GetWide() * 0.49)
			openState.text = XYZUI.Title(openState, "Taken In Fees", DarkRP.formatMoney(processed * CashRegister.Config.Fee), 40, 28, true)


		local withdraw = XYZUI.ButtonInput(shell, "Withdraw Funds", function()
			net.Start("CashRegister:Action:Withdraw")
				net.WriteEntity(cashRegister)
			net.SendToServer()

			frame:Close()
		end)
		withdraw:Dock(BOTTOM)
	end)
	XYZUI.AddNavBarPage(navBar, shell, "List Item", function()
		local _, listableItems = XYZUI.Lists(shell, 1) 

		local stacks = {}
		for k, v in pairs(Inventory.SavedInvs) do
			if not stacks[v.class] then
				stacks[v.class] = {}
				stacks[v.class].count = 0
				stacks[v.class].sample = v
			end
			stacks[v.class].count = stacks[v.class].count + 1
		end


		for k, v in pairs(stacks) do
			local card = XYZUI.Card(listableItems, 70)
			card:DockMargin(0, 0, 0, 5)
	
			local model = vgui.Create("DModelPanel", card)
			model:SetSize(card:GetTall(), card:GetTall())
			model:Dock(LEFT)
			model:SetModel(v.sample.data.info.displayModel)
			model:DockMargin(0, 0, 2, 0)
	
				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = model.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				model:SetFOV(40)
				model:SetCamPos( Vector( size+4, size+4, size+4 ) )
				model:SetLookAt( ( mn + mx ) * 0.5 )
				-- *|*

			local info = XYZUI.Title(card, v.sample.data.info.displayName or "Unknown", "Count: ".."x"..v.count, 40, 30)
			if v.sample.data.type.isWeapon then
				info.title = weapons.Get(v.sample.data.info.displayName).PrintName
			end
			info:Dock(FILL)

			local sellBtn = XYZUI.ButtonInput(card, "Sell One", function()
				XYZUI.PromptInput("Set Price", CashRegister.Config.Color, 10000, function(price)
					price = tonumber(price)
					if not isnumber(price) then return end
					if price <= 0 then return end
	
					net.Start("CashRegister:Action:Sell")
						net.WriteEntity(cashRegister)
						net.WriteString(v.sample.class)
						net.WriteUInt(price, 32)
					net.SendToServer()
	
					frame:Close()
				end)
			end)
			sellBtn:Dock(RIGHT)
			sellBtn:SetWide(frame:GetWide()*0.2)
			sellBtn:DockMargin(10, 10, 10, 10)
		end
	end)
	XYZUI.AddNavBarPage(navBar, shell, "Current Listings", function()
		local _, listedItems = XYZUI.Lists(shell, 1) 

		for k, v in pairs(itemsListed) do
			if not IsValid(v) then continue end
			
			local card = XYZUI.Card(listedItems, 70)
			card:DockMargin(0, 0, 0, 5)
	
			local model = vgui.Create("DModelPanel", card)
			model:SetSize(card:GetTall(), card:GetTall())
			model:Dock(LEFT)
			model:SetModel(v:GetModel())
			model:DockMargin(0, 0, 2, 0)
	
				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = model.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				model:SetFOV(40)
				model:SetCamPos( Vector( size+4, size+4, size+4 ) )
				model:SetLookAt( ( mn + mx ) * 0.5 )
				-- *|*

			local info = XYZUI.Title(card, v:GetDisplayName() or "Unknown", DarkRP.formatMoney(v:GetPrice()), 40, 30)
			info:Dock(FILL)

			local removeBtn = XYZUI.ButtonInput(card, "Delist Item", function()
				XYZUI.Confirm("Delist Item?", CashRegister.Config.Color, function()
					net.Start("CashRegister:Action:Delist")
						net.WriteEntity(cashRegister)
						net.WriteEntity(v, 32)
					net.SendToServer()
	
					card:Remove()
				end)
			end)
			removeBtn:Dock(RIGHT)
			removeBtn:SetWide(frame:GetWide()*0.2)
			removeBtn:DockMargin(10, 10, 10, 10)
		end
	end)
end