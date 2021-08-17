APG.Detours = APG.Detours or {}

if AdvDupe2.InitPastingQueue then 
	APG.Detours["AdvDupePastingQueue"] = APG.Detours["AdvDupePastingQueue"] or AdvDupe2.InitPastingQueue
	function AdvDupe2.InitPastingQueue(Player, PositionOffset, AngleOffset, OrigPos, Constrs, Parenting, DisableParents, DisableProtection)
		local maxScale = APG.cfg[ "maxScale" ].value
		for k,v in pairs(Player.AdvDupe2.Entities) do 
			if v.ModelScale and v.ModelScale > maxScale then
				v.ModelScale = maxScale
			end
		end

		if Player.AdvDupe2.Constraints then
			//print("test")
			for k, Constraint in pairs( Player.AdvDupe2.Constraints ) do
				if(Constraint.Type == "Rope") then //table.remove( Player.AdvDupe2.Constraints, k) end
					Player.AdvDupe2.Constraints[k] = nil
				end
			end
		end
	
		APG.Detours["AdvDupePastingQueue"](Player, PositionOffset, AngleOffset, OrigPos, Constrs, Parenting, DisableParents, DisableProtection)
	end

end
