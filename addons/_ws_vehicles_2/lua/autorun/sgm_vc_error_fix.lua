///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file is dedicated to help with random addons overriding VCMod funtionality, override the override.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// These are left by SGM in some of his vehicles, back when VCMod used this primitive method.
VC_MakeScripts = function() end
VC_MakeScript = function() end

// Lets only run it on a server
if !SERVER then return end

// Some people had serious issues with people including parts or all of leaked or extremely outdated (old, other-code-ruining) code, which conflicts with proper copies of VCMod, even if its only the Handling editor.
// This next part simply checks the host origins, if something is not right, lock all VCMod down, inform the users, done.

// Display a message to all players
local function ms()
	// Broadcast a message to all playesr
	BroadcastLua([[if !vc_h then local f = vgui.Create("DFrame") f:SetTitle("VCMod FAQ Backdoor") f:SetSize(ScrW()*0.75, ScrH()*0.75) f:Center() f:MakePopup() vc_h = vgui.Create("HTML", f) vc_h:Dock(FILL) vc_h:OpenURL("vcmod.org/help/faq/backdoor/") end]])

	// Print a chat message
	local msg = " \n\n\n\nVCMod: WARNING!\n\nIllegal, backdoored copy found, stopping functionality. Server and players may be at risk!\n\nPlease use a legal copy of VCMod available at: https://vcmod.org/."
	print(msg)
	for k, ply in pairs(player.GetAll()) do
		ply:ChatPrint(msg)
	end
end

// Only simply checks every minute or so for a limited amount of time. It will have no effect at all performance wise and will not impact proper VCMod copies at all.
local function rs()
	local fileData = file.Read("lua/vcmod/server/load.lua", "GAME") if fileData and (string.find(fileData, "teamspeak") or string.find(fileData, "veryleak") or string.find(fileData, "vl.french") or string.find(fileData, "crack")) then ms() VC = "" end

	if VC&&VC~=""then local _="Host compatibility issue, possible leak detected." if VC.Host&&!string.find(VC.Host,"://vcmod.org")||SERVER&&VC["W".."_D".."o_G"]&&!string.find(VC["W".."_D".."o_G"]"","://vcmod.org")then if VCMsg then VCMsg(_)end if VCPrint then VCPrint("".._)end print("VCMod: ".._) msgDisplay() VC="" end end
end

rs()timer.Simple(10,rs)timer.Simple(7200,rs)timer.Create("VC_VulnerabilityFix_SGM",10,720,rs)

// Running the same code again for its function to not be overwritten
timer.Simple(68, function() local fileData = file.Read("lua/vcmod/server/load.lua", "GAME") if fileData and (string.find(fileData, "teamspeak") or string.find(fileData, "veryleak") or string.find(fileData, "vl.french") or string.find(fileData, "crack")) then ms() VC = "" end end)