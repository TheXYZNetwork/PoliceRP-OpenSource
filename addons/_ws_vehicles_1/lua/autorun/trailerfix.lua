hook.Add("PlayerSpawnedVehicle", "TDMTrailerReleaseBreakOnSpawn", function( ply, vehicle )
    if not vehicle:GetModel( ) == "models/tdmcars/trailers/*" then return end

	vehicle:Fire("HandbrakeOff", "", 0)
end)