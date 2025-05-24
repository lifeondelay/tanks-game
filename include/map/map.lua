local Object = require("include.classic")
local Block = require("include.map.block")

local Map = Object:extend()

local screenX, screenY = love.window.getMode()


-- Creates a default map
function Map:default_map()
    local def_map = {}

    for i = 1, self.width + 1 do
        def_map[i] = {}
        for j = 1, self.height + 1 do

            def_map[i][j] = 0

            if i == 1 then
                def_map[i][j] = 1
            elseif i == self.width + 1 then
                def_map[i][j] = 1
            elseif j == 1 then
                def_map[i][j] = 1
            elseif j == self.height + 1 then
                def_map[i][j] = 1
            end

        end
    end

    return def_map
end

-- The map. Takes the world, the window width and height, and the walls definition (2d array)
-- to create a map for the game
function Map:new(world, width, height, walls)
    self.width = width or 16
    self.height = height or 16
    self.block_size = (screenX / self.width) or 50

    self.walls = walls or self.default_map(self)
    self.real_map = self.map(self, world)
end

-- Creates a table of rectangles based on the 2d array for the map
function Map:map(world)
    local real_map = {}
    for i = 1, self.width do
        for j = 1, self.height do
            if self.walls[i][j] == 1 then
                local rect = {}
                rect.x = self.block_size * (j - 1)
                rect.y = self.block_size * (i - 1)

                local block = Block(world, rect.x, rect.y, self.block_size, self.block_size)

                table.insert(real_map, block)
            end
        end
    end
    return real_map
end

function Map:draw()
    for i = 1, #self.real_map do
        love.graphics.setColor(0, 0, 0)
        love.graphics.polygon("line", self.real_map[i].body:getWorldPoints(self.real_map[i].shape:getPoints()))
        love.graphics.setColor(0, 0, 0)
    end
end

return Map