-- Player stuff
local ply = FindMetaTable("Player")

function ply:GetSecondaryUserGroup()
	return xSGroups.Users[self:SteamID64()] or nil
end

function ply:GetSecondaryGroupPower()
	return xSGroups.Groups[self:GetUserGroup()].power or 0
end

function ply:GetSecondaryGroupTable()
	return xSGroups.Groups[self:GetUserGroup()] or nil
end


-- Other
function xSGroups.Core.RegisterGroup(name, power)
	xSGroups.Groups[name] = {name = name, power = power}
end

function xSGroups.Core.GetGroupPower(name)
	return xSGroups.Groups[name].power or 0
end

function xSGroups.Core.GetGroupsWithPower(power)
	local groups = {}
	for k, v in pairs(xSGroups.Groups) do
		if v.power >= power then
			table.insert(groups, v)
		end
	end
	return groups
end