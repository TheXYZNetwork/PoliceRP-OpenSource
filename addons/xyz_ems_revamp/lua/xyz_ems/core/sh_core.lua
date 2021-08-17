local nextCheck = 0
local enoughEMS = false
function XYZEMS.Core.EMSOnline()
	if CurTime() < nextCheck then
		return enoughEMS
	end

	nextCheck = CurTime() + 30
	for k, v in pairs(player.GetAll()) do
		if XYZEMS.Core.IsEMS(v) then
			enoughEMS = true
			return true
		end
	end
	enoughEMS = false
	return false
end

function XYZEMS.Core.EMSGetOnline()
	local emsJobs = {}
	for k, v in pairs(player.GetAll()) do
		if XYZEMS.Core.IsEMS(v) then
			table.insert(emsJobs, v)
		end
	end
	return emsJobs
end

function XYZEMS.Core.IsEMS(ply)
	return table.HasValue(XYZShit.Jobs.Government.FR, ply:Team())
end


local tr
local targetPly
function XYZEMS.Core.GetClosestRagdoll(ply)
	tr = ply:GetEyeTrace()
	targetPly = nil

	for k, v in pairs(player.GetAll()) do
		if v:Alive() then continue end
		local ragdoll = v:GetRagdollEntity()
		if not IsValid(ragdoll) then continue end

		if ragdoll:GetPos():DistToSqr(tr.HitPos) > 1000 then continue end
		if ragdoll:GetPos():DistToSqr(ply:GetPos()) > 5000 then continue end
		targetPly = v
		break
	end

	return targetPly
end