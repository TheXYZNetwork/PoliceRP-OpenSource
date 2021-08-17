net.Receive("xAdminNetworkIDRank", function()
	local plyID = net.ReadString()
	local rank = net.ReadString()
	xAdmin.Users[plyID] = rank
end)

net.Receive("xAdminNetworkExistingUsers", function()
	local tbl = net.ReadTable()
	xAdmin.Users = tbl
end)

xAdmin.CommandCache = xAdmin.CommandCache or {}
net.Receive("xAdminNetworkCommands", function()
	xAdmin.CommandCache = net.ReadTable()
end)

concommand.Add("xadmin_help", function()
	print("xAdmin:")
	print("xAdmin is a text based command system that is used by staff to manage the server. You have access to the following commands:")
	for k, v in pairs(xAdmin.CommandCache) do
		print(k, "-", v)
	end
	print("To run a command, use the following format:")
	print("For console use:", "xadmin <command> <arguments>")
	print("	", "Example:", "xadmin health owain 100")
	print("For chat use:", "!<command> <arguments>")
	print("	", "Example:", "!hp owain 100")
	print("\n")
	print("Arguments are broken up by spaces, if you wish to have a multispace argument use \"\"")
	print("	", "Example:", "!hp \"Owain Owjo\" 50")
	print("	", "This will take \"Owain Owjo\" as one argument instead of 2")
end)

net.Receive("xAdminAFKCheck", function()
	local timeLeft = CurTime() + 30
	local frame = vgui.Create("DFrame")
	frame:ShowCloseButton(true)
	--frame:SetPos(ScrW()-200, ScrH()/2-50)
	frame:SetPos(ScrW()/2-90, ScrH()-150)
	frame:SetSize(180, 90)

	frame:SetDraggable(false)
	frame:SetTitle("")
	frame.Paint = function(self, w, h)
		XYZShit.DermaBlurPanel(self, 3)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color( 100, 100, 100, 55 ))
	end

	local button = vgui.Create("DButton", frame)
	button:SetPos(0, 0)
	button:SetSize(frame:GetWide(), frame:GetTall())
	button:SetText("")
	button.DoClick = function()
		frame:Close()
		net.Start("xAdminAFKConfirm")
		net.SendToServer()
	end
	button.Paint = function(self, w, h)
		if self:IsHovered() then
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 155))
		else
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 100))
		end
		draw.SimpleText("AFK check", "xyz_font_40_static", self:GetWide()/2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText("CLICK ME", "xyz_font_30_static", self:GetWide()/2, self:GetTall()/2+20, Color(255, 55, 55), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText(math.Round(timeLeft-CurTime()).."s", "xyz_font_30_static", self:GetWide()/2, self:GetTall()/2+16, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		if CurTime() > timeLeft then
			frame:Close()
		end
	end
end)

function xAdmin.Core.Msg(args)
	chat.AddText(unpack(args))
end

net.Receive("xAdminChatMessage", function()
	if not XYZSettings.GetSetting("xadmin_chat_messages", true) then return end
	
	local args = net.ReadTable()
	if not args then return end

	xAdmin.Core.Msg(args)
end)


-- Sepctate ESP
local spectateState = false
net.Receive("xAdminSpectate", function()
	spectateState = net.ReadBool()
	if not spectateState then
		for k, v in pairs(player.GetAll()) do
			v.SetMaterial(v, "")
		end
	else
		chat.AddText("To disable ESP type `xadmin_reset_esp` in console")
	end
end)


local plyCache = {}
hook.Add("HUDPaint", "HUDPaint_DrawABox", function()
	if not spectateState then return end
	plyCache = {}
	for k, v in pairs(player.GetAll()) do
		local screenpos = v:GetPos():ToScreen()
		if not screenpos.visible then
			continue
		end
		table.insert(plyCache, {ply = v, pos = screenpos, teamcolor = team.GetColor(v:Team())})
	end

		for k, v in pairs(plyCache) do
			draw.DrawText(v.ply:Nick() or "Unknown", "Trebuchet24", v.pos.x, v.pos.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText(v.ply:GetUserGroup() or "Unknown", "Trebuchet18", v.pos.x, v.pos.y+15, Color( 200, 75, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText(v.ply:getDarkRPVar( "job" ) or "Unknown", "Trebuchet18", v.pos.x, v.pos.y+25, v.teamcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText("Health: "..v.ply:Health() or "Unknown".." | "..v.ply:Armor() or "Unknown".." :Armor", "Trebuchet18", v.pos.x, v.pos.y+37, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

	cam.Start3D(EyePos(), EyeAngles())
	cam.IgnoreZ(true)
		for k, v in pairs(plyCache) do
			render.SuppressEngineLighting(true)
			render.SetColorModulation(v.teamcolor.r/255, v.teamcolor.g/255, v.teamcolor.b/255) 
			render.SetBlend(1)
			v.ply.SetMaterial(v.ply, "models/debug/debugwhite")
			v.ply.DrawModel(v.ply)
		end
	render.SuppressEngineLighting(false)
	cam.IgnoreZ(false)
	cam.End3D()
end)


concommand.Add("xadmin_reset_esp", function()
	spectateState = false
	for k, v in pairs(player.GetAll()) do
		v.SetMaterial(v, "")
	end
end)


local colorGold = Color(185, 173, 0)
net.Receive("xAdminStartAnnouncement", function()
	local announcement = net.ReadString()

	hook.Add("HUDPaint", "xAdminAnnouncement", function()
		XYZUI.DrawShadowedBox(5, 5, ScrW()-10, ScrH()/11)
		XYZUI.DrawScaleText("Announcement", 20, ScrW()/2, 10, colorGold, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		XYZUI.DrawScaleText(announcement, 10, ScrW()/2, ScrH()/11, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end)

	timer.Simple(20, function()
		hook.Remove("HUDPaint", "xAdminAnnouncement")
	end)
end)

net.Receive("xAdminRequestFocus", function()
	net.Start("xAdminRequestFocus")
		net.WriteBool(system.HasFocus())
	net.SendToServer()

	system.FlashWindow()
end)