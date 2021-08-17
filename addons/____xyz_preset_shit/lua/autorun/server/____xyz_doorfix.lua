local FixSounds = {
["doors/wood_stop1.wav"] = true,
["doors/door1_move.wav"] = true,
["doors/wood_move1.wav"] = true,

}

hook.Add("EntityEmitSound", "DoorSoundFix", function(tbl)
    if FixSounds[tbl.SoundName] then
        tbl.SoundLevel = 75
        return true
    end
end)
