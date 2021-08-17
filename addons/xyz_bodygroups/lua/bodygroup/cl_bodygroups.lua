function XYZBodyGroups:SavePreset(jobCommand, skin, groups)
	if not sql.TableExists("xyz_bodygroups") then
		sql.Query("CREATE TABLE xyz_bodygroups(model TEXT PRIMARY KEY, skin INT, groups TEXT)")
	end


	sql.Query(string.format("INSERT OR REPLACE INTO xyz_bodygroups (model, skin, groups) VALUES ('%s', %i, '%s');", jobCommand, skin, util.TableToJSON(groups)))
end

function XYZBodyGroups:GetPreset(jobCommand)
	local preset = sql.Query(string.format("SELECT * FROM xyz_bodygroups WHERE model='%s';", jobCommand))

	return preset
end

function XYZBodyGroups:OpenMenu()
	local frame = XYZUI.Frame("Bodygroup Editor", Color(180, 164, 0)) 
	frame:SetSize(ScrH()*0.8, ScrH()*0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local _, contList = XYZUI.Lists(frame, 1)
	contList:DockMargin(0, 0, 10, 0)
	contList:Dock(LEFT)
	contList:SetWide(frame:GetWide()/3)

	-- Preview Model
	local previewPanel = vgui.Create("DAdjustableModelPanel", shell)
	previewPanel:Dock(FILL)
	previewPanel.isRotating = true
	previewPanel.rotateState = previewPanel.LayoutEntity
	previewPanel:SetModel(LocalPlayer():GetModel())

	previewPanel:SetFirstPerson(false)
	previewPanel:SetCamPos(Vector(0, -114, 38))
	previewPanel:SetLookAng(Angle(2, 90, 0))
	previewPanel:SetFOV(30)


	previewPanel.Entity:SetSkin(LocalPlayer():GetSkin())
	previewPanel.Entity:SetAngles(Angle(0, -90, 0))

	local curgroups = LocalPlayer():GetBodyGroups()
	for k,v in pairs( curgroups ) do
		local ent = previewPanel.Entity
		local cur_bgid = LocalPlayer():GetBodygroup(v.id)
		ent:SetBodygroup(v.id, cur_bgid)
	end

	function previewPanel.Entity:GetPlayerColor()
		return LocalPlayer():GetPlayerColor()
	end	

	if LocalPlayer():SkinCount() > 1 then
		local card = XYZUI.Card(contList, 75)
		card:Dock(TOP)
		card:DockMargin(0, 0, 0, 4)
		local title = XYZUI.Title(card, "Skin:", "", 30, 18)
		title:SetTall(30)

		local dropdown = XYZUI.DropDownList(card, "Choose setting", function(name, value)
			previewPanel.Entity:SetSkin(name)
		end)
		dropdown:DockMargin(5, 5, 5, 5)
		dropdown:SetTall(31)
		for i=1, LocalPlayer():SkinCount() do
			XYZUI.AddDropDownOption(dropdown, i-1)
		end
	end

	for k, v in pairs(LocalPlayer():GetBodyGroups()) do
		if v.id == 0 then continue end
		if table.Count(v.submodels) <= 1 then continue end

		local card = XYZUI.Card(contList, 75)
		card:Dock(TOP)
		card:DockMargin(0, 0, 0, 4)
		local title = XYZUI.Title(card, v.name..":", "", 30, 18)
		title:SetTall(30)

		local dropdown = XYZUI.DropDownList(card, "Choose setting", function(name, value)
			previewPanel.Entity:SetBodygroup(v.id, value)
		end)
		dropdown:DockMargin(5, 5, 5, 5)
		dropdown:SetTall(31)
		for k, v in pairs(v.submodels) do
			XYZUI.AddDropDownOption(dropdown, string.upper(string.Replace(v, "_", " "):sub(1, -5)), k)
		end
	end


    local btn = XYZUI.ButtonInput(contList, "Apply Changes", function(self)
		local bodygroups = previewPanel.Entity:GetBodyGroups()
		local groups = {}

		for _, v in pairs( bodygroups ) do
			if v.id == 0 then continue end
			--if XYZBodyGroups.Config.BlockedModels[previewPanel.Entity:GetModel()][v.id] then continue end
			groups[v.id] = previewPanel.Entity:GetBodygroup( v.id )
		end

		net.Start("XYZBodyGroups_ApplyGroups")
			net.WriteInt(previewPanel.Entity:GetSkin(),16)
			net.WriteTable(groups)
		net.SendToServer()

		local jobData = RPExtraTeams[LocalPlayer():Team()]
		local model
		if jobData.model[2] == "o" then
			model = jobData.model
		else
			model = jobData.model[1]
		end

		XYZBodyGroups:SavePreset(model, previewPanel.Entity:GetSkin(), groups)

		frame:Close()
    end)

    local rotateBtn = XYZUI.ButtonInput(contList, "Toggle Rotate", function(self)
    	previewPanel.isRotating = not previewPanel.isRotating

    	if previewPanel.isRotating then 
    		previewPanel.LayoutEntity = previewPanel.rotateState
    	else
    		previewPanel.LayoutEntity = function() end
    	end
    end)
    rotateBtn:DockMargin(0, 5, 0, 0)
    rotateBtn.headerColor = Color(200, 69, 0)
end

net.Receive("XYZBodyGroups_OpenMenu", function()
	XYZBodyGroups:OpenMenu()
end)


hook.Add("OnPlayerChangedTeam", "XYZBodyGroups_SendPreset", function(ply, old, new)
	local jobData = RPExtraTeams[new]
	local model
	if jobData.model[2] == "o" then
		model = jobData.model
	else
		model = jobData.model[1]
	end

	local data = XYZBodyGroups:GetPreset(model)
	if (not data) or (not data[1]) then return end

	net.Start("XYZBodyGroups_SendPreset")
		net.WriteString(model)
		net.WriteInt(data[1].skin, 16)
		net.WriteTable(util.JSONToTable(data[1].groups))
	net.SendToServer()
end)