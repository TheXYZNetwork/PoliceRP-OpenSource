XYZShit = XYZShit or {}
XYZShit.CoolDown = XYZShit.CoolDown or {}
XYZShit.CoolDown.Timers = XYZShit.CoolDown.Timers or {}

function XYZShit.CoolDown.Check(id, time, ply)
	if not id then return true end
	if not time then return true end

	if not XYZShit.CoolDown.Timers[id] then
		XYZShit.CoolDown.Timers[id] = {}
		XYZShit.CoolDown.Timers[id].global = 0
	end

	if ply then
		if not XYZShit.CoolDown.Timers[id][ply:SteamID64()] then
			XYZShit.CoolDown.Timers[id][ply:SteamID64()] = 0
		end

		if XYZShit.CoolDown.Timers[id][ply:SteamID64()] > CurTime() then return true end

		XYZShit.CoolDown.Timers[id][ply:SteamID64()] = CurTime() + time

		return false
	else
		if XYZShit.CoolDown.Timers[id].global > CurTime() then return true end

		XYZShit.CoolDown.Timers[id].global = CurTime() + time

		return false
	end
end

function XYZShit.CoolDown.Get(id, ply)
	if not id then return 0 end
	if not time then return 0 end

	if not XYZShit.CoolDown.Timers[id] then return 0 end

	-- The correct returns
	if ply and XYZShit.CoolDown.Timers[id][ply:SteamID64()] then return CurTime() - XYZShit.CoolDown.Timers[id][ply:SteamID64()] end
	if not ply and XYZShit.CoolDown.Timers[id].global then return CurTime() -XYZShit.CoolDown.Timers[id].global end

	-- Failsafe
	return 0
end

function XYZShit.CoolDown.Reset(id, ply)
	if not id then return end

	if not XYZShit.CoolDown.Timers[id] then return end

	if ply then
		if not XYZShit.CoolDown.Timers[id][ply:SteamID64()] then return end
		XYZShit.CoolDown.Timers[id][ply:SteamID64()] = 0
	else
		XYZShit.CoolDown.Timers[id].global = 0
	end
end