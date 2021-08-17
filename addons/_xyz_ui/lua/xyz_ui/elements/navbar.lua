-- Cache
local vgui_create = vgui.Create
local draw_box = draw.RoundedBox
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated
local color = Color

-- Color cache
local background = color(18, 18, 18)
local outline = color(31, 31, 31)
local white = color(222, 222, 222)
local headerDefault = color(2, 108, 254)
local headerShader = color(0, 0, 0, 55)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")
local gradientCenter = Material("gui/center_gradient")

local gradientSize = 10
function XYZUI.NavBar(frame, isSide)
	if not IsValid(frame) then return end

	local _, navBar = XYZUI.Lists(frame, 1)
	if isSide then
		navBar:SetWide(frame:GetWide()/4)
		navBar:Dock(LEFT)
		navBar:DockMargin(0, 0, 10, 0)
	else
		navBar:SetTall(35)
		navBar:Dock(TOP)
		navBar:DockMargin(0, 0, 0, 10)
	end

	navBar.master = frame.master
	navBar.headerColor = frame.headerColor or headerDefault
	navBar.isSide = isSide
	navBar.currentFocus = nil

	return navBar
end

function XYZUI.AddNavBarPage(nav, container, name, callback, size)
	if not IsValid(nav) then return end

	local button = vgui_create("DButton", nav)
	if nav.isSide then
		button:Dock(TOP)
		button:SetTall((size or 20)+20)
	else
		button:Dock(LEFT)
		button:SetTall(nav:GetTall())
		local navChildren = nav:GetChildren()[1]:GetChildren()
		if navChildren then
			nav:InvalidateParent(true)
			local buttonSize = nav:GetWide()/#navChildren
			for k, v in pairs(navChildren) do
				v:SetWide(buttonSize)
			end
		else
			button:SetWide(80)
		end
	end
	button:SetText("")
	
	button.master = nav.master
	button.headerColor = nav.headerColor or headerDefault

	function button.Paint(self, w, h)
		surface_setdrawcolor(0, 0, 0, 255)
		surface_setmaterial(gradientDown)
		surface_drawtexturedrect(0, 0, w, gradientSize)
		surface_setmaterial(gradientUp)
		surface_drawtexturedrect(0, h-gradientSize, w, gradientSize)
		surface_setmaterial(gradientMain)
		surface_drawtexturedrect(0, 0, gradientSize, h)
		surface_drawtexturedrectrotated(w-(gradientSize/2), h/2, gradientSize, h, 180)
	
		draw_box(0, 0, 0, w, 2, outline)
		draw_box(0, w-2, 0, 2, h, outline)
		draw_box(0, 0, h-2, w, 2, outline)
		draw_box(0, 0, 0, 2, h, outline)
		XYZUI.DrawText(name, size or 20, w/2, h/2, white)
	end

	function button.DoClick()
		if not IsValid(container) then return end
		container:Clear()
		nav.currentFocus = button
		callback(container)
	end

	if not nav.currentFocus then
		timer.Simple(0.1, function()
			if not IsValid(button) then return end
			button.DoClick()
		end)
		nav.currentFocus = button
	end

	return button
end