AddCSLuaFile()

-- adds customizable grenade types for the M203

CustomizableWeaponry.grenadeTypes = {}
CustomizableWeaponry.grenadeTypes.registered = {}
CustomizableWeaponry.grenadeTypes.total = 0
CustomizableWeaponry.grenadeTypes.defaultText = " - 40MM HE"
CustomizableWeaponry.grenadeTypes.defaultFireSound = "CW_M203_FIRE"
CustomizableWeaponry.grenadeTypes.cycleText = " (HOLD - cycle grenades)"
CustomizableWeaponry.grenadeTypes.defaultGrenadeEntity = "cw_40mm_explosive"

function CustomizableWeaponry.grenadeTypes:addNew(gren)
	self.total = self.total + 1
	gren.id = self.total
	
	table.insert(self.registered, gren)
end

local SP = game.SinglePlayer()

function CustomizableWeaponry.grenadeTypes:createGrenadeEntity(name)
	local pos = self.Owner:GetShootPos()
	local eyeAng = self.Owner:EyeAngles()
	local forward = eyeAng:Forward()
	local offset = forward * 30 + eyeAng:Right() * 4 - eyeAng:Up() * 3
	
	local nade = ents.Create(name)
	nade:SetPos(pos + offset)
	nade:SetAngles(eyeAng)
	nade:Spawn()
	nade:Activate()
	nade:SetOwner(self.Owner)
	local phys = nade:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:SetVelocity(forward * 2996)
	end
end

function CustomizableWeaponry.grenadeTypes:defaultFireFunc()
	if SERVER then
		CustomizableWeaponry.grenadeTypes.createGrenadeEntity(self, CustomizableWeaponry.grenadeTypes.defaultGrenadeEntity)
	end
end

function CustomizableWeaponry.grenadeTypes:selectFireSound(target)
	if self:filterPrediction() then
		if target and target.fireSound then
			self:EmitSound(target.fireSound)
		else
			self:EmitSound(CustomizableWeaponry.grenadeTypes.defaultFireSound)
		end
	end
end

function CustomizableWeaponry.grenadeTypes:selectFireFunc(firstTimePrediction)
	if firstTimePrediction then
		local target = CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM]
		
		if not target then
			CustomizableWeaponry.grenadeTypes.defaultFireFunc(self)
		else
			target.fireFunc(self)
		end
		
		CustomizableWeaponry.grenadeTypes.selectFireSound(self, target)
	end
	
	self.dt.State = CW_IDLE
end

function CustomizableWeaponry.grenadeTypes:cycleGrenades()
	if CLIENT then
		RunConsoleCommand("cw_cycle40mm")
		return
	end
	
	if self.Grenade40MM >= CustomizableWeaponry.grenadeTypes.total then
		self.Grenade40MM = 0 -- reset to default 40MM grenade behavior
	else
		self.Grenade40MM = self.Grenade40MM + 1 -- increment 40MM grenade behavior
	end
	
	self.GrenadeTarget = false
end

function CustomizableWeaponry.grenadeTypes:setTo(target, network)
	self.Grenade40MM = math.Clamp(target, 0, CustomizableWeaponry.grenadeTypes.total)
	
	if network then
		umsg.Start("CW20_GRENADETYPE", self.Owner)
			umsg.Short(self.Grenade40MM)
		umsg.End()
	end
end

function CustomizableWeaponry.grenadeTypes:getGrenadeText()
	local target = CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM]
	
	return target and target.display or CustomizableWeaponry.grenadeTypes.defaultText
end

function CustomizableWeaponry.grenadeTypes:get(id)
	return self.registered[id]
end

function CustomizableWeaponry.grenadeTypes:canUseProperSights(id)
	local target = self.registered[id]
	
	if target and target.allowSights then
		return true
	end
	
	return false
end

local path = "cw/shared/grenadetypes/"

-- load 40MM grenade type files

for k, v in pairs(file.Find("cw/shared/grenadetypes/*", "LUA")) do
	loadFile(path .. v)
end