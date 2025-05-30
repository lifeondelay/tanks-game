local Utility = {}

-- Easing function for animations
function Utility:easeOutQuad(t)
    return -1 * t * (t - 2)
end

return Utility