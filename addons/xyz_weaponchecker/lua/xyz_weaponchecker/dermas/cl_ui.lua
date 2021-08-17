local function BuildCard(card, wep, class, target, special)
	local weapon = weapons.Get(class)
	if not weapon then return end
	card:Dock(TOP)
	card:SetSize(card.parent:GetWide(), 110)

	local a = XYZUI.Title(card, wep.name, (wep.reward == 0) and "Unstrippable" or DarkRP.formatMoney(wep.reward), 27, 23, true)
	a:DockMargin(5, 0, 5, 0)
	a:Dock(TOP)
	a:SetTall(50)

	if weapon.WorldModel then
		card:SetSize(card.parent:GetWide(), card.parent:GetTall())
		local cardOldPaint = card.Paint
		card.Paint = function(self, w, h)
			cardOldPaint(self, w, h)

			if not IsValid(self.model) then
				self.model = vgui.Create("DModelPanel", card)
				self.model:SetSize(w, card.parent:GetTall()-110)
				self.model:Dock(FILL)
				self.model:DockMargin(2, 2, 2, 2)
				self.model:SetModel(weapon.WorldModel)
				--function b.model:LayoutEntity( Entity ) return end
			
				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = self.model.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				self.model:SetFOV(60)
				self.model:SetCamPos( Vector( size+4, size+4, size+4 ) )
				self.model:SetLookAt( ( mn + mx ) * 0.5 )
				-- *|*
			end
		end
	end

	if not wep.blockStrip then 
		local buttonText = "Strip"
		if special == "job" then
			buttonText = "Strip (Job Weapon)"
		elseif special == "xstore" then 
			buttonText = "Strip (xStore Weapon)"
		elseif special == "inv" then 
			buttonText = "Strip (Inv Weapon)"
		end
		local strip = XYZUI.ButtonInput(card, buttonText, function()
			if not XYZShit.IsGovernment(LocalPlayer():Team(), true) then return end
			XYZUI.Confirm("Strip "..weapon.PrintName.."?", Color(2, 108, 254), function()
				net.Start("xyz_weaponchecker_strip")
					net.WriteString(weapon.ClassName)
					net.WriteEntity(target)
					--net.WriteString(weapon.PrintName) -- https://discordapp.com/channels/565105920414318602/567617926991970306/693603790913273857 (discord.gg/gmod) /me cries
					net.WriteBool(special == "inv")
				net.SendToServer()
				card:Remove()
			end)
		end)
		strip:Dock(BOTTOM)
		if not XYZShit.IsGovernment(LocalPlayer():Team(), true) then
			strip.headerColor = Color(128, 128, 128)
		else 
			strip.headerColor = Color(40, 174, 20)
			if special ~= true then
				strip.headerColor = Color(10, 155, 150)
			end
		end
	end
end

net.Receive( "xyz_weaponchecker_menu", function( _, ply )
	local illegals = net.ReadTable()
	local inv = net.ReadTable()
	local target = net.ReadEntity()
	local frame = XYZUI.Frame("Weapon Checker", WeaponChecker.Config.Color)
	local shell = XYZUI.Container(frame)
	shell.Paint = function(self, w, h)
    end

    local nav = XYZUI.NavBar(frame)


    XYZUI.AddNavBarPage(nav, shell, "Belt", function()
    	local stripAll = XYZUI.ButtonInput(shell, "Strip All", function()
    		XYZUI.Confirm("Strip all weapons?", Color(2, 108, 254), function()
		    	net.Start("xyz_weaponchecker_strip_all")
		    		net.WriteEntity(target)
		    		net.WriteBool(false)
		    	net.SendToServer()
		    	frame:Remove()
		    end)
    	end)
		local _, slist = XYZUI.Lists(shell, 1)
	
		local itemsGrid = vgui.Create("ThreeGrid", slist)
		itemsGrid:Dock(TOP)
		itemsGrid:SetTall(math.ceil(table.Count(illegals)/3)*222)
		itemsGrid:SetWide(shell:GetWide())
		itemsGrid:InvalidateParent(true)
		itemsGrid:SetColumns(3)
		
		for k, v in pairs(illegals) do
			local wep = WeaponChecker.Config.Weapons[k]
			local pnl = vgui.Create("DPanel")
	
			pnl:SetTall(220)
			itemsGrid:AddCell(pnl)
			pnl:SetWide(shell:GetWide()/3)
			pnl.Paint = function() end
	
			local itemPnl = XYZUI.Container(pnl)
			itemPnl.parent = pnl
	
			BuildCard(itemPnl, wep, k, target, v)
		end
    end)

    XYZUI.AddNavBarPage(nav, shell, "Inventory", function()
    	local stripAll = XYZUI.ButtonInput(shell, "Strip All Inventroy", function()
    		XYZUI.Confirm("Strip all inventroy weapons?", Color(2, 108, 254), function()
		    	net.Start("xyz_weaponchecker_strip_all")
		    		net.WriteEntity(target)
		    		net.WriteBool(true)
		    	net.SendToServer()
		    	frame:Remove()
		    end)
    	end)
		local _, slist = XYZUI.Lists(shell, 1)
	
		local itemsGrid = vgui.Create("ThreeGrid", slist)
		itemsGrid:Dock(TOP)
		itemsGrid:SetTall(math.ceil(table.Count(inv)/3)*222)
		itemsGrid:SetWide(shell:GetWide())
		itemsGrid:InvalidateParent(true)
		itemsGrid:SetColumns(3)
		
		for k, v in pairs(inv) do
			local wep = WeaponChecker.Config.Weapons[v.class]
			if not wep then continue end
			local pnl = vgui.Create("DPanel")
	
			pnl:SetTall(220)
			itemsGrid:AddCell(pnl)
			pnl:SetWide(shell:GetWide()/3)
			pnl.Paint = function() end
	
			local itemPnl = XYZUI.Container(pnl)
			itemPnl.parent = pnl
	
			BuildCard(itemPnl, wep, v.class, target, "inv")
		end
    end)
end )