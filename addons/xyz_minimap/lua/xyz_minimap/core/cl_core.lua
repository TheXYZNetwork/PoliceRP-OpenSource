--[[
Rockford Map Specs:
	Dimensions:
	Width = 30536
	Height = 30542

	Pos:
	Top Left 	 = -15192 15326
	Bottom Right = 15344 -15216
	
Florida Map Specs:
	Dimensions:
	Width		= 30077
	Height		= 28918

	Pos:
	Top Left = -14720 15349 
	Bottom Right = 15357 -13569
	
Riverdean Map Specs:
	Dimensions:
	Width		= 31238
	Height		= 31050

	Pos:
	Top Left = -15632 15358
	Bottom Right = 15606 -15692
	
Rockford Karnaka Map Specs:
	Dimensions:
	Width		= 23063
	Height		= 30694

	Pos:
	Top Left = -10800 15470
	Bottom Right = 12263 -15224

]]--		

Minimap.Waypoints = Minimap.Waypoints or {}

Minimap.Dimensions = {}
Minimap.Dimensions.TopLeft = {-15192, 15326}
Minimap.Dimensions.BottomRight = {15344, -15216}

function Minimap.AddWaypoint(id, image, name, color, scale, pos, ang)
	-- Build position
	pos = isvector(pos) and pos or Vector(0, 0, 0)

	local newPos = {x = 0, y = 0}

	newPos.x = ((pos.x + -Minimap.Dimensions.TopLeft[1])/(-Minimap.Dimensions.TopLeft[1] + Minimap.Dimensions.BottomRight[1]))
	newPos.y = ((pos.y + -Minimap.Dimensions.TopLeft[2])/-(Minimap.Dimensions.TopLeft[2] + -Minimap.Dimensions.BottomRight[2]))

	-- Build rotation
	local newAng = isangle(ang) and ang[2] or 0

	Minimap.Waypoints[id] = {
		image = image,
		name = name,
		color = color,
		scale = scale or 1,
		pos = newPos,
		ang = newAng
	}
end

function Minimap.RemoveWaypoint(id)
	Minimap.Waypoints[id] = nil
end
function Minimap.RemoveWaypointsWithTag(tag)
	for k, v in pairs(Minimap.Waypoints) do
		if string.find(k, tag, nil, true) then
			Minimap.Waypoints[k] = nil
		end
	end
end


-- Stuff to open menu
hook.Add("PlayerButtonDown", "Minimap:Toggle", function(ply, button)
	if not (ply == LocalPlayer()) then return end
	if not XYZSettings.GetSetting("minimap_show_overlay", true) then return end
	if not (button == KEY_M) then return end
	if XYZShit.CoolDown.Check("Minimap:Toggle", 1) then return end

	if IsValid(Minimap.Menu) then
		Minimap.Menu:Close()
	else
		Minimap.BuildMinimap()
	end
end)

concommand.Add("minimap_toggle", function()
	if IsValid(Minimap.Menu) then
		Minimap.Menu:Close()
	else
		Minimap.BuildMinimap()
	end
end)