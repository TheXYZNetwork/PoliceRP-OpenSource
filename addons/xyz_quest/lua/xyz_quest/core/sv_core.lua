hook.Add("PlayerInitialSpawn", "Quest:Load:Ply", function(ply)
	Quest.Database.Load(ply:SteamID64(), function(data)
		-- No previous quest history
		if (not data) or (table.IsEmpty(data)) then
			Quest.Core.GiveStoryline(ply, Quest.Config.StarterQuest)
		else
			Quest.Storylines[ply:SteamID64()] = {}

			local newestQuest
			for k, v in pairs(data) do
				local storylineData = Quest.Config.Storylines[v.story_id]
				if not storylineData then continue end

				if not Quest.Storylines[ply:SteamID64()][v.story_id] then
					Quest.Storylines[ply:SteamID64()][v.story_id] = {}
				end

				if v.complete == 1 then
					Quest.Storylines[ply:SteamID64()][v.story_id][v.quest_id] = true
				else
					Quest.Storylines[ply:SteamID64()][v.story_id][v.quest_id] = v.data or false
				end

				if (not newestQuest) or (newestQuest.t < v.started) then
					newestQuest = {q = v.story_id, t = v.started}
				end
			end

			net.Start("Quest:Load")
				net.WriteTable(Quest.Storylines[ply:SteamID64()])
			net.Send(ply)

			if newestQuest then
				Quest.Core.SetActiveStoryline(ply, newestQuest.q)
			end
		end
	end)
end)

-- Give the player a new storyline
function Quest.Core.GiveStoryline(ply, storyID)
	if Quest.Storylines[ply:SteamID64()] and Quest.Storylines[ply:SteamID64()][storyID] then return end

	-- Add to database the first quest
	Quest.Database.GiveQuest(ply:SteamID64(), storyID, 1)

	-- Build the tracking for the new storyline
	if not Quest.Storylines[ply:SteamID64()] then
		Quest.Storylines[ply:SteamID64()] = {}
	end
	Quest.Storylines[ply:SteamID64()][storyID] = {}
	-- Set the first mission as false
	Quest.Storylines[ply:SteamID64()][storyID][1] = false

	-- Network the new storyline to the player
	net.Start("Quest:Storyline:New")
		net.WriteString(storyID)
	net.Send(ply)

	if not Quest.Active[ply:SteamID64()] then
		 Quest.Core.SetActiveStoryline(ply, storyID)
	end
end

-- Set an active Storyline
function Quest.Core.SetActiveStoryline(ply, storyID)
	if not Quest.Storylines[ply:SteamID64()] then return end
	if not Quest.Storylines[ply:SteamID64()][storyID] then return end

--	if Quest.Active[ply:SteamID64()] and (Quest.Active[ply:SteamID64()].story == storyID) then return end
	if (table.Count(Quest.Storylines[ply:SteamID64()][storyID]) == table.Count(Quest.Config.Storylines[storyID].quests)) and (Quest.Storylines[ply:SteamID64()][storyID][table.Count(Quest.Config.Storylines[storyID].quests)] == true) then return end

	Quest.Active[ply:SteamID64()] = {
		story = storyID,
		quest = table.Count(Quest.Storylines[ply:SteamID64()][storyID])
	}

	local storylineData = Quest.Config.Storylines[storyID]
	if storylineData.quests[Quest.Active[ply:SteamID64()].quest].check and storylineData.quests[Quest.Active[ply:SteamID64()].quest].check(ply) then
		Quest.Core.CompleteQuest(ply, storyID, Quest.Active[ply:SteamID64()].quest)
	end

	net.Start("Quest:Storyline:Active")
		net.WriteString(storyID)
		net.WriteTable(Quest.Storylines[ply:SteamID64()][storyID])
	net.Send(ply)
end

-- Complete a quest for a storyline
function Quest.Core.CompleteQuest(ply, storyID, questID)
	if not Quest.Active[ply:SteamID64()] then return end
	if not (Quest.Active[ply:SteamID64()].story == storyID) then return end
	if not (Quest.Active[ply:SteamID64()].quest == questID) then return end

	if not Quest.Storylines[ply:SteamID64()] then return end
	if not Quest.Storylines[ply:SteamID64()][storyID] then return end

	Quest.Active[ply:SteamID64()].quest = questID + 1

	local storylineData = Quest.Config.Storylines[storyID]
	local completeQuestData = storylineData.quests[questID]

	-- Update the database
	Quest.Database.CompleteQuest(ply:SteamID64(), storyID, questID)

	-- Update the hot table
	Quest.Storylines[ply:SteamID64()][storyID][questID] = true

	-- Play the sound and update the active quest
	net.Start("Quest:Quest:Complete")
		net.WriteString(storyID)
		net.WriteUInt(questID, 32)
	net.Send(ply)
	-- Storyline complete
	if Quest.Active[ply:SteamID64()].quest > table.Count(storylineData.quests) then
		XYZShit.Msg("Quests", Quest.Config.Color, "You have completed this quest: "..storylineData.name, ply)

		-- They no longer have an active Storyline :)
		Quest.Active[ply:SteamID64()] = nil
	-- Log in the database their next quest
	else
		Quest.Database.GiveQuest(ply:SteamID64(), storyID, Quest.Active[ply:SteamID64()].quest)

		net.Start("Quest:Quest:New")
			net.WriteString(storyID)
			net.WriteUInt(Quest.Active[ply:SteamID64()].quest, 32)
		net.Send(ply)

		if storylineData.quests[Quest.Active[ply:SteamID64()].quest].check and storylineData.quests[Quest.Active[ply:SteamID64()].quest].check(ply) then
			Quest.Core.CompleteQuest(ply, storyID, Quest.Active[ply:SteamID64()].quest)
		end

		-- Update the hot table
		Quest.Storylines[ply:SteamID64()][storyID][Quest.Active[ply:SteamID64()].quest] = false
	end

	-- If there's a reward, give it
	if completeQuestData.reward then
		completeQuestData.reward(ply)
	end
end

-- Used to progress a player's active quest
function Quest.Core.ProgressQuest(ply, storyID, questID, data)
	-- They have no active quest
	if not Quest.Active[ply:SteamID64()] then return end
	-- Their active story isn't this story
	if not (Quest.Active[ply:SteamID64()].story == storyID) then return end
	-- Their active quest isn't this quest
	if not (Quest.Active[ply:SteamID64()].quest == questID) then return end

	-- It's their current quest
	local storylineData = Quest.Config.Storylines[storyID]
	local completeQuestData = storylineData.quests[questID]
	local questData = Quest.Storylines[ply:SteamID64()][storyID][questID]

	local complete, newData, updateQuestDataOnClient = completeQuestData.func(ply, questData, data)

	if newData then
		if updateQuestDataOnClient then
			net.Start("Quest:Quest:Update")
				net.WriteString(storyID)
				net.WriteUInt(questID, 32)
				net.WriteString(newData)
			net.Send(ply)
		end

		-- Update the cache table with the new data
		Quest.Storylines[ply:SteamID64()][storyID][questID] = newData
		-- Update the database aswell :D
		Quest.Database.UpdateQuestData(ply:SteamID64(), storyID, questID, newData)
	end

	if complete then
		Quest.Core.CompleteQuest(ply, storyID, questID)
	end

	return true
end

-- Progress a player and their party (If they have one)
function Quest.Core.ProgressPartyQuest(ply, storyID, questID, data)
	local passedProgress = Quest.Core.ProgressQuest(ply, storyID, questID, data)
	-- This user doesn't even have the quest active
	if not passedProgress then return end

	local partyData = XYZParty.Core.GetParty(ply)
	if not partyData then return end

	partyData = XYZParty.Core.Parties[partyData]
	if not partyData then return end

	for k, v in pairs(partyData.members or {}) do
		-- Don't give them double progress
		if v == ply then continue end
		Quest.Core.ProgressQuest(v, storyID, questID, data)
	end
end

net.Receive("Quest:Quest:Progress", function(_, ply)
	if XYZShit.CoolDown.Check("Quest:Quest:Progress", 1, ply) then return end

	local storyID = net.ReadString()
	local questID = net.ReadUInt(32)

	-- They have no active quest
	if not Quest.Active[ply:SteamID64()] then return end
	-- Their active story isn't this story
	if not (Quest.Active[ply:SteamID64()].story == storyID) then return end
	-- Their active quest isn't this quest
	if not (Quest.Active[ply:SteamID64()].quest == questID) then return end

	local questData = Quest.Config.Storylines[storyID].quests[questID]

	if not questData.clientProgress then
		xAdmin.Prevent.Post("Quest", ply, "This user is trying to force progress a Quest that is Server driven!", "8593794", true)
		return
	end

	Quest.Core.ProgressQuest(ply, storyID, questID)
end)

net.Receive("Quest:Storyline:SetActive", function(_, ply)
	if XYZShit.CoolDown.Check("Quest:Quest:SetActive", 1, ply) then return end

	local storyID = net.ReadString()

	-- Check they even have the quest
	if not Quest.Storylines[ply:SteamID64()][storyID] then return end

	Quest.Core.SetActiveStoryline(ply, storyID)
end)