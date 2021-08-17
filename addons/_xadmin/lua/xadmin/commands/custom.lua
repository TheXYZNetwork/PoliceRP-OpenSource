--- #
--- # Uncuff
--- # 
xAdmin.Core.RegisterCommand("uncuff", "Uncuff the user", 40, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	if (not target:XYZIsArrested()) and (not target:XYZIsZiptied()) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "This user is not cuffed"}, admin)
		return
	end

	if target:XYZIsArrested() then
		target:XYZUnarrest(admin)
		xAdmin.Core.Msg({admin, " has uncuffed ", target})
	else
		target:XYZUnziptie(admin)
		xAdmin.Core.Msg({admin, " has unziptied ", target})
	end
end)

--- #
--- # Unarrest
--- # 
xAdmin.Core.RegisterCommand("unarrest", "Unarrest a user", 50, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	if not PrisonSystem.IsArrested(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "This user is not in jail..."}, admin)
		return
	end

	PrisonSystem.UnArrest(target)
	xAdmin.Core.Msg({admin, " has unarrested ", target})
end)

--- #
--- # Unarrest
--- # 
xAdmin.Core.RegisterCommand("arrest", "Arrest a user", 80, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	if PrisonSystem.IsArrested(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "This user is already in jail..."}, admin)
		return
	end

	PrisonSystem.Arrest(target, (tonumber(args[2]) or 5)*60)
	xAdmin.Core.Msg({admin, " has arrested ", target, " for ", args[2] or 5, " minutes!"})
end)