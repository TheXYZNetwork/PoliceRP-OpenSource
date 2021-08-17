hook.Add("OnScreenSizeChanged", "Warn_Res_Change", function()
	XYZShit.Msg("Server", Color(0,255,255), "Detected change of resolution. Please rejoin in order to fix issues with UI scaling.")
end)