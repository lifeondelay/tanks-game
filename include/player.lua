local Actor = require("include.actor")

local Player = Actor:extend()

function Player:new(x, y, radius)
    Player.super.new(self, x, y)
    self.radius = radius or 10
    self.isColliding = false
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(0, 0, 0)
end

function Player:update(dt, map)
    self.isColliding = self:checkMapCollision(map)
    if love.keyboard.isDown("w") and self.isColliding == false then
        self.y = self.y - 1
    end

    if love.keyboard.isDown("s") and self.isColliding == false then
        self.y = self.y + 1
    end

    if love.keyboard.isDown("a") and self.isColliding == false then
        self.x = self.x - 1
    end

    if love.keyboard.isDown("d") and self.isColliding == false then
        self.x = self.x + 1
    end

    -- print(self.x .. ", " .. self.y)
end

function Player:checkMapCollision(map)
    for i = 1, #map.real_map do
        if (self.x + self.radius > map.real_map[i].x)
        and (self.x < map.real_map[i].x + map.block_size)
        and (self.y + self.radius > map.real_map[i].y)
        and (self.y < map.real_map[i].y + map.block_size) then
            return true;
        end
    end
    return false
end

return Player