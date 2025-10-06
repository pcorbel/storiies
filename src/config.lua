local Config = {}

Config.UI = {
    COVER_SIZE_RATIO = 0.5,
    ICON_SIZE_RATIO = 0.1,
    PROGRESS_BAR_WIDTH_RATIO = 0.8,
    MARGIN_RATIO = 0.05,
    PROGRESS_BAR_HEIGHT = 8,
    FONT_SIZE = 32,
    CORNER_RADIUS_RATIO = 0.025,
    TIME_TEXT_SPACING = 10,
    INDEX_INDICATOR_SPACING = 20,
    MIN_FONT_SIZE = 12
}

Config.AUDIO = {
    SEEK_STEP = 10,
    SUPPORTED_EXTENSIONS = { ".mp3" }
}

Config.DIMMING = {
    TIMEOUT = 3.0,
    OVERLAY_ALPHA = 0.75
}

Config.IMAGE = {
    SUPPORTED_EXTENSIONS = { ".png", ".jpg", ".jpeg", ".gif", ".bmp" }
}

Config.PATHS = {
    FONTS = "assets/fonts/RobotoMono-Bold.ttf",
    ICONS = {
        ALBUM = "assets/icons/album.png",
        TRACK = "assets/icons/track.png",
        PLAY = "assets/icons/play.png",
        PAUSE = "assets/icons/pause.png",
        PREVIOUS = "assets/icons/previous.png",
        NEXT = "assets/icons/next.png"
    },
    STORIIES = "storiies"
}

Config.COLORS = {
    BACKGROUND = { 0.0, 0.0, 0.0, 1.0 },
    WHITE = { 1.0, 1.0, 1.0, 1.0 },
    GRAY_DARK = { 0.3, 0.3, 0.3, 1.0 },
    TRANSPARENT = { 0.0, 0.0, 0.0, 0.0 }
}

return Config
