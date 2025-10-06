local Albums = {}
Albums.__index = Albums

local FileManager = require("src.filemanager")
local Utils = require("src.utils")
local Config = require("src.config")

local albums
local currentAlbumCover
local fileManager

function Albums:new()
    return setmetatable({}, Albums)
end

function Albums:enter()
    local stateData = StateManager:getStateData()

    stateData:setTrackData(nil, nil)
    fileManager = FileManager:new()
    albums = fileManager:listAlbums(Config.PATHS.STORIIES)

    local albumName, albumIndex = stateData:getAlbumData()
    if not albumName or not albumIndex then
        stateData:setAlbumData(albums[1], 1)
    end

    currentAlbumCover = fileManager:loadAlbumCover(albums, stateData:getCurrentAlbumIndex())
end

function Albums:update(dt)
end

function Albums:draw()
    local stateData = StateManager:getStateData()
    local screenWidth = stateData:getScreenWidth()
    local screenHeight = stateData:getScreenHeight()
    local currentAlbumIndex = stateData:getCurrentAlbumIndex()
    local font = stateData:getFont()
    local icons = stateData:getIcons()

    Utils.draw_background()

    if #albums > 0 then
        Utils.draw_navigation_icon(icons.previous, "previous", screenWidth, screenHeight)
        Utils.draw_navigation_icon(icons.next, "next", screenWidth, screenHeight)
        Utils.draw_index_indicator(currentAlbumIndex, #albums, screenWidth, screenHeight, font)
        local hasCover, coverY, coverSize = Utils.draw_cover(currentAlbumCover, screenWidth, screenHeight)
        Utils.draw_title(albums[currentAlbumIndex], hasCover, coverY, coverSize, screenWidth, screenHeight, font,
            Config.UI.FONT_SIZE)
    else
        Utils.draw_no_items_message("No storiies found in /MUOS/application/Storii/storiies", font, screenWidth,
            screenHeight)
    end
end

function Albums:keypressed(key)
    if #albums > 0 then
        local stateData = StateManager:getStateData()
        local currentAlbumIndex = stateData:getCurrentAlbumIndex()

        if key == "left" then
            currentAlbumIndex = currentAlbumIndex > 1 and currentAlbumIndex - 1 or #albums
        elseif key == "right" then
            currentAlbumIndex = currentAlbumIndex < #albums and currentAlbumIndex + 1 or 1
        elseif key == "up" then
            currentAlbumIndex = math.min(currentAlbumIndex + 10, #albums)
        elseif key == "down" then
            currentAlbumIndex = math.max(currentAlbumIndex - 10, 1)
        elseif key == "a" then
            stateData:setAlbumData(albums[currentAlbumIndex], currentAlbumIndex)
            local Tracks = require("src.states.tracks")
            StateManager:push(Tracks:new())
            return
        end

        currentAlbumCover = fileManager:loadAlbumCover(albums, currentAlbumIndex)
        stateData:setAlbumData(albums[currentAlbumIndex], currentAlbumIndex)
    end
end

return Albums
