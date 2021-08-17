function Quest.Database.Load(plyID, callback)
	XYZShit.DataBase.Query(string.format("SELECT * FROM quest_progress WHERE userid='%s'", XYZShit.DataBase.Escape(plyID)), callback)
end

function Quest.Database.GiveQuest(plyID, storyID, questID)
	XYZShit.DataBase.Query(string.format("INSERT INTO quest_progress(userid, story_id, quest_id, started) VALUES('%s', '%s', %i, %i)", XYZShit.DataBase.Escape(plyID), XYZShit.DataBase.Escape(storyID), questID, os.time()))
end

function Quest.Database.CompleteQuest(plyID, storyID, questID)
	XYZShit.DataBase.Query(string.format("UPDATE quest_progress SET complete=1, finished=%i WHERE userid='%s' AND story_id='%s' AND quest_id=%i", os.time(), XYZShit.DataBase.Escape(plyID), XYZShit.DataBase.Escape(storyID), questID))
end

function Quest.Database.UpdateQuestData(plyID, storyID, questID, data)
	XYZShit.DataBase.Query(string.format("UPDATE quest_progress SET data='%s' WHERE userid='%s' AND story_id='%s' AND quest_id=%i", XYZShit.DataBase.Escape(tostring(data)), XYZShit.DataBase.Escape(plyID), XYZShit.DataBase.Escape(storyID), questID))
end