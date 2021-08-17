include("shared.lua")

local width = 300
local offset = 90
local shader = Color(0, 0, 0, 55)
local addonColor = Color(40, 160, 40)
function ENT:Draw()
	self:DrawModel()
	if not XYZSettings.GetSetting("overhead_toggle", true) then return end
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end

	local ang = LocalPlayer():EyeAngles();
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	if XYZSettings.GetSetting("overhead_position", "Side") == "Top" then
		cam.Start3D2D(self:GetPos() + (self:GetUp()*79), ang, 0.07)
		offset = -width*0.5
	else
		cam.Start3D2D(self:GetPos() + (self:GetUp()*68), ang, 0.07)
		offset = 60
	end
		-- Base background
		XYZUI.DrawShadowedBox(offset, 0, width, 65)
		draw.RoundedBox(0, offset+5, 5, width-10, 10, addonColor)
		draw.RoundedBox(0, offset+5, 10, width-10, 5, shader)

		XYZUI.DrawText("Weapon Armory", 45, offset + (width*0.5), 37, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end


net.Receive("XYZArmoryOpenUI", function()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame("Weapon Armory", Color(40, 160, 40))
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local _, contList = XYZUI.Lists(shell, 1)
	contList:DockPadding(5, 5, 5, 5)

	for k, v in pairs(XYZArmoryItems) do
		local weaponInfo = weapons.Get(v.class)
		if not weaponInfo then continue end

		if not v.check(LocalPlayer()) then continue end
		if LocalPlayer():HasWeapon(v.class) then continue end

		local card = XYZUI.Card(contList, 60)
		card:DockMargin(0, 0, 0, 5)
	
		if weaponInfo.WorldModel then
			local model = vgui.Create("DModelPanel", card)
			model:SetSize(card:GetTall(), card:GetTall())
			model:Dock(LEFT)
			model:SetModel(weaponInfo.WorldModel)
			model:DockMargin(0, 3, 2, 3)

				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = model.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				model:SetFOV(40)
				model:SetCamPos( Vector( size+4, size+4, size+4 ) )
				model:SetLookAt( ( mn + mx ) * 0.5 )
				-- *|*
		end

		local title = XYZUI.PanelText(card, weaponInfo.PrintName, 40, TEXT_ALIGN_LEFT)
		title:Dock(FILL)
		title:DockMargin(5, 10, 0, 10)

		local useButton = XYZUI.ButtonInput(card, "Use", function()
			net.Start("XYZArmoryCollectWeapon")
				net.WriteEntity(npc)
				net.WriteInt(k, 32)
			net.SendToServer()
			frame:Close()
		end)
		useButton:Dock(RIGHT)
		useButton:SetWide(frame:GetWide()/5)
		useButton:DockMargin(10, 10, 10, 10)
	end
end)