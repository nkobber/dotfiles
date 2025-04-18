local wezterm = require("wezterm")
local config = wezterm.config_builder()
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- Font
config.font_size = 14
config.line_height = 1.2

-- Appearcance
config.color_scheme = "tokyonight"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = "0.2cell",
	bottom = 0,
}

-- Misc
config.max_fps = 120
config.prefer_egl = true
config.audible_bell = "Disabled"

-- Smart splits
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		mode = "CTRL",
		resize = "META",
	},
})

return config
