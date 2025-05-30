local Actor = require("include.actor")

local Destructible = Actor:extend()

function Destructible:new(x, y, world, health, score, parent, body, shape, fixture)
    Destructible.super.new(self, x, y)
    self.health = health or 100
    self.score = score or 0

    self.body = body
    self.shape = shape
    self.fixture = fixture

    self.tag = "destructible"
    self.destroyed = false
    self.damage = 10
    self.parent = parent or nil
end

function Destructible:doDamage(amount)
    self.health = self.health - amount
    if self.health <= 0 then
        self:destroy()
    end
end

function Destructible:destroy()
    self.destroyed = true
    self.fixture:destroy()
end

return Destructible