CreateClientConVar("xyz_time", "1", true, false, "This will toggle the game time in the top right corner.")
local function timeToStr(time)
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp % 60
	tmp = math.floor( tmp / 60 )
	local h = tmp % 24
	tmp = math.floor( tmp / 24 )
	local d = tmp

	return string.format( "%02id %02ih %02im %02is", d, h, m, s )
end

local function timeToStrSession(time)
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp % 60
	tmp = math.floor( tmp / 60 )
	local h = tmp % 24

	return string.format( "%02ih %02im %02is", h, m, s )
end

local xyz_timeUsers = {}
xyz_timeJoined = xyz_timeJoined or  0
xyz_timeTotal = xyz_timeTotal or 0

net.Receive("xyz_time_self", function()
	local time = net.ReadInt(32)

	xyz_timeJoined = os.time()
	xyz_timeTotal = time
end)

hook.Add("HUDPaint", "xyz_request_data", function()
	net.Start("xyz_time_request")
	net.SendToServer()

	hook.Remove("HUDPaint", "xyz_request_data")
end)

net.Receive("xyz_time_request_return", function()
	local tbl = net.ReadTable()
	
	for k, v in pairs(tbl) do
		xyz_timeUsers[v.ply] = {joined = os.time() - v.join, total = v.time}
	end
end)

net.Receive("xyz_time_broadcast", function()
	local ply = net.ReadString()
	local time = net.ReadInt(32)

	xyz_timeUsers[ply] = {joined = os.time(), total = time}
end)

-- Cache
local scrw = ScrW
local scrh = ScrH
local color = Color
local draw_box = draw.RoundedBox
local math_clamp = math.Clamp

-- Colors
local white = color(255, 255, 255)
local headerDefault = color(2, 88, 154)
local headerShader = color(0, 0, 0, 55)

local boxW, boxH = math_clamp(scrw()*0.15, 280, 380), math_clamp(scrh()*0.07+(scrw() > 1920 and ScreenScale(3) or 0), 0, 100)
hook.Add("HUDPaint", "xyz_time_ui", function()
	local w, h = scrw(), scrh()
	local myX, myY = w-(boxW*0.5)-10, 14+((boxH)*0.5)

	if XYZSettings.GetSetting("playtime_show_hud", true) then	
		XYZUI.DrawShadowedBox(w-boxW-10, 5, boxW, boxH)
		draw_box(0, w-boxW-5, 10, boxW-10, 16, headerDefault)
		draw_box(0, w-boxW-5, 18, boxW-10, 8, headerShader)
	
		XYZUI.DrawScaleText("Total: "..timeToStr(xyz_timeTotal + os.difftime(os.time(), xyz_timeJoined)), 8,myX, myY, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		XYZUI.DrawScaleText("Session: "..timeToStrSession(os.difftime(os.time(), xyz_timeJoined)), 8, myX, myY, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	
	if XYZSettings.GetSetting("playtime_show_target_hud", true) then
		local target = LocalPlayer():GetEyeTrace().Entity
		if IsValid(target) and target:IsPlayer() and xyz_timeUsers[target:SteamID64()] then
	
			XYZUI.DrawShadowedBox(w-boxW-10, boxH+10, boxW, boxH)
			draw_box(0, w-boxW-5, boxH+15, boxW-10, 16, headerDefault)
			draw_box(0, w-boxW-5, boxH+23, boxW-10, 8, headerShader)
	
			XYZUI.DrawScaleText("Total: "..timeToStr(xyz_timeUsers[target:SteamID64()].total + os.difftime(os.time(), xyz_timeUsers[target:SteamID64()].joined)), 8, myX, myY+boxH+5, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			XYZUI.DrawScaleText("Session: "..timeToStrSession(os.difftime(os.time(), xyz_timeUsers[target:SteamID64()].joined)), 8, myX, myY+boxH+5, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end)