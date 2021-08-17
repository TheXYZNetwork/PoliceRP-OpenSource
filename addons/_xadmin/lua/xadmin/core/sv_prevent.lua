xAdmin.Prevent = {}
function xAdmin.Prevent.Post(type, user, msg, color, blockBan)
	local embed = {
		author = {
			name = user:Name() or "Unknown User",
			url = "https://thexyznetwork.xyz/lookup/"..user:SteamID64(),
			icon_url = "https://extra.thexyznetwork.xyz/steamProfileByID?id="..user:SteamID64()
		},
		title = type or "Detection Found",
		color = color or "368575",
		description = msg or "Unknown details"
	}

	XYZShit.Webhook.PostEmbed("anticheat", embed)

	if not blockBan then
--	if false then
		if XYZShit.CoolDown.Check("xAdmin:Anti-Cheat", 10, user) then return end

		XYZShit.Webhook.Post("wallofshame", xAdmin.Info.FullName, "Anti-Cheat banned "..string.gsub(user:Name(), "%@", "").." ("..user:SteamID64()..") permanently for triggering the anti-cheat.")
		xAdmin.Core.Msg({"Anti-Cheat has banned ", user:Name(), " permanently for triggering the anti-cheat."})
		xAdmin.Database.CreateBan(user:SteamID64(), user:Name(), "0", "Anti-Cheat", "Triggered Anti-Cheat", 0)
		user:Kick(string.format(xAdmin.Config.BanFormat, "Anti-Cheat", "Permanent", "Triggered Anti-Cheat"))
	end
end

local checked = {}
net.Receive("xAdminKnownAliases", function(_, ply)
	local foundUsers = net.ReadTable()
	if #foundUsers > 10 then
		xAdmin.Prevent.Post("Suspicious Response", ply, "Has given a large aliase list. **Size: "..#foundUsers.."**", nil, true)
		return
	end -- Not worth it as they're probably trying to exploit in some way :/

	local onlineStaff = {}
	for k, v in pairs(player.GetAll()) do
		if not v:HasPower(95) then continue end
		table.insert(onlineStaff, v)
	end

	for k, v in pairs(foundUsers) do
		if not istable(v) then
			xAdmin.Prevent.Post("Suspicious Response", ply, "Has given an invalid aliase. Table expected but not received...", nil, true)
			return
		end
		if not v.userid then
			xAdmin.Prevent.Post("Suspicious Response", ply, "Has given an invalid aliase. No userid provided in subtable...", nil, true)
			return
		end
		if v.userid == ply:SteamID64() then continue end

		xAdmin.Core.Msg({ply:Name(), " has joined with an alt of the ID: ", v.userid}, onlineStaff)

		xAdmin.Database.IsBanned(xAdmin.Database.Escape(v.userid), function(data)
			if not IsValid(ply) then return end
			if data[1] and (((data[1].start + data[1]._end) > os.time()) or (data[1]._end == 0)) then
				xAdmin.Prevent.Post("Ban Evasion", ply, "Suspected of ban evasion of account **"..v.userid.."**", nil, true)

				XYZShit.Webhook.Post("wallofshame", xAdmin.Info.FullName, "Server banned "..string.gsub(ply:Name(), "%@", "").." ("..ply:SteamID64()..") permanently for Ban Evasion of Account "..v.userid..".")
				xAdmin.Core.Msg({"Server has banned ", ply:Name(), " permanently for ban evasion."})
				xAdmin.Database.CreateBan(ply:SteamID64(), ply:Name(), "0", "Server", "Ban Evasion", 0)
		
				ply:Kick(string.format(xAdmin.Config.BanFormat, "Server", "Permanent", "Ban Evasion"))
			else
                xAdmin.Database.DestroyBan(lender)
			end
		end)
	end
end)

net.Receive("xAdminScanHit", function(_, ply)
	local type = net.ReadString()
	local cheat = net.ReadString()
	local item = net.ReadString()
	xAdmin.Prevent.Post("Suspicious Item ("..type..")", ply, "Has a suspicious "..type.." linked to a known cheat: **"..cheat.."**.\nThe detected "..type.." was: **"..item.."**")
end)