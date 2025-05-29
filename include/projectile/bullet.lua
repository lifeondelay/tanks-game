local Projectile = require("include.projectile.projectile")

local Bullet = Projectile:extend()

-- x and y are the spawn coordinates for the bullet
-- mx and my are the coordinates for the bullet direction
function Bullet:new(world, parent, x, y, mx, my, radius, force, density, lifetime, damage)
    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newCircleShape(radius)
    local fixture = love.physics.newFixture(body, shape, density)
    Bullet.super.new(self, x, y, world, lifetime, damage, parent, body, shape, fixture)

    local dx, dy = x - mx, y - my

    local d = math.sqrt ( dx * dx + dy * dy )
    local ndx, ndy = dx / d, dy / d

    self.forceX = - ndx * force
    self.forceY = - ndy * force

    -- self.tag = "bullet"
    self.fixture:setUserData(self)
    self.tag = "destructible"
    self.health = 10

end

function Bullet:update(dt)
    if self.timer < self.lifetime then
        self.body:applyLinearImpulse(self.forceX, self.forceY)
        self.timer = self.timer + dt
    end

end

function Bullet:draw()
    local text = self.body:getX() .. ", " .. self.body:getY()
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    love.graphics.setColor(0, 0, 0)
    -- love.graphics.print(text, self.body:getX(), self.body:getY())

end

return Bullet