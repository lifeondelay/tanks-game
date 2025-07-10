local Actor = require("include.actor")
local StatusBar = Actor:extend()
local Utility = require("include.utility")

local isAnimating = false
local animDuration = 0.5  -- seconds
local animElapsed = 0

function StatusBar:new(x, y, width, height, maxHealth)
    self.super:new(x, y)

    self.x = x
    self.y = y
    self.tag = "statusBar"
    self.previousHealth = 0
    self.displayedHealth = 0
    self.currentHealth = 0
    self.maxHealth = maxHealth or 0
    self.margin = 1
    self.width = width or 100
    self.height = height or 20
    self.innerMaxWidth = self.width - 2 * self.margin
    self.maxedOut = false
end

function StatusBar:draw()
    local fontSize = 14
    local innerX = self.x + self.margin
    local innerY = self.y + self.margin
    local innerHeight = self.height - 2 * self.margin
    local scoreText = (math.floor(self.displayedHealth) .. "/" .. self.maxHealth)
    local textX = self.x + self.width / 2 - self.margin
    local textY = self.y + self.height / 2 - self.margin
    local fillWidth = (self.displayedHealth / self.maxHealth) * (self.width - 2 * self.margin)

    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0.5, 0)
    love.graphics.rectangle("fill", innerX, innerY, fillWidth, innerHeight)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(fontSize))
    love.graphics.print(scoreText, textX, textY - innerHeight / 2 - fontSize / 4)
end

function StatusBar:updatePosition(x, y)
    self.x = x - self.width / 2
    self.y = y - 30
end

function StatusBar:updateHealth(amount, operation)
    if operation == "damage" then
        if self.currentHealth == 0 then
            return
        end

        self.previousHealth = self.displayedHealth
        self.currentHealth = math.min(self.currentHealth - amount, 0)
        animElapsed = 0
        isAnimating = true
    elseif operation == "heal" then
        if self.currentHealth == self.maxHealth then
            return
        end

        self.previousHealth = self.displayedHealth
        self.currentHealth = math.min(self.currentHealth + amount, self.maxHealth)
        animElapsed = 0
        isAnimating = true
        if self.currentHealth >= self.maxHealth then
            self.maxedOut = true
        end
    end
end

function StatusBar:update(dt)
    if isAnimating then
        animElapsed = animElapsed + dt
        local t = math.min(animElapsed / animDuration, 1)
        local easedT = Utility:easeOutQuad(t)
        self.displayedHealth = self.previousHealth + (self.currentHealth - self.previousHealth) * easedT

        if t >= 1 then
            self.displayedHealth = self.currentHealth
            isAnimating = false
        end
    end
end

return StatusBar