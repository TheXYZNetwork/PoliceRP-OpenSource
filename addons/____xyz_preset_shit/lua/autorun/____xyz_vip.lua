local pMeta = FindMetaTable("Player")

// XYZ_IsEvent()
function pMeta:IsEventTeam()
	if (self:GetSecondaryUserGroup() == "event") and (XYZShit.Staff.All[self:GetUserGroup()]) then
		return true
	end
	return false
end

// XYZ_IsElite()
function pMeta:IsElite()
	if (self:GetUserGroup() == "elite") or (self:GetSecondaryUserGroup() == "elite" )then
		return true 
	end
	if self:IsEventTeam() then
		return true
	end
	return false
end

// XYZ_IsVIP()
function pMeta:IsVIP()
	if (self:GetUserGroup() == "vip") or (self:GetSecondaryUserGroup() == "vip") then
		return true
	end
	if self:IsElite() then
		return true 
	end
	if self:IsEventTeam() then
		return true
	end
	return false
end