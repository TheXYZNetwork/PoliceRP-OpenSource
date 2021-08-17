include("shared.lua")

local width = 220
local offset = 90
local shader = Color(0, 0, 0, 55)
local addonColor = Color(100, 100, 100)
function ENT:Draw()
	self:DrawModel()
	if not XYZSettings.GetSetting("overhead_toggle", true) then return end
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end

	local ang = LocalPlayer():EyeAngles();
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	if XYZSettings.GetSetting("overhead_position", "Side") == "Top" then
		cam.Start3D2D(self:GetPos() + (self:GetUp()*76), ang, 0.07)
		offset = -width*0.5
	else
		cam.Start3D2D(self:GetPos() + (self:GetUp()*68), ang, 0.07)
		offset = 75
	end
		-- Base background
		XYZUI.DrawShadowedBox(offset, 0, width, 65)
		draw.RoundedBox(0, offset+5, 5, width-10, 10, addonColor)
		draw.RoundedBox(0, offset+5, 10, width-10, 5, shader)

		XYZUI.DrawText("Black Market", 45, offset + (width*0.5), 37, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

net.Receive("xyz_smuggler_menu", function()
	local npc = net.ReadEntity()

	-- Build a set of items, using a random pool
	if not npc.itemsPool then
		npc.itemsPool = {}

		local pool = {}
		for k, v in pairs(npc.Items) do
			if not v.random then
				npc.itemsPool[k] = v
				continue
			end

			pool[k] = v
		end

		for i=1, npc.TotalRandomItems do
			local ranV, ranK = table.Random(pool)

			npc.itemsPool[ranK] = ranV

			pool[ranK] = nil
		end
	end

	local frame = XYZUI.Frame("Black Market", Color(100, 100, 100))
	frame:SetSize(ScrH()*0.5, ScrH()*0.4)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local _, list = XYZUI.Lists(frame, 1)

	for k, v in pairs(npc.itemsPool) do
		local wepData
		if v.func then
			wepData = {
				PrintName = v.ent
			}
		else
			weapons.Get(v.ent)
		end
		if not wepData then continue end

		local card = XYZUI.Card(list, 60)
		card:InvalidateParent(true)
		card:DockMargin(0, 0, 0, 5)

		local a = XYZUI.Title(card, wepData.PrintName, DarkRP.formatMoney(v.price), 30)
		a:DockMargin(5, 0, 5, 0)
		a:Dock(FILL)

		local b = XYZUI.ButtonInput(card, "Buy", function()
			net.Start("xyz_smuggler_spawn")
				net.WriteEntity(npc)
				net.WriteInt(k, 32)
			net.SendToServer()
			frame:Close()
		end)
		b:DockMargin(10, 10, 10, 10)
		b:Dock(RIGHT)

		if not v.func then
			local m = vgui.Create("DModelPanel", card)
			m:Dock(LEFT)
			m:SetModel(wepData.ViewModel)
			local mn, mx = m.Entity:GetRenderBounds()
			local size = 0
			size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
			size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
			size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
			m:SetFOV(40)
			m:SetCamPos(Vector(size+4, size+4, size+4))
			m:SetLookAt((mn + mx)*0.5)
		end
	end
end)