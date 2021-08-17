AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

UPS.Platforms = UPS.Platforms or {} 
function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube3x6x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.name = "Delivery Point"
	self.reward = 2500
	
	self.id = table.insert(UPS.Platforms, self)
end


function ENT:OnRemove()
	UPS.Platforms[self.id] = nil
end

function ENT:StartTouch(vehicle)
	if not vehicle:IsVehicle() then return end
	if not vehicle:GetVehicleClass() == "courier_trucktdm" then return end
	if not vehicle.hasPackage then return end
	if not IsValid(vehicle.owner) then return end
	if UPS.Core.ActiveDeliveries[vehicle.owner:SteamID64()] ~= self.id then return end

	UPS.Core.RecentDeliveries[vehicle.owner:SteamID64()][UPS.Core.ActiveDeliveries[vehicle.owner:SteamID64()]] = true
	local reward = UPS.Platforms[UPS.Core.ActiveDeliveries[vehicle.owner:SteamID64()]].reward
	local msg = "You were paid "..DarkRP.formatMoney(reward).." for a successful delivery"
	if vehicle.owner.upslate then reward = UPS.Config.LateDelivery msg = "You were paid "..DarkRP.formatMoney(reward).." for a late delivery" end

	XYZShit.Msg("UPS", UPS.Config.Color, msg, vehicle.owner)
	vehicle.owner:addMoney(reward)
	vehicle.hasPackage = nil
	vehicle.owner.upslate = nil
	UPS.Core.ActiveDeliveries[vehicle.owner:SteamID64()] = nil
	
	net.Start("xyz_ups_end")
	net.Send(vehicle.owner)

	Quest.Core.ProgressQuest(vehicle.owner, "delivery_boy", 3)
end