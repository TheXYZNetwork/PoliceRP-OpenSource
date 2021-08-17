local activeFinishPos = nil
net.Receive("xyz_racing_start", function()
	local pos = net.ReadVector()

	activeFinishPos = pos
end)

net.Receive("xyz_racing_finish", function()
	activeFinishPos = nil
end)

local mat = Material("cable/green") -- Caching a material
hook.Add("PostDrawTranslucentRenderables", "xyz_race_wire", function()
	if activeFinishPos then
		render.SetMaterial(mat)
		render.DrawBeam(LocalPlayer():GetPos(), activeFinishPos, 1, 0, LocalPlayer():GetPos():Distance(activeFinishPos), Color(255,0,0))
	end
end)

hook.Add("HUDPaint", "xyz_race_end_text", function()
	if activeFinishPos then
		local pos = activeFinishPos:ToScreen()
		XYZUI.DrawShadowedBox(pos.x-80, pos.y-25, 160, 50, 3)
		XYZUI.DrawText("Race end", "40", pos.x, pos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)
