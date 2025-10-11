local Config = {}

Config.AUDIO = {
    SEEK_STEP = 10,
    SUPPORTED_EXTENSIONS = { ".mp3" }
}

Config.COLORS = {
    BACKGROUND = { 0.0, 0.0, 0.0, 1.0 },
    GRAY_DARK = { 0.3, 0.3, 0.3, 1.0 },
    TRANSPARENT = { 0.0, 0.0, 0.0, 0.0 },
    WHITE = { 1.0, 1.0, 1.0, 1.0 }
}

Config.DIMMING = {
    OVERLAY_ALPHA = 0.75,
    TIMEOUT = 3.0
}

Config.IMAGE = {
    SUPPORTED_EXTENSIONS = { ".png", ".jpg", ".jpeg", ".gif", ".bmp" }
}

Config.PATHS = {
    FONTS = "assets/fonts/RobotoMono-Bold.ttf",
    ICONS = {
        ALBUM = "assets/icons/album.png",
        NEXT = "assets/icons/next.png",
        PAUSE = "assets/icons/pause.png",
        PLAY = "assets/icons/play.png",
        PREVIOUS = "assets/icons/previous.png",
        TRACK = "assets/icons/track.png"
    },
    STORIIES = "storiies"
}

Config.UI = {
    CORNER_RADIUS_RATIO = 0.025,
    COVER_SIZE_RATIO = 0.5,
    FONT_SIZE = 32,
    ICON_SIZE_RATIO = 0.1,
    INDEX_INDICATOR_SPACING = 20,
    MARGIN_RATIO = 0.05,
    MIN_FONT_SIZE = 12,
    PROGRESS_BAR_HEIGHT = 8,
    PROGRESS_BAR_WIDTH_RATIO = 0.8,
    TIME_TEXT_SPACING = 10
}

return Config
