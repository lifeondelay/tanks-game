local Destructible = require("include.destructible")

local Projectile = Destructible:extend()

-- Create a new projectile.
-- Takes the game physics world, starting x and y coords, radius
-- the direction it was fired from, its density, and how long it should fly for.
-- Also how much damage it does!
function Projectile:new(world, x, y, lifetime, damage, parent, body, shape, fixture)
    Projectile.super.new(self, x, y, world, 100, 0, parent, body, shape, fixture)
    self.lifetime = lifetime or 1
    self.damage = damage
    self.timer = 0
    self:addTag("projectile")
    self.parent = parent
end



return Projectile