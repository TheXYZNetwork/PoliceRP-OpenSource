function Alcohol.ChangeUnits(ply, amount)
	if not Alcohol.Units[ply:SteamID64()] then
		Alcohol.ResetUnits(ply, true)
	end

	Alcohol.Units[ply:SteamID64()] = Alcohol.Units[ply:SteamID64()] + amount

	net.Start("Alcohol:Units:Change")
		net.WriteUInt(Alcohol.Units[ply:SteamID64()], 7)
	net.Send(ply)

	hook.Run("Alcohol:ChangeUnits", ply, amount, Alcohol.Units[ply:SteamID64()])
end

function Alcohol.ResetUnits(ply, surpress)
	Alcohol.Units[ply:SteamID64()] = 0

	if not surpress then
		net.Start("Alcohol:Units:Change")
			net.WriteUInt(0, 7)
		net.Send(ply)
	end
end

hook.Add("Initialize", "Alcohol:StartTimer", function()
	timer.Create("Alcohol:TickUnits", Alcohol.Config.ReduceTimer, 0, function()
		for k, v in ipairs(player.GetAll()) do
			local amount = Alcohol.Units[v:SteamID64()]
			if not amount then continue end
			if amount <= 0 then continue end
	
			Alcohol.ChangeUnits(v, -Alcohol.Config.ReduceAmount)
		end
	end)
end)

hook.Add("PlayerDeath", "Alcohol:Reset", function(ply)
	Alcohol.ResetUnits(ply)
end)

-- Kill the player if they drink too much
hook.Add("Alcohol:ChangeUnits", "Alcohol:Death", function(ply, amount, total)
	if total < Alcohol.Config.Death then return end

	ply:Kill()
end)