net.Receive("CashRegister:Action:Withdraw", function(_, ply)
	if XYZShit.CoolDown.Check("CashRegister:Action:Withdraw", 1, ply) then return end

	local cashRegister = net.ReadEntity()

	-- Distance check
	if not (cashRegister:GetClass() == "xyz_cash_register") then return end
	if cashRegister:GetPos():Distance(ply:GetPos()) > 500 then return end

	if not (cashRegister:Getowning_ent() == ply) then return end
	if cashRegister:GetMoney() <= 0 then return end


	XYZShit.Msg("Cash Register", CashRegister.Config.Color, "You withdrew "..DarkRP.formatMoney(cashRegister:GetMoney()).."!", ply)

	xLogs.Log(xLogs.Core.Player(ply).." withdrew "..xLogs.Core.Color(DarkRP.formatMoney(cashRegister:GetMoney()), Color(0, 200, 0)), "Cash Register")

	-- Give the player the money and reset the register's holdings
	ply:addMoney(cashRegister:GetMoney())
	cashRegister:EmptyMoney()
end)

net.Receive("CashRegister:Action:Sell", function(_, ply)
	if XYZShit.CoolDown.Check("CashRegister:Action:Sell", 1, ply) then return end

	local cashRegister = net.ReadEntity()
	local item = net.ReadString()
	local price = net.ReadUInt(32)

	-- Distance check
	if not (cashRegister:GetClass() == "xyz_cash_register") then return end
	if cashRegister:GetPos():Distance(ply:GetPos()) > 500 then return end

	if not (cashRegister:Getowning_ent() == ply) then return end
	if price <= 0 then return end

	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
	if not ownsItem then return end

	local itemData = Inventory.SavedInvs[ply:SteamID64()][ownsItem]

	local ent = ents.Create("xyz_cash_register_item")
	ent:SetPos(cashRegister:GetPos() + Vector(0, 0, 20))
	ent:SetData(itemData)
	ent:SetCashRegister(cashRegister)
	ent:SetPrice(price)
	ent:Spawn()
	ent:Activate()

	cashRegister:AddItem(ent)
	Inventory.Core.RemoveItemFromInv(ply, itemData.class)

	Quest.Core.ProgressQuest(ply, "stable_income", 3)

	xLogs.Log(xLogs.Core.Player(ply).." has put "..xLogs.Core.Color(item, Color(0, 200, 200)).." up for sale.", "Cash Register")
end)

net.Receive("CashRegister:Action:Purchase", function(_, ply)
	if XYZShit.CoolDown.Check("CashRegister:Action:Purchase", 1, ply) then return end

	local item = net.ReadEntity()
	if not IsValid(item) then return end

	-- Distance check
	if not (item:GetClass() == "xyz_cash_register_item") then return end
	if item:GetPos():Distance(ply:GetPos()) > 500 then return end

	if not ply:canAfford(item:GetPrice()) then
		XYZShit.Msg("Cash Register", CashRegister.Config.Color, "You cannot afford this item...", ply)
		return
	end

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end

	ply:addMoney(-item:GetPrice())
	Inventory.Core.GiveItem(ply:SteamID64(), item.data.class, item.data.data)

	local cashRegister = item:GetCashRegister()
	cashRegister:RemoveItem(item, true)

	XYZShit.Msg("Cash Register", CashRegister.Config.Color, "You have purchased an item for "..DarkRP.formatMoney(item:GetPrice()).."!", ply)

	local owner = cashRegister:Getowning_ent()
	if IsValid(owner) then
		local ownerCut = item:GetPrice() - (item:GetPrice() * CashRegister.Config.Fee)
		XYZShit.Msg("Cash Register", CashRegister.Config.Color, "You sold an item for "..DarkRP.formatMoney(ownerCut).."! It has been added to your cash register.", owner)
	
		xLogs.Log(xLogs.Core.Player(ply).." has purchase an item for "..xLogs.Core.Color(DarkRP.formatMoney(item:GetPrice()), Color(0, 200, 0)).." from "..xLogs.Core.Player(owner), "Cash Register")
	
		Quest.Core.ProgressQuest(owner, "stable_income", 4)
	end


	item:Remove()
end)
net.Receive("CashRegister:Action:Delist", function(_, ply)
	if XYZShit.CoolDown.Check("CashRegister:Action:Delist", 1, ply) then return end

	local cashRegister = net.ReadEntity()
	local item = net.ReadEntity()

	-- A whole bunch of checks
	if not (cashRegister:GetClass() == "xyz_cash_register") then return end
	if cashRegister:GetPos():Distance(ply:GetPos()) > 500 then return end
	if not (item:GetClass() == "xyz_cash_register_item") then return end
	if not (cashRegister:Getowning_ent() == ply) then return end
	if not (item.cashRegister == cashRegister) then return end
	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end

	if item:GetPos():Distance(cashRegister:GetPos()) > 1000 then
		XYZShit.Msg("Cash Register", CashRegister.Config.Color, "This item is too far from the Cash Register to be returned to you...", ply)
		return
	end

	cashRegister:RemoveItem(item, false)

	XYZShit.Msg("Cash Register", CashRegister.Config.Color, "Your item has been returned to you.", ply)
	Inventory.Core.GiveItem(ply:SteamID64(), item.data.class, item.data.data)
	item:Remove()
end)