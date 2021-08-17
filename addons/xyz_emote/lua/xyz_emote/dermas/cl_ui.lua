function Emote.UI.DrawWedge(x, y, r, r2, startAng, endAng, step, cache)
    local positions = {}
    local inner = {}
    local outer = {}

    startAng = startAng or 0
    endAng = endAng or 0

    for i = startAng - 90, endAng - 90, step do
        table.insert(inner, {
            x = math.ceil(x + math.cos(math.rad(i)) * r2),
            y = math.ceil(y + math.sin(math.rad(i)) * r2)
        })
    end

    for i = startAng - 90, endAng - 90, step do
        table.insert(outer, {
            x = math.ceil(x + math.cos(math.rad(i)) * r),
            y = math.ceil(y + math.sin(math.rad(i)) * r)
        })
    end

    for i = 1, #inner * 2 do
        local outPoints = outer[math.floor(i / 2) + 1]
        local inPoints = inner[math.floor((i + 1) / 2) + 1]
        local otherPoints

        if i % 2 == 0 then
            otherPoints = outer[math.floor((i + 1) / 2)]
        else
            otherPoints = inner[math.floor((i + 1) / 2)]
        end

        table.insert(positions, {outPoints, otherPoints, inPoints})
    end

    for k,v in pairs(positions) do 
        surface.DrawPoly(v)
    end
end

