XYZBadges.Core.UsersBadges = XYZBadges.Core.UsersBadges or {}
local ply = FindMetaTable("Player")

function ply:HasBadge(id_name)
	if not XYZBadges.Core.UsersBadges[self:SteamID64()] then
		XYZBadges.Core.UsersBadges[self:SteamID64()] = {}
		return false
	end

	if XYZBadges.Core.UsersBadges[self:SteamID64()][id_name] then
		return true
	end
	return false
end

function ply:GetBadges()
	if not XYZBadges.Core.UsersBadges[self:SteamID64()] then
		XYZBadges.Core.UsersBadges[self:SteamID64()] = {}
		return {}
	end 
	return XYZBadges.Core.UsersBadges[self:SteamID64()] or {}
end

function ply:GiveBadge(id_name)
	if CLIENT then return end

	if self:HasBadge(id_name) then return end

	if not XYZBadges.Core.UsersBadges[self:SteamID64()] then
		XYZBadges.Core.UsersBadges[self:SteamID64()] = {}
	end
	XYZBadges.Core.UsersBadges[self:SteamID64()][id_name] = true

	net.Start("xyz_badge_network_specific")
		net.WriteString(self:SteamID64())
		net.WriteString(id_name)
	net.Broadcast()

	XYZShit.Msg("Badge", Color(70, 200, 200), self:Name().." has been given the badge "..XYZBadges.Config.Badges[id_name].name)
	XYZBadges.Core.GiveIDBadge(self:SteamID64(), id_name)
end