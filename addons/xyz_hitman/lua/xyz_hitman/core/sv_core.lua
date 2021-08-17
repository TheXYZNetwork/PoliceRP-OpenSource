local function RandomHit()
	if player.GetCount() < 15 then return end
	local randomPly = table.Random(player.GetAll())
	local randomPrice = math.random(20000, 50000)

	if XYZ_HITMAN.Config.BlacklistedJobs[randomPly:Team()] then RandomHit() return end
	if randomPly:Team() == TEAM_CITIZEN then RandomHit() return end

	XYZ_HITMAN.Core.ActiveHits[#XYZ_HITMAN.Core.ActiveHits+1] = {
		requester = nil,
		target = randomPly,
		price = randomPrice,
		claims = {}
	}
	timer.Start("HitmanExpireBounty")
	XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "An automatic hit has been placed.")
	xLogs.Log("Server placed automatic hit on "..xLogs.Core.Player(ply), "Hitman")
end

net.Receive("xyz_hitman_add_hit", function(_, ply)
	if XYZ_HITMAN.Config.HitmanJobs[ply:Team()] then return end
	local target = net.ReadEntity()
	local hitPrice = net.ReadUInt(32)

	local withinRange = false
	for k, v in ipairs(XYZ_HITMAN.Phones) do
		if v:GetPos():Distance(ply:GetPos()) < 300 then
			withinRange = true
			break
		end
	end
	if not withinRange then return end

	if not target or not hitPrice then return end
	if ply == target or XYZ_HITMAN.Config.BlacklistedJobs[ply:Team()] or XYZ_HITMAN.Config.BlacklistedJobs[target:Team()] then 
		XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "You can't place a hit (on this person).", ply) 
		return
	end
	if hitPrice < XYZ_HITMAN.Config.MinPrice then return end
	if not ply:canAfford(hitPrice) then XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "You can't afford this.", ply)  return end
	if XYZShit.CoolDown.Check("PlaceHit", 120, ply) then XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "Calm down there, I don't want to become a mass murderer just yet.", ply) return end
	if XYZShit.CoolDown.Check("PlaceHitOn"..target:SteamID64(), 900, ply) then XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "Calm down there, they haven't even had the chance to breathe!", ply) return end

	for k, v in pairs(XYZ_HITMAN.Core.ActiveHits) do
		if v.target == target then
			XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "This person already has a hit on them.", ply)
			return
		end
	end

	ply:addMoney(-hitPrice)
	XYZ_HITMAN.Core.ActiveHits[#XYZ_HITMAN.Core.ActiveHits+1] = {
		requester = ply,
		target = target,
		price = hitPrice,
		claims = {}
	}

	local isHitmanOn = false
	for _, v in ipairs( player.GetAll() ) do
		if XYZ_HITMAN.Config.HitmanJobs[v:Team()] then
			isHitmanOn = true
			break
		end
	end

	if isHitmanOn then 
		XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "Someone placed a hit!", ply)
	else
		XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "Someone placed a hit, but there isn't a hitman on.")
	end

	xLogs.Log(xLogs.Core.Player(ply).." placed a hit on "..xLogs.Core.Player(target).." for "..xLogs.Core.Color(DarkRP.formatMoney(hitPrice), Color(34,139,34)), "Hitman")
end)

net.Receive("xyz_hitman_claim_hit", function(_, ply)
	if not XYZ_HITMAN.Config.HitmanJobs[ply:Team()] then return end
	local hit = net.ReadUInt(6)
	if not hit or not XYZ_HITMAN.Core.ActiveHits[hit] then return end
	if XYZ_HITMAN.Core.ActiveHits[hit].target == ply then return end

	if not XYZ_HITMAN.Core.ActiveHits[hit].claims[ply:SteamID64()] then
		XYZ_HITMAN.Core.ActiveHits[hit].claims[ply:SteamID64()] = true
		XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "You have claimed a hit on "..XYZ_HITMAN.Core.ActiveHits[hit].target:Nick()..". Hunt them down and kill them.", ply)
		if IsValid(XYZ_HITMAN.Core.ActiveHits[hit].requester) then
			XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "A hitman has claimed your hit.", XYZ_HITMAN.Core.ActiveHits[hit].requester)
		end
		xLogs.Log(xLogs.Core.Player(ply).." claimed the hit on "..xLogs.Core.Player(XYZ_HITMAN.Core.ActiveHits[hit].target), "Hitman")

		Quest.Core.ProgressQuest(ply, "hitman69", 1)
	else 
		XYZ_HITMAN.Core.ActiveHits[hit].claims[ply:SteamID64()] = false
		XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "You have unclaimed the hit on "..XYZ_HITMAN.Core.ActiveHits[hit].target:Nick()..".", ply)
		if IsValid(XYZ_HITMAN.Core.ActiveHits[hit].requester) then
			XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "A hitman has unclaimed your hit.", XYZ_HITMAN.Core.ActiveHits[hit].requester)
		end
		xLogs.Log(xLogs.Core.Player(ply).." unclaimed the hit on "..xLogs.Core.Player(XYZ_HITMAN.Core.ActiveHits[hit].target), "Hitman")
	end
end)

hook.Add("PlayerDeath", "xyz_hitman_death", function(ply, _, attacker)
	if !IsValid(attacker) then return end
	if !attacker:IsPlayer() then return end
	if XYZ_HITMAN.Config.HitmanJobs[attacker:Team()] then
		for k, v in pairs(XYZ_HITMAN.Core.ActiveHits) do
			if v.target == ply and v.claims[attacker:SteamID64()] then
				attacker:addMoney(XYZ_HITMAN.Core.ActiveHits[k].price)
				XYZ_HITMAN.Core.ActiveHits[k] = nil
				XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "A hit has been completed on "..ply:Nick()..".")
				xLogs.Log(xLogs.Core.Player(attacker).." completed a hit on "..xLogs.Core.Player(ply), "Hitman")

				Quest.Core.ProgressQuest(attacker, "hitman69", 2)
				Quest.Core.ProgressQuest(attacker, "hitman69", 3)

				if table.Count(XYZ_HITMAN.Core.ActiveHits) == 0 then
					RandomHit()
				end
				break
			end
		end
	end
end)

hook.Add("PlayerDisconnected", "xyz_hitman_disconnect", function(ply)
	for k, v in pairs(XYZ_HITMAN.Core.ActiveHits) do
		if v.requester == ply or not IsValid(v.requester) or v.target == ply or not IsValid(v.target) then
			XYZ_HITMAN.Core.ActiveHits[k] = nil
		end
	end
end)

timer.Create("HitmanExpireHit", 1200, 0, function()
	for k, v in pairs(XYZ_HITMAN.Core.ActiveHits) do
		if v.requester == v.target then
			-- requester can only be target if its a serverside hit
			xLogs.Log("An automatic hit on "..xLogs.Core.Player(v.target).." expired", "Hitman")
			XYZ_HITMAN.Core.ActiveHits[k] = nil
			XYZShit.Msg("Hitman", XYZ_HITMAN.Config.Color, "A automatic hit has expired.")
		end
	end
end)
timer.Stop("HitmanExpireBounty")