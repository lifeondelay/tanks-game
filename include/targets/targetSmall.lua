local Target = require("include.targets.target")

local TargetSmall = Target:extend()

function TargetSmall:new(world, x, y)
    local health = 20
    local score = 10
    local shape = love.physics.newCircleShape(20)
    local body = love.physics.newBody(world, x, y, "dynamic")
    TargetSmall.super.new(self, world, x, y, health, score, body, shape, 20)
end

function TargetSmall:update(dt)
end

function TargetSmall:draw()
    local text = self.body:getX() .. ", " .. self.body:getY()
    love.graphics.setColor(0.5, 0.5, 1)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, self.body:getX(), self.body:getY())
end

return TargetSmall