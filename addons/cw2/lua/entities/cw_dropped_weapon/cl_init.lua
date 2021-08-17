include("shared.lua")
ENT.dataRequestTime = 0

function ENT:Initialize()
end

function ENT:getMainText()
	return self.weaponName
end

function ENT:Think()
	if self.inRange and (not self.containedAttachments or not self.weaponName) then
		if CurTime() > self.dataRequestTime then
			RunConsoleCommand("cw_request_wep_data", self:EntIndex())
			self.dataRequestTime = CurTime() + 1
		end
	end
end

local green = Color(215, 255, 160, 255)

function ENT:getNoAttachmentColor()
	return green
end

function ENT:getAttachmentColor()
	return green
end

net.Receive("CW_DROPPED_WEAPON_ATTACHMENTS", function()
	local entity = net.ReadEntity()
	
	if IsValid(entity) and entity:GetClass() == "cw_dropped_weapon" then
		local attachments = net.ReadTable()
		entity.containedAttachments = attachments
		entity.weaponName = weapons.GetStored(entity:GetWepClass()).PrintName
		
		entity:setupAttachmentDisplayData()
	end
end)