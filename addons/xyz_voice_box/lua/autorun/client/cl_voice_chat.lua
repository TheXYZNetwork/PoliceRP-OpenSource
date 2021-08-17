local background = Color(18, 18, 18)
local draw_box = draw.RoundedBox

XYZ_Voice = {}
XYZ_Voice.CurTalking = {}
if XYZ_Voice.Panel then XYZ_Voice.Panel:Remove() end
XYZ_Voice.Panel = false

function XYZ_Voice:AddPlayer(ply)
	if not IsValid(ply) then return end
	if not ply:SteamID64() then return end
	if IsValid(self.CurTalking[ply:SteamID64()]) then return end

	self.CurTalking[ply:SteamID64()] = self.Panel.Shell.List:Add("AvatarImage")
	self.CurTalking[ply:SteamID64()]:SetSize(self.Panel.Shell:GetWide()/3-5, self.Panel.Shell:GetWide()/3-5)
	self.CurTalking[ply:SteamID64()]:SetPlayer(ply, 64)
	self:ResizePanel()
end

function XYZ_Voice:RemovePlayer(ply)
	if not IsValid(self.CurTalking[ply:SteamID64()]) then return end
	self.CurTalking[ply:SteamID64()]:Remove()
	self.CurTalking[ply:SteamID64()] = nil

	XYZ_Voice:ResizePanel()
end

function XYZ_Voice:RemoveID(id)
	if not self.CurTalking[id] then return end
	self.CurTalking[id]:Remove()
	self.CurTalking[id] = nil

	XYZ_Voice:ResizePanel()
end

function XYZ_Voice:talkingCount()
	local count = 0
	for k, v in pairs(self.CurTalking) do
		count = count + 1
	end
	return count
end

function XYZ_Voice:GetTalking()
	return self.CurTalking
end

function XYZ_Voice:ResizePanel()
	if self.Panel then
		local count = self:talkingCount()
		self.Panel:SetTall(80*(math.ceil(count/3)))
		self.Panel.Shell:SetSize(self.Panel:GetWide()-5, self.Panel:GetTall()-10)
		self.Panel.Shell.List:SetSize(self.Panel.Shell:GetWide(), self.Panel.Shell:GetTall())
	end
end

hook.Add("PlayerStartVoice", "xyz_voice_chat_start", function(ply)
	hook.Remove("Think", "DarkRP_chatRecipients")
	hook.Remove("HUDPaint", "DarkRP_DrawChatReceivers")
	ply.DRPIsTalking = nil
	if ( IsValid( g_VoicePanelList ) ) then
		g_VoicePanelList:SetVisible( false )
	end

	timer.Simple(0,function()
		hook.Remove("Think", "DarkRP_chatRecipients")
		hook.Remove("HUDPaint", "DarkRP_DrawChatReceivers")
		if not IsValid(ply) then return end
		ply.DRPIsTalking = nil
	end)

	if not XYZSettings.GetSetting("voicechat_show_hud", true) then return end

	if not XYZ_Voice.Panel then
		XYZ_Voice.Panel = vgui.Create("DFrame")
		XYZ_Voice.Panel:SetSize(250, 80)
		XYZ_Voice.Panel:SetTitle("")
		XYZ_Voice.Panel:ShowCloseButton(false)
		XYZ_Voice.Panel:SetPos(ScrW()-XYZ_Voice.Panel:GetWide()-10, (ScrH()*0.7)-XYZ_Voice.Panel:GetTall())
		XYZ_Voice.Panel.Paint = function(self, w, h)
			draw_box(0, 0, 0, w, h, background)
		end

		XYZ_Voice.Panel.Shell = vgui.Create("DPanel", XYZ_Voice.Panel)
		XYZ_Voice.Panel.Shell:SetPos(5, 5)
		XYZ_Voice.Panel.Shell:SetSize(XYZ_Voice.Panel:GetWide()-5, XYZ_Voice.Panel:GetTall()-15)
		XYZ_Voice.Panel.Shell.Paint = function(self, w, h)
			XYZUI.DrawShadowedBox(0, 0, w, h)
		end

		XYZ_Voice.Panel.Shell.List = vgui.Create("DIconLayout", XYZ_Voice.Panel.Shell)
		XYZ_Voice.Panel.Shell.List:SetSize(XYZ_Voice.Panel.Shell:GetWide(), XYZ_Voice.Panel.Shell:GetTall()-5)
		XYZ_Voice.Panel.Shell.List:SetSpaceY(5)
		XYZ_Voice.Panel.Shell.List:SetSpaceX(5)
	end

	XYZ_Voice:AddPlayer(ply)
end)

hook.Add("PlayerEndVoice", "xyz_voice_chat_end", function(ply)
	ply.DRPIsTalking = nil
	timer.Simple(0,function()
		if not IsValid(ply) then return end
		ply.DRPIsTalking = nil
	end)

	if not XYZSettings.GetSetting("voicechat_show_hud", true) then return end
	
	XYZ_Voice:RemovePlayer(ply)

	if XYZ_Voice:talkingCount() <= 0 then
		if XYZ_Voice.Panel then
			XYZ_Voice.Panel:Remove()
			XYZ_Voice.Panel = false
		end
	end
end)

net.Receive("xyz_voice_chat_leave_net", function()
	local id = net.ReadString()
	XYZ_Voice:RemoveID(id)
end)