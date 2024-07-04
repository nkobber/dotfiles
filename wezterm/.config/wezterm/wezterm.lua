local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
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

local config = wezterm.config_builder()

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.scrollback_lines = 99999

-- Window settings
local TITLEBAR_COLOR = "#333333"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
	font = wezterm.font({ family = "Hack", weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = TITLEBAR_COLOR,
	inactive_titlebar_bg = TITLEBAR_COLOR,
}
config.adjust_window_size_when_changing_font_size = false

wezterm.on("update-status", function(window, pane)
	local cells = {}

	-- Current working dir
	local home_dir = "^/Users/nko"
	local cwd = pane:get_current_working_dir().path
	cwd = string.gsub(cwd, home_dir, "~")
	table.insert(cells, " " .. cwd)

	-- Format date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime(" %a %b %-d %H:%M")
	table.insert(cells, date)

	-- Add an entry for each battery (typically 0 or 1)
	local batt_icons = { "", "", "", "", "" }
	for _, b in ipairs(wezterm.battery_info()) do
		local curr_batt_icon = batt_icons[math.ceil(b.state_of_charge * #batt_icons)]
		table.insert(cells, string.format("%s %.0f%%", curr_batt_icon, b.state_of_charge * 100))
	end

	-- Color palette for each cell
	local text_fg = "#c0c0c0"
	local colors = {
		TITLEBAR_COLOR,
		"#3c1361",
		"#52307c",
		"#663a82",
		"#7c5295",
		"#b491c8",
	}

	local elements = {}
	while #cells > 0 and #colors > 1 do
		local text = table.remove(cells, 1)
		local prev_color = table.remove(colors, 1)
		local curr_color = colors[1]

		table.insert(elements, { Background = { Color = prev_color } })
		table.insert(elements, { Foreground = { Color = curr_color } })
		table.insert(elements, { Text = "" })
		table.insert(elements, { Background = { Color = curr_color } })
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Text = " " .. text .. " " })
	end
	window:set_right_status(wezterm.format(elements))
end)

-- color scheme
config.colors = require("cyberdream")
-- config.color_scheme = "Tokyo Night"

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
}

return config
