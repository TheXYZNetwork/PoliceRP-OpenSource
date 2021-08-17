-- Cache
local vgui_create = vgui.Create
local color = Color
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated
local draw_box = draw.RoundedBox

-- Color cache
local background = color(18, 18, 18)
local outline = color(31, 31, 31)
local headerShader = color(0, 0, 0, 55)
local headerDefault = color(2, 108, 254)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")

local gradientSize = 20
function XYZUI.Lists(container, count)
	container:InvalidateParent(true)
	local returnTbl = {}
	for i= 1, count do
		local column = vgui_create("DScrollPanel", container)
		if count == 1 then
			column:Dock(FILL)
		else
			column:SetWide((container:GetWide()/count))
			column:Dock(LEFT)
		end
		column:DockPadding(5, 5, 5, 5)
		function column.Paint(self, w, h)
			draw_box(0, 0, 0, w, h, background)
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
		end

		column.headerColor = container.headerColor or headerDefault
		column.master = container.master
		table.insert(returnTbl, column)
		
		local sbar = column:GetVBar()
		sbar:SetWide(sbar:GetWide()/2)
		sbar:SetHideButtons(true)
		function sbar:Paint(w, h)
			draw_box(0, 0, 0, w, h, background)
		end
		function sbar.btnGrip:Paint(w, h)
			draw_box(0, 0, 0, w, h, container.headerColor or headerDefault)
			draw_box(0, 0, 0, w, h, headerShader)
		end
	end

	return returnTbl, unpack(returnTbl)
end