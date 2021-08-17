if SERVER then
	local cartCache = {}
	PrisonSystem.RegisterJob("maintenance", function(ply)
		ply:Give("xyz_prison_wrench")
	end,
	function(ply)
		ply:StripWeapon("xyz_prison_wrench")
	end)
end