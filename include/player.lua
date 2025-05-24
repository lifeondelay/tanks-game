local Actor = require("include.actor")

local Player = Actor:extend()

function Player:new(world, x, y, radius)
    Player.super.new(self, world, x, y)
    self.radius = radius or 10
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.isColliding = false
    self.shape = love.physics.newCircleShape(self.radius)
    self.fixture = love.physics.newFixture(
        self.body, self.shape, 5
    )
    self.fixture:setRestitution(0.9)

    self.x = self.body:getX()
    self.y = self.body:getY()

    print(self.body:getX())
    print(self.body:getY())
    print(self.shape:getRadius())
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    -- love.graphics.circle("fill", self.body:getX(), self.body:getY(), 10)
    print(self.body:getX() .. ",  " .. self.body:getY())
    love.graphics.setColor(0, 0, 0)
end

function Player:update(dt, map)
    -- self.isColliding = self:checkMapCollision(map)
    if love.keyboard.isDown("w") then
        self.body:applyForce(0, -100)
    end

    if love.keyboard.isDown("s") then
        self.body:applyForce(0, 100)
    end

    if love.keyboard.isDown("a") then
        self.body:applyForce(-100, 0)
    end

    if love.keyboard.isDown("d") then
        self.body:applyForce(100, 0)
    end

    self.x = self.body:getX()
    self.y = self.body:getY()

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