local Actor = require("include.actor")

local Physical = Actor:extend()

function Physical:new(world, x, y, shape)
    Physical.super.new(self, x, y)
    self.body = love.physics.newBody(world, x, y, "dynamic")
end

return Physical