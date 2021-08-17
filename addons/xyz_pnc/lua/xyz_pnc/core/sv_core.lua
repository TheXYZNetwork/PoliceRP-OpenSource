local pncInfoPress = {}

local function openPNC(ply)
	if not IsValid(ply:GetVehicle()) then
		XYZShit.Msg("PNC", PNC.Config.Color, "You need to be in a vehicle to use the PNC", ply)
	return end
	if not PNC.Config.AllowedVehicles[ply:GetVehicle():GetVehicleClass()] then 
		XYZShit.Msg("PNC", PNC.Config.Color, "This vehicle is not supported", ply)
	return end
	net.Start("xyz_pnc_open")
	net.Send(ply)
	return ""
end

hook.Add("PlayerSay", "xyzPNCCommands", function(pSender, sText)
	if string.sub(sText, 1, 4) == "!pnc" then
		openPNC(pSender)
	end
end)

concommand.Add("xyz_open_pnc", function(ply)
    openPNC(ply)
end, nil, "Opens the PNC")

function PNC.validateAccess(ply)
	if IsValid(ply:GetVehicle()) then
		if PNC.Config.AllowedVehicles[ply:GetVehicle():GetVehicleClass()] then
			return true
		end
	elseif IsValid(ply:GetActiveWeapon()) then
		if (ply:GetActiveWeapon():GetClass() == "xyz_pnc_tablet") then
			return true
		end
	end

	return false
end

net.Receive("xyz_pnc_search", function(_, ply)
	if not PNC.validateAccess(ply) then return end
	if ply.PNCCoolDown and ply.PNCCoolDown > CurTime() then return end

	local searchQ = net.ReadString()
	if string.len(searchQ) < 3 then return end
	local matchedPlayer = PNC.find(searchQ)
	ply.PNCCoolDown = CurTime() + 1
	if matchedPlayer then 
		local licensed = isnumber(licensedUsers[matchedPlayer:SteamID64()])
		local points = licensedUsers[matchedPlayer:SteamID64()] or 0
		net.Start("xyz_pnc_search")
			net.WriteEntity(matchedPlayer)
			net.WriteBool(licensed)
			net.WriteEntity(matchedPlayer.currentVehicle or NULL)
			net.WriteTable((IsValid(matchedPlayer.currentVehicle)) and PNC.Core.StolenVehicles[matchedPlayer.currentVehicle:EntIndex()] or {false})
			net.WriteUInt(points, 10)
		net.Send(ply)
	end
end)

net.Receive("xyz_pnc_markstolen", function(_, ply)
	if not XYZShit.IsGovernment(ply:Team()) then return end
	if not ply:isCP() then return end

	local target = net.ReadEntity()
	if IsValid(target.currentVehicle) then
		if PNC.Core.StolenVehicles[target.currentVehicle:EntIndex()] then
			PNC.Core.StolenVehicles[target.currentVehicle:EntIndex()] = nil
			XYZShit.Msg("PNC", PNC.Config.Color, "Your vehicle has been unmarked as stolen", target)
			XYZShit.Msg("PNC", PNC.Config.Color, "You have unmarked this vehicle as stolen", ply)
		else
			PNC.Core.StolenVehicles[target.currentVehicle:EntIndex()] = {true, ply}
			XYZShit.Msg("PNC", PNC.Config.Color, "Your vehicle has been marked as stolen", target)
			XYZShit.Msg("PNC", PNC.Config.Color, "You have marked this vehicle as stolen", ply)
		end
	end
end)

hook.Add("EntityRemoved", "pnc_remove_stolen_veh", function(ent)
	if PNC.Core.StolenVehicles[ent:EntIndex()] then
		PNC.Core.StolenVehicles[ent:EntIndex()] = nil
	end
end)

net.Receive("xyz_pnc_arrests", function(_, ply)
	if not PNC.validateAccess(ply) then return end

	local target = net.ReadEntity()
	net.Start("xyz_pnc_arrests")
	net.WriteTable(PNC.Core.Arrests[target:SteamID64()] or {})
	net.WriteEntity(target)
	net.Send(ply)
end)

net.Receive("xyz_pnc_tickets", function(_, ply)
	if not PNC.validateAccess(ply) then return end

	local target = net.ReadEntity()
	net.Start("xyz_pnc_tickets")
	net.WriteTable(PNC.Core.Tickets[target:SteamID64()] or {})
	net.WriteEntity(target)
	net.Send(ply)
end)

net.Receive("xyz_pnc_vehicles", function(_, ply)
	if not PNC.validateAccess(ply) then return end

	local target = net.ReadEntity()
	net.Start("xyz_pnc_vehicles")
	net.WriteTable(CarDealer.Vehicles[ply:SteamID64()])
	net.WriteEntity(target)
	net.Send(ply)
end)

function PNC.find(name)
	local players = player.GetAll()
	for k, v in pairs(players) do
		if string.find(string.lower(v:Nick()), string.lower(name)) ~= nil then
			return v
		end
	end
end


PNC.Core.ActivePatrols = PNC.Core.ActivePatrols or {}

net.Receive("xyz_pnc_patrol_start", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_patrol_start", 1, ply) then return end
	if not XYZShit.IsGovernment(ply:Team()) then return end
	if not ply:isCP() then return end
	if PNC.Core.ActivePatrols[ply:SteamID64()] then return end

	local isFootPatrol = true
	if IsValid(ply:GetVehicle()) then 
		if PNC.Config.AllowedVehicles[ply:GetVehicle():GetVehicleClass()] then
			isFootPatrol = false
		end
	end

	PNC.Core.ActivePatrols[ply:SteamID64()] = {}
	PNC.Core.ActivePatrols[ply:SteamID64()].current = 1
	PNC.Core.ActivePatrols[ply:SteamID64()].pads = {}
	PNC.Core.ActivePatrols[ply:SteamID64()].start = CurTime()
	PNC.Core.ActivePatrols[ply:SteamID64()].foot = isFootPatrol

	local pads = {}
	if isFootPatrol then
		for k, v in pairs(PNC.FootPlatforms) do
			table.insert(pads, k)
		end
	else
		for k, v in pairs(PNC.Platforms) do
			table.insert(pads, k)
		end
	end

	for i=1, 5 do
		local padKey, tblKey = table.Random(pads)
		if isFootPatrol then
			table.insert(PNC.Core.ActivePatrols[ply:SteamID64()].pads, PNC.FootPlatforms[padKey])
		else
			table.insert(PNC.Core.ActivePatrols[ply:SteamID64()].pads, PNC.Platforms[padKey])
		end
		pads[tblKey] = nil
	end


	-- We do this as clients often doesn't have ents correctly set up, or even loaded.
	local clientTable = {}
	for k, v in pairs(PNC.Core.ActivePatrols[ply:SteamID64()].pads) do
		clientTable[k] = {name = v.name, pos = v:GetPos()}
	end

	net.Start("xyz_pnc_patrol_send")
		net.WriteTable(clientTable)
	net.Send(ply)

	if PNC.Core.ActivePatrols[ply:SteamID64()].foot then
		XYZShit.Msg("PNC", PNC.Config.Color, "You have started a foot patrol! Entering a vehicle will void this patrol, however it pays more. Your first waypoint is: "..clientTable[1].name, ply)
	else
		XYZShit.Msg("PNC", PNC.Config.Color, "You have started a patrol! Your first waypoint is: "..clientTable[1].name, ply)
	end
end)

net.Receive("xyz_pnc_patrol_stop", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_patrol_stop", 1, ply) then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end

	PNC.Core.EndPatrol(ply)
end)

net.Receive("xyz_pnc_patrol_share", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_patrol_share", 1, ply) then return end
	if not XYZShit.IsGovernment(ply:Team()) then return end
	if not ply:isCP() then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end

	if not (PNC.Core.ActivePatrols[ply:SteamID64()].current == 1) then
		XYZShit.Msg("PNC", PNC.Config.Color, "You can only share a fresh patrol!", ply)
		return
	end

	local partner = ply.currentPartner
	if not IsValid(partner) then return end
	if PNC.Core.ActivePatrols[partner:SteamID64()] then
		XYZShit.Msg("PNC", PNC.Config.Color, "Your partner already has an active patrol, they should end their patrol first!", ply)
		return
	end

	-- Clone the patrol
	PNC.Core.ActivePatrols[partner:SteamID64()] = table.Copy(PNC.Core.ActivePatrols[ply:SteamID64()])
	XYZShit.Msg("PNC", PNC.Config.Color, "Your partner has shared their patrol with you.", partner)
	XYZShit.Msg("PNC", PNC.Config.Color, "You have shared your patrol with your partner.", ply)


	-- Network the new patrol positions
	local clientTable = {}
	for k, v in pairs(PNC.Core.ActivePatrols[partner:SteamID64()].pads) do
		clientTable[k] = {name = v.name, pos = v:GetPos()}
	end
	net.Start("xyz_pnc_patrol_send")
		net.WriteTable(clientTable)
	net.Send(partner)
end)


function PNC.Core.EndPatrol(ply, finished)
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end

	if finished then 
		if PNC.Core.ActivePatrols[ply:SteamID64()].foot then
			ply:addMoney(PNC.Config.FootPatrolFinishMoney)
			XYZShit.Msg("PNC", PNC.Config.Color, "You have completed a foot patrol, "..DarkRP.formatMoney(PNC.Config.FootPatrolFinishMoney).." has been rewarded to you!", ply)
			XYZShit.Webhook.Post("patrol_log_"..(PNC.Config.DepartmentToLog[RPExtraTeams[ply:Team()].category] or "pd"), nil, ply:Name().." ("..ply:SteamID64()..") has completed a foot patrol. It took them "..string.NiceTime(CurTime() - PNC.Core.ActivePatrols[ply:SteamID64()].start).."!")
			Quest.Core.ProgressQuest(ply, "boys_in_blue", 3)
		else
			ply:addMoney(PNC.Config.PatrolFinishMoney)
			XYZShit.Msg("PNC", PNC.Config.Color, "You have completed a patrol, "..DarkRP.formatMoney(PNC.Config.PatrolFinishMoney).." has been rewarded to you!", ply)
			XYZShit.Webhook.Post("patrol_log_"..(PNC.Config.DepartmentToLog[RPExtraTeams[ply:Team()].category] or "pd"), nil, ply:Name().." ("..ply:SteamID64()..") has completed a patrol. It took them "..string.NiceTime(CurTime() - PNC.Core.ActivePatrols[ply:SteamID64()].start).."!")
			Quest.Core.ProgressQuest(ply, "boys_in_blue", 4)
		end


	else
		XYZShit.Msg("PNC", PNC.Config.Color, "You failed to complete your patrol. You can start another one at any time!", ply)
	end

	PNC.Core.ActivePatrols[ply:SteamID64()] = nil

	net.Start("xyz_pnc_patrol_end")
	net.Send(ply)
end


hook.Add("PlayerDeath", "pnc_patrol_die", function(ply)
	if not IsValid(ply) then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end

	PNC.Core.EndPatrol(ply)
end)
hook.Add("OnPlayerChangedTeam", "pnc_patrol_team", function(ply, old, new)
	if not IsValid(ply) then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end
	
	PNC.Core.EndPatrol(ply)
end)

hook.Add("PlayerDisconnected", "pnc_patrol_leave", function(ply)
	if not IsValid(ply) then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end
	
	PNC.Core.EndPatrol(ply)
end)

hook.Add("PlayerEnteredVehicle", "pnc_patrol_vehicle", function(ply)
	if not IsValid(ply) then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()] then return end
	if not PNC.Core.ActivePatrols[ply:SteamID64()].foot then return end
	PNC.Core.EndPatrol(ply)
end)

hook.Add("PlayerButtonDown", "PNCInfoDown", function(ply, button)
	if button == KEY_G and IsValid(ply:GetVehicle()) and PNC.Config.AllowedVehicles[ply:GetVehicle():GetVehicleClass()] then
		-- Start a trace to see vehicle in front
		local veh = ply:GetVehicle()
		local ltw = veh:LocalToWorld(PNC.Config.TraceStart)
		local tr = util.TraceLine({
			start = ltw,
			endpos = veh:LocalToWorld(PNC.Config.TraceEnd),
			filter = {ply:GetVehicle()}
		})
		if IsValid(tr.Entity) and tr.Entity:IsVehicle() and (CarDealer.Config.Cars[tr.Entity:GetVehicleClass()] ~= nil) then
			if (ply:GetVehicle():GetPos():Distance(tr.Entity:GetPos()) <= PNC.Config.TraceScanDistance) then
				sound.Play("npc/turret_floor/click1.wav", ply:GetVehicle():GetPos(), 95)
				pncInfoPress[ply:SteamID64()] = CurTime() + 2
				XYZShit.Msg("PNC", PNC.Config.Color, "You have a vehicle in front of you! Hold for 2 seconds to get reading", ply)
			end
			
			if not PNC.Config.SpeedChecker[tr.Entity:GetVehicle():GetVehicleClass()] then return end

			XYZShit.Msg("PNC", PNC.Config.Color, "This vehicle is currently going "..math.Round(tr.Entity:VC_getSpeedKmH()*0.6).." MPH!", ply)
		end
	end
end)

hook.Add("PlayerButtonUp", "PNCInfoUp", function(ply, button)
	if button == KEY_G and pncInfoPress[ply:SteamID64()] and IsValid(ply:GetVehicle()) and PNC.Config.AllowedVehicles[ply:GetVehicle():GetVehicleClass()] then
		if CurTime() < pncInfoPress[ply:SteamID64()] then 
			pncInfoPress[ply:SteamID64()] = nil 
			return
		end
		pncInfoPress[ply:SteamID64()] = nil

		-- Start a trace to see vehicle in front
		local veh = ply:GetVehicle()
		local ltw = veh:LocalToWorld(PNC.Config.TraceStart)
		local tr = util.TraceLine({
			start = ltw,
			endpos = veh:LocalToWorld(PNC.Config.TraceEnd),
			filter = {veh}
		})
		if IsValid(tr.Entity) and tr.Entity:IsVehicle() and CarDealer.Config.Cars[tr.Entity:GetVehicleClass()] then
			local owner = tr.Entity:getDoorOwner()

			sound.Play("npc/turret_floor/retract.wav", ply:GetVehicle():GetPos(), 95)
			net.Start("xyz_pnc_select")
				net.WriteEntity(tr.Entity)
				net.WriteBool(isnumber(licensedUsers[owner:SteamID64()]))
			net.Send(ply)
			XYZShit.Msg("PNC", PNC.Config.Color, string.format(
				[[Vehicle: %s
				Marked as Stolen: %s
				Owner: %s
				Owner Wanted: %s
				Owner Has License: %s]],
				CarDealer.Config.Cars[tr.Entity:GetVehicleClass()].name,
				(tr.Entity.markedstolen and "Yes" or "No"),
				(owner and owner:Name() or "None"),
				(owner and owner:isWanted()) and owner:getWantedReason() or "No",
				isnumber(licensedUsers[owner:SteamID64()]) and "Yes" or "No"
			), ply)
		end
	end
end)


function getGov()
	local gov = {}
	for k, v in pairs(player.GetAll()) do
		if not (XYZShit.Jobs.Government.List[v:Team()]) then continue end
		table.insert(gov, v)
	end
	return gov
end

net.Receive("xyz_pnc_request_prisonert", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_request_prisonert", 5, ply) then return end
	if not table.HasValue(XYZShit.Jobs.Government.All, ply:Team()) then return end
	if not ply:isCP() then return end
        
    local gov = getGov()

	if PNC.Core.PrisonerTransportRequests[ply:SteamID64()] then
		PNC.Core.PrisonerTransportRequests[ply:SteamID64()] = nil
		net.Start("xyz_pnc_cancel_prisonert")
		net.WriteEntity(ply)
		net.Send(gov)
		XYZShit.Msg("PNC", PNC.Config.Color, "You have cancelled the prisoner transport request", ply)
		if timer.Exists(ply:SteamID64().."_prisonert") then 
			timer.Destroy(ply:SteamID64().."_prisonert")
		end
		return
	end
        
    local pos = ply:GetPos()

	net.Start("xyz_pnc_request_prisonert")
	net.WriteVector(pos)
	net.WriteEntity(ply)
	net.Send(gov)
    
    PNC.Core.PrisonerTransportRequests[ply:SteamID64()] = pos
    XYZShit.Msg("PNC", PNC.Config.Color, "You have created a prisoner transport request. Request one again to cancel", ply)

	timer.Create(ply:SteamID64().."_prisonert", PNC.Config.PrisonerTransportRequestTime, 1, function()
		PNC.Core.PrisonerTransportRequests[ply:SteamID64()] = nil
		net.Start("xyz_pnc_cancel_prisonert")
		net.WriteEntity(ply)
		net.Send(gov)
		XYZShit.Msg("PNC", PNC.Config.Color, "Your prisoner transport request has expired", ply)
	end)
end)

net.Receive("xyz_pnc_request_stolen_vehicles", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_request_stolen_vehicles", 5, ply) then return end
	if not table.HasValue(XYZShit.Jobs.Government.All, ply:Team()) then return end
	if not ply:isCP() then return end

	net.Start("xyz_pnc_request_stolen_vehicles")
	net.WriteTable(PNC.Core.StolenVehicles)
	net.Send(ply)
end)

net.Receive("xyz_pnc_reports", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_reports", 5, ply) then return end
	if not table.HasValue(XYZShit.Jobs.Government.All, ply:Team()) then return end
	if not ply:isCP() then return end

	net.Start("xyz_pnc_reports")
	net.WriteTable(PNC.Core.Reports)
	net.Send(ply)
end)

net.Receive("xyz_pnc_add_report", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_pnc_add_report", 65, ply) then return end
	if not table.HasValue(XYZShit.Jobs.Government.All, ply:Team()) then return end
	if not ply:isCP() then return end

	local title = net.ReadString()
	local body = net.ReadString()

	if not title or not body then return end
	if title == "" or body == "" then return end

	local id = #PNC.Core.Reports+1
	
	PNC.Core.Reports[id] = {
		["time"] = os.time(),
		["title"] = title,
		["body"] = body,
	}

	XYZShit.Msg("PNC", PNC.Config.Color, "Added report #"..id, ply)
	xLogs.Log(xLogs.Core.Player(ply).." has made a report with the title "..xLogs.Core.Color(title, Color(0, 200, 200)), "PNC")
end)