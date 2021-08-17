function XYZDrugsTable.Core.OpenMenu()
	Quest.Core.NetworkProgress("pablo_escopole", 1)
	
	local frame = XYZUI.Frame("Buy Drugs", XYZDrugsTable.Config.Color)
	local navBar = XYZUI.NavBar(frame, true)

	local _, shell = XYZUI.Lists(frame, 1)

	  XYZUI.AddNavBarPage(navBar, shell, "Buy Drug Equipment", function(shell)
	  	for k, v in ipairs(XYZDrugsTable.Config.Drugs) do
	  		if v.check and not (v.check(LocalPlayer())) then continue end
	  		local body, card, mainContainer = XYZUI.ExpandableCard(shell, v.name, 40)
	  		mainContainer:DockMargin(0, 0, 0, 5)

	  		for n, m in pairs(v.ents) do
	  			if v.check and not (v.check(LocalPlayer())) then continue end
					local entity = scripted_ents.Get(m.ent)
					if not entity then continue end
					if not entity.Model then continue end

					local card = XYZUI.Card(body, 60)
					XYZUI.AddToExpandableCardBody(mainContainer, card)


					local model = vgui.Create("DModelPanel", card)
					model:Dock(LEFT)
					model:SetSize(card:GetTall(), card:GetTall())
					model:SetModel(entity.Model)
				
					-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
					if IsValid(model.Entity) then
						local mn, mx = model.Entity:GetRenderBounds()
						local size = 0
						size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
						size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
						size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
						model:SetFOV( 45 )
						model:SetCamPos( Vector( size+4, size+4, size+4 ) )
						model:SetLookAt( ( mn + mx ) * 0.5 )
						-- *|*
					end


					local name = XYZUI.Title(card, entity.PrintName, "Price: "..((m.price == 0 and "Free") or DarkRP.formatMoney(m.price)).." - Limit: "..((m.limit == 0) and "Infinite" or (m.limit + (XYZDrugsTable.Config.Addition[ply:Team()] or 0))), 30)
					name:Dock(FILL)
					name:DockMargin(5, 0, 5, 0)


					local purchase = XYZUI.ButtonInput(card, "Purchase", function()
						XYZDrugsTable.ActiveItem = m.ent
						frame:Close()
					end)
					purchase:SetWide(80)
					purchase:Dock(RIGHT)
					purchase:DockMargin(10, 10, 10, 10)
    		end
    	end
    end)
    XYZUI.AddNavBarPage(navBar, shell, "Find Drug Guides", function(shell)
    	for k, v in ipairs(XYZDrugsTable.Config.Guides) do
    		local body, card, mainContainer = XYZUI.ExpandableCard(shell, "[Guide] "..v.name, 40)
    		mainContainer:DockMargin(0, 0, 0, 5)


			local card = XYZUI.Card(body, 200)
			XYZUI.AddToExpandableCardBody(mainContainer, card)

		local desc = vgui.Create("DHTML", card)
		desc:Dock(FILL)
		desc:SetHTML([[
<head>
<style>
body::-webkit-scrollbar {
  width: 5px;
}
 
body::-webkit-scrollbar-track {
  box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
 
body::-webkit-scrollbar-thumb {
  background-color: rgba(55, 55, 55, 1);
}
body {
	color: white;
	font-family:Calibri;
	font-weight: 100;
	font-size: 15px;
	white-space: pre-line;
}
</style>
</head>
<body><p>]]..v.desc..[[</p></body]])
    	end
    end)

end