local Player = require("include.player")
local Map = require("include.map.map")
local TargetSmall = require("include.targets.targetSmall")
local TargetUtils = require("include.targets.targetUtils")
local Callbacks = require("include.world.callbacks")

love.window.setMode(800, 800)

local width, height = love.graphics.getDimensions()
local score = 0
local world = love.physics.newWorld(0, 0, true)
local targets = {}
local destructibles = {}

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
    targets = TargetUtils.populateMap(world, width, height, map.real_map, player)
    world:setCallbacks(Callbacks.onBeginContact, Callbacks.onEndContact, Callbacks.onPreSolve, Callbacks.onPostSolve)
end


function love.update(dt)
    world:update(dt)
    player:update(dt, map, destructibles)

    local i = 1
    while i <= #destructibles do
        destructibles[i]:update(dt)
        if destructibles[i].destroyed == true then
            print("removing " .. destructibles[i].tag .. " at " .. destructibles[i].health .. " health")
            table.remove(destructibles, i)
        else
            i = i + 1
        end
    end

    local j = 1
    while j <= #targets do
        targets[j]:update(dt)
        if targets[j].destroyed == true then
            print("removing " .. targets[j].tag .. " at " .. targets[j].health .. " health")
            table.remove(targets, j)
        else
            j = j + 1
        end
    end

end

function love.draw()
    love.graphics.setColor(1, 0, 0)

    -- draw the player
    player:draw()

    love.graphics.setColor(0, 0, 0)

    --- Draw the players bullets
    -- for _, projectile in ipairs(player.projectiles) do
    --     projectile:draw()
    -- end

    for _, projectile in ipairs(destructibles) do
        projectile:draw()
    end

    love.graphics.setColor(1, 1, 1)

    for _, target in ipairs(targets) do
        target:draw()
    end

    -- draw the map
    map:draw(width, height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(score, 0, 0)
    love.graphics.setBackgroundColor(1, 1, 1)


end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then
      player:shoot(world, x, y, destructibles)
   end
end
