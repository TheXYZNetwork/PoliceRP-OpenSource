CustomizableWeaponry.canDropWeapon = true -- set this to false to disable cw_dropweapon concommand
CustomizableWeaponry.enableWeaponDrops = true -- set this to false to disable weapon dropping in general (no idea why you would want to do that though)

function CustomizableWeaponry:dropWeapon(ply, wep, velocity, angleVelocity, pos, ang)
	if not self.enableWeaponDrops then
		return
	end
	
	wep = wep or ply:GetActiveWeapon()
	
	if not IsValid(wep) or not wep.CW20Weapon or wep.disableDropping then
		return
	end
	
	local eyePos = nil
	
	if not pos then
		eyePos = ply:EyePos()
		local aimVec = ply:GetAimVector()
		eyePos = eyePos + aimVec * 40
	else
		eyePos = pos
	end
	
	local eyeAng = nil
	
	if not ang then
		eyeAng = ply:EyeAngles()
		eyeAng:RotateAroundAxis(eyeAng:Up(), 90)
	else
		eyeAng = ang
	end
	
	local droppedWep = ents.Create("cw_dropped_weapon")
	droppedWep:SetPos(eyePos)
	droppedWep:SetAngles(eyeAng)
	droppedWep:setWeapon(wep)
	
	droppedWep:Spawn()
	droppedWep:Activate()
	
	local physObj = droppedWep:GetPhysicsObject()
	
	if velocity then
		physObj:SetVelocity(velocity)
	end
	
	if angleVelocity then
		physObj:AddAngleVelocity(angleVelocity)
	end
	
	CustomizableWeaponry.callbacks.processCategory(wep, "droppedWeapon", droppedWep)
	
	ply:StripWeapon(wep:GetClass())
end