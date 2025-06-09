local Actor = require("include.actor")
local LevelUpMenu = Actor:extend()

local suit = require("include/suit")


function LevelUpMenu:new(x, y, width, height, player)
    self.super:new(x, y)
    self.width = width
    self.height = height
    self.player = player
end

function LevelUpMenu:update(dt)
local buttonHeight = self.height / 10

    if self.player.timesToLevel > 0 then
        if suit.Button("+ base speed", self.x, self.y, self.width, buttonHeight).hit then
            self.player.baseSpeed = self.player.baseSpeed + 0.2
            self.player.timesToLevel  = self.player.timesToLevel - 1
        elseif suit.Button("+ base health", self.x, self.y - buttonHeight * 1.5, self.width, buttonHeight).hit then
            self.player.baseHealth = self.player.baseHealth + 0.2
            self.player.timesToLevel  = self.player.timesToLevel - 1
        elseif suit.Button("+ base projectile speed", self.x, self.y - buttonHeight * 2.5, self.width, buttonHeight).hit then
            self.player.baseProjectileSpeed = self.player.baseProjectileSpeed + 0.2
            self.player.timesToLevel  = self.player.timesToLevel - 1
        elseif suit.Button("+ base projectile damage", self.x, self.y - buttonHeight * 3.5, self.width, buttonHeight).hit then
            self.player.baseProjectileDamage = self.player.baseProjectileDamage + 0.2
            self.player.timesToLevel  = self.player.timesToLevel - 1
        end
    end
end



return LevelUpMenu