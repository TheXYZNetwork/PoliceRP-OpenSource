local NPC
net.Receive("WepSkin:OpenUI", function()
	NPC = net.ReadEntity()

	WepSkins.Core.HUBUI()
end)

local color = Color
local draw_box = draw.RoundedBox
local background = color(18, 18, 18)
local outline = color(31, 31, 31)
local headerShader = color(0, 0, 0, 55)
local headerDefault = color(2, 108, 254)
function WepSkins.Core.HUBUI()
	local frame = XYZUI.Frame("Weapon Skins", Color(200, 100, 0))
	frame:SetSize(ScrH()*0.8, ScrH()*0.8)
	frame:Center()

    --local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)
	shell.Paint = function() end


	local searchInput, searchContainer = XYZUI.TextInput(shell)
	searchContainer:SetTall(40)
	searchContainer:DockMargin(0, 0, 0, 5)


	local contList = vgui.Create("ThreeGrid", shell)
	contList:Dock(FILL)
	--contList:SetTall(math.ceil(table.Count(WepSkins.Config.Weps)/4)*200)
	contList:SetWide(shell:GetWide())
	contList:InvalidateParent(true)
	contList:SetColumns(4)
	
		local sbar = contList:GetVBar()
		sbar:SetWide(sbar:GetWide()/2)
		sbar:SetHideButtons(true)
		function sbar:Paint(w, h)
			draw_box(0, 0, 0, w, h, background)
		end
		function sbar.btnGrip:Paint(w, h)
			draw_box(0, 0, 0, w, h, shell.headerColor or headerDefault)
			draw_box(0, 0, 0, w, h, headerShader)
		end


	local function populate(keyWord)
		contList:Clear()

		for k, v in pairs(WepSkins.Config.Weps) do
			local wepData = weapons.Get(k)
			if not wepData then continue end

			if not (keyWord == "") then
				if not string.find(string.lower(wepData.PrintName), string.lower(keyWord)) then continue end
			end

			local card = XYZUI.Card(contList, frame:GetWide()/8)
			card:DockMargin(0, 0, 5, 5)
			card:SetTall(200)
			contList:AddCell(card)
		
			local model = vgui.Create("DModelPanel", card)
			model:SetSize(card:GetTall(), card:GetTall())
			model:Dock(FILL)
			model:SetModel(wepData.ViewModel)
			model:DockMargin(2, 2, 2, 2)
			model.LayoutEntity = function() end
			model.DoClick = function()
				frame:Close()
				WepSkins.Core.SkinSelectUI(k)
			end
		
				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = model.Entity:GetRenderBounds()
				local size = 0
				size = math.max(size, math.abs(mn.x)+math.abs(mx.x))
				size = math.max(size, math.abs(mn.y)+math.abs(mx.y))
				size = math.max(size, math.abs(mn.z)+math.abs(mx.z))
				model:SetFOV(30)
				model:SetCamPos(Vector(size+4, size+4, size+5))
				model:SetLookAt((mn+mx) * 0.5)
				-- *|*


			local btn = XYZUI.ButtonInput(card, wepData.PrintName, function()
				frame:Close()
				WepSkins.Core.SkinSelectUI(k)
			end)
			btn:Dock(BOTTOM)
			btn:SetTall(30)
			btn.headerColor = Color(200, 100, 0)
		end

	end

	timer.Simple(0.1, function() -- Cus gmod
		populate("")
	end)

	function searchInput.OnTextChanged()
		populate(searchInput:GetText())
	end
end

function WepSkins.Core.SkinSelectUI(wepClass)
	local wepData = weapons.Get(wepClass)
	if not wepData then return end

	local activeSkin

	local frame = XYZUI.Frame("Weapon Skins - "..wepData.PrintName, Color(200, 100, 0))
	frame:SetSize(ScrH()*0.8, ScrH()*0.8)
	frame:Center()

    --local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)
	shell.Paint = function() end


	local viewShell = XYZUI.Container(shell)
	viewShell:Dock(TOP)
	viewShell:SetTall(frame:GetTall()/3)

			local wepName = XYZUI.PanelText(viewShell, wepData.PrintName, 50, TEXT_ALIGN_CENTER)		


			local model = vgui.Create("DAdjustableModelPanel", viewShell)
			model:SetSize(viewShell:GetTall(), viewShell:GetTall())
			model:Dock(FILL)
			model:SetModel(wepData.ViewModel)
			model:DockMargin(2, 2, 2, 2)
			model.LayoutEntity = function() end

			model:SetFirstPerson(false)
			model:SetCamPos(Vector(6, -114, 0))
			model:SetLookAng(Angle(2, 90, 0))
			model:SetFOV(30)

			-- Apply current texture
			if WepSkins.Config.Skins[wepClass] then
				model.Entity:SetSubMaterial(WepSkins.Config.Weps[wepClass], WepSkins.Config.Skins[WepSkins.Core.MySkins[wepClass]].path)
			end
--				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
--				local mn, mx = model.Entity:GetRenderBounds()
--				local size = 0
--				size = math.max(size, math.abs(mn.x)+math.abs(mx.x))
--				size = math.max(size, math.abs(mn.y)+math.abs(mx.y))
--				size = math.max(size, math.abs(mn.z)+math.abs(mx.z))
--				model:SetFOV(50)
--				model:SetCamPos(Vector(size, size, size))
--				model:SetLookAt((mn+mx) * 0.5)
--				-- *|*

	local skinShell = XYZUI.Container(shell)
	skinShell:Dock(FILL)
	skinShell.Paint = function() end

	local contList = vgui.Create("ThreeGrid", skinShell)
	contList:Dock(FILL)
	--contList:SetTall(math.ceil(table.Count(WepSkins.Config.Weps)/4)*200)
	contList:SetWide(skinShell:GetWide())
	contList:InvalidateParent(true)
	contList:SetColumns(4)
	
		local sbar = contList:GetVBar()
		sbar:SetWide(sbar:GetWide()/2)
		sbar:SetHideButtons(true)
		function sbar:Paint(w, h)
			draw_box(0, 0, 0, w, h, background)
		end
		function sbar.btnGrip:Paint(w, h)
			draw_box(0, 0, 0, w, h, shell.headerColor or headerDefault)
			draw_box(0, 0, 0, w, h, headerShader)
		end

	timer.Simple(0.1, function() -- Cus gmod
		for k, v in pairs(WepSkins.Config.Skins) do
			local card = XYZUI.Card(contList, frame:GetWide()/8)
			card:DockMargin(0, 0, 5, 5)
			card:SetTall(200)
			contList:AddCell(card)
		
			local material = vgui.Create("DImage", card)
			material:SetSize(card:GetTall(), card:GetTall())
			material:Dock(FILL)
			--material:SetMaterial(Material(v.path))
			if not (v.path == "") then
				material:SetImage(v.path) -- Using image cus material was being gay and flickering.
			end
			material:DockMargin(2, 2, 2, 2)


			local btn = XYZUI.ButtonInput(card, v.name.." - $"..string.Comma(v.price), function()
				if WepSkins.Core.MySkins[wepClass] and (WepSkins.Core.MySkins[wepClass] == k) then return end

				model.Entity:SetSubMaterial(WepSkins.Config.Weps[wepClass], v.path)
				activeSkin = k
			end)
			btn:Dock(BOTTOM)
			btn:SetTall(30)

			-- This is their active skin
			if WepSkins.Core.MySkins[wepClass] and (WepSkins.Core.MySkins[wepClass] == k) then
				btn.headerColor = Color(100, 100, 100)
			else
				btn.headerColor = Color(200, 100, 0)
			end
		end
	end)


	local finishShell = XYZUI.Container(shell)
	finishShell:Dock(BOTTOM)
	finishShell:SetTall(40)
	finishShell.Paint = function() end

	local cancel = XYZUI.ButtonInput(finishShell, "Go Back", function()
		frame:Close()
		WepSkins.Core.HUBUI()
	end)
	cancel:Dock(LEFT)
	cancel:SetTall(30)
	cancel:SetWide(80)
	cancel.headerColor = Color(200, 0, 0)


	local purchase = XYZUI.ButtonInput(finishShell, "Purchase Selected Skin", function()
		if not activeSkin then return end -- No skin selected

		XYZUI.Confirm("Purchase "..WepSkins.Config.Skins[activeSkin].name.." for $"..string.Comma(WepSkins.Config.Skins[activeSkin].price), Color(0, 120, 0), function()
			net.Start("WepSkin:BuySkin")
				net.WriteEntity(NPC)
				net.WriteString(wepClass)
				net.WriteString(activeSkin)
			net.SendToServer()

			frame:Close()
			WepSkins.Core.HUBUI()
		end)
	end)
	purchase:Dock(RIGHT)
	purchase:SetTall(30)
	purchase:SetWide(200)
	purchase.headerColor = Color(0, 120, 0)
end