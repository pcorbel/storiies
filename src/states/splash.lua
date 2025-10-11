local Splash = {}
Splash.__index = Splash

local Config = require("src.config")
local Utils = require("src.utils")

local timer
local font

function Splash:new()
    return setmetatable({}, Splash)
end

function Splash:enter()
    timer = 0
    font = love.graphics.newFont(Config.PATHS.FONTS, Config.UI.FONT_SIZE * 2)
end

function Splash:update(dt)
    timer = timer + dt

    if timer >= 2.0 then
        local Albums = require("src.states.albums")
        StateManager:switch(Albums:new())
    end
end

function Splash:draw()
    local stateData = StateManager:getStateData()
    local screenWidth = stateData:getScreenWidth()
    local screenHeight = stateData:getScreenHeight()

    Utils.draw_background()

    love.graphics.setFont(font)
    love.graphics.setColor(Config.COLORS.WHITE)

    local appName = "Storiies"
    local textWidth = font:getWidth(appName)
    local textHeight = font:getHeight()

    love.graphics.print(appName,
        (screenWidth - textWidth) / 2,
        (screenHeight - textHeight) / 2)

    love.graphics.setColor(Config.COLORS.WHITE)
end

function Splash:keypressed(key)
end

return Splash
