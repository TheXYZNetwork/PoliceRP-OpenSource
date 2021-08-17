local soundReplacements = {
    ["vehicles/sgmcars/17raptor/rumbler/wail.wav"] = "vcmod/els/smartsiren/wail.wav",
    ["vehicles/sgmcars/17raptor/rumbler/yelp.wav"] = "vcmod/els/smartsiren/yelp.wav",
    ["vehicles/sgmcars/17raptor/rumbler/phaser.wav"] = "vcmod/els/smartsiren/priority.wav"
}

hook.Add("VC_soundEmit_ELS", "XYZShit:ChangeSounds", function(ent, type, data)    
    if not data then return end
    if not (type == "siren") then return end

    data.Sound = soundReplacements[data.Sound] or data.Sound

    return data
end)
