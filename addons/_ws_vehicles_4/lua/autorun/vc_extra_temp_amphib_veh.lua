// This is an extremely quick rip of VCMod Extra Amphibious Vehicles module for one vehicle. Made by http://steamcommunity.com/profiles/76561197989323181 (freemmaann) .
// The following code will be automatically disabled with VCMod Extra is installed.

if SERVER then

	if !VC then VC = {} end

	VC.Extra_Temp_AmphV_List = {
		"models/sentry/l4dapc.mdl",
	}

	if !VC.Extra_Amph_ActiveList then VC.Extra_Amph_ActiveList = {} end

	hook.Add("Think", "VC_Extra_Temp_Think", function()
		if VC and VC.Loaded and VC.Loaded["extra"] then return end

		if VC.Extra_Amph_ActiveList then
			for k,ent in pairs(VC.Extra_Amph_ActiveList) do
				if IsValid(ent) then
					local waterLevel = VC.GetWaterLevel and VC.GetWaterLevel(ent) or ent:WaterLevel()
					if waterLevel > 0 then
						// Handle variables
						local vehSpeed = ent.VC_Speed_Forward
						if !vehSpeed then vehSpeed = ent:GetVelocity():Dot(ent:GetForward()) end

						local speed = 6
						local speed_turning = 1

						local drv = ent:GetDriver()

						local thrt = IsValid(drv) and (drv:KeyDown(IN_FORWARD) and 1 or drv:KeyDown(IN_BACK) and -1) or 0
						if thrt == 0 and ent.VC_Throttle and ent.VC_Throttle != 0 then thrt = ent.VC_Throttle end

						local physObj = ent:GetPhysicsObject()

						// Handle velocity
						if thrt == 0 and vehSpeed < -2 then
							if true then
								local cthr = VC.GetThrottle(0, vehSpeed)
								physObj:AddVelocity(ent:GetForward()*cthr*2)
							end
						else
							physObj:AddVelocity(ent:GetForward()*(thrt*(speed)))
						end

						// Handle steering
						local steer = ent:GetSteering()
						if steer != 0 then
							if true then
								local vehSpeedPrc = math.abs(vehSpeed)
								local steerMax = 200
								if vehSpeedPrc > 5 then
									if vehSpeedPrc > steerMax then vehSpeedPrc = steerMax end
									speed_turning = speed_turning*vehSpeedPrc/steerMax
								else
									speed_turning = 0
								end
							end
							physObj:AddAngleVelocity(Vector(0,0,-steer*speed_turning*(vehSpeed < -5 and -1 or 1)))
						end
					end
				else
					VC.Extra_Amph_ActiveList[k] = nil
				end
			end
		end
	end)
	hook.Add("OnEntityCreated", "VC_Extra_Temp_OnEntityCreated", function(ent)
		if !VC and VC.Loaded and VC.Loaded["extra"] then return end

		timer.Simple(1, function()
			if IsValid(ent) then
				if ent:IsVehicle() and table.HasValue(VC.Extra_Temp_AmphV_List, ent:GetModel()) then
					table.insert(VC.Extra_Amph_ActiveList, ent)
					ent:GetPhysicsObject():SetBuoyancyRatio(2.4)
				end
			end
		end)
	end)

	function VC.GetThrottle(vel_t, vel_c)
		local ret = 1
		if vel_t < vel_c then
			ret = 0
		elseif (vel_t-vel_c) < 20 then
			ret = math.sin(math.pi* (vel_t-vel_c)/40)
		end
		return ret
	end
end