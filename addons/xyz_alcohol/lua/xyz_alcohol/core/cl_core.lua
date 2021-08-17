net.Receive("Alcohol:Units:Change", function()
	Alcohol.Units = net.ReadUInt(7)
end)


local lastForcedMovement = 0
hook.Add("RenderScreenspaceEffects", "Alcohol:Visuals", function()
	if (not Alcohol.Units) or (Alcohol.Units < Alcohol.Config.DrunkAmount) then return end

	DrawToyTown(2, ScrH()*0.3)
	DrawBokehDOF(1.8, 0.9, 8)
	DrawMotionBlur(math.Clamp((Alcohol.Config.Death - (Alcohol.Units))/Alcohol.Config.Death, 0.05, 1), 10, 0)


	if lastForcedMovement + 1 > CurTime() then return end

	lastForcedMovement = CurTime()
	-- Trigger random movements
	local movementChange = math.random(0, 10)
	if movementChange == 10 then
		local movementType = table.Random(Alcohol.Config.ForceInputs)
		LocalPlayer():ConCommand("+"..movementType)
		LocalPlayer():ConCommand("+strafe")
		timer.Simple(0.2, function()
			LocalPlayer():ConCommand("-"..movementType)
			LocalPlayer():ConCommand("-strafe")
		end)
	end
end)