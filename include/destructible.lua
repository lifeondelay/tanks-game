local Actor = require("include.actor")

local Destructible = Actor:extend()

function Destructible:new(x, y, health, points)
    Destructible.super.new(self, x, y)
    self.health = health or 100
    self.points = points or 0
    self.tag = "destructible"
end

function Destructible:doDamage(amount)
    self.health = self.health - amount
end

function Destructible:destroy()

end

return Actor