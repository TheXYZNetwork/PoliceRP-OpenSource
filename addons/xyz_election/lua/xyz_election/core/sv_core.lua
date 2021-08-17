local pendingVice
net.Receive("Election:JoinElection", function(_, ply)
    if XYZShit.CoolDown.Check("Election:JoinElection", 3, ply) then
    	return
    end

    if CurTime() <= Election.Core.NextElection then
    	XYZShit.Msg("Election", Election.Config.Color, "An election has recently happened. Wait a while before a new one starts.", ply)
    	return
    end

--    local curPres = false
--    for k, v in ipairs(player.GetAll()) do
--    	if v:Team() == TEAM_PRESIDENT then
--    		curPres = true
--    		break
--    	end
--    end
--    if curPres then
--    	XYZShit.Msg("Election", Election.Config.Color, "There is currently a president!", ply)
--    	return
--    end

	local npc = net.ReadEntity()

    if not (npc:GetClass() == "xyz_election") then return end
    if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

    if Election.Core.Entered[ply] then
		XYZShit.Msg("Election", Election.Config.Color, "Seems you're already opt in to the election? We've went ahead and removed you, you can opt back in at any time!", ply)
  
		Election.Core.Entered[ply] = nil
		if table.IsEmpty(Election.Core.Entered) then
			timer.Remove("Election:Vote")
		end
    	return
    end

	if table.IsEmpty(Election.Core.Entered) and not XYZShit.CoolDown.Check("Election:BroadcastStart", 30) then
		XYZShit.Msg("Election", Election.Config.Color, "An election will start soon, head to the election NPC to opt yourself in!")
	end

	if not XYZShit.CoolDown.Check("Election:BroadcastStart", 30, ply) then
		XYZShit.Msg("Election", Election.Config.Color, ply:Name().." has entered the running!")
	else
		XYZShit.Msg("Election", Election.Config.Color, "You have entered the running!", ply)
	end
	
	Election.Core.Entered[ply] = true

	Quest.Core.ProgressQuest(ply, "rigged_elections", 1)

    local curPres = false
    for k, v in ipairs(player.GetAll()) do
    	if v:Team() == TEAM_PRESIDENT then
    		curPres = v
    		break
    	end
    end
    if curPres and not Election.Core.Entered[curPres] then
    	Election.Core.Entered[curPres] = true
    	XYZShit.Msg("Election", Election.Config.Color, "Another election has started, you've been auto opt into the election.", curPres)
    end
	

	if not timer.Exists("Election:Vote") then
		timer.Create("Election:Vote", Election.Config.ElectionStart, 1, function()
			print("Election:Vote")
			pendingVice = nil
			if table.IsEmpty(Election.Core.Entered) then
				Election.Core.HasVoted = {}
				Election.Core.IsVoting = false
				Election.Core.Entered = {}
				return
			end

			-- Only 1 person in the vote
			if table.Count(Election.Core.Entered) == 1 then
				for k, v in pairs(Election.Core.Entered) do
					if IsValid(k) then
						Election.Core.MakeWinner(k)
						XYZShit.Msg("Election", Election.Config.Color, k:Name().." was the only person to enter the election, they win by default.")
					end
					Election.Core.HasVoted = {}
					Election.Core.IsVoting = false
					Election.Core.Entered = {}
					return
				end
			end

			-- Multiple people in the vote, so we gotta do it proper
			Election.Core.IsVoting = true
			for k, v in ipairs(player.GetAll()) do
				if Election.Core.Entered[v] then continue end
				net.Start("Election:StartVote")
					net.WriteTable(Election.Core.Entered)
				net.Send(v)
			end


			timer.Simple(Election.Config.VoteTime, function()
				-- Get 1st and 2nd place
				local pres
				for k, v in pairs(Election.Core.Entered) do
					if not pres then pres = k continue end

					if (isbool(Election.Core.Entered[pres]) and 0 or Election.Core.Entered[pres]) <= (isbool(v) and 0 or v) then
						pres = k
					end
				end

				Election.Core.MakeWinner(pres)

				Election.Core.HasVoted = {}
				Election.Core.IsVoting = false
				Election.Core.Entered = {}
				Election.Core.NextElection = CurTime() + Election.Config.ElectionCooldown
			end)
		end)
	end
end)

net.Receive("Election:SubmitVote", function(_, ply)
	if not Election.Core.IsVoting then return end
	if Election.Core.HasVoted[ply] then return end
	if Election.Core.Entered[ply] then return end

	local votee = net.ReadEntity()
	if not Election.Core.Entered[votee] then return end -- Trying to vote for someone who didn't even enter

	if not isnumber(Election.Core.Entered[votee]) then
		Election.Core.Entered[votee] = 0
	end
	Election.Core.Entered[votee] = Election.Core.Entered[votee] + 1

	Election.Core.HasVoted[ply] = true

	XYZShit.Msg("Election", Election.Config.Color, "Thanks for voting!", ply)
end)

function Election.Core.MakeWinner(pres)
	if PrisonSystem.IsArrested(pres) or pres:XYZIsArrested() or pres:XYZIsZiptied() then
		XYZShit.Msg("Election", Election.Config.Color, pres:Name().." has won the election but is currently unable to be inaugurated!")
		return 
	end
	-- Reset any pres or vice pres
	for k, v in ipairs(player.GetAll()) do
		if pres == v then continue end
		if (v:Team() == TEAM_PRESIDENT) or (v:Team() == TEAM_VICE_PRESIDENT) then
			v:changeTeam(TEAM_CITIZEN, true)
		end
	end

	Quest.Core.ProgressQuest(pres, "rigged_elections", 2)

	if IsValid(pres) then
		if not (pres:Team() == TEAM_PRESIDENT) then
			pres:changeTeam(TEAM_PRESIDENT, true)
		end
		XYZShit.Msg("Election", Election.Config.Color, pres:Name().." has won the election and was made President!")
		XYZShit.Msg("Election", Election.Config.Color, "You have won the election, you can pick a vice pres at the election NPC.", pres)
	end
end

hook.Add("PlayerDisconnect", "Election:PlyLeave", function(ply)
	Election.Core.Entered[ply] = nil
end)

net.Receive("Election:VicePres", function(_, ply)
    if XYZShit.CoolDown.Check("Election:VicePres", 10, ply) then
    	return
    end

    if not ply:Team() == TEAM_PRESIDENT then return end

    local curVicePres = false
    for k, v in ipairs(player.GetAll()) do
    	if v:Team() == TEAM_VICE_PRESIDENT then
    		curVicePres = true
    		break
    	end
    end
    if curVicePres then
    	XYZShit.Msg("Election", Election.Config.Color, "There is currently a vice-president!", ply)
    	return
    end

	local npc = net.ReadEntity()

    if not (npc:GetClass() == "xyz_election") then return end
    if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

    local vice = net.ReadEntity()
    XYZShit.Msg("Election", Election.Config.Color, "You offered "..vice:Nick().." Vice President!", ply)
    pendingVice = vice
    
	Quest.Core.ProgressQuest(ply, "rigged_elections", 3)

    net.Start("Election:VicePres:Ask")
    net.Send(vice)
end)

net.Receive("Election:VicePres:Accept", function(_, ply)
	if not (pendingVice == ply) then return end

    if PrisonSystem.IsArrested(ply) then
    	XYZShit.Msg("Election", Election.Config.Color, "You cannot become the Vice President while in prison...", ply)
    	return
    end

    local curPres = false
    for k, v in ipairs(player.GetAll()) do
    	if v:Team() == TEAM_PRESIDENT then
    		curPres = true
    		break
    	end
    end
    if not curPres then
    	XYZShit.Msg("Election", Election.Config.Color, "It seems there is no longer a president...", ply)
    	return
    end

    pendingVice = nil
	ply:changeTeam(TEAM_VICE_PRESIDENT, true)
	XYZShit.Msg("Election", Election.Config.Color, ply:Name().." has been selected as the Vice-President!")
end)