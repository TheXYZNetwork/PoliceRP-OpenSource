xLogs.RegisterCategory("Props", "Sandbox")
xLogs.RegisterCategory("Toolgun", "Sandbox")
hook.Add("PlayerSpawnedProp", "xLogsSandbox-Props", function(ply, model)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." spawned "..xLogs.Core.Color(model, Color(0, 200, 0)), "Props")
end)

hook.Add("CanTool", "xLogsSandbox-Toolgun", function(ply, tr, tool)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." used "..xLogs.Core.Color(tool, Color(0, 200, 0)), "Toolgun")
end)