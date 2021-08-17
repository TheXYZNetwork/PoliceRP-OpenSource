GovBadgeID.Tags = GovBadgeID.Tags or {}

function GovBadgeID.SetBadge(ply, badgeID)
	local formattedID = string.format("%04d", badgeID)

	GovBadgeID.Tags[ply:SteamID64()] = formattedID

	GovBadgeID.Database.SetBadgeID(ply:SteamID64(), badgeID)

	return formattedID
end
function GovBadgeID.GetBadge(ply)
	return GovBadgeID.Tags[ply:SteamID64()] or GovBadgeID.SetBadge(ply, math.random(1, 9999))
end

function GovBadgeID.GetCoreName(ply)
	local nameTbl = string.Split(ply:Name(), " ")
	local badgeID = GovBadgeID.GetBadge(ply)

	-- Remove the prefix from a user's name
	if table.HasValue(GovBadgeID.Config.JobPrefix, nameTbl[1]) then
		table.remove(nameTbl, 1)
	end

	local tblCount = table.Count(nameTbl)

	if nameTbl[tblCount] == badgeID then
		table.remove(nameTbl, tblCount)
	end

	return table.concat(nameTbl, " ")
end

function GovBadgeID.FormatName(ply)
	local prefix = GovBadgeID.Config.JobPrefix[ply:Team()]
	local coreName = GovBadgeID.GetCoreName(ply)
	-- Not a job with a govID prefix. Attempt to remove any gov identity from name
	if not prefix then
		return coreName

	-- Government ID found
	else
		local badgeID = GovBadgeID.GetBadge(ply)
		-- Build a format for their name
		local nameFormat = prefix.." %s "..badgeID

		return string.format(nameFormat, coreName)
	end
end

net.Receive("GovBadgeID:Submit", function(_, ply)
	if not ply:IsVIP() then return end

	if XYZShit.CoolDown.Check("GovBadgeID:Submit", 30, ply) then
		XYZShit.Msg("Government Badge ID", GovBadgeID.Config.Color, "You have just changed your Government Badge ID, wait a moment before trying to change it again!", ply)
		return
	end

	local badgeID = net.ReadUInt(14)
	-- Not a number
	if not isnumber(badgeID) then return end
	-- More than 4 chars
	if string.len(badgeID) > 4 then return end
	-- ID is too short
	if badgeID <= 0 then return end

	local officalBadgeID = GovBadgeID.SetBadge(ply, badgeID)

	local newName = GovBadgeID.FormatName(ply)

	-- Hack together removing the old ID
	if GovBadgeID.Config.JobPrefix[ply:Team()] then
		local newNameTbl = string.Split(newName, " ")
		table.remove(newNameTbl, #newNameTbl - 1)

		newName = table.concat(newNameTbl, " ")
	end

	XYZShit.Msg("Government Badge ID", GovBadgeID.Config.Color, "Your Government Badge ID is now: "..officalBadgeID, ply)

	-- Their name is the same
	if ply:Name() == newName then return end
	
	ply:setRPName(newName)
end)

hook.Add("OnPlayerChangedTeam", "GovBadgeID:ChangeJob", function(ply, before, after)
	if not (GovBadgeID.Config.JobPrefix[before] or GovBadgeID.Config.JobPrefix[after]) then return end

	XYZShit.Msg("Government Badge ID", GovBadgeID.Config.Color, "Your name has been updated to reflect your Government Identity.", ply)

	local name = GovBadgeID.FormatName(ply)
	ply:setRPName(name)
end)

hook.Add("PlayerInitialSpawn", "GovBadgeID:ChangeJob", function(ply)
	GovBadgeID.Database.GetBadgeID(ply:SteamID64(), function(data)
		-- No data bruh
		if (not data) or (not data[1]) then return end

		local formattedID = string.format("%04d", data[1].tag)
		GovBadgeID.Tags[ply:SteamID64()] = formattedID
	end)
end)