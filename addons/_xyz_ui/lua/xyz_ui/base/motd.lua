-- Cache
local color = Color
local vgui_create = vgui.Create

function XYZUI.BuildMOTD()
	local frame = XYZUI.Frame(GetHostName(), color(2, 88, 154))
	frame:SetSize(ScrH()*1, ScrH()*0.9)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local html = vgui_create("DHTML", shell)
	html:Dock(FILL)
	html:OpenURL("https://thexyznetwork.xyz/rules/policerp")
end

concommand.Add("xyz_motd", function()
	XYZUI.BuildMOTD()
end)

hook.Add("XYZOnPlayerChat", "_XYZMOTD", function(ply, text)
	if not (ply == LocalPlayer()) then return end
	if not (string.lower(text) == "!motd") then return end

	XYZUI.BuildMOTD()
end)