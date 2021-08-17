local att, wep, dist, mul

local function CW_EntityTakeDamage(ent, d)
	att = d:GetInflictor()
	
	if att:IsPlayer() then
		wep = att:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon and not wep.NoDistance and wep.EffectiveRange then
			dist = ent:GetPos():Distance(att:GetPos())
			
			if dist >= wep.EffectiveRange * 0.5 then
				dist = dist - wep.EffectiveRange * 0.5
				mul = math.Clamp(dist / wep.EffectiveRange, 0, 1)

				d:ScaleDamage(1 - wep.DamageFallOff * mul)
			end
		end
	end
end

hook.Add("EntityTakeDamage", "CW_EntityTakeDamage", CW_EntityTakeDamage)