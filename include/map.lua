local Object = require("include.classic")

local Map = Object:extend()

local screenX, screenY = love.window.getDesktopDimensions()

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

function Map:new(width, height, walls)
    self.width = width or 16
    self.height = height or 16

    self.walls = walls or self.default_map(self)
    self.real_map = self.map(self)
end

-- Creates a table of rectangles based on the 2d array for the map
function Map:map()
    local block_size = screenX / self.width

    local real_map = {}
    for i = 1, self.width do
        for j = 1, self.height do
            if self.walls[i][j] == 1 then
                local rect = {}
                rect.x = block_size * (j - 1)
                rect.y = block_size * (i - 1)
                table.insert(real_map, rect)
            end
        end
    end
    return real_map
end

function Map:isColliding(x, y)
    for i = 1, #self:map() do
        if x >= self:map()[i].x and x >= self:map()[i].x and y >= self:map()[i].y and y >= self:map()[i].y then
            print("colliding")
        end
    end
end

function Map:draw()

    local block_size = screenX / self.width

    for i = 1, #self.real_map do
        love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle(
                "line", self.real_map[i].x, self.real_map[i].y, block_size, block_size
            )
                love.graphics.setColor(0, 0, 0)
    end
end

return Map