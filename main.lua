local Player = require("include.player")
local Map = require("include.map.map")
love.window.setMode(800, 800)

local width, height = love.graphics.getDimensions()
local score = 0
local world = love.physics.newWorld(0, 0, true)

local player = Player(world, width/2, height/2)

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
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}



local map = Map(world, 16, 16, new_map)

function love.load()
    -- love.physics.setMeter(64)
end

function love.update(dt)
    world:update(dt)
    player:update(dt, map)
end

function love.draw()
    love.graphics.setColor(1, 0, 0)

    -- draw the player
    player:draw()

    love.graphics.setColor(0, 0, 0)


    for i =1, #player.projectiles do
        player.projectiles[i]:draw()
    end

    love.graphics.setColor(1, 1, 1)

    -- draw the map
    map:draw(width, height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(score, 0, 0)
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then
      player:shoot(world, x, y)
   end
end