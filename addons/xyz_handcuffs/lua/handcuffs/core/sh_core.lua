hook.Add("canLockpick", "xyz_handcuff_lockpick", function(ply, ent)
	if CLIENT then return end
	if IsValid(ent) and ent:IsPlayer() and (ent:XYZIsArrested() or PrisonSystem.IsArrested(ent)) then
		return true
	end
end)

hook.Add("onLockpickCompleted", "xyz_handcuff_lockpick", function(ply, bool, ent)
	if CLIENT then return end
	if not bool then return end
	if not IsValid(ent) or not ent:IsPlayer() then return end
	if not PrisonSystem.IsArrested(ent) and not ent:XYZIsArrested() then return end

	if PrisonSystem.IsArrested(ent) then
		local oldPos = ent:GetPos()
		PrisonSystem.UnArrest(ent)
		--print("xyz_handcuff_lockpick pre timer", ent)
		--timer.Simple(0.15, function()
		--	print("xyz_handcuff_lockpick post timer", ent)
		--	ent:SetPos(oldPos)
		--end)
	elseif ent:XYZIsArrested() then
		ent:XYZUnarrest()
	end
end)