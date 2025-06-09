local Actor = require("include.actor")

local Block = Actor:extend()

function Block:new(world, x, y, width, height)
    Block.super.new(self, x, y)
    self.width = width
    self.height = height
    self.body = love.physics.newBody(world, width, height, "static")
    self.shape = love.physics.newRectangleShape(x - width / 2, y - width / 2, width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape, 10)
    self.x = x
    self.y = y

    self:addTag("wall")

    self.fixture:setUserData(self)
end

return Block