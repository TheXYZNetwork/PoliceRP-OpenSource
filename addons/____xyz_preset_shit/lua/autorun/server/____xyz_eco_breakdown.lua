XYZShit = XYZShit or {}
XYZShit.EcoBreakdown = {}
XYZShit.EcoBreakdown.Systems = {}

function XYZShit.EcoBreakdown.RegisterSystem(systemName)
    if XYZShit.EcoBreakdown.Systems[systemName] then
        print("[Eco Breakdown]", "Trying to register '"..systemName.."', which has already been registered.")
        return
    end

    XYZShit.EcoBreakdown.Systems[systemName] = {
        loss = 0,
        gain = 0
    }

    print("[Eco Breakdown]", "Registered system '"..systemName.."'!")
end

function XYZShit.EcoBreakdown.AddGain(systemName, amount)
    if not XYZShit.EcoBreakdown.Systems[systemName] then
        print("[Eco Breakdown]", "Trying to add gains to '"..systemName.."', which has not been registered. Registering it now!")
        XYZShit.EcoBreakdown.RegisterSystem(systemName)
    end

    XYZShit.EcoBreakdown.Systems[systemName].gain = XYZShit.EcoBreakdown.Systems[systemName].gain + amount
end

function XYZShit.EcoBreakdown.AddLoss(systemName, amount)
    if not XYZShit.EcoBreakdown.Systems[systemName] then
        print("[Eco Breakdown]", "Trying to add loss to '"..systemName.."', which has not been registered. Registering it now!")
        XYZShit.EcoBreakdown.RegisterSystem(systemName)
    end

    XYZShit.EcoBreakdown.Systems[systemName].loss = XYZShit.EcoBreakdown.Systems[systemName].loss + amount
end


function XYZShit.EcoBreakdown.Dump()
    print("[Eco Breakdown]", "Dumping complete breakdown")
    for k, v in pairs(XYZShit.EcoBreakdown.Systems) do
        print("[Eco Breakdown]", "Dumping for "..k)
        XYZShit.Webhook.PostEmbed("eco_breakdown", {
            title = k,
            fields = {
                {
                    name = "Total Gain",
                    value = DarkRP.formatMoney(v.gain),
                    inline = true,
                },
                {
                    name = "Total Loss",
                    value = DarkRP.formatMoney(v.loss),
                    inline = true,
                },
                {
                    name = "Total Net",
                    value = DarkRP.formatMoney(v.gain - v.loss),
                    inline = true,
                }
            },
            color = 6729778,
            footer = {
                text = "PoliceRP 1"
            }
        })
    end
end
hook.Add("ShutDown", "EcoBreakdown", XYZShit.EcoBreakdown.Dump)
concommand.Add("eco_breakdown_dump", XYZShit.EcoBreakdown.Dump)

-- Implement systems through hooks

-- pCasino
hook.Add("pCasinoOnBlackjackPayout", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddGain("pCasino:BlackJack", amount)
end)
hook.Add("pCasinoOnRoulettePayout", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddGain("pCasino:Roulette", amount)
end)
hook.Add("pCasinoOnBasicSlotMachinePayout", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddGain("pCasino:SlotMachine:Basic", amount)
end)
hook.Add("pCasinoOnWheelSlotMachinePayout", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddGain("pCasino:SlotMachine:Wheel", amount)
end)
hook.Add("pCasinoOnBlackjackLoss", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddLoss("pCasino:BlackJack", amount)
end)
hook.Add("pCasinoOnRouletteLoss", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddLoss("pCasino:Roulette", amount)
end)
hook.Add("pCasinoOnBasicSlotMachineLoss", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddLoss("pCasino:SlotMachine:Basic", amount)
end)
hook.Add("pCasinoOnWheelSlotMachineLoss", "EcoBreakdown", function(ply, machine, amount)
    XYZShit.EcoBreakdown.AddLoss("pCasino:SlotMachine:Wheel", amount)
end)