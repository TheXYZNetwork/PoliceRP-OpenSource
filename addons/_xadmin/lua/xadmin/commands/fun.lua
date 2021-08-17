--- #
--- # CLOAK
--- #
xAdmin.Core.RegisterCommand("cloak", "Cloak a user", 40, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	xAdmin.Core.Msg({admin, " has cloaked ", target},  xAdmin.Core.GetOnlineStaff())
	target:SetNoDraw(true)
end)

--- #
--- # UNCLOAK
--- #
xAdmin.Core.RegisterCommand("uncloak", "Cloak a user", 40, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	xAdmin.Core.Msg({admin, " has uncloaked ", target},  xAdmin.Core.GetOnlineStaff())
	target:SetNoDraw(false)
end)

--- #
--- # FREEZE
--- #
xAdmin.Core.RegisterCommand("freeze", "Freeze a user", 30, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:Lock()
	target.xAdminIsFrozen = true
	xAdmin.Core.Msg({admin, " has frozen ", target})
end)

--- #
--- # UNFREEZE
--- #
xAdmin.Core.RegisterCommand("unfreeze", "Unfreeze a user", 30, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:UnLock()
	target.xAdminIsFrozen = false
	xAdmin.Core.Msg({admin, " has unfrozen ", target})
end)

--- #
--- # SETMODEL
--- #
xAdmin.Core.RegisterCommand("setmodel", "Set a user's model", 95, function(admin, args)
	if not args or not args[1] or not args[2] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:SetModel(args[2] or "models/props_lab/blastdoor001c.mdl")
	xAdmin.Core.Msg({admin, " has set ", target, "'s model to ", Color(138,43,226), args[2] or "models/props_lab/blastdoor001c.mdl"})
end)

--- #
--- # setscale
--- #
xAdmin.Core.RegisterCommand("setscale", "Set a user's scale", 95, function(admin, args)
	if not args or not args[1] or not args[2] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:SetModelScale(args[2] or 1, 4)

	target:SetModel(args[2] or "models/props_lab/blastdoor001c.mdl")
	xAdmin.Core.Msg({admin, " has set ", target, "'s scale to ", Color(138,43,226), args[2] or 1})
end)


