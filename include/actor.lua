local Object = require("include.classic")

local Actor = Object:extend()

function Actor:new(x, y)
    self.x = x or 0;
    self.y = y or 0;
end

return Actor