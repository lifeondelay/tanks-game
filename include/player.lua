local Destructible = require("include.destructible")
local Bullet = require("include.projectile.bullet")

local Player = Destructible:extend()

function Player:new(world, x, y, radius, xpBar)

    --- Base multipliers
    self.baseSpeed = 1
    self.baseHealth = 1
    self.baseProjectileSpeed = 1
    self.baseProjectileDamage = 1

    self.radius = radius or 10
    local body = love.physics.newBody(world, x, y, "dynamic")
    body:setLinearDamping(10)
    local shape = love.physics.newCircleShape(self.radius)
    local fixture = love.physics.newFixture(body, shape, 2)

    Player.super.new(self, x, y, world, 100, 100, "player", body, shape, fixture, 10)

    self.gunBarrel = {}
    self.projectiles = {}
    self.tag = "player"
    self.fixture:setUserData(self)
    self.experience = 0
    self.maxExperience = 1000
    self.xpBar = xpBar

    -- This is checked by the levelling-up ui, to see whether to draw
    self.isLevellingUp = false

    -- Poitns are used to upgrade player stats
    self.points = 0

    -- Level number is the number of times a player has reached the maximum XP in a level
    self.level = 1

    local text = self.body:getX() .. ", " .. self.body:getY()
    print(text)



    self.xpBar:setNewLevel(0, 200, 1)
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
        self.body:applyForce(0, -1000 * self.baseSpeed)
    end

    if love.keyboard.isDown("s") then
        self.body:applyForce(0, 1000 * self.baseSpeed)
    end

    if love.keyboard.isDown("a") then
        self.body:applyForce(-1000 * self.baseSpeed, 0)
    end

    if love.keyboard.isDown("d") then
        self.body:applyForce(1000 * self.baseSpeed, 0)
    end

    self.x = self.body:getX()
    self.y = self.body:getY()
    self.gunBarrel = self:getBarrel()
end

-- Fire a projectile
-- Psawn projectile at position of end of gunbarrel
function Player:shoot(world, mx, my, destructibles)
    local lifetime = 0.01
    table.insert(destructibles, Bullet(world, self, self.gunBarrel.x, self.gunBarrel.y, mx, my, 5, 30 * self.baseProjectileSpeed, 3, lifetime, 10 * self.baseProjectileDamage))
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

function Player:addExperience(amount)
    print("adding " .. amount .. " experience")
    self.experience = self.experience + amount
    self.xpBar:addExperience(amount)

    if self.xpBar.maxedOut == true then
        self:levelUp()
    end
end

function Player:levelUp()
    self.level = self.level + 1
    self.xpBar:setNewLevel(0, 200, self.level)
    self.xpBar.maxedOut = false
    self.isLevellingUp = true
end

return Player