local Actor = require("include.actor")

local Player = Actor:extend()

function Player:new(world, x, y, radius)
    Player.super.new(self, x, y)

    print("World x passed to player = " .. self.x)
    print("World y passed to player = " .. self.y)

    self.radius = radius or 10
    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.body:setLinearDamping(10)
    self.shape = love.physics.newCircleShape(self.radius)
    self.fixture = love.physics.newFixture(
        self.body, self.shape, 2
    )
    self.fixture:setRestitution(0.9)
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(0, 0, 0)
end

function Player:update(dt)
    if love.keyboard.isDown("w") then
        self.body:applyForce(0, -1000)
    end

    if love.keyboard.isDown("s") then
        self.body:applyForce(0, 1000)
    end

    if love.keyboard.isDown("a") then
        self.body:applyForce(-1000, 0)
    end

    if love.keyboard.isDown("d") then
        self.body:applyForce(1000, 0)
    end

    self.x = self.body:getX()
    self.y = self.body:getY()
end


return Player