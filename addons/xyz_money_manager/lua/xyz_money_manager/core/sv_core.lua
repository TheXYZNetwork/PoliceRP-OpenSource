net.Receive("MoneyManager:Respose", function(_, ply)
	if XYZShit.CoolDown.Check("MoneyManager:Respose", 1, ply) then return end

	xAdmin.Prevent.Post("Honeypot", ply, "This user has trigged the Money Manager honeypot!", "16098851", true)
end)