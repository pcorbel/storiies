local Utils = {}

local Config = require("src.config")

function Utils.draw_background()
    love.graphics.setColor(Config.COLORS.BACKGROUND)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(Config.COLORS.WHITE)
end

function Utils.draw_cover(cover, screenWidth, screenHeight)
    local coverSize = screenHeight * Config.UI.COVER_SIZE_RATIO
    local imageX = (screenWidth - coverSize) / 2
    local imageY = (screenHeight - coverSize) / 2
    local cornerRadius = coverSize * Config.UI.CORNER_RADIUS_RATIO

    local canvas = love.graphics.newCanvas(coverSize, coverSize)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.draw(cover, 0, 0, 0, coverSize / cover:getWidth(), coverSize / cover:getHeight())
    love.graphics.setCanvas()

    love.graphics.setColor(Config.COLORS.TRANSPARENT)
    love.graphics.rectangle("fill", imageX, imageY, coverSize, coverSize)

    love.graphics.stencil(function()
        love.graphics.rectangle("fill", imageX, imageY, coverSize, coverSize, cornerRadius, cornerRadius)
    end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)

    love.graphics.setColor(Config.COLORS.WHITE)
    love.graphics.draw(canvas, imageX, imageY)
    love.graphics.setStencilTest()

    return true, imageY, coverSize
end

function Utils.calculateFontSize(text, maxWidth, defaultFontSize)
    local testFont = love.graphics.newFont(Config.PATHS.FONTS, defaultFontSize)
    local textWidth = testFont:getWidth(text)

    if textWidth <= maxWidth then
        return defaultFontSize
    end

    local ratio = maxWidth / textWidth
    local newFontSize = math.floor(defaultFontSize * ratio)
    return math.max(newFontSize, Config.UI.MIN_FONT_SIZE)
end

function Utils.draw_navigation_icon(icon, position, screenWidth, screenHeight)
    local iconSize = screenHeight * Config.UI.ICON_SIZE_RATIO
    local iconY = (screenHeight - iconSize) / 2
    local iconX = position == "previous" and 0 or screenWidth - iconSize

    love.graphics.draw(icon, iconX, iconY, 0, iconSize / icon:getWidth(), iconSize / icon:getHeight())
end

function Utils.draw_no_items_message(message, font, screenWidth, screenHeight)
    love.graphics.setFont(font)
    local textHeight = font:getHeight()
    love.graphics.printf(message, 0, screenHeight / 2 - textHeight / 2, screenWidth, "center")
end

function Utils.draw_title(title, hasCover, coverY, coverSize, screenWidth, screenHeight, defaultFont, titleFontSize)
    if hasCover then
        local calculatedFontSize = Utils.calculateFontSize(title, screenWidth, titleFontSize)
        local titleFont = love.graphics.newFont(Config.PATHS.FONTS, calculatedFontSize)

        love.graphics.setFont(titleFont)
        local textHeight = titleFont:getHeight()
        local titleY = (coverY - textHeight) / 2

        love.graphics.printf(title, 0, titleY, screenWidth, "center")
        love.graphics.setFont(defaultFont)
    end
end

function Utils.draw_play_pause_icon(icon, screenWidth, screenHeight)
    local iconSize = screenHeight * Config.UI.COVER_SIZE_RATIO
    local iconX = (screenWidth - iconSize) / 2
    local iconY = (screenHeight - iconSize) / 2

    love.graphics.draw(icon, iconX, iconY, 0, iconSize / icon:getWidth(), iconSize / icon:getHeight())
    return iconY, iconSize
end

function Utils.draw_progress_bar(iconY, iconSize, screenWidth, screenHeight, audioSource)
    local iconBottom = iconY + iconSize
    local availableSpace = screenHeight - iconBottom
    local progressBarHeight = Config.UI.PROGRESS_BAR_HEIGHT
    local progressBarWidth = screenWidth * Config.UI.PROGRESS_BAR_WIDTH_RATIO
    local progressBarX = (screenWidth - progressBarWidth) / 2
    local progressBarY = iconBottom + (availableSpace - progressBarHeight) / 2

    love.graphics.setColor(Config.COLORS.GRAY_DARK)
    love.graphics.rectangle("fill", progressBarX, progressBarY, progressBarWidth, progressBarHeight)

    if audioSource:getDuration() > 0 then
        local progress = audioSource:tell() / audioSource:getDuration()
        local progressWidth = progressBarWidth * progress

        love.graphics.setColor(Config.COLORS.WHITE)
        love.graphics.rectangle("fill", progressBarX, progressBarY, progressWidth, progressBarHeight)
    end

    love.graphics.setColor(Config.COLORS.WHITE)
end

function Utils.draw_index_indicator(currentIndex, totalCount, screenWidth, screenHeight, font)
    local indicatorText = currentIndex .. " / " .. totalCount
    local textHeight = font:getHeight()
    local coverY = (screenHeight - screenHeight * Config.UI.COVER_SIZE_RATIO) / 2
    local coverSize = screenHeight * Config.UI.COVER_SIZE_RATIO
    local coverBottom = coverY + coverSize
    local availableSpace = screenHeight - coverBottom
    local indicatorY = coverBottom + (availableSpace - textHeight) / 2

    love.graphics.setFont(font)
    love.graphics.printf(indicatorText, 0, indicatorY, screenWidth, "center")
end

function Utils.format_time(seconds)
    local minutes = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d", minutes, secs)
end

function Utils.draw_time_display(iconY, iconSize, screenWidth, screenHeight, audioSource, font)
    local iconBottom = iconY + iconSize
    local availableSpace = screenHeight - iconBottom
    local progressBarHeight = Config.UI.PROGRESS_BAR_HEIGHT
    local progressBarY = iconBottom + (availableSpace - progressBarHeight) / 2
    local timeY = progressBarY + progressBarHeight + Config.UI.TIME_TEXT_SPACING
    local margin = screenWidth * Config.UI.MARGIN_RATIO

    love.graphics.setFont(font)

    if audioSource then
        local currentTime = audioSource:tell()
        local totalTime = audioSource:getDuration()

        local currentTimeText = Utils.format_time(currentTime)
        love.graphics.print(currentTimeText, margin, timeY)

        local totalTimeText = Utils.format_time(totalTime)
        local totalTimeWidth = font:getWidth(totalTimeText)
        love.graphics.print(totalTimeText, screenWidth - margin - totalTimeWidth, timeY)
    end
end

return Utils
