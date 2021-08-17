concommand.Add("xyz_properties_door_config", function()
	local ent = LocalPlayer():GetEyeTrace().Entity
	print(string.format("Vector(%G, %G, %G)", ent:GetPos().x, ent:GetPos().y, ent:GetPos().z))
end)

net.Receive("Property:Icon", function()
	local state = net.ReadBool()
	local houseID = net.ReadUInt(32)

	if state then
		-- This cancer maths go get the centre point of all the doors:
		local centre = Vector(0, 0, 0)
		local doorData = Property.Config.Properties[houseID]

		for k, v in pairs(doorData.doors) do
			centre.x = centre.x + v.x
			centre.y = centre.y + v.y
		end
		local totalPoints = #doorData.doors
		centre.x = centre.x / totalPoints
		centre.y = centre.y / totalPoints

		Minimap.AddWaypoint("home", "minimap_house", "Home", color_white, 1.3, centre)
	else
		Minimap.RemoveWaypoint("home")
	end
end)

local scrW, scrH = ScrW(), ScrH()
local green = Color(0, 200, 0)
local blue = Color(0, 100, 200)
hook.Add("HUDDrawDoorData", "Property:Overlay", function(door)
	--if true then return end
	if door:IsVehicle() then return end

	local doorData = Property.Core.FindProperty(door)

	if doorData then
		XYZUI.DrawTextOutlined(doorData.name, 60, scrW*0.5, scrH*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
		
		if door:isKeysOwned() then
			local owner = door:getDoorOwner()
			XYZUI.DrawTextOutlined(owner:Nick(), 30, scrW*0.5, scrH*0.5 + 50, team.GetColor(owner:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
			local count = 0
			for k, v in pairs(door:getKeysCoOwners() or {}) do
				local owner = Player(k)
				if not IsValid(owner) then continue end
				count = count + 1

				XYZUI.DrawTextOutlined(owner:Nick(), 25, scrW*0.5, scrH*0.5 + 55 + (15 * count), team.GetColor(owner:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
			end
			if door:isKeysAllowedToOwn(LocalPlayer()) then
				XYZUI.DrawTextOutlined("Co-ownable", 25, scrW*0.5, scrH*0.5 + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1)
			end
		else
			XYZUI.DrawTextOutlined(DarkRP.formatMoney(doorData.price), 40, scrW*0.5, scrH*0.5 + 45, green, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
		end
	else
		local otherOwnerships = {}
		local doorGroups = door:getKeysDoorGroup()
		if doorGroups then
			table.insert(otherOwnerships, doorGroups)
		end
		local doorTeams = door:getKeysDoorTeams()
		if doorTeams then
			for k, v in pairs(doorTeams) do
				if (not v) or (not RPExtraTeams[k]) then continue end

				table.insert(otherOwnerships, RPExtraTeams[k].name)
			end
		end
		for k, v in pairs(otherOwnerships) do
			XYZUI.DrawTextOutlined(v, 40, scrW*0.5, scrH*0.5 + (28 * k), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
		end
	end

	return true
end)