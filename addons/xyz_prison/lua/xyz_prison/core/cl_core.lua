net.Receive("PrisonSystem:Sentence", function()
	local prisoner = net.ReadEntity()
	local time = net.ReadUInt(10)

	if not IsValid(prisoner) then return end

	PrisonSystem.Arrested[prisoner:SteamID64()] = {
		start = os.time(),
		length = time
	}
end)

net.Receive("PrisonSystem:Sentence:Destroy", function()
	local prisoner = net.ReadEntity()
	if not IsValid(prisoner) then return end
	PrisonSystem.Arrested[prisoner:SteamID64()] = nil
end)

local arrested, left = NULL, 0
hook.Add("HUDPaint", "PrisonSystem:HUD", function()
	arrested, left = PrisonSystem.IsArrested(ply)
	if not arrested then return end

	XYZUI.DrawScaleText("Time left on sentence: "..string.NiceTime(left), 15, ScrW()*0.5, ScrH()*0.9, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

net.Receive("PrisonSystem:SendArrests", function()
	local data = net.ReadTable()
	PrisonSystem.Arrested = data
end)