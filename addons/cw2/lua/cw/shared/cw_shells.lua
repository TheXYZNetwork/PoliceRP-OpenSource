AddCSLuaFile()

CustomizableWeaponry.shells = {}
CustomizableWeaponry.shells.cache = {}

-- register new shell types with this function
-- name - the name of the shell
-- model - the model of the shell
-- collideSound - table containing the collision sounds this shell should make
-- keep in mind that the shells are somewhat fake

function CustomizableWeaponry.shells:addNew(name, model, collideSound)
	self.cache[name] = {m = model, s = collideSound}
end

function CustomizableWeaponry.shells:getShell(name)
	return self.cache[name]
end

local up = Vector(0, 0, -100)
local shellMins, shellMaxs = Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5)

function CustomizableWeaponry.shells:make(pos, ang, velocity, soundTime, removeTime)
	if not pos or not ang then
		return
	end

	CustomizableWeaponry.shells.finishMaking(self, pos, ang, velocity, soundTime, removeTime)
end

local angleVel = Vector(0, 0, 0)

function CustomizableWeaponry.shells:finishMaking(pos, ang, velocity, soundTime, removeTime)
	velocity = velocity or up
	velocity.x = velocity.x + math.Rand(-5, 5)
	velocity.y = velocity.y + math.Rand(-5, 5)
	velocity.z = velocity.z + math.Rand(-5, 5)
	
	time = time or 0.5
	removetime = removetime or 5
	
	local t = self._shellTable or CustomizableWeaponry.shells:getShell("mainshell") -- default to the 'mainshell' shell type if there is none defined
	
	local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
	ent:SetPos(pos)
	ent:PhysicsInitBox(shellMins, shellMaxs)
	ent:SetAngles(ang)
	ent:SetModelScale((self.ShellScale or 1), 0)
	ent:SetMoveType(MOVETYPE_VPHYSICS) 
	ent:SetSolid(SOLID_VPHYSICS) 
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	
	local phys = ent:GetPhysicsObject()
	phys:SetMaterial("gmod_silent")
	phys:SetMass(10)
	phys:SetVelocity(velocity)
	
	angleVel.x = math.random(-500, 500)
	angleVel.y = math.random(-500, 500)
	angleVel.z = math.random(-500, 500)
	
	phys:AddAngleVelocity(ang:Right() * 100 + angleVel)

	timer.Simple(time, function()
		if t.s and IsValid(ent) then
			sound.Play(t.s, ent:GetPos())
		end
	end)
	
	SafeRemoveEntityDelayed(ent, removetime)
end

CustomizableWeaponry:addRegularSound("CW_SHELL_MAIN", {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}, 65)
CustomizableWeaponry:addRegularSound("CW_SHELL_SMALL", {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}, 65)
CustomizableWeaponry:addRegularSound("CW_SHELL_SHOT", {"weapons/fx/tink/shotgun_shell1.wav", "weapons/fx/tink/shotgun_shell2.wav", "weapons/fx/tink/shotgun_shell3.wav"}, 65)

CustomizableWeaponry.shells:addNew("mainshell", "models/weapons/rifleshell.mdl", "CW_SHELL_MAIN")
CustomizableWeaponry.shells:addNew("smallshell", "models/weapons/shell.mdl", "CW_SHELL_SMALL")
CustomizableWeaponry.shells:addNew("shotshell", "models/weapons/Shotgun_shell.mdl", "CW_SHELL_SHOT")