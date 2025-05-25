local Player = require("include.player")
local Map = require("include.map.map")
local TargetSmall = require("include.targets.targetSmall")

love.window.setMode(800, 800)

local width, height = love.graphics.getDimensions()
local score = 0
local world = love.physics.newWorld(0, 0, true)
local targets = {}

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

function PopulateTargets()
    for i = 1, 10 do
        local target = TargetSmall(world, width /2, height/2)
        table.insert(targets, target)
    end
end

local map = Map(world, 16, 16, new_map)

function love.load()
    PopulateTargets()
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

    --- Draw the players bullets
    for i =1, #player.projectiles do
        player.projectiles[i]:draw()
    end

    love.graphics.setColor(1, 1, 1)

    for i = 1, #targets do
        targets[i]:draw()
    end

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

