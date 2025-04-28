local Player = require("include.player")
local Map = require("include.map")
love.window.setMode(800, 800)

local width, height = love.graphics.getDimensions()
local score = 0
local player = Player(width/2, height/2)


local new_map =
{
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}



local map = Map(16, 16, new_map)

function love.load()
end

function love.update(dt)
    player:update(dt)
    -- map:isColliding(player.x, player.y)
end

function love.draw()
    love.graphics.setColor(1, 0, 0)

    -- draw the player
    player:draw()

    -- draw the map
    map:draw(width, height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(score, 0, 0)
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local mouseToTarget = distanceToTarget(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
        end
    end
end

function distanceToTarget(mouseX, mouseY, targetX, targetY)
    return math.sqrt((targetX - mouseX)^2 + (targetY - mouseY) ^ 2)
end

-- Is the player leaving the window?
function isPlayerColliding(x, y)

    if x >= width or x <= 0 or y >= height or y <= 0 then
        return true
    else
        return false
    end
end

