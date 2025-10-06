local StateData = {}
StateData.__index = StateData

function StateData:new()
    local instance = setmetatable({}, StateData)
    instance.data = {
        currentAlbumName = nil,
        currentAlbumIndex = nil,
        currentTrackName = nil,
        currentTrackIndex = nil,
        audioSource = nil,
        isPlaying = false,
        screenWidth = nil,
        screenHeight = nil,
        font = nil,
        icons = {
            album = nil,
            track = nil,
            play = nil,
            pause = nil,
            previous = nil,
            next = nil
        }
    }
    return instance
end

function StateData:setAlbumData(albumName, albumIndex)
    self.data.currentAlbumName = albumName
    self.data.currentAlbumIndex = albumIndex
end

function StateData:getAlbumData()
    return self.data.currentAlbumName, self.data.currentAlbumIndex
end

function StateData:getCurrentAlbumName()
    return self.data.currentAlbumName
end

function StateData:getCurrentAlbumIndex()
    return self.data.currentAlbumIndex
end

function StateData:setTrackData(trackName, trackIndex)
    self.data.currentTrackName = trackName
    self.data.currentTrackIndex = trackIndex
end

function StateData:getTrackData()
    return self.data.currentTrackName, self.data.currentTrackIndex
end

function StateData:getCurrentTrackName()
    return self.data.currentTrackName
end

function StateData:getCurrentTrackIndex()
    return self.data.currentTrackIndex
end

function StateData:setAudioData(audioSource, isPlaying)
    self.data.audioSource = audioSource
    self.data.isPlaying = isPlaying
end

function StateData:getAudioSource()
    return self.data.audioSource
end

function StateData:isPlaying()
    return self.data.isPlaying
end

function StateData:setScreenDimensions(width, height)
    self.data.screenWidth = width
    self.data.screenHeight = height
end

function StateData:getScreenWidth()
    return self.data.screenWidth
end

function StateData:getScreenHeight()
    return self.data.screenHeight
end

function StateData:setFont(font)
    self.data.font = font
end

function StateData:getFont()
    return self.data.font
end

function StateData:setIcons(icons)
    self.data.icons = icons
end

function StateData:getIcons()
    return self.data.icons
end

return StateData
