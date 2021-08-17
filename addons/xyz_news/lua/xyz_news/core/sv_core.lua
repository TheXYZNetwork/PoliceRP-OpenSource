function NewsSystem.Core.StartStreaming(ply)
	if NewsSystem.Data.IsLive then return end

	NewsSystem.Data.IsLive = true
	NewsSystem.Data.CameraMan = ply

	Quest.Core.ProgressQuest(ply, "news", 2)
	for k, v in ipairs(team.GetPlayers(TEAM_NEWSR)) do
		Quest.Core.ProgressQuest(v, "news", 5)
	end

	net.Start("NewsSystem:Stream:State")
		net.WriteBool(NewsSystem.Data.IsLive)
		net.WriteEntity(ply)
	net.Broadcast()
end


function NewsSystem.Core.StopStreaming()
	if NewsSystem.Data.IsLive == false then return end

	if NewsSystem.Data.CameraMan then
		Quest.Core.ProgressQuest(NewsSystem.Data.CameraMan, "news", 3)
	end

	NewsSystem.Data.IsLive = false
	NewsSystem.Data.CameraMan = nil


	net.Start("NewsSystem:Stream:State")
		net.WriteBool(NewsSystem.Data.IsLive)
	net.Broadcast()
end


net.Receive("NewsSystem:News:Set", function(_, ply)
	if XYZShit.CoolDown.Check("NewsSystem:News:Set", 2, ply) then return end
	if not (ply:GetActiveWeapon():GetClass() == "xyz_news_camera") then return end

	local title = net.ReadString()
	local desc = net.ReadString()

	NewsSystem.Data.Title = title
	NewsSystem.Data.Desc = desc

	net.Start("NewsSystem:News:Update")
		net.WriteString(title)
		net.WriteString(desc)
	net.Broadcast()
end)

hook.Add("PlayerCanHearPlayersVoice", "NewsSystem:Broadcast", function(listener, talker)
	if not NewsSystem.Data.IsLive then return end

	if talker:GetPos():DistToSqr(NewsSystem.Data.CameraMan:GetPos()) > NewsSystem.Config.TalkingDistance then return end

	local withinView = false
	for k, v in pairs(NewsSystem.ScreenCache) do
		if listener:GetPos():DistToSqr(v:GetPos()) < NewsSystem.Config.StartDistance then
			withinView = true
			break
		end
	end

	-- We're not within view to care to render anything
	if not withinView then return end

	return true, false
end)

-- Yoinked from the wiki https://wiki.facepunch.com/gmod/Global.AddOriginToPVS
hook.Add("SetupPlayerVisibility", "NewsSystem:UpdateRT", function(pPlayer, pViewEntity)
	if not NewsSystem.Data.IsLive then return end
	if not IsValid(NewsSystem.Data.CameraMan) then return end

	AddOriginToPVS(NewsSystem.Data.CameraMan:GetPos())
end)