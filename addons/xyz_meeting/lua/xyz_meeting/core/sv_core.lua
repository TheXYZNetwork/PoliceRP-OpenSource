-- Setting up the default meeting data


local function checkPrivladge(ply)
	return table.HasValue(XYZShit.Jobs.Government.PoliceMeetings, ply:Team()) or ply:IsAdmin()
end


hook.Add("PlayerSay", "meeting_chat_command", function(ply, msg)
	if string.lower(msg) == "!meeting" then
		if checkPrivladge(ply) then
			if timer.Exists("xyz_meeting_end_timer") then
				XYZShit.Msg("Meeting", Color(0, 100, 155), "There is currently an active meeting. Type '!stopmeeting' to end it early.", ply)
			else
				net.Start("xyz_meeting_open")
				net.Send(ply)
			end
		else
			XYZShit.Msg("Meeting", Color(0, 100, 155), "You do not have permission to run a meeting!", ply)
		end
	elseif string.lower(msg) == "!stopmeeting" then
		if checkPrivladge(ply) then
			if timer.Exists("xyz_meeting_end_timer") then
				XYZShit.Msg("Meeting", Color(0, 100, 155), "You have ended the meeting early.", ply)
				XYZShit.Msg("Meeting", Color(0, 100, 155), "The meeting has now ended.")
				timer.Destroy("xyz_meeting_end_timer")
				net.Start("xyz_meeting_end_early")
				net.Broadcast()
			else
				XYZShit.Msg("Meeting", Color(0, 100, 155), "There is currently no active meeting?", ply)
			end
		else
			XYZShit.Msg("Meeting", Color(0, 100, 155), "You do not have permission to end a meeting!", ply)
		end
	end
end)

net.Receive("xyz_meeting_start", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_meeting_start", 1, ply) then return end

	if not checkPrivladge(ply) then return end

	if XYZMeeting.NextMeeting > CurTime() then
		XYZShit.Msg("Meeting", Color(0, 100, 155), "There was recently a meeting. The next meeting can be run in "..math.Round((XYZMeeting.NextMeeting - CurTime())/60, 0).." minutes.", ply)
		return
	end

	if timer.Exists("xyz_meeting_end_timer") then
		XYZShit.Msg("Meeting", Color(0, 100, 155), "There is currently an active meeting.", ply)
		return
	end

	XYZMeeting.LastMeeting = CurTime()
	XYZMeeting.NextMeeting = CurTime() + XYZMeeting.MeetingCooldown

	local TABLE = net.ReadTable()

	XYZMeeting.MeetingData.name = TABLE.name
	XYZMeeting.MeetingData.dep = TABLE.dep
	XYZMeeting.MeetingData.stopCrime = TABLE.stopCrime
	XYZMeeting.MeetingData.time = TABLE.time
	XYZMeeting.MeetingData.host = ply
	XYZMeeting.MeetingData.hostName = ply:Name()
	XYZMeeting.MeetingData.started = CurTime()

	if XYZMeeting.MeetingData.name == "Announcement" then
		XYZMeeting.MeetingData.announcement = TABLE.announcement
		XYZMeeting.MeetingData.time = 1
		XYZMeeting.MeetingData.stopCrime = false
		XYZShit.Msg("Meeting", Color(0, 100, 155), XYZMeeting.MeetingData.hostName.." to "..XYZMeeting.MeetingData.dep..": "..TABLE.announcement)
	else
		XYZShit.Msg("Meeting", Color(0, 100, 155), XYZMeeting.MeetingData.hostName.." has started a "..TABLE.name.." for the "..XYZMeeting.MeetingData.dep..". This "..TABLE.name.." will end in "..XYZMeeting.MeetingData.time.." minutes.")
	end

	net.Start("xyz_meeting_broadcast")
		net.WriteTable(XYZMeeting.MeetingData)
	net.Broadcast()

	timer.Create("xyz_meeting_end_timer", XYZMeeting.MeetingData.time * 60, 1, function()
		XYZShit.Msg("Meeting", Color(0, 100, 155), "The "..XYZMeeting.MeetingData.name.." has now ended.")
	end)

end)