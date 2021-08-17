net.Receive("Mining:UI", function()
	local npc = net.ReadEntity()
	local ores = net.ReadTable()

    local frame = XYZUI.Frame("Mining", Mining.Config.Color)
    frame:SetSize(ScrH()*0.9, ScrH()*0.6)
    frame:Center()

    local _, shellOres = XYZUI.Lists(frame, 1)
    shellOres.Paint = nil

    local _, shellEquipment = XYZUI.Lists(frame, 1)
    shellEquipment.Paint = nil
    shellEquipment:DockPadding(10, 5, 10, 10)
    shellEquipment:DockMargin(0, 0, 10, 0)
    shellEquipment:Dock(LEFT)
    shellEquipment:SetWide(frame:GetWide()/3)

    	for k, v in ipairs(Mining.Config.Gear) do
    		if not v.canBuy(LocalPlayer()) then continue end

			local card = XYZUI.Container(shellEquipment)
			card:Dock(TOP)
			card:SetTall(75)
			card:DockMargin(0, 0, 0, 10)

            local model = vgui.Create("DModelPanel", card)
            model:SetSize(card:GetTall(), card:GetTall())
            model:Dock(LEFT)
            model:SetModel(v.model)
            --function b.model:LayoutEntity( Entity ) return end
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


            local text = XYZUI.Title(card, v.name, DarkRP.formatMoney(v.price), 40, 30)
            text:Dock(FILL)

			local buy = XYZUI.ButtonInput(card, "BUY", function()
				net.Start("Mining:Buy")
					net.WriteEntity(npc)
					net.WriteUInt(k, 10)
				net.SendToServer()
			
				frame:Close()
			end)
			buy.headerColor = Color(0, 155, 0)
			buy:Dock(RIGHT)
			buy:SetWide(card:GetTall() * 1)
			buy:DockMargin(5, 5, 5, 5)
    	end


    local heightPerCard = 260

    local gridOres = vgui.Create("ThreeGrid", shellOres)
	gridOres:Dock(TOP)
	gridOres:SetTall(math.ceil(table.Count(Mining.Config.Ores)/3)*(260 + 2))
	gridOres:SetWide(shellOres:GetWide())
	gridOres:InvalidateParent(true)
	gridOres:SetColumns(3)
	gridOres:SetVerticalMargin(2)

	-- Gmod go brrr
	timer.Simple(0.5, function()
		if not IsValid(frame) then return end
		
		for k, v in pairs(Mining.Config.Ores) do
			local pnl = vgui.Create("DPanel")
			pnl:SetTall(260)
			pnl:DockPadding(0, 0, 2, 0)
			gridOres:AddCell(pnl)
			pnl:SetWide((shellOres:GetWide()/3) - 5)
			pnl.Paint = function() end
	
			local card = XYZUI.Container(pnl)
			card.parent = pnl

            local model = vgui.Create("DModelPanel", card)
            model:SetSize(card:GetTall(), card:GetTall())
            model:Dock(FILL)
            model:SetModel("models/freeman/exhibition_ore_rock.mdl")
            model:SetColor(v.color)
            --function b.model:LayoutEntity( Entity ) return end
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

			local sell = XYZUI.ButtonInput(card, "SELL", function()
				if (not ores[k]) or (ores[k] == 0) then return end

				XYZUI.PromptInput("Sell "..v.name, Color(0, 150, 0), "Amount to sell | Max "..ores[k], function(amount)
					if (not amount) or (not tonumber(amount)) then return end
					
					if tonumber(amount) > ores[k] then return end

					net.Start("Mining:Sell")
						net.WriteEntity(npc)
						net.WriteString(k)
						net.WriteUInt(amount, 32)
					net.SendToServer()

					frame:Close()
				end)
			end)
			sell:Dock(BOTTOM)
			sell:DockMargin(2, 2, 2, 2)


            local info = XYZUI.Container(card)
            info:SetTall(80)
            info:Dock(BOTTOM)
            info.Paint = nil

            	--local text = XYZUI.Title(info, v.name, "Value: "..DarkRP.formatMoney(v.value.min).." - "..DarkRP.formatMoney(v.value.max), 30, 20, true)
				local oreName = XYZUI.PanelText(info, v.name, 40, TEXT_ALIGN_CENTER)
				oreName:DockMargin(0, -5, 0, -8)
				local storing = XYZUI.PanelText(info, "Storing: "..(ores[k] or "None"), 25, TEXT_ALIGN_CENTER)
				local oreValue = XYZUI.PanelText(info, "Value: "..DarkRP.formatMoney(v.value.min).." - "..DarkRP.formatMoney(v.value.max), 20, TEXT_ALIGN_CENTER)
		end

		local sellAll = XYZUI.ButtonInput(shellOres, "SELL ALL", function()
			net.Start("Mining:Sell:All")
				net.WriteEntity(npc)
			net.SendToServer()
		
			frame:Close()
		end)
		sellAll:Dock(TOP)
		sellAll:DockMargin(0, 5, 10, 0)
	end)
end)