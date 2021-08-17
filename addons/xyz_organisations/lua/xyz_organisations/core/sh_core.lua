function XYZ_ORGS.Core.HasPerms(perms, permtocheck, ply, dontNotify)
	if bit.band(perms, bit.bor(XYZ_ORGS.Config.Permissions.ALL, XYZ_ORGS.Config.Permissions[permtocheck])) == 0 then 
		if SERVER and not dontNotify then
			XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "No permission.", ply)
		end
		return false
	end
	return true

end