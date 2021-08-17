hook.Add("PlayerSay", "xSitsChatTrigger", function(ply , text)
	if string.sub(text, 1, 1) == "@" and not (ply:HasPower(xAdmin.Config.AdminChat)) then
		xSits.OpenSit(ply, string.TrimLeft(text, "@"))
		return ""
	elseif string.sub(text, 1, 10) == "!sitcancel" then
		local hasSit, sitData = xSits.HasOpenSit(ply)
		if not hasSit then return end -- Check if they have a sit
		if sitData.claimer then return end -- Check if it's already been claimed

		xSits.CloseSit(ply, sitData.key)

		local staffOnline = {} -- I know, doing this loop twice :/
		for k, v in pairs(player.GetAll()) do
			if XYZShit.Staff.All[v:GetUserGroup()] then
				table.insert(staffOnline, v)
			end
		end
		net.Start("xSitsSitClaimed")
			net.WriteString(ply:SteamID64())
		net.Send(staffOnline)
		return ""
	elseif string.sub(text, 1, 4) == "!sit" then
		xSits.OpenSit(ply, string.TrimLeft(text, "!sit"))
		return ""
	elseif string.sub(text, 1, 3) == "///" then
		xSits.OpenSit(ply, string.TrimLeft(text, "///"))
		return ""
	end	
end)

local function buildsuffix(i)
	if i == 1 then
		return i.."st"
	elseif i == 2 then
		return i.."nd"
	elseif i == 3 then
		return i.."rd"
	end

	return i.."th"
end

function xSits.HasOpenSit(ply)
	for k, v in pairs(xSits.OpenSits) do
		if v.creator == ply then
			return true, v
		end
	end

	return false
end

function xSits.CloseSit(ply, key)
	if key then
		xSits.OpenSits[key] = nil
		timer.Remove("xSits:Timedout:"..key)
		return true
	end
	for k, v in pairs(xSits.OpenSits) do
		if v.creator == ply then
			xSits.OpenSits[k] = nil
			timer.Remove("xSits:Timedout:"..k)
			return true
		end
	end
	return false
end

-- Format:
-- creator = ply (creator)
-- reason = string (the ticket reason)
-- claimer = nil or ply (the person who claimed the ticket)
-- created = int (created time)
-- rowID = int (The SQL row ID)
-- key = int (The sub table's key)
xSits.OpenSits = {}--xSits.OpenSits or {}

function xSits.OpenSit(ply, reason)
	if xSits.HasOpenSit(ply) then
		XYZShit.Msg("xSits", Color(46, 170, 200), "You already have an open sit request!", ply)
		return
	end

	local staffOnline = {} -- I know, doing this loop twice :/
	for k, v in pairs(player.GetAll()) do
		if XYZShit.Staff.All[v:GetUserGroup()] then
			table.insert(staffOnline, v)
		end
	end

	if #staffOnline <= 0 then
		XYZShit.Msg("xSits", Color(46, 170, 200), "There are currently no staff online to take your sit...", ply)
		return
	elseif (#staffOnline <= 1) and XYZShit.Staff.All[ply:GetUserGroup()] then
		XYZShit.Msg("xSits", Color(46, 170, 200), "You are currently the only staff member online...", ply)
		return
	end

	local reason = string.TrimLeft(reason, " ")

	local key = table.insert(xSits.OpenSits, {creator = ply, reason = reason, created = os.time()})
	xSits.OpenSits[key].key = key

	xSits.Database.LogSitCreation(ply, reason, staffOnline, function(data)
		xSits.OpenSits[key].rowID = data[1]["LAST_INSERT_ID()"]
	end)
	XYZShit.Msg("xSits", Color(46, 170, 200), "You have requested a sit. You are currently "..buildsuffix(#xSits.OpenSits).." in the queue. You can cancel this sit before it's claimed with !sitcancel", ply)

	net.Start("xSitsSitOpened")
		net.WriteEntity(ply)
		net.WriteString(reason)
	net.Send(staffOnline)

	timer.Create("xSits:Timedout:"..key, xSits.Config.Timeout, 1, function()
		xSits.CloseSit(ply, key)
		if not IsValid(ply) then return end
		XYZShit.Msg("xSits", Color(46, 170, 200), "Your sit request has expired. If you still need assistance, please reopen your request.", ply)

		net.Start("xSitsSitClaimed")
			net.WriteString(ply:SteamID64())
		net.Send(staffOnline)
	end)
end

net.Receive("xSitsSitClaim", function(_, ply)
	if not XYZShit.Staff.All[ply:GetUserGroup()] then return end

	local target = net.ReadEntity()
	if not IsValid(target) then return end
	local hasSit, sitData = xSits.HasOpenSit(target)

	if not hasSit then return end
	if IsValid(sitData.claimer) then return end


	sitData.claimer = ply
	xSits.Database.UpdateSitClaimer(sitData.rowID, sitData.creator, sitData.claimer, sitData.created)
	timer.Remove("xSits:Timedout:"..sitData.key)

	local staffOnline = {} -- I know, doing this loop twice :/
	for k, v in pairs(player.GetAll()) do
		if XYZShit.Staff.All[v:GetUserGroup()] then
			table.insert(staffOnline, v)
		end
	end

	net.Start("xSitsSitClaimed")
		net.WriteString(target:SteamID64())
	net.Send(staffOnline)

	net.Start("xSitsSitYouClaimed")
		net.WriteEntity(sitData.creator)
		net.WriteString(sitData.reason)
	net.Send(ply)

	XYZShit.Msg("xSits", Color(46, 170, 200), "You have claimed the sit submitted by "..sitData.creator:Name(), ply)
	XYZShit.Msg("xSits", Color(46, 170, 200), ply:Name().." has claimed your sit!", sitData.creator)
end)

local pendingRating = {}
net.Receive("xSitsSitClose", function(_, ply)
	if not XYZShit.Staff.All[ply:GetUserGroup()] then return end

	local target = net.ReadEntity()
	if not IsValid(target) then return end

	local hasSit, sitData = xSits.HasOpenSit(target)
	if not hasSit then return end

	if sitData.rowID then
		pendingRating[sitData.rowID] = target
		net.Start("xSitsSitRequestRating")
			net.WriteInt(sitData.rowID, 32)
		net.Send(target)
	end

	xSits.CloseSit(target, sitData.key)
	XYZShit.Msg("xSits", Color(46, 170, 200), "Your sit has been closed!", target)
	XYZShit.Msg("xSits", Color(46, 170, 200), "You have closed the sit!", ply)
end)

net.Receive("xSitsSitRate", function(_, ply)
	local rowID = net.ReadInt(32)
	local rating = math.Clamp(net.ReadInt(4), 1, 5)
	if not pendingRating[rowID] then return end
	if not (pendingRating[rowID] == ply) then return end


	pendingRating[rowID] = nil
	xSits.Database.GiveRating(rowID, rating)
end)

hook.Add("PlayerDisconnected", "xSitsDisconnect", function(ply)
	local hadSit = xSits.CloseSit(ply)

	if hadSit then
		local staffOnline = {}
		for k, v in pairs(player.GetAll()) do
			if XYZShit.Staff.All[v:GetUserGroup()] then
				table.insert(staffOnline, v)
			end
		end
	
		net.Start("xSitsSitClaimed")
			net.WriteString(ply:SteamID64())
		net.Send(staffOnline)
	end
	
	for k, v in pairs(xSits.OpenSits) do
		if v.claimer == ply then
			XYZShit.Msg("xSits", Color(46, 170, 200), "The staff member running your sit has disconnected, your sit was closed as a result.", v.creator)
			xSits.CloseSit(v.creator, k)
			return
		end
	end
end)