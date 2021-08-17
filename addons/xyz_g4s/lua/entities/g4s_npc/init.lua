AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Eli.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetTrigger(true)

	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
	
	self.coolDown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator)
	if self.coolDown > CurTime() then return end
	self.coolDown = CurTime() + 0.1
	-- Team check here
	if not (activator:Team() == G4S.Config.Job) then
		XYZShit.Msg("Gruppe 6", G4S.Config.Color, "You must be a Gruppe 6 driver...", activator)
		return
	end

	if not IsValid(activator.g4struck) then
		local truck = ents.Create("prop_vehicle_jeep")
		truck:SetPos(G4S.Config.TruckSpawnPos)
		truck:SetAngles(self:GetAngles())
		truck:SetModel("models/dannio/durastar.mdl")
		truck:SetKeyValue("vehiclescript", "scripts/vehicles/dannio/durastar.txt")
		truck:Spawn()
		truck:Activate()
		truck:SetVehicleClass("dannio_2002_international_durastar")
		truck:keysOwn(activator)
		truck:keysLock()
		truck:SetSkin(1)
		truck.owner = activator
		truck.isG4Struck = true
		truck.holdingBags = {}
		truck.coolDown = CurTime() + 0.1

		local healthMax = truck:VC_getHealthMax() or 100
		local newHealth = healthMax*2
		truck:VC_setHealthMax(healthMax+newHealth*100)
		truck:VC_setHealth(healthMax+newHealth*100)

		truck:SetBodygroup(2, 1)

		-- Makes it so money bags can be put into the vehicle
		truck:SetTrigger(true)
		truck:AddCallback("PhysicsCollide", function(ent, data)
			if self.coolDown > CurTime() then return end
			if not (data.HitEntity:GetClass() == "pvault_moneybag") then return end
			self.coolDown = CurTime() + 0.5
			if #truck.holdingBags == 3 then return end
			truck.holdingBags[#truck.holdingBags+1] = data.HitEntity:GetValue()
			data.HitEntity:Remove()

			truck:SetBodygroup(2, 0)
		end)

		activator.g4struck = truck

		XYZShit.Msg("Gruppe 6", G4S.Config.Color, "Go to businesses and see if they have money for you to transport to bank. You may not carry more than three bags at once, as that is too much of a risk. Drive safe.", activator)

		-- Notify them of businesses without cooldown

		local locations = ""

		for k, v in ipairs(ents.FindByClass("xyz_raid_*")) do
			if v.RobCooldown > CurTime() then continue end
			locations = locations.."\n- "..v.StoreNameDisplay
		end

		Quest.Core.ProgressQuest(activator, "money_guard", 2)

		XYZShit.Msg("Gruppe 6", G4S.Config.Color, "The following businesses are looking to store their cash in a safe place:"..locations, activator)
	end
end