local mod = "logs"

if GAS then
	if APG.modules[ mod ] and GAS.Logging then
		local MODULE = GAS.Logging:MODULE()

		MODULE.Category = "APG"
		MODULE.Name = "Lag Detection"
		MODULE.Colour = Color(255,0,0)

		MODULE:Setup(function()

			MODULE:Hook("APG_logsLagDetected", "APG.logs.lagDetected", function()

				if not APG.cfg["logLagDetected"].value then return end

				MODULE:Log("Lag detected, running lag function {1} to prevent further lag.", GAS.Logging:Highlight(APG.cfg["lagFunc"].value))

			end)

		end)

		GAS.Logging:AddModule(MODULE)

		local MODULE = GAS.Logging:MODULE()

		MODULE.Category = "APG"
		MODULE.Name = "Crash Attempts"
		MODULE.Colour = Color(255,0,0)

		MODULE:Setup(function()

			MODULE:Hook("APG_stackCrashAttempt", "APG.logs.stackCrashAttempt", function(ply, count)

				if not APG.cfg["logStackCrashAttempt"].value then return end
				MODULE:Log("{1} stacked {2} props and triggered a detection.", GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(count))

			end)

		end)

		GAS.Logging:AddModule(MODULE)
	end
end

if plogs then
	if APG.modules[ mod ] and plogs.Register then
		plogs.Register("APG", true, Color(255,100,0))

		plogs.AddHook("APG_logsLagDetected", function()
			if not APG.cfg["logLagDetected"].value then return end
			plogs.PlayerLog("console", "APG", "Lag detected, running lag fix function " .. APG.cfg["lagFunc"].value .. " to prevent further lag.")
		end)


		plogs.AddHook("APG_stackCrashAttempt", function(ply, count)
			if not APG.cfg["logStackCrashAttempt"].value then return end
			plogs.PlayerLog(ply, "APG", ply:NameID() .. " stacked " .. count .. " props and triggered a detection.", {
				["Name"] 	= ply:Name(),
				["SteamID"]	= ply:SteamID()
			})
		end)
	end
end
