local FileManager = {}
FileManager.__index = FileManager

local Config = require("src.config")

function FileManager:new()
    return setmetatable({}, FileManager)
end

local function loadImageWithExtensions(basePath, fallbackPath)
    for _, ext in ipairs(Config.IMAGE.SUPPORTED_EXTENSIONS) do
        local imagePath = basePath .. ext
        if love.filesystem.getInfo(imagePath) then
            local success, image = pcall(love.graphics.newImage, imagePath)
            if success then
                return image
            end
        end
    end

    local success, image = pcall(love.graphics.newImage, fallbackPath)
    return success and image or nil
end

function FileManager:listAlbums(path)
    local albums = {}

    if not love.filesystem.getInfo(path) then
        return albums
    end

    local function scanDirectory(currentPath)
        for _, item in ipairs(love.filesystem.getDirectoryItems(currentPath)) do
            local itemPath = currentPath .. "/" .. item
            local info = love.filesystem.getInfo(itemPath)

            if info.type == "directory" then
                local albumName = itemPath:gsub("^" .. path .. "/", "")
                table.insert(albums, albumName)
                scanDirectory(itemPath)
            end
        end
    end

    scanDirectory(path)
    return albums
end

function FileManager:albumExists(albumName)
    local info = love.filesystem.getInfo(self:getAlbumPath(albumName))
    return info and info.type == "directory"
end

function FileManager:getAlbumPath(albumName)
    return Config.PATHS.STORIIES .. "/" .. albumName
end

function FileManager:loadAlbumCover(albums, currentAlbumIndex)
    if #albums > 0 then
        local basePath = Config.PATHS.STORIIES .. "/" .. albums[currentAlbumIndex]
        return loadImageWithExtensions(basePath, Config.PATHS.ICONS.ALBUM)
    end
    return nil
end

function FileManager:getAlbumFiles(albumName)
    local files = {}

    if self:albumExists(albumName) then
        local albumPath = self:getAlbumPath(albumName)
        for _, item in ipairs(love.filesystem.getDirectoryItems(albumPath)) do
            local info = love.filesystem.getInfo(albumPath .. "/" .. item)
            if info.type == "file" then
                table.insert(files, item)
            end
        end
    end

    return files
end

function FileManager:getAlbumTracks(albumName)
    local tracks = {}

    for _, file in ipairs(self:getAlbumFiles(albumName)) do
        for _, ext in ipairs(Config.AUDIO.SUPPORTED_EXTENSIONS) do
            if file:lower():match(ext:gsub("%.", "%%.") .. "$") then
                local trackName = file:gsub(ext:gsub("%.", "%%.") .. "$", "")
                table.insert(tracks, trackName)
                break
            end
        end
    end

    return tracks
end

function FileManager:loadTrackCover(albumName, trackName)
    local basePath = Config.PATHS.STORIIES .. "/" .. albumName .. "/" .. trackName
    return loadImageWithExtensions(basePath, Config.PATHS.ICONS.TRACK)
end

function FileManager:getTrackPath(albumName, trackName)
    local trackPath = Config.PATHS.STORIIES ..
        "/" .. albumName .. "/" .. trackName .. Config.AUDIO.SUPPORTED_EXTENSIONS[1]
    return love.filesystem.getInfo(trackPath) and trackPath or nil
end

return FileManager
