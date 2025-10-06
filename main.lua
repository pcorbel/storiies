local StateManagerClass = require("src.statemanager")

StateManager = StateManagerClass:new()

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

    local Albums = require("src.states.albums")
    StateManager:switch(Albums:new())
end

function love.update(dt)
    StateManager:update(dt)
end

function love.draw()
    StateManager:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    StateManager:keypressed(key)
end
