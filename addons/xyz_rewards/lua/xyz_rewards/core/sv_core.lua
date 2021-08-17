hook.Add("PlayerInitialSpawn", "Rewards:InitialSpawn", function(ply)
	Rewards.Players[ply:SteamID64()] = {}

	Rewards.Database.LoadPlayer(ply)
end)

hook.Add("PlayerSay", "Rewards:ChatCommand", function(ply, text)
	if not Rewards.Config.Commands[string.lower(text)] then return end

	net.Start("Rewards:UI")
		net.WriteTable(Rewards.Players[ply:SteamID64()])
	net.Send(ply)
end)


net.Receive("Rewards:Claim", function(_, ply)
    if XYZShit.CoolDown.Check("Rewards:Claim", 1, ply) then return end

    local task = net.ReadString()
    local data = Rewards.Players[ply:SteamID64()][task]

    if not data then return end

    Rewards.Config.Rewards[task].method(ply, data.progress, data.updated, function(passed)
    	if not passed then
    		net.Start("Rewards:Failed")
    			net.WriteString(task)
    		net.Send(ply)
    		return
    	end

    	Rewards.Config.Rewards[task].reward(ply, data.progress, data.updated)
        xLogs.Log(xLogs.Core.Player(ply).." claimed reward for "..Rewards.Config.Rewards[task].name..".", "Rewards")
    end)
end)