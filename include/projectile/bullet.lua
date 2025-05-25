local Projectile = require("include.projectile.projectile")

local Bullet = Projectile:extend()

-- x and y are the spawn coordinates for the bullet
-- mx and my are the coordinates for the bullet direction
function Bullet:new(world, x, y, mx, my, radius, force, density, lifetime, damage)
    Bullet.super.new(self, world, x, y, mx, my, radius, force, density, lifetime, damage)
end

function Bullet:update(dt)

    if self.timer < self.lifetime then
        self.body:applyForce(self.forceX, self.forceY)
        self.timer = self.timer + dt
    end

end

function Bullet:draw()
    local text = self.body:getX() .. ", " .. self.body:getY()
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, self.body:getX(), self.body:getY())

end

return Bullet