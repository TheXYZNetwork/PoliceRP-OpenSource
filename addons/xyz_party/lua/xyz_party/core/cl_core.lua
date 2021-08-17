XYZParty.Core.MyParty = XYZParty.Core.MyParty or nil
XYZParty.Core.Pings = {}
net.Receive("xyz_party_data", function()
	XYZParty.Core.MyParty = net.ReadTable()
	Minimap.RemoveWaypointsWithTag("party")

	if not XYZParty.Core.MyParty then return end

	for k, v in pairs(XYZParty.Core.MyParty.members) do
		if not IsValid(v) then continue end
		if v == LocalPlayer() then continue end -- Don't show yourself silly
		Minimap.AddWaypoint("party_"..v:SteamID64(), "minimap_party", XYZUI.CharLimit(v:Name(), 20), color_white, 1, v:GetPos(), v:GetAngles())
	end
end)

net.Receive("xyz_party_data_wipe", function()
	XYZParty.Core.MyParty = nil
	Minimap.RemoveWaypointsWithTag("party")
end)

-- Cache
local scrw = ScrW
local scrh = ScrH
local curtime = CurTime
local localplayer = LocalPlayer
local color = Color
local draw_box = draw.RoundedBox
local getglobalbool = GetGlobalBool
local math_clamp = math.Clamp

-- Colors
local white = color(255, 255, 255)
local headerDefault = color(0, 100, 155)
local headerShader = color(0, 0, 0, 55)
local healthRed = color(200, 0, 55)
local ArmorRed = color(0, 100, 200)

local post_x, post_y = 0, 0
local startX, startY = 360, 200
local boxBuffer = 65
local count = 0
hook.Add("HUDPaint", "xyz_party_display", function()
	if XYZParty.Core.MyParty and #XYZParty.Core.MyParty.members > 1 and XYZSettings.GetSetting("party_show_hud", true) then
		local w, h = scrw(), scrh()
		XYZUI.DrawShadowedBox(w-startX, startY, startX-10, 65)
		draw_box(0, w-startX+5, startY+5, startX-20, 16, XYZParty.Core.MyParty.color)
		draw_box(0, w-startX+5, startY+15, startX-20, 8, headerShader)

		XYZUI.DrawText(XYZParty.Core.MyParty.name, 35, w-(startX*0.5), startY+40, white, TEXT_ALIGN_CENTER)

		count = 0
		for k, v in pairs(XYZParty.Core.MyParty.members) do
			if not IsValid(v) then continue end
			if v == LocalPlayer() then continue end
			count = count + 1
			local yPos = startY+70+(count*boxBuffer)-boxBuffer

			XYZUI.DrawShadowedBox(w-startX, yPos, startX-10, 60)
			XYZUI.DrawText(XYZUI.CharLimit(v:Name(), 20), 32, w-startX+5, yPos+18, white, TEXT_ALIGN_LEFT)

			draw_box(0, w-startX+5, yPos+40, (startX-20) * math_clamp(v:Health(), 0, 100)/100, 15, healthRed)
			draw_box(0, w-startX+5, yPos+35, (startX-20) * math_clamp(v:Armor(), 0, 100)/100, 5, ArmorRed)
		end
	end
end)

hook.Add("PreDrawOutlines", "xyz_party_halo", function()
	if XYZParty.Core.MyParty and XYZSettings.GetSetting("party_show_halo", true) then
		for k, v in pairs(XYZParty.Core.MyParty.members) do
			if IsValid(v) and IsValid(v:GetActiveWeapon()) and ((v:GetActiveWeapon():GetClass() == "weapon_ziptied") or (v:GetActiveWeapon():GetClass() == "weapon_cuffed")) then continue end 

			outline.Add(v, XYZParty.Core.MyParty.color, 2)
		end
	end
end)

net.Receive("xyz_party_chat", function()
	if not XYZParty.Core.MyParty then return end

	local ply = net.ReadEntity()
	local msg = net.ReadString()
	chat.AddText(XYZParty.Core.MyParty.color, "["..XYZParty.Core.MyParty.name.."] ", team.GetColor(ply:Team()), ply, Color( 255, 255, 255 ), ": "..msg)
end)

concommand.Add("xyz_party_ping", function(ply, cmd, args)
	local pingPos = LocalPlayer():GetEyeTrace().HitPos
	if not XYZParty.Core.MyParty then return end

	net.Start("xyz_party_ping_send")
		net.WriteVector(pingPos)
	net.SendToServer()
end)

net.Receive("xyz_party_ping_broadcast", function()
	if not XYZSettings.GetSetting("party_show_pings", true) then return end
	
	local ply = net.ReadEntity()
	local pos = net.ReadVector()

	if not ply then return end
	if not pos then return end

	local id64 = ply:SteamID64()

	if XYZParty.Core.Pings[id64] then timer.Destroy("xyz_ping_"..id64) end

	XYZParty.Core.Pings[id64] = pos

	Minimap.AddWaypoint("party_ping_"..id64, "minimap_party_waypoint", "Party Ping", color_white, 1, pos, Angle(0, 0, 0))

	timer.Create("xyz_ping_"..id64, 10, 1, function()
		XYZParty.Core.Pings[id64] = nil
		Minimap.RemoveWaypoint("party_ping_"..id64)
	end)
end)

hook.Add("HUDPaint", "xyz_party_pings", function()
	if not XYZParty.Core.Pings then return end
	if not XYZParty.Core.MyParty then return end
	for k, v in pairs(XYZParty.Core.Pings) do
		local pos = v:ToScreen()

		pos.x = math.Clamp(pos.x, 45, ScrW()-45)
		pos.y = math.Clamp(pos.y, 45, ScrH()-45)

		surface.SetDrawColor(XYZParty.Core.MyParty.color.r, XYZParty.Core.MyParty.color.g, XYZParty.Core.MyParty.color.b, 255)
		XYZUI.DrawCircle(pos.x, pos.y, 15, 2, false)
		draw.SimpleText("!", "xyz_font_30_static", pos.x-1, pos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(math.Round(v:DistToSqr(LocalPlayer():GetPos())/50000).."m", "xyz_font_20_static", pos.x, pos.y+25, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)

net.Receive("xyz_party_edit_share", function()
	if not XYZParty.Core.MyParty then return end

	data = net.ReadTable()
	XYZParty.Core.MyParty.name = data.name
	XYZParty.Core.MyParty.password = data.password
	XYZParty.Core.MyParty.color = data.color
end)


hook.Add("MinimapThink", "PartyMembers", function()
	if not XYZParty.Core.MyParty then return end

	for k, v in pairs(XYZParty.Core.MyParty.members) do
		if not IsValid(v) then continue end
		if v == LocalPlayer() then continue end -- Don't show yourself silly
		if IsValid(v) and IsValid(v:GetActiveWeapon()) and ((v:GetActiveWeapon():GetClass() == "weapon_ziptied") or (v:GetActiveWeapon():GetClass() == "weapon_cuffed")) then continue end 
		Minimap.AddWaypoint("party_"..v:SteamID64(), "minimap_party", XYZUI.CharLimit(v:Name(), 20), team.GetColor(v:Team()), 1, v:GetPos(), v:EyeAngles())
	end
end)