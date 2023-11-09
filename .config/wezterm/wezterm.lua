local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font "FiraCode Nerd Font"

-- To change color scheme, see: https://github.com/catppuccin/WezTerm
config.color_scheme = "Catppuccin Mocha"

config.window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
}
config.use_fancy_tab_bar = false

return config
