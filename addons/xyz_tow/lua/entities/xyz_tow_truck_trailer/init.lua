AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/cipro/tow_truck/remorque.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:StartMotionController()

	self.defaultMass = 500

	local tblDefaultPos = XYZTowTruck.Positions.pos

    self.vecPos = Vector(unpack(string.Explode(" ", tostring(tblDefaultPos.vec))))
    self.angPos = Angle(unpack(string.Explode(" ", tostring(tblDefaultPos.ang))))

	self.vecDefault = XYZTowTruck.Positions.pos.vec

	self.tblShadow = {}
end
--[[
	desc: (Un)locks the trailer
	return: nil
]]--

function ENT:Lock(boolLock, truck)
	self.boolLocked = boolLock

	if ( not self.boolLocked ) then
		constraint.RemoveConstraints(self, "Weld")

		self:StartMotionController()
		--self:GetPhysicsObject():SetMass(20000)
		self:GetPhysicsObject():RecheckCollisionFilter()
		self:GetPhysicsObject():Wake()
	else
		self:StopMotionController()
		
		constraint.Weld(truck, self, 0, 0)

		self:SetDefaultMass()
	end
end

--[[
	desc: Set default mass to trailer
	return: nil
]]--

function ENT:SetDefaultMass()
	self:GetPhysicsObject():SetMass(self.defaultMass)
	self:PhysWake() 
end

--[[
	desc: Sets trailer direction
	return: nil
]]--

function ENT:SetGoingDown(boolDown)
	self.boolGoingDown = boolDown
end

--[[
	desc: Check if trailer is down
	return: nil
]]--

function ENT:IsDown()
	local tblToPos = XYZTowTruck.Positions.topos
	local boolHorizontaly = self.vecPos.y <= tblToPos.maxVec
	local boolVerticaly = self.angPos.r >= tblToPos.maxAng

	if ( boolVerticaly and boolHorizontaly ) then
		return true
	end

	return false
end

--[[
	desc: Check if trailer is up
	return: nil
]]--

function ENT:IsUp()
	local tblDefaultPos = XYZTowTruck.Positions.pos
	local boolHorizontaly = self.vecPos.y >= tblDefaultPos.vec.y
	local boolVerticaly = self.angPos.r == 0

	if ( boolVerticaly and boolHorizontaly ) then
		return true
	end

	return false
end

--[[
	desc: Check if trailer is moving
	return: nil
]]--

function ENT:IsMoving()
	if ( self:IsDown() ) then return false end
	if ( self:IsUp() ) then return false end

	return true
end

--[[
	desc: Remove sound
	return: nil
]]--

function ENT:RemoveSound()
	if ( self.soundMoving and self.soundMoving:IsPlaying() ) then
		self.soundMoving:Stop()
		self.soundMoving = nil
		self:EmitSound("plats/crane/vertical_stop.wav")
	end
end

function ENT:PhysicsSimulate(phys, intDeltaTime)
	if ( not IsValid(self.truck) ) then return end

	if ( self.boolLocked ) then 
		return self:RemoveSound()
	end

	local tblToPos = XYZTowTruck.Positions.topos

	local vecMove = tblToPos.vec
	local angMove = tblToPos.ang

	local boolMoving = false

	if ( self.boolGoingDown ) then
		if ( self.vecPos.y <= tblToPos.maxVec ) then
			self.angPos.r = math.Clamp(self.angPos.r + (angMove.r * intDeltaTime), 0, tblToPos.maxAng)
		else
			self.vecPos.y = math.Clamp(self.vecPos.y + (vecMove.y * intDeltaTime), tblToPos.maxVec, 0)
		end
	else
		if ( self.vecPos.y <= tblToPos.maxVec and self.angPos.r ~= 0 ) then
			self.angPos.r = math.Clamp(self.angPos.r + (angMove.r * -1 * intDeltaTime), 0, tblToPos.maxVec * -1)
		else
			self.vecPos.y = math.Clamp(self.vecPos.y + (vecMove.y * -1 * intDeltaTime), tblToPos.maxVec, self.vecDefault.y)
		end
	end

	if ( not boolMoving and self.vecPos.y >= tblToPos.maxVec + 1 and self.vecPos.y <= self.vecDefault.y - 1 ) then
		boolMoving = true
	end

	if ( boolMoving ) then
		if ( not self.soundMoving ) then self.soundMoving = CreateSound(self, "plats/crane/vertical_start.wav") end
		if ( not self.soundMoving:IsPlaying() ) then self.soundMoving:Play() end
	else
		self:RemoveSound()
	end

	phys:Wake()
	
	self.tblShadow.secondstoarrive = 0.0001
	self.tblShadow.pos = self.truck:LocalToWorld(self.vecPos)
	self.tblShadow.angle = self.truck:LocalToWorldAngles(self.angPos)
	self.tblShadow.maxangular = 5000
	self.tblShadow.maxangulardamp = 10000
	self.tblShadow.maxspeed = 1000000
	self.tblShadow.maxspeeddamp = 10000
	self.tblShadow.dampfactor = 0.8
	self.tblShadow.teleportdistance = 200
	self.tblShadow.deltatime = intDeltaTime

	phys:ComputeShadowControl(self.tblShadow)
end

function ENT:OnRemove()
	self:RemoveSound()
end