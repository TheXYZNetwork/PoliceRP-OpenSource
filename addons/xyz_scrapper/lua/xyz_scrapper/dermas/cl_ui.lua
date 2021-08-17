net.Receive("Scrapper:UI", function()

	local npc = net.ReadEntity()
	local vehicle = false

	for k, v in ipairs(ents.GetAll()) do
		if not v:IsVehicle() then continue end
		if v:GetPos():Distance(npc:GetPos()) > 500 then continue end
		if v.getDoorOwner and (v:getDoorOwner() == LocalPlayer()) then continue end

		vehicle = v

		break
	end

	if not vehicle then
		XYZShit.Msg("Car Scrapper", Scrapper.Config.Color, "No vehicle found to scrap...")
		return
	end


	local frame = XYZUI.Frame("Scrap Vehicle", Scrapper.Config.Color)
	local shell = XYZUI.Container(frame)

	local car = vgui.Create("DModelPanel", shell)
	car:Dock(FILL)
	car:SetModel(vehicle:GetModel())

	-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
	local mn, mx = car.Entity:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
	car:SetFOV( 50 )
	car:SetCamPos( Vector( size+4, size+4, size+4 ) )
	car:SetLookAt( ( mn + mx ) * 0.5 )
	-- *|*

	car:SetColor(vehicle:GetColor())
	for k, v in pairs(vehicle:GetBodyGroups()) do
		car.Entity:SetBodygroup(v.id, v.num)
	end

 	local scrap = XYZUI.ButtonInput(shell, "Sell vehicle for "..DarkRP.formatMoney(math.Round(Scrapper.Config.PriceMultiplier(LocalPlayer(), npc:GetSellPrice()))), function(self)
 		net.Start("Scrapper:Sell")
 			net.WriteEntity(npc)
 			net.WriteEntity(vehicle)
 		net.SendToServer()
 		frame:Close()
    end)
    scrap:Dock(BOTTOM)
end)