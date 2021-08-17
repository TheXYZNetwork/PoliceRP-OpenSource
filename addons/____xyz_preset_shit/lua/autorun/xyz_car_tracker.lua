XYZShit = XYZShit or {}

if SERVER then
	util.AddNetworkString("XYZShit:ApplyTracker")

	function XYZShit.ApplyTracker(car, ply)
		net.Start("XYZShit:ApplyTracker")
			net.WriteEntity(car)
		net.Send(ply)
	end
elseif CLIENT then
	net.Receive("XYZShit:ApplyTracker", function()
		local car = net.ReadEntity()
		if not IsValid(car) then return end
	
		Minimap.AddWaypoint("mycar", "minimap_mycar", "My Car", color_white, 1.5, car:GetPos())
	
		hook.Add("MinimapThink", "CarDealer:MyCar", function()
			if not IsValid(car) then
				Minimap.RemoveWaypoint("mycar")
				hook.Remove("MinimapThink", "CarDealer:MyCar")
				return
			end
	
			Minimap.AddWaypoint("mycar", "minimap_mycar", "My Car", color_white, 1.5, car:GetPos())
		end)
	end)
end