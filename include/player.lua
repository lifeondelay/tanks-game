local Destructible = require("include.destructible")
local Bullet = require("include.projectile.bullet")

local Player = Destructible:extend()

function Player:new(world, x, y, radius)
    self.radius = radius or 10
    local body = love.physics.newBody(world, x, y, "dynamic")
    body:setLinearDamping(10)
    local shape = love.physics.newCircleShape(self.radius)
    local fixture = love.physics.newFixture(body, shape, 2)
    Player.super.new(self, x, y, world, 100, 100, "player", body, shape, fixture, 10)

    print("World x passed to player = " .. self.x)
    print("World y passed to player = " .. self.y)

    -- self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    -- self.body:setLinearDamping(10)
    -- self.shape = love.physics.newCircleShape(self.radius)
    -- self.fixture = love.physics.newFixture(
    --     self.body, self.shape, 2
    -- )
    -- self.fixture:setRestitution(0.9)
    self.gunBarrel = {}
    self.projectiles = {}
    self.tag = "player"
    self.fixture:setUserData(self)


    local text = self.body:getX() .. ", " .. self.body:getY()
    print(text)
end

function Player:draw()
    local text = self.body:getX() .. ", " .. self.body:getY()


    -- Draw line pointing to mouse
    love.graphics.line(self.x, self.y, self.gunBarrel.x, self.gunBarrel.y)

    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(0, 0, 0)
    -- love.graphics.print(text, self.body:getX(), self.body:getY())
end

function Player:update(dt, world)
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

    -- for i = 1, #self.projectiles do
    --     self.projectiles[i]:update(dt)
    -- end

    self.x = self.body:getX()
    self.y = self.body:getY()
    self.gunBarrel = self:getBarrel()
end

-- Fire a projectile
-- Psawn projectile at position of end of gunbarrel
function Player:shoot(world, mx, my, destructibles)
    table.insert(destructibles, Bullet(world, self, self.gunBarrel.x, self.gunBarrel.y, mx, my, 5, 30, 3, 3, 10))
end

-- Get location of end-of-barrel to shoot from
-- Also used for drawing directional gun barrel for tank
function Player:getBarrel()
    -- Get mouse position
    local mx, my = love.mouse.getPosition()

    -- Vector from center to mouse
    local dx = mx - self.x
    local dy = my - self.y

    -- Normalize the vector
    local length = math.sqrt(dx*dx + dy*dy)
    if length == 0 then length = 1 end  -- Prevent division by zero
    local nx = dx / length
    local ny = dy / length

    -- Scale to 20 pixels
    local lineLength = 20

    local ends = {}

    ends.x = self.x + nx * lineLength
    ends.y = self.y + ny * lineLength

    return ends
end

return Player