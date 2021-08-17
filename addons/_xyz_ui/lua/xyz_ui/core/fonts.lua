--local defaultDefault = "Lato"
--local defaultDefault = "Leeawadee"
--local defaultDefault = "MS Reference Sans"
--local defaultDefault = "Roboto"
--local defaultDefault = "Myriad"

function XYZUI.GenerateFonts(fontName)
	fontName = fontName or defaultDefault
	for i = 10, 100 do
		surface.CreateFont("xyz_ui_main_font_"..i, {
			font = fontName,
			size = i,
			weight = 100
		})
	end
	
	for i = 1, 40 do
		surface.CreateFont("xyz_ui_scale_font_"..i, {
			font = fontName,
			size = ScreenScale(i),
			weight = 100
		})
	end
end

XYZUI.GenerateFonts("Calibri")