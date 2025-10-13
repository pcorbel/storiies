local StateManagerClass = require("src.statemanager")

StateManager = StateManagerClass:new()
local escapeHoldTime = 0

function love.load()
    local Config = require("src.config")
    local stateData = StateManager:getStateData()

    stateData:setScreenDimensions(love.graphics.getWidth(), love.graphics.getHeight())

    local font = love.graphics.newFont(Config.PATHS.FONTS, Config.UI.FONT_SIZE)
    stateData:setFont(font)

    local icons = {
        album = love.graphics.newImage(Config.PATHS.ICONS.ALBUM),
        track = love.graphics.newImage(Config.PATHS.ICONS.TRACK),
        play = love.graphics.newImage(Config.PATHS.ICONS.PLAY),
        pause = love.graphics.newImage(Config.PATHS.ICONS.PAUSE),
        previous = love.graphics.newImage(Config.PATHS.ICONS.PREVIOUS),
        next = love.graphics.newImage(Config.PATHS.ICONS.NEXT)
    }
    stateData:setIcons(icons)

    local Splash = require("src.states.splash")
    StateManager:switch(Splash:new())
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        escapeHoldTime = escapeHoldTime + dt
        if escapeHoldTime >= 2.0 then
            love.event.quit()
        end
    end

    StateManager:update(dt)
end

function love.draw()
    StateManager:draw()
end

function love.keypressed(key)
    StateManager:keypressed(key)
end

function love.keyreleased(key)
    if key == "escape" then
        escapeHoldTime = 0
    end
end
