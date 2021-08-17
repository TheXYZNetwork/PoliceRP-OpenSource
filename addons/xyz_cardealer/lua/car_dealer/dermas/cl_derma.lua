function CarDealer.UI.Open(npc)
	CarDealer.UI.CamData = {
		zoom = 300,
		x = 165,
		y = 20,
		
		orbitPoint = CarDealer.Config.VehPos,
	}

	if IsValid(CarDealer.UI.Menu) then
		CarDealer.UI.Menu:Remove()
	end
	if IsValid(CarDealer.UI.Vehicle) then
		CarDealer.UI.Vehicle:Remove()
	end

	local frame = vgui.Create("DFrame")
	CarDealer.UI.Menu = frame
	function frame:OnClose()
		if IsValid(CarDealer.UI.Vehicle) then
			CarDealer.UI.Vehicle:Remove()
		end
	end
	frame:SetSize(ScrW(), ScrH())
	frame:SetPos(0, 0)
	frame:MakePopup()
	frame:SetDraggable(false)
	frame.Paint = nil
	frame:SetTitle("")
	frame:DockPadding(0, 0, 0, 0)

	local customsShell = XYZUI.Container(frame)
	customsShell:Dock(RIGHT)
	customsShell:SetWide(frame:GetWide()*0.2)

	local _, customs = XYZUI.Lists(customsShell, 1)
	customs:Dock(FILL)
	customs.Paint = nil

	local buyButton
	function populateCustoms(data, existingData, newPurchase)
		-- Sell button
		if IsValid(customsShell:GetChildren()[2]) then
			customsShell:GetChildren()[2]:Remove()
		end
		-- Spawn/Tune button
		if IsValid(customsShell:GetChildren()[3]) then
			customsShell:GetChildren()[3]:Remove()
		end
		customs:Clear()
		if IsValid(buyButton) then
			buyButton:Remove()
		end

		-- Color mixer
		local colorMixerShell = XYZUI.Container(customs)
		colorMixerShell:Dock(TOP)
		colorMixerShell:SetTall(customs:GetWide())
		colorMixerShell.Paint = nil

		local text = XYZUI.PanelText(colorMixerShell, newPurchase and "Color:" or "Color - "..DarkRP.formatMoney(CarDealer.Config.Price.Color(LocalPlayer()))..":", 35, TEXT_ALIGN_LEFT)
		text:DockMargin(0, 5, 0, -10)

		local colorMixer = vgui.Create("DColorMixer", colorMixerShell)
		colorMixer:Dock(FILL)
		colorMixer:DockMargin(10, 10, 10, 10)
		colorMixer:SetPalette(false)
		colorMixer:SetAlphaBar(false)
		colorMixer:SetWangs(true)
		colorMixer:SetColor(existingData and existingData.color or color_white)
		colorMixer.ValueChanged = function(newColor)
			CarDealer.UI.Vehicle:SetColor(newColor:GetColor())
		end

		-- Skin
		local skinShell = XYZUI.Container(customs)
		skinShell:Dock(TOP)
		skinShell:SetTall(80)
		skinShell.Paint = nil

		local text = XYZUI.PanelText(skinShell, "Skin - "..DarkRP.formatMoney(CarDealer.Config.Price.Skin(LocalPlayer()))..":", 35, TEXT_ALIGN_LEFT)
		text:DockMargin(0, 5, 0, -10)

		local skinDropdown = XYZUI.DropDownList(skinShell, "Skin", function(name, value)
			CarDealer.UI.Vehicle:SetSkin(name)
		end)
		skinDropdown:DockMargin(10, 10, 10, 0)

		for i=0, CarDealer.UI.Vehicle:SkinCount() do
			if table.HasValue(data.block.skins, i) then continue end
			XYZUI.AddDropDownOption(skinDropdown, i)
		end

		-- Bodygroups
		local bodygroupList = XYZUI.Container(customs)
		bodygroupList:Dock(TOP)
		bodygroupList.Paint = nil

		local text = XYZUI.PanelText(bodygroupList, "Bodygroups - "..DarkRP.formatMoney(CarDealer.Config.Price.Bodygroup(LocalPlayer())).." each:", 35, TEXT_ALIGN_LEFT)
		text:DockMargin(0, 5, 0, -5)

		for k, v in pairs(CarDealer.UI.Vehicle:GetBodyGroups()) do
			if v.num <= 1 then continue end
			if data.block.bodygroups[string.lower(v.name)] == true then continue end

			local bodygroupDrop = XYZUI.DropDownList(bodygroupList, string.upper(v.name), function(name, value)
				CarDealer.UI.Vehicle:SetBodygroup(v.id, name)
			end)
			bodygroupDrop:DockMargin(10, 10, 10, 0)
			bodygroupDrop.key = v.id

			for n, m in pairs(v.submodels) do
				if data.block.bodygroups[string.lower(v.name)] and table.HasValue(data.block.bodygroups[string.lower(v.name)], n) then continue end
				XYZUI.AddDropDownOption(bodygroupDrop, n, v.id)
			end
		end

		local increase = 0
		for k, v in pairs(bodygroupList:GetChildren()) do
			increase = increase + v:GetTall() + 10
		end
		bodygroupList:SetTall(increase)

		-- Mods
		local modsList = XYZUI.Container(customs)
		modsList:Dock(TOP)
		modsList:SetTall(customs:GetWide()*0.38)
		modsList.Paint = nil

		local text = XYZUI.PanelText(modsList, "Mods:", 35, TEXT_ALIGN_LEFT)
		text:DockMargin(0, 5, 0, -5)

		for k, v in pairs(CarDealer.Config.Mods) do
			local card = XYZUI.Container(modsList)
			card:Dock(TOP)
			card:SetTall(35)
			card.Paint = nil

			local checkbox, buffer = XYZUI.ToggleInput(card)
			buffer:Dock(LEFT)
			buffer:SetWide(30)
			buffer:DockMargin(10, 0, 0, 0)

			card.data = v
			card.key = k

			if existingData and existingData.mods then
				checkbox.state = existingData.mods[k] or false
			end
	
			local name = XYZUI.PanelText(card, v.name.." - "..DarkRP.formatMoney(v.price(LocalPlayer())), 30, TEXT_ALIGN_LEFT)
			name:Dock(FILL)
		end

		local increase = 0
		for k, v in pairs(modsList:GetChildren()) do
			increase = increase + v:GetTall()
		end
		modsList:SetTall(increase)

		-- Performance
		local perfList = XYZUI.Container(customs)
		perfList:Dock(TOP)
		perfList:SetTall(customs:GetWide()*0.5)
		perfList.Paint = nil

		local text = XYZUI.PanelText(perfList, "Performance:", 35, TEXT_ALIGN_LEFT)
		text:DockMargin(0, 5, 0, -5)

		for k, v in pairs(CarDealer.Config.Performance) do
			local card = XYZUI.Container(perfList)
			card:Dock(TOP)
			card:SetTall(35)
			card.Paint = nil

			card.data = v
			card.key = k

			card:SetTall(70)
			local name = XYZUI.PanelText(card, " | "..v.name, 30, TEXT_ALIGN_LEFT)
			name:Dock(TOP)

			local dropdown = XYZUI.DropDownList(card, v.name, function(name, value)
			end)
			dropdown:Dock(FILL)
			dropdown:DockMargin(10, 0, 10, 0)
	
			for n, m in pairs(v.options) do
				XYZUI.AddDropDownOption(dropdown, m.name.." - "..DarkRP.formatMoney(m.price), n)
			end
		end

		local increase = 10
		for k, v in pairs(perfList:GetChildren()) do
			increase = increase + v:GetTall()
		end
		perfList:SetTall(increase)

		buyButton = XYZUI.ButtonInput(customsShell, "Loading", function()
			if newPurchase or buyButton.tune then
				local customsData = {}
				-- Vehicle Color
				customsData.color = colorMixer:GetColor()
				-- Vehicle Skin
				customsData.skin = skinDropdown.GetSelected and skinDropdown:GetSelected() or 0
				-- Bodygroups
				customsData.bodygroups = {}
				for k, v in pairs(bodygroupList:GetChildren()) do
					if not v.GetSelected then continue end
					-- We -2 because bodygroups start at 0 and the first child is the title panel.
					local val, key = v:GetSelected()
					if not key then continue end
					customsData.bodygroups[key] = val
				end
				-- Mods
				customsData.mods = {}
				for k, v in pairs(modsList:GetChildren()) do
					if not v:GetChildren()[1] then continue end
					customsData.mods[v.key] = v:GetChildren()[1]:GetChildren()[1].state
				end
				-- Performance
				customsData.performance = {}
				for k, v in pairs(perfList:GetChildren()) do
					if not v:GetChildren()[2] then continue end

					local val, key = v:GetChildren()[2]:GetSelected()

					customsData.performance[v.key] = key
				end

				if newPurchase then
					net.Start("CarDealer:Purchase")
						net.WriteEntity(npc)
						net.WriteString(data.class)
						net.WriteTable(customsData)
					net.SendToServer()
				else
					net.Start("CarDealer:Tune")
						net.WriteEntity(npc)
						net.WriteUInt(existingData.id, 32)
						net.WriteTable(customsData)
					net.SendToServer()
				end
			else
				net.Start("CarDealer:Spawn")
					net.WriteEntity(npc)
					net.WriteUInt(existingData.id, 32)
				net.SendToServer()
			end

			frame:Close()
		end)
		buyButton.headerColor = Color(0, 150, 0)
		buyButton:DockMargin(5, 0, 5, 5)
		buyButton:Dock(BOTTOM)
		buyButton.Think = function()
			local totalCost = 0
			-- Vehicle cost
			if newPurchase then
				totalCost = totalCost + CarDealer.Config.Price.Vehicle(LocalPlayer(), data.price)
			end

			if (not newPurchase) and existingData and existingData.color and (not (existingData.color:ToVector() == colorMixer:GetVector())) then
				totalCost = totalCost + CarDealer.Config.Price.Color(LocalPlayer())
			end
			-- Vehicle Skin
			local skinNum = skinDropdown.GetSelected and skinDropdown:GetSelected()
			if skinNum and (not (skinNum == 0)) and not (existingData.skin and (existingData.skin == skinNum)) then
				totalCost = totalCost + CarDealer.Config.Price.Skin(LocalPlayer())
			end
			-- Bodygroups
			for k, v in pairs(bodygroupList:GetChildren()) do
				if not v.GetSelected then continue end
				local bodyNum = v:GetSelected()
				local key = v.key

				if existingData.bodygroups and existingData.bodygroups[key] and (existingData.bodygroups[key] == bodyNum) then
					continue
				end

				if bodyNum and not (newPurchase and (bodyNum == 0)) then
					totalCost = totalCost + CarDealer.Config.Price.Bodygroup(LocalPlayer())
				end
			end
			-- Mods
			for k, v in pairs(modsList:GetChildren()) do
				if not v:GetChildren()[1] then continue end
				local isTicked = v:GetChildren()[1]:GetChildren()[1].state

				if isTicked then
					if existingData and existingData.mods and existingData.mods[v.key] and (existingData.mods[v.key] == isTicked) then
						continue
					end
					totalCost = totalCost + v.data.price(LocalPlayer())
				end
			end
			-- Performance
			for k, v in pairs(perfList:GetChildren()) do
				if not v:GetChildren()[2] then continue end

				local _, perNum = v:GetChildren()[2]:GetSelected()
				local data = v.data.options[perNum]

				if data then
					if existingData and existingData.performance and existingData.performance[v.key] and (existingData.performance[v.key] == perNum) then
						continue
					end
					totalCost = totalCost + data.price
				end
			end
			if newPurchase then
				buyButton.disText = "Purchase - "..DarkRP.formatMoney(totalCost)
			elseif not (totalCost == 0) then
				buyButton.disText = "Tune - "..DarkRP.formatMoney(totalCost)
				buyButton.tune = true
			else
				buyButton.disText = "Spawn"
				buyButton.tune = false
			end
		end
		
		if (not newPurchase) and data.sellable then
			local sellButton = XYZUI.ButtonInput(customsShell, "Sell ("..DarkRP.formatMoney(data.price * CarDealer.Config.SellBack)..")", function()
				XYZUI.Confirm("Sell", Color(200, 0, 0), function()
					net.Start("CarDealer:Sell")
						net.WriteEntity(npc)
						net.WriteUInt(existingData.id, 32)
					net.SendToServer()

					frame:Close()
				end)
			end)
			sellButton:Dock(BOTTOM)
			sellButton:DockMargin(5, 0, 5, 5)
			sellButton.headerColor = Color(200, 0, 0)
		end
	end


	local _, vehicleCats = XYZUI.Lists(frame, 1)

	vehicleCats:Dock(LEFT)
	vehicleCats:SetSize(frame:GetWide()*0.2)




	local camControls = XYZUI.Container(frame)
	camControls:Dock(BOTTOM)
	camControls:SetTall(60)
	camControls.Paint = nil

	-- Left
	local camLeft = XYZUI.ButtonInput(camControls, "←", function()
		CarDealer.UI.CamData.y = CarDealer.UI.CamData.y - 10 
	end)
	camLeft:Dock(LEFT)
	camLeft:DockMargin(5, 5, 5, 5)

	local camRight = XYZUI.ButtonInput(camControls, "→", function()
		CarDealer.UI.CamData.y = CarDealer.UI.CamData.y + 10 
	end)
	camRight:Dock(LEFT)
	camRight:DockMargin(5, 5, 5, 5)

	local camUp = XYZUI.ButtonInput(camControls, "↑", function()
		CarDealer.UI.CamData.x = math.Clamp(CarDealer.UI.CamData.x - 10, 140, 180)
		
	end)
	camUp:Dock(LEFT)
	camUp:DockMargin(5, 5, 5, 5)

	local camDown = XYZUI.ButtonInput(camControls, "↓", function()
		CarDealer.UI.CamData.x = math.Clamp(CarDealer.UI.CamData.x + 10, 140, 180)
	end)
	camDown:Dock(LEFT)
	camDown:DockMargin(5, 5, 5, 5)

	local camZoomIn = XYZUI.ButtonInput(camControls, "+", function()
		CarDealer.UI.CamData.zoom = math.Clamp(CarDealer.UI.CamData.zoom - 10, 10, 300)
	end)
	camZoomIn:Dock(LEFT)
	camZoomIn:DockMargin(5, 5, 5, 5)

	local camZoomOut = XYZUI.ButtonInput(camControls, "-", function()
		CarDealer.UI.CamData.zoom = math.Clamp(CarDealer.UI.CamData.zoom + 10, 10, 300)
	end)
	camZoomOut:Dock(LEFT)
	camZoomOut:DockMargin(5, 5, 5, 5)


	-- Close
	local controlsClose = XYZUI.ButtonInput(camControls, "Close", function()
		frame:Close()
	end)
	controlsClose:Dock(RIGHT)
	controlsClose:DockMargin(5, 5, 5, 5)
	-- Garage
	local controlsGarage = XYZUI.ButtonInput(camControls, "Garage", function()
		vehicleCats:Clear()

		for k, v in pairs(CarDealer.Vehicles) do
			local vehicleData = CarDealer.Config.Cars[v.class]
			if not vehicleData then print("Tried to load vehicle that does not exist", v.class) continue end
			local card = XYZUI.Container(vehicleCats)
			card:Dock(TOP)
			card:SetTall(80)

			local cardOldPaint = card.Paint
			card.Paint = function(self, w, h)
				cardOldPaint(self, w, h)
				if not IsValid(self.model) then
					self.model = vgui.Create("DModelPanel", card)
					self.model:SetSize(h, h)
					self.model:Dock(LEFT)
					self.model:SetModel(vehicleData.model)
					--function b.model:LayoutEntity( Entity ) return end
				
					-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
					local mn, mx = self.model.Entity:GetRenderBounds()
					local size = 0
					size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
					size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
					size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
					self.model:SetFOV(40)
					self.model:SetCamPos( Vector( size+4, size+4, size+4 ) )
					self.model:SetLookAt( ( mn + mx ) * 0.5 )
					-- *|*

					-- Apply bodygroups
					for n, m in pairs(v.bodygroups) do
						self.model.Entity:SetBodygroup(n, m)
					end
					-- Apply skin
					self.model.Entity:SetSkin(v.skin)
					-- Apply color
					self.model:SetColor(v.color) 
				end
			end

			local text = XYZUI.PanelText(card, vehicleData.name, 30, TEXT_ALIGN_LEFT)
			text:Dock(FILL)

			local shadowButton = vgui.Create("DButton", card)
			shadowButton.Paint = nil
			shadowButton:SetText("")
			function card:PerformLayout(w, h)
				shadowButton:SetSize(w, h)
				shadowButton:SetPos(0, 0)

				shadowButton.DoClick = function()
					CarDealer.UI.CreateViewVehicle(vehicleData.model, v)

					populateCustoms(vehicleData, v)
				end
			end
		end
	end)
	controlsGarage:Dock(RIGHT)
	controlsGarage:DockMargin(5, 5, 5, 5)
	controlsGarage:SetWide(80)
	-- Dealership
	local controlsDealership = XYZUI.ButtonInput(camControls, "Dealership", function()
		vehicleCats:Clear()

		local cats = {}
		for k, v in pairs(CarDealer.Config.Cars) do
			if not cats[v.category] then
				cats[v.category] = {}
			end

			table.insert(cats[v.category], v)
		end

		for k, v in pairs(cats) do
			local body, head, main = XYZUI.ExpandableCard(vehicleCats, k)
			main:DockMargin(0, 0, 0, 5)

			for n, m in ipairs(v) do
				if not m.sellable then continue end
				if not m.restricted(LocalPlayer()) then continue end

				local card = XYZUI.Container(body)
				card:Dock(TOP)
				card:SetTall(80)

				local cardOldPaint = card.Paint
				card.Paint = function(self, w, h)
					cardOldPaint(self, w, h)
					if not IsValid(self.model) then
						self.model = vgui.Create("DModelPanel", card)
						self.model:SetSize(h, h)
						self.model:Dock(LEFT)
						self.model:SetModel(m.model)
						--function b.model:LayoutEntity( Entity ) return end
					
						-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
						local mn, mx = self.model.Entity:GetRenderBounds()
						local size = 0
						size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
						size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
						size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
						self.model:SetFOV(40)
						self.model:SetCamPos( Vector( size+4, size+4, size+4 ) )
						self.model:SetLookAt( ( mn + mx ) * 0.5 )
						-- *|*
					end
				end

				local text = XYZUI.Title(card, m.name, DarkRP.formatMoney(CarDealer.Config.Price.Vehicle(LocalPlayer(), m.price) or 0), 35, 30)
				text:Dock(FILL)

				local shadowButton = vgui.Create("DButton", card)
				shadowButton.Paint = nil
				shadowButton:SetText("")
				function card:PerformLayout(w, h)
					shadowButton:SetSize(w, h)
					shadowButton:SetPos(0, 0)

					shadowButton.DoClick = function()
						CarDealer.UI.CreateViewVehicle(m.model)

						populateCustoms(m, {}, true)
					end
				end

				XYZUI.AddToExpandableCardBody(main, card)
			end

			if table.Count(body:GetChildren()) == 0 then
				main:Remove()
			end
		end
	end)
	controlsDealership:Dock(RIGHT)
	controlsDealership:SetWide(100)
	controlsDealership:DockMargin(5, 5, 5, 5)
end

net.Receive("CarDealer:UI", function()
	CarDealer.UI.Open(net.ReadEntity())
end)

net.Receive("CarDealer:UI:Return", function()
	XYZUI.Confirm("Return Vehicle", CarDealer.Config.Color, function()
		net.Start("CarDealer:Return")
		net.SendToServer()
	end)
end)

local lerpData = {
}
hook.Add("CalcView", "CarDealer:CamView", function(ply, origin, angles, fov, znear, zfar)
	if not IsValid(CarDealer.UI.Menu) then return end
	if not CarDealer.UI.CamData then return end	

	local x, y, scale = CarDealer.UI.CamData.x, CarDealer.UI.CamData.y
	x = x * -0.5
	y = y * 0.5
	local ang = angle_zero + Angle(x*4, y*4, 0)
	local pos = CarDealer.UI.CamData.orbitPoint - ang:Forward() * CarDealer.UI.CamData.zoom

	if not lerpData.curPos then
		lerpData.curPos = pos
		lerpData.targetPos = pos
	elseif not lerpData.targetPos:IsEqualTol(pos, 1) then
		lerpData.targetPos = pos
	end
	if not lerpData.curAng then
		lerpData.curAng = ang
		lerpData.targetAng = ang
	elseif not (lerpData.targetAng == ang) then
		lerpData.targetAng = ang
	end


	lerpData.curPos = LerpVector(FrameTime(), lerpData.curPos, lerpData.targetPos)
	lerpData.curAng = LerpAngle(FrameTime(), lerpData.curAng, lerpData.targetAng)

    local view = {}
    view.origin = lerpData.curPos
    view.angles = lerpData.curAng
    view.fov = fov
    
    return view
end)


function CarDealer.UI.CreateViewVehicle(model, data)
	if IsValid(CarDealer.UI.Vehicle) then
		CarDealer.UI.Vehicle:Remove()
	end

	CarDealer.UI.Vehicle = ClientsideModel(model)
	CarDealer.UI.Vehicle:SetPos(CarDealer.Config.VehPos)
	CarDealer.UI.Vehicle:SetAngles(CarDealer.Config.VehAng)

	if data then
		-- Apply bodygroups
		for n, m in pairs(data.bodygroups) do
			CarDealer.UI.Vehicle:SetBodygroup(n, m)
		end
		-- Apply skin
		CarDealer.UI.Vehicle:SetSkin(data.skin)
		-- Apply color
		CarDealer.UI.Vehicle:SetColor(data.color) 
	end

	return CarDealer.UI.Vehicle
end

net.Receive("CarDealer:UI:Repair", function()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame("Repair Vehicle", CarDealer.Config.Color)
	frame:SetSize(ScrW()*0.3, ScrH()*0.17)
	frame:Center()

	XYZUI.Title(frame, "Fully Repair Your Vehicle?", "This will cost "..DarkRP.formatMoney(CarDealer.Config.RepairCost(LocalPlayer())).."!", 40, 30, TEXT_ALIGN_CENTER)

	local confirm = XYZUI.ButtonInput(frame, "Do it!", function()
		net.Start("CarDealer:Vehicle:Repair")
			net.WriteEntity(npc)
		net.SendToServer()

		frame:Close()
	end)
	confirm:Dock(BOTTOM)
end)