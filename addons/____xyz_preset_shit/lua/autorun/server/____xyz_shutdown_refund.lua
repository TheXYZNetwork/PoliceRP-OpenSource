hook.Add("ShutDown", "xyz_shutdown_refund", function()
    for k,v in pairs(ents.GetAll()) do
        if v:GetClass() == "tierp_printer" then
            local owner = v:Getowning_ent()
            local amount = 10000

            for i=1, v:GetTier() do
                amount = amount + TierPrinters.Config.Tiers[i].price
            end
            print("Giving "..owner:Nick().." $"..amount.." from printer refund.")

            owner:addMoney(amount)
        end
    end
end)