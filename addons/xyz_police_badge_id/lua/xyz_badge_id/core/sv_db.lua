function GovBadgeID.Database.SetBadgeID(plyID, badgeID)
	XYZShit.DataBase.Query(string.format("INSERT INTO gov_tag(userid, tag) VALUES('%s', %s) ON DUPLICATE KEY UPDATE tag = %s", XYZShit.DataBase.Escape(plyID), badgeID, badgeID))
end

function GovBadgeID.Database.GetBadgeID(plyID, callback)
	XYZShit.DataBase.Query(string.format("SELECT tag FROM gov_tag WHERE userid='%s'", XYZShit.DataBase.Escape(plyID)
		), callback)
end