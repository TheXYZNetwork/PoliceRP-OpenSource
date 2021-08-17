net.Receive("GunDealer:UI", function()
	local npc = net.ReadEntity()
	local stockLeft = net.ReadTable()

	GunDealer.Core.BuyUI(npc, stockLeft)
end)

function GunDealer.Core.BuyUI(npc, stockLeft)
    local frame = XYZUI.Frame("Gun Dealer", GunDealer.Config.Color)
    frame:SetSize(ScrH()*0.9, ScrH()*0.6)
    frame:Center()

    local _, shellWeapons = XYZUI.Lists(frame, 1)
    shellWeapons.Paint = nil


	-- Gmod go brrr
	for catName, catWeps in pairs(GunDealer.Config.Weapons) do
		local body, card, mainContainer = XYZUI.ExpandableCard(shellWeapons, catName)
		mainContainer:DockMargin(0, 0, 0, 10)

    	local gridWeapons = vgui.Create("ThreeGrid", body)
		gridWeapons:Dock(TOP)
		gridWeapons:SetTall(math.ceil(table.Count(catWeps)/4)*(260 + 2))
		gridWeapons:SetWide(body:GetWide())
		gridWeapons:InvalidateParent(true)
		gridWeapons:SetColumns(4)
		gridWeapons:SetVerticalMargin(2)

		XYZUI.AddToExpandableCardBody(mainContainer, gridWeapons)

		timer.Simple(0.1, function()
			for k, v in ipairs(catWeps) do
				local wep = weapons.Get(v.class)
				if not wep then return end
	
				local pnl = vgui.Create("DPanel")
				pnl:SetTall(260)
				pnl:DockPadding(0, 0, 2, 0)
				gridWeapons:AddCell(pnl)
				pnl:SetWide((shellWeapons:GetWide()/4) - 5)
				pnl.Paint = function() end
		
				local card = XYZUI.Container(pnl)
				card.parent = pnl
	
            	local model = vgui.Create("DModelPanel", card)
            	model:SetSize(card:GetTall(), card:GetTall())
            	model:Dock(FILL)
            	model:SetModel(wep.WorldModel)
            	--function model:LayoutEntity( Entity ) return end
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
	
				local buy = XYZUI.ButtonInput(card, "Purchase", function()
					GunDealer.Core.BuyQuantitiyUI(catName, k, npc, stockLeft)
					frame:Close()
				end)
				buy:Dock(BOTTOM)
				buy:DockMargin(2, 2, 2, 2)
				buy.headerColor = Color(0, 160, 0)
				if v.stock and (stockLeft[catName][k] == 0) then
					buy.headerColor = Color(160, 160, 160)
					buy.disText = "No Stock"
					buy.DoClick = function() end
				end
	
            	local info = XYZUI.Container(card)
            	info:SetTall(80)
            	info:Dock(BOTTOM)
            	info.Paint = nil
	
					local wepName = XYZUI.PanelText(info, wep.PrintName, 30, TEXT_ALIGN_CENTER)
					wepName:DockMargin(0, -5, 0, -8)
					XYZUI.PanelText(info, "Cost x1: "..DarkRP.formatMoney(v.price), 25, TEXT_ALIGN_CENTER)
					XYZUI.PanelText(info, "Stock: "..(v.stock and ((stockLeft[catName][k] == 0) and "No Stock Left" or string.Comma(stockLeft[catName][k])) or "∞"), 20, TEXT_ALIGN_CENTER)
			end
		end)
	end
end


function GunDealer.Core.BuyQuantitiyUI(category, key, npc, stockLeft)
	local wepStoreData = GunDealer.Config.Weapons[category][key]
	local remainingStock = stockLeft[category][key]
	local desiredAmount = 1
	local wep = weapons.Get(wepStoreData.class)

    local frame = XYZUI.Frame("Gun Dealer - "..wep.PrintName, GunDealer.Config.Color)
    frame:SetSize(ScrH()*0.9, ScrH()*0.6)
    frame:Center()

    local model = vgui.Create("DModelPanel", frame)
    model:SetSize(frame:GetTall(), frame:GetTall())
    model:Dock(FILL)
    model:SetModel(wep.WorldModel)
    --function model:LayoutEntity( Entity ) return end
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


    local card = XYZUI.Card(frame, 150)
    card:Dock(BOTTOM)

    local quantity = XYZUI.Card(card, 40)
    quantity:Dock(TOP)
    quantity.Paint = nil
    quantity:DockMargin(frame:GetWide()*0.3, 10, frame:GetWide()*0.3, 0)

    local totalCost

    local counter = XYZUI.PanelText(quantity, desiredAmount.."/"..(remainingStock and string.Comma(remainingStock) or "∞"), 40, TEXT_ALIGN_CENTER)
    counter:Dock(FILL)
    local leftArrow = XYZUI.ButtonInput(quantity, "<", function()
    	desiredAmount = math.Clamp(desiredAmount - 1, 1, remainingStock or 100)
    	counter.text = string.Comma(desiredAmount).."/"..(remainingStock and string.Comma(remainingStock) or "∞")

    	totalCost.text = DarkRP.formatMoney(wepStoreData.price * desiredAmount)
    end)
    leftArrow:Dock(LEFT)
    local rightArrow = XYZUI.ButtonInput(quantity, ">", function()
    	desiredAmount = math.Clamp(desiredAmount + 1, 1, remainingStock or 100)
    	counter.text = string.Comma(desiredAmount).."/"..(remainingStock and string.Comma(remainingStock) or "∞")

    	totalCost.text = DarkRP.formatMoney(wepStoreData.price * desiredAmount)
    end)
    rightArrow:Dock(RIGHT)
	
	totalCost = XYZUI.PanelText(card, DarkRP.formatMoney(wepStoreData.price * desiredAmount), 50, TEXT_ALIGN_CENTER)
	totalCost:Dock(TOP)

	local buy = XYZUI.ButtonInput(card, "Purchase", function()
		XYZUI.Confirm(wep.PrintName.." - x"..desiredAmount.." - "..DarkRP.formatMoney(wepStoreData.price * desiredAmount), Color(0, 160, 0), function()
			net.Start("GunDealer:Purchase")
				net.WriteEntity(npc)
				net.WriteString(category)
				net.WriteUInt(key, 7)
				net.WriteUInt(desiredAmount, 7)
			net.SendToServer()

			frame:Close()
		end)
	end)
	buy:Dock(BOTTOM)
	buy:DockMargin(2, 2, 2, 2)
	buy.headerColor = Color(0, 160, 0)
end