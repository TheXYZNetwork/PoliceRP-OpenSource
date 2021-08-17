hook.Add("PlayerEnteredVehicle", "CarBombDetonate", function(ply, veh, role)
	if veh.HasCarBombPlanted then
		timer.Simple(1, function()
			CarBombApplyDamage(veh, ply)
		end)
	end
end)


function CarBombApplyDamage(veh, ply)
	-- Kill everyone inside the car
	if ply then
		ply:Kill()
	elseif IsValid(veh:GetDriver()) then
		veh:GetDriver():Kill()
	end
	
	for k, v in pairs(veh:GetChildren()) do
		if v:IsVehicle() and IsValid(v:GetDriver()) then
			v:GetDriver():Kill()
		end
	end
	-- Kill players within a range
	print(veh.CarBombPlanter)
	util.BlastDamage(veh, veh.CarBombPlanter, veh:GetPos(), 600, 400)

	-- Destory the VCMod Vehicle
	veh:VC_explodeEngine(false)

	-- Visual explosion
	ParticleEffect("c4_explosion", veh:GetPos(), angle_zero)

	-- Disable the carbomb
	veh.HasCarBombPlanted = false
end

-- hook.Add("PlayerUse", "CarBombDetonateSCars", function(ply, ent)
-- 	if ent.HasCarBombPlanted and string.Left(ent:GetClass(), 18) == "sent_sakarias_car_"  then 
-- 		timer.Simple(1, function()
-- 			if IsValid(ply) then
-- 				ply:Kill()
-- 			end
-- 			local boom = EffectData()
-- 			boom:SetOrigin(ent:GetPos())
-- 			util.Effect("HelicopterMegaBomb", boom)
-- 			ent:EmitSound(Sound("weapons/awp/awp1.wav"))
-- 			ent:TakeDamage(1337, ply, ply)
-- 			ent.HasCarBombPlanted = nil
-- 		end)
-- 	end
-- end)