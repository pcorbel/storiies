local Player = {}
Player.__index = Player

local FileManager = require("src.filemanager")
local Utils = require("src.utils")
local Config = require("src.config")

local audioSource
local fileManager
local currentIcon
local lastInputTime
local isDimmed

function Player:new()
    return setmetatable({}, Player)
end

function Player:enter()
    local stateData = StateManager:getStateData()

    fileManager = FileManager:new()

    local icons = stateData:getIcons()
    currentIcon = icons.pause

    lastInputTime = love.timer.getTime()
    isDimmed = false

    local albumName = stateData:getCurrentAlbumName()
    local trackName = stateData:getCurrentTrackName()
    local audioPath = fileManager:getTrackPath(albumName, trackName)
    if audioPath then
        audioSource = love.audio.newSource(audioPath, "stream")
        if audioSource then
            love.audio.play(audioSource)
            stateData:setAudioData(audioSource, true)
        end
    end
end

function Player:update(dt)
    local stateData = StateManager:getStateData()
    local audioSource = stateData:getAudioSource()
    local icons = stateData:getIcons()

    if audioSource then
        if audioSource:isPlaying() then
            currentIcon = icons.pause
            stateData:setAudioData(audioSource, true)
        else
            currentIcon = icons.play
            stateData:setAudioData(audioSource, false)
        end
    end

    local currentTime = love.timer.getTime()
    local timeSinceLastInput = currentTime - lastInputTime
    isDimmed = timeSinceLastInput >= Config.DIMMING.TIMEOUT
end

function Player:draw()
    local stateData = StateManager:getStateData()
    local audioSource = stateData:getAudioSource()
    local screenWidth = stateData:getScreenWidth()
    local screenHeight = stateData:getScreenHeight()
    local font = stateData:getFont()

    Utils.draw_background()

    if audioSource then
        local iconY, iconSize = Utils.draw_play_pause_icon(currentIcon, screenWidth, screenHeight)
        Utils.draw_progress_bar(iconY, iconSize, screenWidth, screenHeight, audioSource)
        Utils.draw_time_display(iconY, iconSize, screenWidth, screenHeight, audioSource, font)
    else
        Utils.draw_no_items_message("Could not load audio file", font, screenWidth, screenHeight)
    end

    if isDimmed then
        love.graphics.setColor(0, 0, 0, Config.DIMMING.OVERLAY_ALPHA)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Player:keypressed(key)
    local stateData = StateManager:getStateData()
    local audioSource = stateData:getAudioSource()

    lastInputTime = love.timer.getTime()

    if key == "b" then
        if audioSource then
            love.audio.stop(audioSource)
            stateData:setAudioData(nil, false)
        end
        StateManager:pop()
        return
    end

    if audioSource then
        if key == "a" then
            local icons = stateData:getIcons()
            if stateData:isPlaying() then
                love.audio.pause(audioSource)
                currentIcon = icons.play
                stateData:setAudioData(audioSource, false)
            else
                love.audio.play(audioSource)
                currentIcon = icons.pause
                stateData:setAudioData(audioSource, true)
            end
        elseif key == "left" then
            local currentTime = audioSource:tell()
            local newTime = math.max(0, currentTime - Config.AUDIO.SEEK_STEP)
            audioSource:seek(newTime)
        elseif key == "right" then
            local currentTime = audioSource:tell()
            local duration = audioSource:getDuration()
            local newTime = math.min(duration, currentTime + Config.AUDIO.SEEK_STEP)
            audioSource:seek(newTime)
        end
    end
end

function Player:leave()
    local stateData = StateManager:getStateData()
    local audioSource = stateData:getAudioSource()

    if audioSource then
        love.audio.stop(audioSource)
        stateData:setAudioData(nil, false)
    end
end

return Player
