local Tracks = {}
Tracks.__index = Tracks

local FileManager = require("src.filemanager")
local Utils = require("src.utils")
local Config = require("src.config")

local tracks
local currentTrackCover
local fileManager

function Tracks:new()
    return setmetatable({}, Tracks)
end

function Tracks:enter()
    local stateData = StateManager:getStateData()

    fileManager = FileManager:new()
    local albumName = stateData:getCurrentAlbumName()
    tracks = fileManager:getAlbumTracks(albumName)

    local trackName, trackIndex = stateData:getTrackData()
    if not trackIndex then
        stateData:setTrackData(tracks[1], 1)
    end

    currentTrackCover = fileManager:loadTrackCover(albumName, tracks[stateData:getCurrentTrackIndex()])
end

function Tracks:update(dt)
end

function Tracks:draw()
    local stateData = StateManager:getStateData()
    local screenWidth = stateData:getScreenWidth()
    local screenHeight = stateData:getScreenHeight()
    local currentTrackIndex = stateData:getCurrentTrackIndex()
    local font = stateData:getFont()
    local icons = stateData:getIcons()

    Utils.draw_background()

    if #tracks > 0 then
        Utils.draw_navigation_icon(icons.previous, "previous", screenWidth, screenHeight)
        Utils.draw_navigation_icon(icons.next, "next", screenWidth, screenHeight)
        Utils.draw_index_indicator(currentTrackIndex, #tracks, screenWidth, screenHeight, font)
        local hasCover, coverY, coverSize = Utils.draw_cover(currentTrackCover, screenWidth, screenHeight)
        Utils.draw_title(tracks[currentTrackIndex], hasCover, coverY, coverSize, screenWidth, screenHeight, font,
            Config.UI.FONT_SIZE)
    else
        Utils.draw_no_items_message("No tracks found", font, screenWidth, screenHeight)
    end
end

function Tracks:keypressed(key)
    if key == "b" then
        StateManager:pop()
        return
    end

    if #tracks > 0 then
        local stateData = StateManager:getStateData()
        local albumName = stateData:getCurrentAlbumName()
        local currentTrackIndex = stateData:getCurrentTrackIndex()

        if key == "left" then
            currentTrackIndex = currentTrackIndex > 1 and currentTrackIndex - 1 or #tracks
        elseif key == "right" then
            currentTrackIndex = currentTrackIndex < #tracks and currentTrackIndex + 1 or 1
        elseif key == "up" then
            currentTrackIndex = math.min(currentTrackIndex + 10, #tracks)
        elseif key == "down" then
            currentTrackIndex = math.max(currentTrackIndex - 10, 1)
        elseif key == "a" then
            stateData:setTrackData(tracks[currentTrackIndex], currentTrackIndex)
            local Player = require("src.states.player")
            StateManager:push(Player:new())
            return
        end

        currentTrackCover = fileManager:loadTrackCover(albumName, tracks[currentTrackIndex])
        stateData:setTrackData(tracks[currentTrackIndex], currentTrackIndex)
    end
end

return Tracks
