XYZShit = XYZShit or {}

XYZShit.Version = "2.0"
if string.sub(game.GetIPAddress(), -5) == "27025" then
	XYZShit.Version = XYZShit.Version.."_dev"
	ISDEV = true
end
CURRENTVERSION = XYZShit.Version

if ISDEV then
	print("[SERVER]", "This server is running in Developer mode, some systems may be disabled!")
end