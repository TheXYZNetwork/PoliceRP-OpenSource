-- The color to be used around the addon
Minimap.Config.Color = Color(0, 148, 200)
-- The max value that the sign image counter can go to (There are currently only 5 images to choose from, so we set it to 5)
Minimap.Config.SignImageCounter = 5

if SERVER then return end
-- The player waypoint, inside the hook so it only updates when the menu is open
Minimap.AddWaypoint("localplayer", "minimap_localplayer", "Me", color_white, 1, Vector(0, 0, 0), Angle(0, 0, 0)) -- Gotta start it 
hook.Add("MinimapThink", "MainPlayer", function()
	Minimap.AddWaypoint("localplayer", "minimap_localplayer", "Me", color_white, 1, LocalPlayer():GetPos(), LocalPlayer():GetAngles())
end)

Minimap.AddWaypoint("spawn", "minimap_spawn", "Spawn", color_white, 1.8, Vector(-4628, -5238, 0))
Minimap.AddWaypoint("pd", "minimap_pd", "PD", color_white, 1.8	, Vector(-7969, -5203, 0))
Minimap.AddWaypoint("subdep", "minimap_pd", "Sub Dep HQ", color_white, 1.8	, Vector(-5525, -3224, 0))
Minimap.AddWaypoint("hospital", "minimap_ems", "Hospital", color_white, 1.6	, Vector(0, -5824, 0))
Minimap.AddWaypoint("cardealer", "minimap_cardealer", "Car Dealer", color_white, 1.8, Vector(-4533, -730, 0))
Minimap.AddWaypoint("bank", "minimap_bank", "Bank", color_white, 1.8, Vector(-3602, -3697, 0))
Minimap.AddWaypoint("towtruck", "minimap_towtruck", "Tow Truck", color_white, 1.5, Vector(-7375, -6, 0))
Minimap.AddWaypoint("mine", "minimap_pickaxe", "Mine", color_white, 1.6, Vector(13334, -3053, 0))
Minimap.AddWaypoint("shell1", "minimap_shell", "Shell", color_white, 1.6, Vector(-14485, 2656, 0))
Minimap.AddWaypoint("shell2", "minimap_shell", "Shell", color_white, 1.6, Vector(765, 3929, 0))
Minimap.AddWaypoint("rockford_food", "minimap_rockford_food", "Rockford Foods", color_white, 1.6, Vector(1100, 6060, 0))
Minimap.AddWaypoint("rta", "minimap_rta", "RTA", color_white, 1.9, Vector(-1507, 4118, 0))
Minimap.AddWaypoint("tacobell", "minimap_tacobell", "Taco Bell", color_white, 1.6, Vector(500, 1955, 0))
Minimap.AddWaypoint("casino", "minimap_casino", "Casino", color_white, 1.6, Vector(1862, 2365, 0))


-- Signs
hook.Add("MinimapThink", "UserSigns", function()
	for k, v in pairs(Minimap.Signs) do
		Minimap.AddWaypoint("sign"..v:EntIndex(), "minimap_sign"..v:GetDisplayImage(), v:GetDisplayName(), color_white, 1.5, v:GetPos())
	end
end)