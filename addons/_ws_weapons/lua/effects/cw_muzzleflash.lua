AddCSLuaFile()

function EFFECT:Init(fx)
	local ent = fx:GetEntity()
	
	if not IsValid(ent) then
		return
	end
	
	if not IsValid(ent.Owner) then
		return
	end
	
	if not ent.Owner:ShouldDrawLocalPlayer() and ent.Owner == LocalPlayer() then -- don't create the effect if we're in first person
		return
	end
	
	local particleEffect = ent:getFireParticles()
	local attachModel = ent:getMuzzleModel()
	
	if not IsValid(attachModel) then
		return
	end
	
	local attachment = attachModel:GetAttachment(ent.WorldMuzzleAttachmentID)
	local shell = attachModel:GetAttachment(ent.WorldShellEjectionAttachmentID)
	
	local lightPos = nil
	
	if attachment then
		ParticleEffectAttach(particleEffect, PATTACH_POINT_FOLLOW, attachModel, ent.WorldMuzzleAttachmentID)
		lightPos = attachment.Pos
	else
		local aimVec = ent.Owner:EyeAngles()
		lightPos = ent.Owner:GetShootPos() + aimVec:Forward() * 30 - aimVec:Up() * 3 
	end
	
	if shell and ent.Shell then
		if ent.ShellDelay then
			timer.Simple(ent.ShellDelay, function()
				if IsValid(ent) then
					shell = attachModel:GetAttachment(ent.WorldShellEjectionAttachmentID)
					local ejectVelocity = shell.Ang:Forward() * 200
					shell.Ang:RotateAroundAxis(shell.Ang:Right(), 90)
					CustomizableWeaponry.shells.make(ent, shell.Pos, shell.Ang, ejectVelocity, 0.5, 10)
				end
			end)
		else
			local ejectVelocity = shell.Ang:Forward() * 200
			shell.Ang:RotateAroundAxis(shell.Ang:Right(), 90)
			CustomizableWeaponry.shells.make(ent, shell.Pos, shell.Ang, ejectVelocity, 0.5, 10)
		end
	end
	
	if not ent.dt.Suppressed then
		local dlight = DynamicLight(self:EntIndex())
		
		dlight.r = 255 
		dlight.g = 218
		dlight.b = 74
		dlight.Brightness = 4
		dlight.Pos = lightPos
		dlight.Size = 96
		dlight.Decay = 128
		dlight.DieTime = CurTime() + FrameTime()
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
