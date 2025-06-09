-- This class holds the base level members for a target.
-- Rendering and updating should be handled by the subclass.
local Destructible = require("include.destructible")

local Target = Destructible:extend()

function Target:new(world, x, y, health, score, body, shape, fixture, density)
    Target.super.new(self, x, y, world, health, score, self, body, shape, fixture, density)
    self:addTag("target")
    self:addTag("enemy")
    self.health = health
    self.score = score
    self.damage = 10
end

-- function Target:takeDamage(damage)
--     self.health = self.health - damage
--     if self.health <= 0 then
--         self:Destroy()
--     end
-- end

return Target