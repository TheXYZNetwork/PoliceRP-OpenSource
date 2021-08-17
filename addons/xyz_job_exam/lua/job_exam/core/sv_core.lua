-- This file validates player input

net.Receive("job_exam_submit_exam", function(len, ply)
	local ent = net.ReadEntity()

	if ent.Config.LimitToJob and ply:Team() ~= ent.Config.LimitToJob then return end
	if xWhitelist.Users[ply:SteamID64()].whitelist[ent.Config.Whitelist] then return end
	if xWhitelist.Users[ply:SteamID64()].blacklist[ent.Config.Whitelist] then XYZShit.Msg("Exam", Color(33, 80, 118), "You're blacklisted!", ply) return end
	if ent.Chances[ply:SteamID64()] and ent.Chances[ply:SteamID64()] >= 3 then ply:changeTeam(GAMEMODE.DefaultTeam, true) return end
	if not licensedUsers[ply:SteamID64()] then return end
	local exam_answers = net.ReadTable()
	local score = 0 -- The score AKA the amount of correct answers.
	for k, v in SortedPairs( exam_answers ) do
        if ent.Config.Questions[k].CorrectAnswer == v then
        	score = score + 1
        end
    end
	
	-- Loop finished, time to check final results!

	if score >= ent.Config.AmountCorrectToPass then
		hook.Run("JobExamPassed", ply, ent)

		-- The player passed the exam, give whitelists
		XYZShit.Msg("Exam", Color(33, 80, 118), string.format("You passed the exam. You got %s answers correct (out of the required %s). You are now a "..team.GetName(ent.Config.Team)..".", score, ent.Config.AmountCorrectToPass), ply)
		XYZShit.Msg("Exam", Color(33, 80, 118), "Please join the relevant Discord: https://discord.gg/"..ent.Config.DInvite..".", ply)
		xWhitelist.Core.AddWhitelist(ply:SteamID64(), ent.Config.Whitelist)
		XYZShit.Webhook.Post(ent.Config.Webhook, nil, string.format("%s (%s) passed the exam. They got %s answers correct (out of the required %s).", string.gsub(ply:Nick(), "@", ""), ply:SteamID64(), score, ent.Config.AmountCorrectToPass))
		ply:changeTeam(ent.Config.Team, true)
	else
		if ent.Chances[ply:SteamID64()] then 
			ent.Chances[ply:SteamID64()] = ent.Chances[ply:SteamID64()] + 1
			if ent.Chances[ply:SteamID64()] == 3 then ply:changeTeam(GAMEMODE.DefaultTeam, true) end -- Failed 3 times, change team
		else
			ent.Chances[ply:SteamID64()] = 1
		end
		
		-- The player didn't pass the exam...
		XYZShit.Webhook.Post(ent.Config.Webhook, nil, string.format("%s (%s) failed the exam. They got %s answers correct (out of the required %s).", string.gsub(ply:Nick(), "@", ""), ply:SteamID64(), score, ent.Config.AmountCorrectToPass))
		XYZShit.Msg("Exam", Color(33, 80, 118), string.format("You failed the exam. You got %s answers correct (out of the required %s).", score, ent.Config.AmountCorrectToPass), ply)
	end
end)


hook.Add("xWhitelistUnwhitelist", "JobExamSetToMaxChancesOnDemo", function(ply, steamid, jobName, jobTbl)
	-- TODO: better way of handling this
	if jobName == "Police Officer" then 
		for k, v in ipairs(ents.FindByClass("police_exam_npc")) do
			v.Chances[steamid] = 3
		end
	elseif jobName == "Candidate Firefighter" then
		for k, v in ipairs(ents.FindByClass("fr_exam_npc")) do
			v.Chances[steamid] = 3
		end
	end
end)