local Object = require("include.classic")
local Utility = require("include.utility")

local Actor = Object:extend()

function Actor:new(x, y)
    self.x = x or 0;
    self.y = y or 0;
    self.tags = {"actor"}
end

-- Add a new tag to this class
function Actor:addTag(tag)
    if Utility:tableContains(self.tags, tag) then
        return
    end
    table.insert(self.tags, tag)
end

function Actor:update()

end

function Actor:draw()
    love.graphics.points(self.x, self.y)
end

return Actor