hook.Add("PlayerInitialSpawn", "xAdminLoadPlayerRank", function(ply)
	xAdmin.Database.GetUsersGroup(ply:SteamID64(), function(data)
		if not data or not data[1] then
			xAdmin.Database.UpdateUsersGroup(ply:SteamID64(), xAdmin.Config.DefaultGroup)
			xAdmin.Users[ply:SteamID64()] = xAdmin.Config.DefaultGroup
		else
			xAdmin.Users[ply:SteamID64()] = data[1].rank
		end

		net.Start("xAdminNetworkIDRank")
			net.WriteString(ply:SteamID64())
			net.WriteString(xAdmin.Users[ply:SteamID64()])
		net.Broadcast()


		net.Start("xAdminNetworkExistingUsers")
			net.WriteTable(xAdmin.Users)
		net.Send(ply)

		if ply:HasPower(xAdmin.Config.AdminChat) then
			xAdmin.AdminChat[ply:SteamID64()] = ply
		end


		local commandCache = {}
		for k, v in pairs(xAdmin.Commands) do
			if ply:HasPower(v.power) then
				commandCache[v.command] = v.desc
			end
		end
		net.Start("xAdminNetworkCommands")
			net.WriteTable(commandCache)
		net.Send(ply)
	end)

	-- Incase they get banned when they are already loading, yeet them when they spawn in.
	timer.Simple(5, function() -- Timer is gay but server errors if you kick them instantly
		xAdmin.Database.IsBanned(ply:SteamID64(), function(data)
			if data[1] then
				if data[1]._end == 0 then
					ply:Kick(string.format(xAdmin.Config.BanFormat, data[1].admin, "Permanent", data[1].reason))
				elseif (data[1].start + data[1]._end) > os.time() then
					ply:Kick(string.format(xAdmin.Config.BanFormat, data[1].admin, string.NiceTime((data[1].start+data[1]._end)-os.time()), data[1].reason))
				end
			end
		end)
	end)
end)

hook.Add("PlayerDisconnected", "xAdminDisconnectPlayerRank", function(ply)
	xAdmin.Users[ply:SteamID64()] = nil
	xAdmin.AdminChat[ply:SteamID64()] = nil
end)

function xAdmin.Core.GetUser(info, admin)
	if info == "" then
		return nil
	end
	
	if IsValid(admin) then
		if info == "^" then
			return admin
		end
	end

	if IsValid(admin) then
		if info == "@" then
			local target = admin:GetEyeTrace().Entity
			if target:IsPlayer() then
				return target
			end
		end
	end

	local isID
	if not (util.SteamIDFrom64(info) == "STEAM_0:0:0") then
		isID = info
	else
		isID = util.SteamIDTo64(info)
	end
	if not (isID == "0") then
		return player.GetBySteamID64(isID)
	end


	info = string.Replace(info, "\"", "")
	for k, v in pairs(player.GetAll()) do
		if string.find(string.lower(v:Name()), string.lower(info), nil, true) then
			return v
		end
	end

	return nil
end

function xAdmin.Core.GetID64(info, admin)
	if IsValid(admin) then
		if info == "^" then
			return admin:SteamID64(), admin
		end
	end


	local isID
	if not (util.SteamIDFrom64(info) == "STEAM_0:0:0") then
		isID = info
	else
		isID = util.SteamIDTo64(info)
	end
	if not (isID == "0") then
		return isID, player.GetBySteamID64(isID)
	end

	info = string.Replace(info, "\"", "")
	for k, v in pairs(player.GetAll()) do
		if string.find(string.lower(v:Name()), string.lower(info)) then
			return v:SteamID64(), v
		end
	end

	return nil
end

function xAdmin.Core.FormatArguments(args)
	local startk, endk
	for k, v in pairs(args) do
		if (v[1] == "\"") then
			startk = k
		elseif (startk and v[#v] == "\"") then
			endk = k
			break
		end
	end

	if (startk and endk) then
		args[startk] = string.sub(table.concat(args, " ", startk, endk), 2, -2)
		local num = endk - startk
		for i=1, num do
			table.remove(args, startk + 1)
		end
		
		args = xAdmin.Core.FormatArguments(args)
	end

	for k, v in pairs(args) do
		if (v == "") or (v == " ") then
			table.remove(args, k)
		end
	end
	
	return args
end

function xAdmin.Core.CovertTime(time)
    time = tostring(time)
    
    local timeArray = string.ToTable(time)
    local timeLength = #timeArray

    if not tonumber(timeArray[timeLength]) then
        time = tonumber( table.concat( timeArray , "", 1, timeLength-1 ) )
        if !time then return end
        if timeArray[timeLength] == "h" then
            time = time *60
        elseif timeArray[timeLength] == "d" then
            time = time *60 *24
        elseif timeArray[timeLength] == "w" then
            time = time *60 *24 *7
        end
    else
        time = tonumber(table.concat(timeArray))
    end

    return time > 0 and time or 0
end

function xAdmin.Core.Msg(args, target)
	for k, v in pairs(args) do
		if istable(v) and v.isConsole then
			args[k]= v:Name()
			table.insert(args, k, Color(0, 0, 0))
			table.insert(args, k+2, Color(215, 215, 215))
		end
	end
	net.Start("xAdminChatMessage")
		net.WriteTable(args)
	if target then
		net.Send(target)
	else
		net.Broadcast()

		local log = ""
		local skip = false
		for k, v in pairs(args) do
			if skip then
				skip = false
				continue
			end 

			if not isstring(v) and IsValid(v) and v:IsPlayer() then
				log = log..xLogs.Core.Player(v)
			elseif IsColor(v) then
				log = log..xLogs.Core.Color(args[k+1], v)
				skip = true
			else
				log = log..v
			end
		end
		xLogs.Log(log, "xAdmin")
	end
end

xAdmin.Core.PendingFocusRequests = {}
function xAdmin.Core.GetFocus(ply, admin)
	net.Start("xAdminRequestFocus")
	net.Send(ply)

	xAdmin.Core.PendingFocusRequests[ply:SteamID64()] = admin
end
net.Receive("xAdminRequestFocus", function(_, ply)
	if not xAdmin.Core.PendingFocusRequests[ply:SteamID64()] then return end -- No request given

	local admin = xAdmin.Core.PendingFocusRequests[ply:SteamID64()]
	local focusState = net.ReadBool()

	xAdmin.Core.Msg({ply, " is currently "..(focusState and "" or "not ").."tabbed in!"}, admin)

	xAdmin.Core.PendingFocusRequests[ply:SteamID64()] = nil
end)

local function CheckAlts(steamid)
	http.Fetch("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=MYSTEAMKEY&format=json&steamid="..steamid.."&appid_playing=4000", function(body)
		local body = util.JSONToTable(body)
		if not body or not body.response or not body.response.lender_steamid then return end
		local lender = body.response.lender_steamid
		if lender == "0" then return end
		
		xAdmin.Database.IsBanned(lender, function(data)
			if data[1] and (((data[1].start + data[1]._end) > os.time()) or (data[1]._end == 0)) then
				game.KickID(util.SteamIDFrom64(steamid), string.format(xAdmin.Config.BanFormat, "Server", "Permanent", "Ban evasion"))
				
				XYZShit.Webhook.Post("wallofshame", xAdmin.Info.FullName, "Server banned "..steamid.." and the original banned account ("..lender..") permanently for Ban Evasion")
				xAdmin.Core.Msg({"Server has banned ", steamid, " for permanent with the reason: Ban evasion"})
				xAdmin.Database.CreateBan(steamid, "Unknown", "0", "Server", "Ban evasion", 0)
				xAdmin.Database.CreateBan(lender, "Unknown", "0", "Server", "Ban evasion", 0)
			else
                xAdmin.Database.DestroyBan(lender)
			end
		end)
	end)
end

hook.Add("CheckPassword", "xAdminCheckBanned", function(steamID64)
    xAdmin.Database.IsBanned(steamID64, function(data)
        if data[1] then
            if data[1]._end == 0 then
                game.KickID(util.SteamIDFrom64(steamID64), string.format(xAdmin.Config.BanFormat, data[1].admin, "Permanent", data[1].reason))
            elseif ((data[1].start + data[1]._end) > os.time()) then
                game.KickID(util.SteamIDFrom64(steamID64), string.format(xAdmin.Config.BanFormat, data[1].admin, string.NiceTime((data[1].start+data[1]._end)-os.time()), data[1].reason))
            else
                xAdmin.Database.DestroyBan(steamID64)
                return
			end
		else 
			CheckAlts(steamID64)
        end
    end)
end)