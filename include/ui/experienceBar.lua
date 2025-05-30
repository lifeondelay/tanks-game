local Actor = require("include.actor")
local Palette = require("include.ui.palette")
local Utility = require("include.utility")

local isAnimating = false
local animDuration = 0.5  -- seconds
local animElapsed = 0

local ExperienceBar = Actor:extend()

function ExperienceBar:new(x, y, width, height)
    self.x = x
    self.y = y
    self.tag = "xpbar"
    self.previousXp = 0
    self.displayedXp = 0
    self.currentXp = 0
    self.maxXp = 0
    self.margin = 2
    self.width = width or 100
    self.height = height or 20
    self.innerMaxWidth = self.width - 2 * self.margin
end

function ExperienceBar:draw()
    local innerX = self.x + self.margin
    local innerY = self.y + self.margin
    local innerHeight = self.height - 2 * self.margin
    local scoreText = (math.floor(self.displayedXp) .. "/" .. self.maxXp)
    local textX = self.x + self.width / 2 - self.margin
    local textY = self.y + self.height / 2 - self.margin
    local fillWidth = (self.displayedXp / self.maxXp) * (self.width - 2 * self.margin)

    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0.5, 0)
    love.graphics.rectangle("fill", innerX, innerY, fillWidth, innerHeight)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.print(scoreText, textX, textY)
end

function ExperienceBar:addExperience(amount)
    print("adding " .. amount ..  " xp to the bar. Current displayed XP is: " .. self.displayedXp)
    if self.currentXp < self.maxXp then
        self.previousXp = self.displayedXp
        self.currentXp = math.min(self.currentXp + amount, self.maxXp)
        animElapsed = 0
        isAnimating = true
    end
    print(self.currentXp)
end

function ExperienceBar:update(dt)
    if isAnimating then
        animElapsed = animElapsed + dt
        local t = math.min(animElapsed / animDuration, 1)
        local easedT = Utility:easeOutQuad(t)
        self.displayedXp = self.previousXp + (self.currentXp - self.previousXp) * easedT

        if t >= 1 then
            self.displayedXp = self.currentXp
            isAnimating = false
        end
    end
end

function ExperienceBar:setNewLevel(startingXp, maxXp)
    self.maxXp = maxXp
    self:addExperience(startingXp)
end

return ExperienceBar