function xStore.Core.ValidateToID64(target)
	if not tonumber(target) then
		target = util.SteamIDTo64(target)
		if target == "0" then return false end
	end
	if not tonumber(target) then return false end
	if tonumber(target) <= 9999999999999999 then return false end

	return target
end