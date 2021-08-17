--local toRemove = {"env_fire","trigger_hurt","prop_physics","prop_ragdoll","light","spotlight_end","beam","point_spotlight","env_sprite","func_tracktrain","light_spot","point_template"}


hook.Add("Initialize", "remove_useless_shit", function()
 	hook.Remove("PlayerTick","TickWidgets")
	hook.Remove("Think", "CheckSchedules")
	hook.Remove("LoadGModSave", "LoadGModSave")

	timer.Destroy("HostnameThink")

 	if SERVER then
 		if timer.Exists("CheckHookTimes") then
 			timer.Remove("CheckHookTimes")
 		end
 	end
		
	--for k, v in pairs(ents.GetAll()) do
	--	if table.HasValue(toRemove, v:GetClass()) then
	--		print("[Clutter collector]", "Removing:", v:GetClass())
	--		v:Remove()
	--	end
	--end
	
	 if CLIENT then
 		-- Stolen from some facepunch thread.
 		--Render
 		hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
 		hook.Remove("RenderScreenspaceEffects", "RenderBloom")
 		hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
 		hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
 		hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
 		hook.Remove("RenderScreenspaceEffects", "RenderSobel")
 		hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
 		hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
 		hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
 		hook.Remove("RenderScene", "RenderStereoscopy")
 		hook.Remove("RenderScene", "RenderSuperDoF")
 		hook.Remove("PostRender", "RenderFrameBlend")
 		hook.Remove("PreRender", "PreRenderFrameBlend")
 		hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
 		-- GUI
 		hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
 		hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
 		hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
 		-- Think
 		hook.Remove("Think", "DOFThink")
 		-- Other
 		hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
 		-- Widget
 		hook.Remove("PostDrawEffects", "RenderWidgets")
 		--hook.Remove("PostDrawEffects", "RenderHalos")
 	end
end)


-- Given to me
--hook.Add("OnEntityCreated", "remove_widgets_on_spawn", function(ent)
--	if ent:IsWidget() then
--		hook.Add("PlayerTick", "TickWidgets", function(pl, mv) widgets.PlayerTick(pl, mv) end)
--		hook.Remove("OnEntityCreated","WidgetInit")
--	end
--end)




