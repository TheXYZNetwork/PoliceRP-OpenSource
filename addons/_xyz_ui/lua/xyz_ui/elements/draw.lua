-- Cache
local scrW, scrH = ScrW, ScrH
local vgui_create = vgui.Create
local color = Color
local draw_box = draw.RoundedBox
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated
local math_floor = math.floor
local math_round = math.Round
local lerp = Lerp

-- Color cache
local background = color(18, 18, 18)
local backgroundShaded = color(20, 20, 20)
local white = color(255, 255, 255)
local black = color(0, 0, 0)
local outline = color(31, 31, 31)
local bubble = color(120, 120, 120)
local headerShader = color(0, 0, 0, 55)
local headerDefault = color(2, 108, 254)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")
local gradientCenter = Material("gui/center_gradient")

local gradientSize = 20


local sinCache = {}
local cosCache = {}
for i = 0, 360 do
	sinCache[i] = math.sin(math.rad(i))
	cosCache[i] = math.cos(math.rad(i))
end
function XYZUI.DrawCircle(x, y, r, step)
    local positions = {}

    for i = 0, 360, step do
        table.insert(positions, {
            x = x + cosCache[i] * r,
            y = y + sinCache[i] * r
        })
    end

    return surface.DrawPoly(positions)
end


function XYZUI.DrawText(text, size, posx, posy, color, align1, align2)
	return draw.SimpleText(text or "Sample Text", "xyz_ui_main_font_"..(size or 10), posx or 0, posy or 0, color or black, align1 or TEXT_ALIGN_CENTER, align2 or TEXT_ALIGN_CENTER)
end
function XYZUI.DrawTextOutlined(text, size, posx, posy, color, align1, align2, thickness, lineColor)
	return draw.SimpleTextOutlined(text or "Sample Text", "xyz_ui_main_font_"..(size or 10), posx or 0, posy or 0, color or black, align1 or TEXT_ALIGN_CENTER, align2 or TEXT_ALIGN_CENTER, thickness or 2, lineColor or black)
end
function XYZUI.DrawScaleText(text, size, posx, posy, color, align1, align2)
	return draw.SimpleText(text or "Sample Text", "xyz_ui_scale_font_"..(size or 10), posx or 0, posy or 0, color or black, align1 or TEXT_ALIGN_CENTER, align2 or TEXT_ALIGN_CENTER)
end

function XYZUI.DrawLineBreakText(text, size, posx, posy, align1, align2, color)
	text = string.Split(text or "", "\n")
	size = size or 20

	local space = size*#text
	local startingPos = posy-(space/2)+(size/2)

	--print(posy, space, startingPos)
	for k, v in pairs(text) do
		XYZUI.DrawText(v, size, posx, startingPos+((k-1)*size), color or white, align1, align2)
	end
end

function XYZUI.DrawShadowedBox(posx, posy, w, h)
	draw_box(0, posx, posy, w, h, background)
	
	surface_setdrawcolor(0, 0, 0, 255)
	surface_setmaterial(gradientDown)
	surface_drawtexturedrect(posx, posy, w, gradientSize)
	surface_setmaterial(gradientUp)
	surface_drawtexturedrect(posx, posy+h-gradientSize, w, gradientSize)
	surface_setmaterial(gradientMain)
	surface_drawtexturedrect(posx, posy, gradientSize, h)
	surface_drawtexturedrectrotated(posx+w-(gradientSize/2), posy+h/2, gradientSize, h, 180)
end


local blur = Material("pp/blurscreen")
function XYZUI.DrawBlur(posx, posy, w, h, amount)
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 6 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(posx * -1, posy * -1, w, h)
	end
end