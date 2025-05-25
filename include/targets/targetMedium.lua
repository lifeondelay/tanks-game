local Target = require("include.targets.target")

local TargetMedium = Target:extend()

function TargetMedium:new(world, x, y)
    local health = 20
    local score = 10
    local shape = love.physics.newCircleShape(20)
    local body = love.physics.newBody(world, x, y, "dynamic")
    TargetMedium.super.new(self, world, x, y, health, score, body, shape, 20)
end

return TargetMedium