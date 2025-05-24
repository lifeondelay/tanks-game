local Actor = require("include.actor")

local Projectile = Actor:extend()

-- Create a new projectile.
-- Takes the game physics world, starting x and y coords, radius
-- the direction it was fired from, its density, and how long it should fly for.
-- Also how much damage it does :)
function Projectile:new(world, x, y, mx, my, radius, impulse, density, lifetime, damage)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(radius)
    self.fixture = love.physics.newFixture(self.body, self.shape, density)

    local dx, dy = x - mx, y - my

    local d = math.sqrt ( dx * dx + dy * dy )
    local ndx, ndy = dx / d, dy / d

    self.impulseX = ndx * impulse
    self.impulseY = ndy * impulse

end

function Projectile:update(dt)
    self.body:applyLinearImpulse(self.impulseX, self.impulseY)
    -- print(self.body:getX() .. ", " .. self.body:getY())
end

function Projectile:draw()
    love.graphics.setBackgroundColor(0, 1, 0)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    love.graphics.setBackgroundColor(1, 1, 1)
end

return Projectile