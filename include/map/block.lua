local Actor = require("include.actor")

local Block = Actor:extend()

function Block:new(world, x, y, width, height)
    self.body = love.physics.newBody(world, width, height, "static")
    self.shape = love.physics.newRectangleShape(x - width / 2, y - width / 2, width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.x = self.body:getX()
    self.y = self.body:getY()
end

return Block