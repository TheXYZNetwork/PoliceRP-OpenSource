-- Give the player a new storyline
function Quest.Core.NetworkProgress(storyID, questID)
	net.Start("Quest:Quest:Progress")
		net.WriteString(storyID)
		net.WriteUInt(questID, 32)
	net.SendToServer()
end

function Quest.Core.SetActive(storyID)
	net.Start("Quest:Storyline:SetActive")
		net.WriteString(storyID)
	net.SendToServer()
end

net.Receive("Quest:Storyline:New", function()
	local storyID = net.ReadString()

	Quest.Storylines[storyID] = {
		[1] = false
	}

	local storylineData = Quest.Config.Storylines[storyID]
	XYZShit.Msg("Quests", Quest.Config.Color, "You have just unlocked the quest: "..storylineData.name)
end)

net.Receive("Quest:Load", function()
	Quest.Storylines = net.ReadTable()
end)

net.Receive("Quest:Storyline:Active", function()
	local storyID = net.ReadString()
	local data = net.ReadTable()

	Quest.Storylines[storyID] = data
	Quest.Active = {
		story = storyID,
		quest = table.Count(data)
	}

	local storylineData = Quest.Config.Storylines[storyID]
	XYZShit.Msg("Quests", Quest.Config.Color, "You have changed quest, your new quest is now: "..storylineData.name)
end)

net.Receive("Quest:Quest:New", function()
	local storyID = net.ReadString()
	local questID = net.ReadUInt(32)

	Quest.Storylines[storyID][questID] = false
end)

net.Receive("Quest:Quest:Complete", function()
	local storyID = net.ReadString()
	local questID = net.ReadUInt(32)
	
	local storylineData = Quest.Config.Storylines[storyID]

	Quest.Storylines[storyID][questID] = true

	Quest.Active.quest = Quest.Active.quest + 1

	surface.PlaySound("xyz/complete.mp3")
end)

net.Receive("Quest:Quest:Update", function()
	local storyID = net.ReadString()
	local questID = net.ReadUInt(32)
	local newData = net.ReadString()

	Quest.Storylines[storyID][questID] = newData
end)

local scrW, scrH = ScrW(), ScrH()
local gold = Color(255, 215, 0)
local grey = Color(155, 155, 155)
hook.Add("HUDPaint", "Quest:HUD", function()
	if not Quest.Active then return end

	local storyLineData = Quest.Config.Storylines[Quest.Active.story]
	if not storyLineData then return end
	local questData = storyLineData.quests[Quest.Active.quest]
	if not questData then return end
	local lastQuestData = storyLineData.quests[Quest.Active.quest - 1]

	XYZUI.DrawTextOutlined(storyLineData.name, 80, 20, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)

	local offset = 0
	if lastQuestData then
		offset = 1
		XYZUI.DrawTextOutlined(lastQuestData.name, 45, 20, 65, grey, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)
	end
	XYZUI.DrawTextOutlined(questData.name, 45, 20, 65 + (28 * offset), gold, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)
	XYZUI.DrawTextOutlined(isfunction(questData.desc) and questData.desc(Quest.Storylines[Quest.Active.story][Quest.Active.quest]) or questData.desc, 30, 20, 65 + (offset * 28) + 36, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)

end)
/*
hook.Add("HUDPaint", "Quest:HUD", function()
	if not Quest.Active then return end

	local storyLineData = Quest.Config.Storylines[Quest.Active.story]
	XYZUI.DrawTextOutlined(storyLineData.name, 80, 20, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)

	local count = 1
	for i=Quest.Active.quest, Quest.Active.quest-1, -1 do
		local questData = storyLineData.quests[i]
		if not questData then return end

		local offset = i - (Quest.Active.quest - 1)

		XYZUI.DrawTextOutlined(questData.name, 45, 20, 65 + (offset * 28), (Quest.Active.quest == i) and gold or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)
		if Quest.Active.quest == i then
			XYZUI.DrawTextOutlined(questData.desc, 30, 20, 65 + (offset * 28) + 32, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)
		end
	end
--	XYZUI.DrawTextOutlined(questData.desc, 35, scrW-20, 100, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1)
end)
*/