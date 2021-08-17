net.Receive("DJSet:AddToQueue", function(_, ply)
	if XYZShit.CoolDown.Check("DJSet:AddToQueue", 5, ply) then return end

	local set = net.ReadEntity()
	if set:Getowning_ent() ~= ply then return end
	if set:GetClass() ~= "xyz_dj_set" then return end

	local url = net.ReadString()

	HTTP({
		['method'] = 'post',
		['url'] = 'http://music.ntwrk.xyz/add-to-queue',
		['body'] = util.TableToJSON({
			['key'] = 'SECRETKEY!',
			['url'] = url,
		}),
		['type'] = 'application/json',
		['success'] = function(_, body)
			local jbody = util.JSONToTable(body)
			if not jbody then XYZShit.Msg("DJ", XYZDJ.Config.Color, "Error adding queue", ply) return end
			if jbody.error then XYZShit.Msg("DJ", XYZDJ.Config.Color, "Error adding to queue, "..jbody.error, ply) return end
			XYZShit.Msg("DJ", XYZDJ.Config.Color, "Added to queue", ply)
		end
	})
end)

net.Receive("DJSet:Play", function(_, ply)
	if XYZShit.CoolDown.Check("DJSet:Play", 60, ply) then return end

	local set = net.ReadEntity()
	if set:Getowning_ent() ~= ply then return end
	if set:GetClass() ~= "xyz_dj_set" then return end

	HTTP({
		['method'] = 'post',
		['url'] = 'http://music.ntwrk.xyz/play',
		['body'] = util.TableToJSON({
			['key'] = 'SECRETKEY!',
		}),
		['type'] = 'application/json',
		['success'] = function(_, body)
			local jbody = util.JSONToTable(body)
			if not jbody then XYZShit.Msg("DJ", XYZDJ.Config.Color, "Error playing") return end
			if jbody.error then XYZShit.Msg("DJ", XYZDJ.Config.Color, "Error playing, "..jbody.error) return end
			XYZShit.Msg("DJ", XYZDJ.Config.Color, "Playing queue", ply)
		end
	})
end)

local function reset()
	HTTP({
		['method'] = 'post',
		['url'] = 'http://music.ntwrk.xyz/stop',
		['body'] = util.TableToJSON({
			['key'] = 'SECRETKEY!',
		}),
		['type'] = 'application/json'
	})
end
hook.Add("OnPlayerChangedTeam", "xyz_dj_job", function(ply, before, after)
	if before == TEAM_DJ and team.NumPlayers(TEAM_DJ) == 0 then
		reset()
	end
end)

hook.Add("PlayerDisconnected", "xyz_dj_dc", function(ply)
	if ply:Team() == TEAM_DJ and team.NumPlayers(TEAM_DJ) == 0 then
		reset()
	end
end)