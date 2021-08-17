XYZParty.Core.Parties = XYZParty.Core.Parties or {}
XYZParty.Core.Passwords = XYZParty.Core.Passwords or {}

hook.Add("PlayerSay", "xyz_party_chat_command", function(ply, msg)
	if string.lower(msg) == "!party" then
		if not table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then
			net.Start("xyz_party_open")
				net.WriteTable(XYZParty.Core.Parties)
			net.Send(ply)
		else
			XYZShit.Msg("Party", Color(100, 160, 40), "Use the government assigned partner system if you want to team up.", ply)
		end
	end
end)

local function getUsersParty(ply)
	for k, v in pairs(XYZParty.Core.Parties) do
		if v.leader == ply then
			return k, true
		end

		for n, m in pairs(v.members) do
			if m == ply then
				return k, false
			end
		end
	end

	return false
end

-- So we can use it in the quest system
XYZParty.Core.GetParty = getUsersParty

local function addtoParty(ply, key)
	local targetParty = XYZParty.Core.Parties[key]
	if not targetParty then return end

	XYZShit.Msg("Party", Color(100, 160, 40), ply:Name().." has joined the party.", targetParty.members)
	hook.Call("XYZPartyJoin", nil, ply, targetParty.name)

	table.insert(XYZParty.Core.Parties[key].members, ply)

	net.Start("xyz_party_data")
		net.WriteTable(XYZParty.Core.Parties[key])
	net.Send(targetParty.members)
end

local function removeFromParty(ply, key)
	local targetParty = XYZParty.Core.Parties[key]
	if not targetParty then return end

	for k, v in pairs(XYZParty.Core.Parties[key].members) do
		if v == ply then
			table.remove(XYZParty.Core.Parties[key].members, k)
			break
		end
	end

	XYZShit.Msg("Party", Color(100, 160, 40), ply:Name().." has left the party. (or was kicked)", targetParty.members)
	hook.Call("XYZPartyLeave", nil, ply, targetParty.name)

	net.Start("xyz_party_data")
		net.WriteTable(XYZParty.Core.Parties[key])
	net.Send(targetParty.members)

	net.Start("xyz_party_data_wipe")
	net.Send(ply)
end

local function endParty(key)
	local targetParty = XYZParty.Core.Parties[key]
	if not targetParty then return end

	XYZShit.Msg("Party", Color(100, 160, 40), "Your party has been disbanded.", targetParty.members)
	hook.Call("XYZPartyDisband", nil, targetParty.name)
	XYZParty.Core.Parties[key] = nil
	XYZParty.Core.Passwords[key] = nil

	net.Start("xyz_party_data_wipe")
	net.Send(targetParty.members)
end

local function startParty(ply, data)
	data.name = data.name or "My party"
	data.password = data.password or false
	data.color = data.color or Color(100, 255, 100)
	data.leader = ply
	data.members = {ply}

	if data.orgOnly then
		data.orgOnly = XYZ_ORGS.Core.Members[ply:SteamID64()]
		data.password = false
		data.name = XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].name
	end

	local key = table.insert(XYZParty.Core.Parties, data)
	XYZParty.Core.Passwords[key] = data.password
	if data.password then
		XYZParty.Core.Parties[key].password = true
	else
		XYZParty.Core.Parties[key].password = false
	end

	XYZShit.Msg("Party", Color(100, 160, 40), ply:Name().." has started a party called '"..data.name.."'.")
	hook.Call("XYZPartyStart", nil, ply, data.name)

	net.Start("xyz_party_data")
		net.WriteTable(XYZParty.Core.Parties[key])
	net.Send(ply)
end

local function editParty(partyKey, data)
	data.name = data.name or "My party"
	data.password = data.password or false
	data.color = data.color or Color(100, 255, 100)

	local targetParty = XYZParty.Core.Parties[partyKey]
	if not targetParty then return end

	targetParty.name = data.name
	targetParty.password = data.password
	targetParty.color = data.color

	if data.password then
		XYZParty.Core.Parties[partyKey].password = true
		XYZParty.Core.Passwords[partyKey] = data.password
	end

	net.Start("xyz_party_edit_share")
		net.WriteTable(data)
	net.Send(targetParty.members)
end


net.Receive("xyz_party_request", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_party_request", 1, ply) then return end

	local partyKey = net.ReadInt(32)
	local party = XYZParty.Core.Parties[partyKey]

	if table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then return end

	if not party then
		XYZShit.Msg("Party", Color(100, 160, 40), "Seems the party you're requesting doesn't exist anymore...", ply)
		return
	end

	if party.password then
		local recPassword = net.ReadString() or ""
		if not (recPassword == XYZParty.Core.Passwords[partyKey]) then
			XYZShit.Msg("Party", Color(100, 160, 40), "Seems the password you gave is wrong. Remember, it's case sensitive", ply)
			return
		end
	end

	if party.orgOnly then
		if not XYZ_ORGS.Core.Members[ply:SteamID64()] then
			XYZShit.Msg("Party", Color(100, 160, 40), "This is an org-only party. You are not in an organization.", ply)
			return
		else
			if party.orgOnly ~= XYZ_ORGS.Core.Members[ply:SteamID64()] then
				XYZShit.Msg("Party", Color(100, 160, 40), "This is an org-only party. You are not in the correct organization.", ply)
				return
			end
		end
	end

	local curParty, curPartyLeader = getUsersParty(ply)
	if curParty then
		XYZShit.Msg("Party", Color(100, 160, 40), "Leave your current party before you try to join a new one...", ply)
		return
	end

	addtoParty(ply, partyKey)
	XYZShit.Msg("Party", Color(100, 160, 40), "You have joined the party '"..party.name.."'", ply)
end)

net.Receive("xyz_party_leave", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_party_leave", 1, ply) then return end

	local plysParty, plyLeader = getUsersParty(ply)

	if plyLeader then
		endParty(plysParty)
	elseif plysParty then
		removeFromParty(ply, plysParty)
		XYZShit.Msg("Party", Color(100, 160, 40), "You have left the party.", ply)
	end
end)

net.Receive("xyz_party_create", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_party_create", 1, ply) then return end

	local data = net.ReadTable()
	data.name = string.sub(data.name, 0, 20) or "My party"
	if not data.password or (data.password == "") then
		data.password = false
	end
	data.color = data.color or Color(100, 255, 100)

	if table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then return end

	local curParty, curPartyLeader = getUsersParty(ply)
	if curParty then
		XYZShit.Msg("Party", Color(100, 160, 40), "Leave your current party before you try to start a new one...", ply)
		return
	end

	startParty(ply, data)
end)


net.Receive("xyz_party_kick", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_party_kick", 1, ply) then return end
	
	local target = net.ReadEntity()
	if target == ply then return end

	local plysParty, plyLeader = getUsersParty(ply)

	if not plyLeader then return end

	local kickable = false
	for k, v in pairs(XYZParty.Core.Parties[plysParty].members) do
		if v == target then kickable = true break end
	end
	if not kickable then return end
	XYZShit.Msg("Party", Color(100, 160, 40), "You have been kicked from the party.", target)
	removeFromParty(target, plysParty)
end)

hook.Add("OnPlayerChangedTeam", "xyz_party_team_change", function(ply, old, new)
	if table.HasValue(XYZShit.Jobs.Government.Police, new) then
		local plysParty, plyLeader = getUsersParty(ply)
		
		if plyLeader then
			XYZShit.Msg("Party", Color(100, 160, 40), "You have joined a job that does not support parties. Your party has been ended.", ply)
			endParty(plysParty)
		elseif plysParty then
			XYZShit.Msg("Party", Color(100, 160, 40), "You have joined a job that does not support parties. You have been removed from the party.", ply)
			removeFromParty(ply, plysParty)
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "xyz_party_no_team_damange", function(victim, attacker)
	if not attacker then return end
	if not IsValid(attacker) then return end
	if not attacker:IsPlayer() then return end
	if not IsValid(attacker:GetActiveWeapon()) then return end
	
	if attacker:GetActiveWeapon():GetClass() == "xyz_suicide_vest" then return end

	local plysParty, plyLeader = getUsersParty(attacker)
	local party = XYZParty.Core.Parties[plysParty]

	if party then
		if table.HasValue(party.members, victim) then
			return false
		end
	end
end)

hook.Add("PlayerDisconnected", "xyz_party_team_change", function(ply)
	local plysParty, plyLeader = getUsersParty(ply)
	
	if plyLeader then
		endParty(plysParty)
	elseif plysParty then
		removeFromParty(ply, plysParty)
	end
end)

hook.Add("PlayerSay", "xyz_party_chat", function(ply, msg)
	if string.sub(string.lower(msg), 1, 3) == "!p " then
		local plysParty, plyLeader = getUsersParty(ply)
		if not plysParty then return end

		net.Start("xyz_party_chat")
			net.WriteEntity(ply)
			net.WriteString(string.sub(msg, 4))
		net.Send(XYZParty.Core.Parties[plysParty].members)
		return ""
	end
end)

net.Receive("xyz_party_ping_send", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_party_ping_send", 1, ply) then return end

	if ply:GetActiveWeapon() and (ply:GetActiveWeapon():GetClass() == "weapon_ziptied") then return end 

	local curParty, curPartyLeader = getUsersParty(ply)
	if not curParty then return end

	local targetParty = XYZParty.Core.Parties[curParty]
	if not targetParty then return end

	local pingPos = net.ReadVector()
	if not pingPos then return end

	net.Start("xyz_party_ping_broadcast")
		net.WriteEntity(ply)
		net.WriteVector(pingPos)
	net.Send(targetParty.members)
end)

net.Receive("xyz_party_edit", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_party_edit", 1, ply) then return end

	local plysParty, plyLeader = getUsersParty(ply)

	if not plyLeader then return end

	local data = net.ReadTable()
	data.name = string.sub(data.name, 0, 20) or "My party"
	if not data.password or (data.password == "") then
		data.password = false
	end
	data.color = data.color or Color(100, 255, 100)

	editParty(plysParty, data)
end)