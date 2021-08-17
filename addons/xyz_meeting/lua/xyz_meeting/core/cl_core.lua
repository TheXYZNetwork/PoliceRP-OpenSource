XYZMeeting.MeetingEnd = XYZMeeting.MeetingEnd or 0
net.Receive("xyz_meeting_broadcast", function()
	local TABLE = net.ReadTable()

	XYZMeeting.MeetingData.name = TABLE.name
	XYZMeeting.MeetingData.announcement = TABLE.announcement
	XYZMeeting.MeetingData.dep = TABLE.dep
	XYZMeeting.MeetingData.time = TABLE.time
	XYZMeeting.MeetingData.stopCrime = TABLE.stopCrime
	XYZMeeting.MeetingData.host = TABLE.host
	XYZMeeting.MeetingData.hostName = TABLE.hostName
	XYZMeeting.MeetingData.started = TABLE.started

	XYZMeeting.LastMeeting = XYZMeeting.MeetingData.started
	XYZMeeting.NextMeeting = XYZMeeting.MeetingData.started + XYZMeeting.MeetingCooldown

	XYZMeeting.MeetingEnd = XYZMeeting.MeetingData.started + (XYZMeeting.MeetingData.time*60)
end)

net.Receive("xyz_meeting_end_early", function()
	XYZMeeting.MeetingEnd = CurTime()
end)

-- Cache
local scrw = ScrW
local scrh = ScrH
local curtime = CurTime
local localplayer = LocalPlayer
local color = Color
local draw_box = draw.RoundedBox
local getglobalbool = GetGlobalBool

-- Colors
local white = color(255, 255, 255)
local headerDefault = color(0, 100, 155)
local headerShader = color(0, 0, 0, 55)
local healthRed = color(200, 0, 55)
local ArmorRed = color(0, 100, 200)
local healthSegments = color(31, 31, 31, 155)

hook.Add("HUDPaint", "xyz_meeting_header", function()
	if not XYZSettings.GetSetting("meeting_show_overlay", true) then return end
	if XYZMeeting.MeetingEnd > curtime() then
		local w, h = scrw(), scrh()
	
		local panelHeight = h*0.08+(w > 1920 and ScreenScale(5) or 0)

		XYZUI.DrawShadowedBox(w*0.3, 5, w*0.4, panelHeight+20)
		draw_box(0, w*0.3+5, 10, w*0.4-10, 20, headerDefault)
		draw_box(0, w*0.3+5, 20, w*0.4-10, 10, headerShader)
	
		XYZUI.DrawScaleText(XYZMeeting.MeetingData.name, 12, w/2, 30, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		if XYZMeeting.MeetingData.name == "Announcement" then
			XYZUI.DrawScaleText(XYZMeeting.MeetingData.announcement, 6, w/2, (panelHeight*0.85)+20, white, TEXT_ALIGN_CENTER)
		end
		XYZUI.DrawScaleText("For: "..XYZMeeting.MeetingData.dep.." - By: "..XYZMeeting.MeetingData.hostName, 8, w/2, (panelHeight*0.62)+20, white, TEXT_ALIGN_CENTER)
		if XYZMeeting.MeetingData.name ~= "Announcement" then
			XYZUI.DrawScaleText(math.Round((XYZMeeting.MeetingEnd - curtime())/60, 0).." minutes left - Major crimes: "..(XYZMeeting.MeetingData.stopCrime and "Not allowed" or "Allowed"), 8, w/2, panelHeight+20, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
	end
end)