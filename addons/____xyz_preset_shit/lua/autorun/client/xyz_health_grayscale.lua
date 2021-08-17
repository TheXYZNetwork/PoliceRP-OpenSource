local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

hook.Add("RenderScreenspaceEffects", "XYZHealthGrayScale", function()
	if not LocalPlayer():Alive() then return end

	local plyHP = LocalPlayer():Health()
	local modifier = math.Clamp(plyHP/75, 0, 1)
	tab["$pp_colour_colour"] = modifier
--
	DrawColorModify(tab)
	-- Might play with motion blur again later, but currently it's just too eye fuckering
	-- DrawMotionBlur(math.Clamp(modifier, 0.5, 1), 0.8, 0.01)
	DrawBokehDOF(2, 1-modifier, 5)
end)