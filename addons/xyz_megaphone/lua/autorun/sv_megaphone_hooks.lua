local dist = 15000

hook.Add("PlayerCanHearPlayersVoice", "xyz_megaphone_voice", function(listener, talker)
    if talker:Alive() and talker.activeMegaphone == true and talker:GetPos():DistToSqr(listener:GetPos()) < dist*dist then return true, true end
end)