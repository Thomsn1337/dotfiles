----------------------------
-- Basic catppuccin theme --
----------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- Color table
local colors = {}

colors.base = "#24273a"
colors.crust = "#181926"
colors.text = "#cad3f5"
colors.blue = "#8aadf4"
colors.teal = "#8bd5ca"
colors.red = "#ed8796"

-- Theme
local theme = {}

theme.wibar_height = 24

theme.font = "Ubuntu Mono 9"

theme.bg_normal = colors.base
theme.bg_focus = colors.blue
theme.bg_urgent = colors.red
theme.bg_minimize = colors.base
theme.bg_systray = colors.base

theme.fg_normal = colors.text
theme.fg_focus = colors.base
theme.fg_urgent = colors.base
theme.fg_minimize = colors.text

theme.useless_gap         = dpi(4)
theme.border_width        = dpi(3)
theme.border_color_normal = colors.crust
theme.border_color_active = colors.blue
theme.border_color_marked = colors.red

theme.hotkeys_modifiers_fg = colors.text
theme.hotkeys_border_color = colors.blue

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, colors.base
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, colors.blue
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_border_color = colors.blue
theme.notification_border_width = 3

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = colors.red, fg = colors.base }
    }
end)

return theme
