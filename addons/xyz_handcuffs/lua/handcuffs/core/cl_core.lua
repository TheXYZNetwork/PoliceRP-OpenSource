local colormod = {
	["$pp_colour_brightness"] = -1,
}

net.Receive("hc_blindfold", function()
	if hook.GetTable().RenderScreenspaceEffects["XYZZiptieBlindfold"] then 
		hook.Remove("RenderScreenspaceEffects", "XYZZiptieBlindfold")
	else
		hook.Add("RenderScreenspaceEffects", "XYZZiptieBlindfold", function()
			DrawColorModify(colormod)
		end)
	end
end)