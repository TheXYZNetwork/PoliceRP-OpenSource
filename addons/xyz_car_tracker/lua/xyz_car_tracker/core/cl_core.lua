local markerMap = {}
net.Receive("CarTracker:AddTracking", function()
	local criminal = net.ReadEntity()
	local vehicle = net.ReadEntity()

	if not IsValid(vehicle) then return end

	CarTracker.Tracking[criminal] = vehicle

	markerMap[vehicle] = ply:SteamID64()

	hook.Add("MinimapThink", "CarTracker:Minimap", function()
		for ply, car in pairs(CarTracker.Tracking) do
			if not IsValid(car) then
				if IsValid(ply) then
					Minimap.RemoveWaypoint("car_tracker_"..ply:SteamID64())
				elseif IsValid(car) then
					Minimap.RemoveWaypoint("car_tracker_"..markerMap[car])
				else
					-- The absolute fallback if all else fails
					Minimap.RemoveWaypointsWithTag("car_tracker")
				end

				CarTracker.Tracking[ply] = nil
				
				continue
			end
		
			Minimap.AddWaypoint("car_tracker_"..ply:SteamID64(), "minimap_mycar", ply:Name().."'s Car", color_white, 1.5, car:GetPos())
		end
	end)
end)

net.Receive("CarTracker:RemoveTracking", function()
	local criminal = net.ReadEntity()

	CarTracker.Tracking[criminal] = nil

	if table.IsEmpty(CarTracker.Tracking) then
		hook.Remove("MinimapThink", "CarTracker:Minimap")
	end
end)

net.Receive("CarTracker:Wipe", function()
	CarTracker.Tracking = {}

	Minimap.RemoveWaypointsWithTag("car_tracker")

	hook.Remove("MinimapThink", "CarTracker:Minimap")
end)
