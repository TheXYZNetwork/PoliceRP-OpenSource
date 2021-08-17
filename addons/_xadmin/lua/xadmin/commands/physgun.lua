--- #
--- # PLY PICKUP
--- #
hook.Add("PhysgunPickup", "xAdminPlayerPickup", function(ply, target)
	if ply:HasPower(30) and target:IsPlayer() and not target:HasPower(ply:GetGroupPower()) then
		target:SetMoveType(MOVETYPE_NONE)
		return true
	end
end)

hook.Add("loadCustomDarkRPItems", "xAdminCarPhysgunHotfix", function()
    timer.Simple(0.1, function()
		hook.Add("PhysgunPickup", "_xAdminCarPickup", function(ply, target)
			if target:IsVehicle() then
				if ply:IsAdmin() then
					return true
				elseif ply.isSOD and ply:HasPower(40) then
					return true
				end
				return false
			end
		end)
    end)
end)

hook.Add("PhysgunDrop", "xAdminPlayerDrop", function(ply, target)
	if ply:HasPower(30) and target:IsPlayer() and not target:HasPower(ply:GetGroupPower()) then
		if ply:KeyDown(IN_ATTACK2) then
			print("Freezing", target)
			timer.Simple(0.1, function()
				if not target:XYZIsArrested() then
					print("Locking")
					target:Lock()
				end
				target:SetColor(Color(255, 0, 0))
			end)
		else
			print("Unfreezing", target)
			timer.Simple(0.1, function()
				target:SetMoveType(MOVETYPE_WALK)
				if not target:XYZIsArrested() then
					print("Unlocking")
					target:UnLock()
				end
				target:SetLocalVelocity(Vector(0, 0, 0))
				target:SetColor(Color(255, 255, 255))
			end)
		end
	end
end)

