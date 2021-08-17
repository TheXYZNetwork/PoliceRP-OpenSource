net.Receive("towtruck_spawn", function(_, ply)
	if not (ply:Team() == TEAM_MECHANIC) then return end
	local npc = net.ReadEntity()

	if not (npc:GetClass() == "xyz_tow_truck_agency") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if npc.coolDown > CurTime() then return end
	npc.coolDown = CurTime() + 2

	if IsValid(ply.TowTruck) then
		ply.TowTruck:Remove()
	end

	local truck = ents.Create("prop_vehicle_jeep")
	truck:SetPos(npc:GetPos()+(npc:GetForward()*115))
	truck:SetAngles(npc:GetAngles())
	truck:SetModel("models/cipro/tow_truck/towtruck.mdl")
	truck:SetKeyValue("vehiclescript", "scripts/vehicles/tow_truck/tow_truck.txt")
	truck:Spawn()
	truck:Activate()
	truck:SetVehicleClass("tow_truck")
	truck:keysOwn(ply)
	truck.owner = ply

	truck.trailer = ents.Create("xyz_tow_truck_trailer")
	truck.trailer:SetPos(truck:LocalToWorld(XYZTowTruck.Positions.pos.vec))
	truck.trailer:SetAngles(truck:GetAngles())
	truck.trailer:Spawn()
	truck.trailer:Activate()
    truck:DeleteOnRemove(truck.trailer)
	truck.trailer.truck = truck -- Yes, I know. Needed for ComputeShadowControl
	--timer.Simple(1, function()
	--	if ( IsValid(truck.trailer) ) then
	--		constraint.NoCollide(truck, truck.trailer, 0, 0)
	--	else
	--		truck:Remove()
	--	end
	--end)
	truck.hook = ents.Create("xyz_tow_truck_hook_base")
    if ( not IsValid(truck.hook) ) then return end
    truck.hook:SetPos(truck.trailer:LocalToWorld(XYZTowTruck.Positions.hookpos.vec))
    truck.hook:SetAngles(truck.trailer:LocalToWorldAngles(XYZTowTruck.Positions.hookpos.ang))
    truck.hook:Spawn()
    truck.hook:Activate()
    truck.hook:SetParent(truck.trailer)
    constraint.NoCollide(truck, truck.hook, 0, 0)
    truck:MSystem_Lock(true)
	ply:EnterVehicle(truck)

	ply.TowTruck = truck

	XYZShit.Msg("Mechanic", Color(213, 195, 30), "Your truck has been spawned.", ply)
end)

hook.Add("OnPlayerChangedTeam", "xyz_remove_truck", function(ply)
	if IsValid(ply.TowTruck) then
		ply.TowTruck:Remove()
		XYZShit.Msg("Mechanic", Color(213, 195, 30), "Your truck has been removed.", ply)
	end
end)
hook.Add("PlayerDisconnected", "xyz_remove_truck", function(ply)
	if IsValid(ply.TowTruck) then
		ply.TowTruck:Remove()
	end
end)

XYZTowTruck.Positions = {
	pos = {
		vec = Vector(0, -1, 7),
		ang = Angle(0, 0, 0)
	},
	topos = {
		vec = Angle(-0, -0, -180):Right() * -20,
		maxVec = -160,
		ang = Angle(0, 0, 5),
		maxAng = 16
	},
	hookpos = {
        vec = Vector(0, 39, 70),
        ang = Angle(0, 90, 0)
    }
}

local ENT = FindMetaTable("Entity")
function ENT:MSystem_Lock(boolLock)
    local entTrailer = self.trailer

    if ( not entTrailer:IsUp() ) then
        return false
    end

    entTrailer:Lock(boolLock, self) 

    local entHook = self.hook
    local entTrailer = self.trailer
    
    if ( boolLock ) then
        if ( entHook:IsAttached() ) then
            local entAttached = entHook.ent

            constraint.Weld(self.trailer, entAttached, 0, 0)
            
            entAttached:SetHandbrake(true)

            -- Disable all collisions to avoid lag
            for i = 1, self:GetPhysicsObjectCount() do
            	local phys = self:GetPhysicsObjectNum(i - 1)

            	if ( IsValid(phys) ) then
            		phys:EnableCollisions(not bool)
            		phys:RecheckCollisionFilter()
            	end
            end

            -- Disable wheels damping of vehicle
            entAttached.wheels = entAttached.wheels or {}

            for i = 1, self:GetWheelCount() do
            	local wheel = entAttached:GetWheel(i - 1)

            	if ( not IsValid(wheel) ) then continue end
            	entAttached.wheels[i] = { wheel:GetDamping() }
            	wheel:SetDamping(1, 50)
            end

            entTrailer:StopMotionController()
        end
    else
        local pDriver = self:GetDriver()

        if ( IsValid(pDriver) ) then
            pDriver:ExitVehicle()
        end

        if ( entHook:IsAttached() ) then
            local entAttached = entHook.ent

            entAttached:SetHandbrake(false)

            -- Enable all collisions to avoid lag
            for i = 1, entAttached:GetPhysicsObjectCount() do
                local phys = entAttached:GetPhysicsObjectNum(i - 1)

                if ( IsValid(phys) ) then
                    phys:EnableCollisions(true)
                    phys:RecheckCollisionFilter()
                end
            end

            -- Set wheels damping of vehicle
            entAttached.wheels = entAttached.wheels or {}

            for i = 1, entAttached:GetWheelCount() do
                local wheel = entAttached:GetWheel(i - 1)

                if not IsValid(wheel) then continue end
                local tblWheel = entAttached.wheels[i]
                if not tblWheel then return end
                wheel:SetDamping(tblWheel[1], tblWheel[2])
            end
        end
    end

    return true
end

function ENT:MSystem_HasRope()
    if ( not self:GetClass() == "tow_truck" ) then return false end

    local entHook = self.hook

    if ( not entHook:IsAttached() ) then return false end

    return true
end