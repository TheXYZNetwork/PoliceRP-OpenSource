net.Receive("xyz_dmv", function()
	local ent = net.ReadEntity()

	local frame = XYZUI.Frame("Take a Driving Test", DMV.Config.Color)
	frame:SetSize(ScrH()*0.5, ScrH()*0.85)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell:DockPadding(5, 5, 5, 5)

		local questionCache = {}
		local _, questionList = XYZUI.Lists(shell, 1)
		for k, v in ipairs(ent.Questions) do
			local card = XYZUI.Card(questionList, 90)
			card:DockMargin(0, 0, 0, 5)
			card:Dock(TOP)
			card:DockPadding(10, 5, 10, 10)

			local t = XYZUI.PanelText(card, v.q, 30, TEXT_ALIGN_LEFT)
			t:DockMargin(0, 0, 0, 5)
			local d = XYZUI.DropDownList(card, "What do you do?")
			for k, v in pairs(v.o) do
				XYZUI.AddDropDownOption(d, v, k)
			end
			d:DockMargin(0, 0, 5, 0)
			table.insert(questionCache, d)
		end

	local  submit = XYZUI.ButtonInput(shell, "Submit Answers", function(container)
		local answers = {}
		for k, v in pairs(questionCache) do
			local a = v.value
			if not a then XYZShit.Msg("DMV", DMV.Config.Color, "You have missed a question, look back over your test before attempting to submit again.") return end
			answers[k] = a
		end

		net.Start("xyz_dmv_response")
			net.WriteEntity(ent)
			net.WriteTable(answers)
		net.SendToServer()
		frame:Close()
	end)
	submit:DockMargin(0, 5, 0, 0)
	submit:Dock(BOTTOM)
end)