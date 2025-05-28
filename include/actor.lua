local Object = require("include.classic")

local Actor = Object:extend()

function Actor:new(x, y)
    self.x = x or 0;
    self.y = y or 0;
    self.tag = "actor"
end

function Actor:update()

end

function Actor:draw()
    love.graphics.points(self.x, self.y)
end

return Actor