local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.color_scheme then
		overrides.color_scheme = "Tokyo Night Day"
	else
		overrides.color_scheme = nil
	end
	window:set_config_overrides(overrides)
end)

local config = wezterm.config_builder()

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Window settings
config.window_background_opacity = 1.0
config.adjust_window_size_when_changing_font_size = false
config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

-- color scheme
config.color_scheme = "Tokyo Night"

-- Nerd Font
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13

-- Set cursor to blicking block and decrease fps to make it blink and not "fade"
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Pane focus follows mouse
config.pane_focus_follows_mouse = true

-- Keybinds
config.keys = {
	-- easier splits
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- smartsplits.nvim
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),

	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),

	-- enable opt left/right to jump words
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },

	-- toggle colorscheme
	{ key = "E", mods = "LEADER", action = wezterm.action.EmitEvent("toggle-colorscheme") },
}

return config
