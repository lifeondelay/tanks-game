-- This class holds the base level members for a target.
-- Rendering and updating should be handled by the subclass.
local Actor = require("include.actor")

local Target = Actor:extend()

function Target:new(world, x, y, health, score, body, shape, density)
    Target.super.new(self, x, y)
    self.health = health
    self.score = score

    self.body = body or love.physics.newBody(world, x, y, "dynamic")
    self.shape = shape or love.physics.newCircleShape(10)
    self.fixture = love.physics.newFixture(self.body, self.shape, density)
end

return Target