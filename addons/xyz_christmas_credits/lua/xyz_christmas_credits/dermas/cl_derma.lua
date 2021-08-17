net.Receive("ChristmasCredits:Derma", function()
	local npc = net.ReadEntity()
	local creditCount = net.ReadInt(32)

	local frame = XYZUI.Frame("Christmas Credit Store", Color(246, 70, 99))
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()


    local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)
	shell.Paint = function() end

    XYZUI.AddNavBarPage(navBar, shell, "Store", function(shell)
		local myCredits = XYZUI.Card(shell, 80)
		myCredits:DockMargin(0, 0, 0, 5)
	
			local myCreditsText = XYZUI.Title(myCredits, "My Credits:", string.Comma(creditCount), 45, 30, true)
			myCreditsText:Dock(FILL)
			myCreditsText:DockMargin(0, 5, 0, 5)
	
		local _, contList = XYZUI.Lists(shell, 1)
		contList:DockPadding(5, 5, 5, 5)
	
		for k, v in pairs(XYZChristmasCredits.Config.Items) do
			local card = XYZUI.Card(contList, 80)
			card:DockMargin(0, 0, 0, 5)
	
			if v.model then
				local model = vgui.Create("DModelPanel", card)
				model:SetSize(card:GetTall(), card:GetTall())
				model:Dock(LEFT)
				model:SetModel(v.model)
				model:DockMargin(0, 3, 2, 3)
		
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
			end
			
	
			local title = XYZUI.Title(card, v.name, string.Comma(v.price).." credits", 35, 25)
			title:Dock(FILL)
			title:DockMargin(5, 10, 0, 10)
	
			local purchaseButton = XYZUI.ButtonInput(card, "Purchase", function()
				net.Start("ChristmasCredits:Purchase")
					net.WriteEntity(npc)
					net.WriteInt(k, 32)
				net.SendToServer()
				frame:Close()
			end)
			purchaseButton:Dock(RIGHT)
			purchaseButton:SetWide(frame:GetWide()/5)
			purchaseButton:DockMargin(10, 10, 10, 10)
		end
    end)
    XYZUI.AddNavBarPage(navBar, shell, "Advent Calendar", function(shell)
        XYZChristmasAdvent.Core.UI()
        frame:Close()
    end)



end)