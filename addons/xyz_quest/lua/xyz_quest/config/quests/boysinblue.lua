Quest.Config.Storylines["boys_in_blue"] ={
	name = "Boys in Blue",
	id = "boys_in_blue",
	desc = "Join the Police Force and work your way up.",
	quests = {
		[1] = {
			name = "Take the Police Exam",
			desc = "Head to the Police Department and talk to the Cadet Trainer",
			func = function(ply, data)
				return true
			end,
			check = function(ply)
				return xWhitelist.Users[ply:SteamID64()].whitelist["policeofficer"] 
			end
		},
		[2] = {
			name = "Pass the Police Exam",
			desc = "Pass the exam",
			func = function(ply, data)
				return true
			end,
			check = function(ply)
				return xWhitelist.Users[ply:SteamID64()].whitelist["policeofficer"] 
			end,
			reward = function(ply)
				ply:addMoney(25000)
				XYZShit.Msg("Quests", Quest.Config.Color, "You have been given $25,000 as a sign on bonus!", ply)
			end
		},
		[3] = {
			name = "Complete a Foot Patrol",
			desc = "Go into your PNC to start a Foot Patrol, then complete it",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Complete 3 Vehicle Patrols",
			desc = function(data) return string.format("Go into your PNC to start a Patrol. You have currently finished %i/3 patrols.", data or 0) end,
			func = function(ply, data)
				local completePatrols = data or 0

				completePatrols = completePatrols + 1
				return (completePatrols == 3), completePatrols, true
			end
		},
		[5] = {
			name = "Respond to a 911 call",
			desc = "Accept and respond to a 911 call",
			func = function(ply, data)
				return true
			end
		},
		[6] = {
			name = "Give a suspect a ticket",
			desc = "Ticket a suspect for breaking a law",
			func = function(ply, data)
				return true
			end
		},
		[7] = {
			name = "Arrest a suspect",
			desc = "Arrest a suspect for breaking a law. Remember to read them their Miranda Rights",
			func = function(ply, data)
				return true
			end
		},
		[8] = {
			name = "Defend against a Bank Raid",
			desc = "Be present during a bank raid. You can help by placing road blocks around the bank",
			func = function(ply, data)
				return true
			end
		},
		[9] = {
			name = "Be promoted to Police Corporal",
			desc = "Work your way up to the Police Corporal rank",
			func = function(ply, data)
				return true
			end,
			check = function(ply)
				return xWhitelist.Users[ply:SteamID64()].whitelist["policecorporal"] 
			end,
			reward = function(ply)
				ply:addMoney(100000)
				XYZShit.Msg("Quests", Quest.Config.Color, "You have been given $100,000 as a bonus!", ply)
			end
		}
	}
}

-- Open police exam
hook.Add("JobExamOpened", "Quest:Progress:boys_in_blue", function(ply, ent)
	if not IsValid(ent) then return end
	if not (ent:GetClass() == "police_exam_npc") then return end
	
	Quest.Core.ProgressQuest(ply, "boys_in_blue", 1)
end)
-- Pass the police exam
hook.Add("JobExamPassed", "Quest:Progress:boys_in_blue", function(ply, ent)
	if not (ent:GetClass() == "police_exam_npc") then return end
	
	Quest.Core.ProgressQuest(ply, "boys_in_blue", 2)
end)
-- Player arrested
hook.Add("XYZFrontDeskJail", "Quest:Progress:boys_in_blue", function(ply, prisoner, time)
	Quest.Core.ProgressQuest(ply, "boys_in_blue", 7)
end)
-- Bank robbery
hook.Add("pVaultVaultCracked", "Quest:Progress:boys_in_blue", function(ent, ply)
	if not (ent:GetClass() == "pvault_door") then return end

	for k, v in pairs(player.GetAll()) do
		if not XYZShit.IsGovernment(v:Team()) then continue end

		Quest.Core.ProgressQuest(v, "boys_in_blue", 8)
	end
end)
-- Promotion to Corporal
hook.Add("xWhitelistWhitelist", "Quest:Progress:boys_in_blue", function(whitelister, targetID, jobName)
	if not (jobName == "Police Corporal") then return end

	local target = player.GetBySteamID64(targetID)
	if not target then return end

	Quest.Core.ProgressQuest(target, "boys_in_blue", 9)
end)