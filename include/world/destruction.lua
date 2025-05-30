local Destruction = {}

function Destruction.updateDestructibles(destructibles, dt)
    local i = 1
    while i <= #destructibles do
        destructibles[i]:update(dt)
        if destructibles[i].destroyed == true then
            -- print("removing " .. destructibles[i].tag .. " at " .. destructibles[i].health .. " health")
            table.remove(destructibles, i)
        else
            i = i + 1
        end
    end
end

return Destruction