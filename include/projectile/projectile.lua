local Actor = require("include.actor")

local Projectile = Actor:extend()

-- Create a new projectile.
-- Takes the game physics world, starting x and y coords, radius
-- the direction it was fired from, its density, and how long it should fly for.
-- Also how much damage it does!
function Projectile:new(world, x, y, mx, my, radius, force, density, lifetime, damage)
    local dx, dy = x - mx, y - my

    local d = math.sqrt ( dx * dx + dy * dy )
    local ndx, ndy = dx / d, dy / d

    self.forceX = - ndx * force
    self.forceY = - ndy * force


    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(radius)
    self.fixture = love.physics.newFixture(self.body, self.shape, density)

    self.lifetime = lifetime or 1
    self.damage = damage
    self.timer = 0
end



return Projectile