local Actor = require("include.actor")
local Palette = require("include.ui.palette")
local Utility = require("include.utility")

local isAnimating = false
local animDuration = 0.5  -- seconds
local animElapsed = 0

local ExperienceBar = Actor:extend()

local xpShader

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
    self.maxedOut = false
    self.level = 1
    xpShader = love.graphics.newShader("shader/gradient.glsl")
end

function ExperienceBar:draw()
    local innerX = self.x + self.margin
    local innerY = self.y + self.margin
    local innerHeight = self.height - 2 * self.margin
    local scoreText = (math.floor(self.displayedXp) .. "/" .. self.maxXp)
    local textX = self.x + self.width / 2 - self.margin
    local textY = self.y + self.height / 2 - self.margin - 5
    local fillWidth = self.width - 2 * self.margin
    -- local fillWidth = (self.displayedXp / self.maxXp) * (self.width - 2 * self.margin)

    local verts = {
        {innerX, innerY, 0, 0},                    -- top-left
        {innerX + fillWidth, innerY, 1, 0},            -- top-right
        {innerX + fillWidth, innerY + innerHeight, 1, 1},    -- bottom-right
        {innerX, innerY + innerHeight, 0, 1},            -- bottom-left
    }
    local mesh = love.graphics.newMesh(verts, "fan", "static")

    xpShader:send("time", love.timer.getTime())
    xpShader:send("fillRatio", math.max(self.displayedXp / self.maxXp, 0))

    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setShader(xpShader)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(mesh)
    love.graphics.setShader()
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.print(scoreText, fillWidth / 2, textY)
    love.graphics.print(self.level, fillWidth + 100, textY)
end

function ExperienceBar:addExperience(amount)
    print("adding " .. amount ..  " xp to the bar. Current displayed XP is: " .. self.displayedXp)
    if self.currentXp < self.maxXp then
        self.previousXp = self.displayedXp
        self.currentXp = math.min(self.currentXp + amount, self.maxXp)
        animElapsed = 0
        isAnimating = true
        if self.currentXp >= self.maxXp then
            self.maxedOut = true
        end
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

function ExperienceBar:setNewLevel(startingXp, maxXp, level)
    self.previousXp = 0
    self.currentXp = 0
    self.maxXp = maxXp
    self.level = level
    self:addExperience(startingXp)
end

return ExperienceBar