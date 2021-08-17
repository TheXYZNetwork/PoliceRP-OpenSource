function PrisonSystem.IsArrested(ply)
	if not IsValid(ply) then return end
	
	local data = PrisonSystem.Arrested[ply:SteamID64()]
	if data then
		return true, (data.start + data.length) - os.time()
	end

	return false
end