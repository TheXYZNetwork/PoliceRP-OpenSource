net.Receive("JobCarDealer:Derma", function()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame(npc.PrintName, Color(40, 40, 40))
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell.Paint = function() end

	local _, contList = XYZUI.Lists(shell, 1)
	contList:DockPadding(5, 5, 5, 5)

	local displayShell
	local count = 0
	for k, v in pairs(npc.Config.Vehicles) do
		local car = list.Get("Vehicles")[v.class]
		if not car then continue end

		if not v.canAccess(LocalPlayer()) then continue end

		count = count + 1

		local card = XYZUI.Card(contList, 80)
		card:DockMargin(0, 0, 0, 5)

		local carModel = vgui.Create("DModelPanel", card)
		carModel:SetSize(card:GetTall(), card:GetTall())
		carModel:Dock(LEFT)
		carModel:SetModel(car.Model)
		carModel:DockMargin(0, 0, 2, 0)

			-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
			local mn, mx = carModel.Entity:GetRenderBounds()
			local size = 0
			size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
			size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
			size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
			carModel:SetFOV(40)
			carModel:SetCamPos( Vector( size+4, size+4, size+4 ) )
			carModel:SetLookAt( ( mn + mx ) * 0.5 )
			-- *|*

		if v.postSpawn then
			v.postSpawn(carModel.Entity)
		end

		local carTitle = XYZUI.PanelText(card, car.Name, 35, TEXT_ALIGN_LEFT)
		carTitle:Dock(FILL)


		if v.editable then -- No no bodygroup editing for you!
			local selectCar = XYZUI.ButtonInput(card, "Select", function()
				frame:SetSize(ScrH(), ScrH()*0.8)
				frame:Center()

				contList:Dock(LEFT)
			
				if IsValid(displayShell) then
					displayShell:Remove()
				end

				displayShell = XYZUI.Container(shell)
				displayShell:DockMargin(5, 0, 0, 0)

				local header = XYZUI.PanelText(displayShell, car.Name, 40, TEXT_ALIGN_CENTER)

				local model = vgui.Create("DAdjustableModelPanel", displayShell)
				model:SetSize(displayShell:GetWide(), shell:GetTall()*0.3)
				model:Dock(TOP)
				model:SetFirstPerson(false)
				model:SetCamPos( Vector(-150, 0, 40))
				model:SetFOV(90)
				model:SetModel(car.Model)
				model:DockMargin(0, 0, 2, 0)
				function model:LayoutEntity( Entity ) return end

				if v.postSpawn then
					v.postSpawn(model.Entity)
				end

				local _, bodygroupList = XYZUI.Lists(displayShell, 1)
				bodygroupList:Dock(FILL)
				bodygroupList.Paint = nil
				bodygroupList:DockMargin(5, 0, 5, 5)


				-- Load the preset from the last spawn
				local carPreset = JobCarDealer.Core.GetCustoms(v.class)
				if carPreset then
					for k, v in pairs(carPreset) do
						model.Entity:SetBodygroup(k, v)
					end
				end

				for k, v in ipairs(model.Entity:GetBodyGroups()) do
					if v.num <= 1 then continue end
					local itemHeader = XYZUI.PanelText(bodygroupList, string.upper(v.name), 20, TEXT_ALIGN_LEFT)

					local bodygroupDrop = XYZUI.DropDownList(bodygroupList, string.upper(v.name), function(name, value)
						model.Entity:SetBodygroup(v.id, name)
					end)
					bodygroupDrop:DockMargin(0, 0, 0, 5)
					for n, m in pairs(v.submodels) do
						XYZUI.AddDropDownOption(bodygroupDrop, n)
					end

				end

				local spawnCar = XYZUI.ButtonInput(displayShell, "Spawn", function()
					local bodygroups = {}
					for k, v in ipairs(model.Entity:GetBodyGroups()) do
						if v.num <= 1 then continue end
						bodygroups[v.id] = model.Entity:GetBodygroup(v.id)
					end
					net.Start("JobCarDealer:SpawnVehicle:Custom")
						net.WriteEntity(npc)
						net.WriteInt(k, 32)
						net.WriteTable(bodygroups)
					net.SendToServer()
		
					-- Log the car for auto presets
					JobCarDealer.Core.SetCustoms(v.class, bodygroups)

					frame:Close()
				end)
				spawnCar:Dock(BOTTOM)
				--spawnCar:DockMargin(10, 10, 10, 10)
			end)
			selectCar:Dock(RIGHT)
			selectCar:SetWide(frame:GetWide()/5)
			selectCar:DockMargin(10, 10, 10, 10)
		else
			local spawnCar = XYZUI.ButtonInput(card, "Spawn", function()
				net.Start("JobCarDealer:SpawnVehicle")
					net.WriteEntity(npc)
					net.WriteInt(k, 32)
				net.SendToServer()
	
				frame:Close()
			end)
			spawnCar:Dock(RIGHT)
			spawnCar:SetWide(frame:GetWide()/5)
			spawnCar:DockMargin(10, 10, 10, 10)
		end
	end

	if count <= 0 then
		frame:Remove()
	end
end)
