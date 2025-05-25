local TargetSmall = require("include.targets.targetSmall")

local TargetUtils = {}

local maxTries = 1000

local targets = {}

function TargetUtils.populateMap(world, width, height, map, player)
    local amountToSpawn = 10
    local circleRadius = 20
    local tries = 0
    while #targets < amountToSpawn and tries < maxTries do
        local x = love.math.random(circleRadius, width - circleRadius)
        local y = love.math.random(circleRadius, height - circleRadius)

        if isValidPosition(x, y, circleRadius, width, height, map) then
            local target = TargetSmall(world, x, y)
            table.insert(targets, target)
        end

        tries = tries + 1
    end

    if #targets < 10 then
        print("Warning: Only spawned " .. #targets .. " circles after " .. tries .. " tries.")
    end

    return targets
end

function isValidPosition(x, y, radius, width, height, map)
    -- Check bounds
    if x - radius < 0 or x + radius > width or
        y - radius < 0 or y + radius > height then
        return false
    end

    -- Check overlap with other circles
    for _, c in ipairs(targets) do
        local dx = x - c.x
        local dy = y - c.y
        local distSq = dx * dx + dy * dy
        if distSq < (2 * radius) ^ 2 then
            return false
        end
    end

    for _, block in ipairs(map) do
        if isCollidingWithMap(x, y, radius, block.x, block.y, block.width, block.height) then
            return false
        end
    end

    return true
end

function isCollidingWithMap(circleX, circleY, radius, rectX, rectY, rectWidth, rectHeight)
    -- Closest point on rectangle to circle center
    local closestX = math.max(rectX, math.min(circleX, rectX + rectWidth))
    local closestY = math.max(rectY, math.min(circleY, rectY + rectHeight))
    local dx = circleX - closestX
    local dy = circleY - closestY
    return (dx * dx + dy * dy) < radius * radius
end

return TargetUtils