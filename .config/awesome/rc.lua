-- Initialize LuaRocks if it's installed
pcall(require, "luarocks.loader")

-- Important awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.autofocus")

-- Send notification if the config throws an error
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- Key definitions
super = "Mod4"
alt = "Mod1"
shift = "Shift"
ctrl = "Control"

-- Default programs
terminal = "kitty"
editor = "emacsclient -c -a emacs"
runlauncher = "rofi -show drun"
browser = "firefox"
browser_pvt = "firefox --private-window"
filemanager = "pcmanfm"

-- Theming
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- beautiful.useless_gap = 4
-- beautiful.border_color_active = "#8aadf4"
-- beautiful.border_color_normal = "#181926"
-- beautiful.border_width = 3

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
              image = gears.filesystem.get_configuration_dir() .. "0001.jpg",
              upscale = true,
              downscale = true,
              widget = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled = false,
            widget = wibox.container.tile,
        }
    }
end)

-- Layouts
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        -- awful.layout.suit.floating,
        awful.layout.suit.tile,
      --  awful.layout.suit.tile.left,
      --  awful.layout.suit.tile.bottom,
      --  awful.layout.suit.tile.top,
      --  awful.layout.suit.fair,
      --  awful.layout.suit.fair.horizontal,
      --  awful.layout.suit.spiral,
      --  awful.layout.suit.spiral.dwindle,
      --  awful.layout.suit.max,
      --  awful.layout.suit.max.fullscreen,
      --  awful.layout.suit.magnifier,
      --  awful.layout.suit.corner.nw,
    })
end)

-- Wibar
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "q", "w", "e", "r", "t", "z", "u", "i", "o" }, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
            },
        }
    }
end)

-- Global key bindings
awful.keyboard.append_global_keybindings({
    -- Awesome
    awful.key({super}, "s", hotkeys_popup.show_help,
        {description = "Show keybinds", group = "Awesome"}),
    awful.key({super, shift}, "r", awesome.restart,
        {description = "Restart Awesome", group = "Awesome"}),
    awful.key({super, shift}, "q", awesome.quit,
        {description = "Quit Awesome", group = "Awesome"}),

    -- Apps
    awful.key({super}, "r", function() awful.spawn(runlauncher) end,
        {description = "Run launcher", group = "Apps"}),
    awful.key({super}, "Return", function() awful.spawn(terminal) end,
        {description = "Open Terminal", group = "Apps"}),
    awful.key({super}, "e", function() awful.spawn(filemanager) end,
        {description = "Open File Manager", group = "Apps"}),
    awful.key({super}, "c", function() awful.spawn(editor) end,
        {description = "Open Emacs", group = "Apps"}),
    awful.key({super}, "f", function() awful.spawn(browser) end,
        {description = "Open Web Browser", group = "Apps"}),
    awful.key({super, shift}, "f", function() awful.spawn(browser_pvt) end,
        {description = "Open Web Browser (Private)", group = "Apps"}),

    -- Tags
    awful.key({super}, "Left", awful.tag.viewprev,
        {description = "View previous tag", group = "Tags"}),
    awful.key({super}, "Right", awful.tag.viewnext,
        {description = "View next tag", group = "Tags"}),

    awful.key{
      modifiers = {super},
      keygroup = "numrow",
      description = "View tag #",
      group = "Tags",
      on_press = function(i)
        local s = awful.screen.focused()
        local t = s.tags[i]
        if t then
          t:view_only()
        end
      end
    },

    awful.key{
      modifiers = {super, shift},
      keygroup = "numrow",
      description = "Move window to tag",
      group = "Tags",
      on_press = function(i)
        if client.focus then
          local t = client.focus.screen.tags[i]
          if t then
            client.focus:move_to_tag(t)
          end
        end
      end
    },

    -- Window Focus
    awful.key({super}, "h" , function() awful.client.focus.bydirection("left") end,
        {description = "Focus window to the left", group = "Focus"}),
    awful.key({super}, "j" , function() awful.client.focus.bydirection("down") end,
        {description = "Focus window below", group = "Focus"}),
    awful.key({super}, "k" , function() awful.client.focus.bydirection("up") end,
        {description = "Focus window above", group = "Focus"}),
    awful.key({super}, "l" , function() awful.client.focus.bydirection("right") end,
        {description = "Focus window to the right", group = "Focus"}),

    -- Window movement
    awful.key({super, shift}, "h", function() awful.client.swap.bydirection("left") end,
        {description = "Move window left", group = "Movement"}),
    awful.key({super, shift}, "j", function() awful.client.swap.bydirection("down") end,
        {description = "Move window down", group = "Movement"}),
    awful.key({super, shift}, "k", function() awful.client.swap.bydirection("up") end,
        {description = "Move window up", group = "Movement"}),
    awful.key({super, shift}, "l", function() awful.client.swap.bydirection("right") end,
        {description = "Move window right", group = "Movement"}),

    -- Window resizing
    awful.key({super, ctrl}, "h", function() awful.tag.incmwfact(-0.02) end,
        {description = "Decrease master width", group = "Resize"}),
    awful.key({super, ctrl}, "j", function() awful.client.incwfact(0.05) end,
        {description = "Increase focused window height", group = "Resize"}),
    awful.key({super, ctrl}, "k", function() awful.client.incwfact(-0.05) end,
        {description = "Decrease focused window height", group = "Resize"}),
    awful.key({super, ctrl}, "l", function() awful.tag.incmwfact(0.02) end,
        {description = "Increase master width", group = "Resize"}),

    -- Screens
    awful.key({super}, "Tab", function () awful.screen.focus_relative( 1) end,
        {description = "Focus next screen", group = "screen"}),
    awful.key({super, "Shift"}, "Tab", function () awful.screen.focus_relative(-1) end,
        {description = "Focus previous screen", group = "screen"}),

    -- Multimedia keys
    awful.key({super}, "XF86AudioRaiseVolume", function() os.execute("amixer -q sset Master 5%+") end,
        {description = "Raise volume by 5%", group = "Multimedia"}),
    awful.key({super}, "XF86AudioLowerVolume", function() os.execute("amixer -q sset Master 5%-") end,
        {description = "Lower volume by 5%", group = "Multimedia"}),
    awful.key({}, "XF86AudioMute", function() os.execute("amixer -q sset Master toggle") end,
        {description = "Toggle mute volume", group = "Multimedia"}),
    awful.key({}, "XF86AudioNext", function() os.execute("playerctl next") end,
        {description = "Next track", group = "Multimedia"}),
    awful.key({}, "XF86AudioPrev", function() os.execute("playerctl previous") end,
        {description = "Previous track", group = "Multimedia"}),
    awful.key({}, "XF86AudioPlay", function() os.execute("playerctl play-pause") end,
        {description = "Play/Pause", group = "Multimedia"}),
})

-- Client key bindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({super}, "w", function(c) c:kill() end,
            {description = "Close window", group = "Window"}),
        awful.key({super}, "space", awful.client.floating.toggle,
            {description = "Toggle floating", group = "Window"}),
        awful.key({super}, "o", function(c) c:move_to_screen() end,
            {description = "Move window to next screen", group = "Window"}),

        awful.key({super}, "p", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
            {description = "Toggle fullscreen", group = "Window"}),

        awful.key({super}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
            {description = "Toggle maximize", group = "Window"}),
    })
end)

-- Mouse bindings
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c) c:activate{context = "mouse_click"} end),
        awful.button({super}, 1, function(c) c:activate{context = "mouse_click", action = "mouse_move"} end),
        awful.button({super}, 3, function(c) c:activate{context = "mouse_click", action = "mouse_resize"} end),
    })
end)

-- Window rules
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }
end)

-- Notifications
ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule = { },
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- Window focus follows mouse
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = true }
end)

-- Autostart script
awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "autostart.sh")
