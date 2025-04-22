local Actor = require("include.actor")

local Player = Actor:extend()

function Player:new(x, y, radius)
    Player.super.new(self, x, y)
    self.radius = radius or 10
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(0, 0, 0)
end

function Player:update(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - 1
    end

    if love.keyboard.isDown("s") then
        self.y = self.y + 1
    end

    if love.keyboard.isDown("a") then
        self.x = self.x - 1
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + 1
    end

    -- print(self.x .. ", " .. self.y)
end

return Player