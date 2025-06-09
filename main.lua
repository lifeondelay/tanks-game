local Player = require("include.player")
local Map = require("include.map.map")
local TargetSmall = require("include.targets.targetSmall")
local TargetUtils = require("include.targets.targetUtils")
local Callbacks = require("include.world.callbacks")
local Destruction = require("include.world.destruction")
local ExperienceBar = require("include.ui.experienceBar")
local LevelUpMenu = require("include.ui.levelUpMenu")
local suit = require("include/suit")

love.window.setMode(800, 800)

local width, height = love.graphics.getDimensions()
local world = love.physics.newWorld(0, 0, true)
local targets = {}
local destructibles = {}




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
    {1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local map = Map(world, 16, 16, new_map)
local levelUi = {x = map.block_size, y = height * 0.95}
local experienceBar = ExperienceBar(levelUi.x, levelUi.y, map.block_size * 5, height * 0.04)
local player = Player(world, width/2, height/2, 10, experienceBar)
local levelUpMenu = LevelUpMenu(levelUi.x, levelUi.y - experienceBar.height * 2, experienceBar.width, experienceBar.height * 10, player)

function love.load()
    -- love.physics.setMeter(64)
    targets = TargetUtils.populateMap(world, width, height, map.real_map, player)
    world:setCallbacks(Callbacks.onBeginContact, Callbacks.onEndContact, Callbacks.onPreSolve, Callbacks.onPostSolve)
    
end


function love.update(dt)
    world:update(dt)
    player:update(dt, map, destructibles)
    experienceBar:update(dt)

    -- Update lists of destructibles
    Destruction.updateDestructibles(destructibles, dt)
    Destruction.updateDestructibles(targets, dt)

    levelUpMenu:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 0, 0)

    -- draw the player
    player:draw()

    love.graphics.setColor(0, 0, 0)

    for _, projectile in ipairs(destructibles) do
        projectile:draw()
    end

    love.graphics.setColor(1, 1, 1)

    for _, target in ipairs(targets) do
        target:draw()
    end

    -- draw the map
    map:draw(width, height)
    love.graphics.setBackgroundColor(1, 1, 1)

    love.graphics.setColor(0, 0, 1)
    experienceBar:draw()

    suit.draw()
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then
      player:shoot(world, x, y, destructibles)
   end
end
