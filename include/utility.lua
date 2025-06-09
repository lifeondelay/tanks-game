local Utility = {}

-- Easing function for animations
function Utility:easeOutQuad(t)
    return -1 * t * (t - 2)
end

-- Check if a table contains an item
function Utility:tableContains(table, value)
    for i = 1,#table do
            if (table[i] == value) then
                return true
            end
        end
    return false
end

return Utility