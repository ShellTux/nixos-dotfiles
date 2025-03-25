-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local gui = wezterm.gui

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local options = {
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
	-- leader = nil,
	mouse = {
		scroll = {
			multiplier = 5,
		},
	},
	keys = {
		{ key = "LeftArrow",  mods = "OPT", action = act.SendString("\x1bb") },
		{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },

		-- The physical CMD key on OSX is the Alt key on Win/*nix, so map the common Alt-combo commands.
		{ key = ".",          mods = "CMD", action = act.SendString("\x1b.") },
		{ key = "p",          mods = "CMD", action = act.SendString("\x1bp") },
		{ key = "n",          mods = "CMD", action = act.SendString("\x1bn") },
		{ key = "b",          mods = "CMD", action = act.SendString("\x1bb") },
		{ key = "f",          mods = "CMD", action = act.SendString("\x1bf") },

	},
	key_tables = {
		-- added new shortcuts to the end
		copy_mode = {
			{ key = "c",          mods = "CTRL",  action = act.CopyMode("Close") },
			{ key = "g",          mods = "CTRL",  action = act.CopyMode("Close") },
			{ key = "q",          mods = "NONE",  action = act.CopyMode("Close") },
			{ key = "Escape",     mods = "NONE",  action = act.CopyMode("Close") },

			{ key = "h",          mods = "NONE",  action = act.CopyMode("MoveLeft") },
			{ key = "j",          mods = "NONE",  action = act.CopyMode("MoveDown") },
			{ key = "k",          mods = "NONE",  action = act.CopyMode("MoveUp") },
			{ key = "l",          mods = "NONE",  action = act.CopyMode("MoveRight") },

			{ key = "LeftArrow",  mods = "NONE",  action = act.CopyMode("MoveLeft") },
			{ key = "DownArrow",  mods = "NONE",  action = act.CopyMode("MoveDown") },
			{ key = "UpArrow",    mods = "NONE",  action = act.CopyMode("MoveUp") },
			{ key = "RightArrow", mods = "NONE",  action = act.CopyMode("MoveRight") },

			{ key = "RightArrow", mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
			{ key = "f",          mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab",        mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
			{ key = "w",          mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
			{ key = "e",          mods = "NONE",  action = act.CopyMode("MoveForwardWordEnd") },

			{ key = "LeftArrow",  mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
			{ key = "b",          mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
			{ key = "Tab",        mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b",          mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },

			{ key = "0",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
			{ key = "Enter",      mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },

			{ key = "$",          mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$",          mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "^",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^",          mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "m",          mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },

			{ key = " ",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
			{ key = "v",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
			{ key = "V",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Line" } },
			{ key = "V",          mods = "SHIFT", action = act.CopyMode { SetSelectionMode = "Line" } },
			{ key = "v",          mods = "CTRL",  action = act.CopyMode { SetSelectionMode = "Block" } },

			{ key = "G",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G",          mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "g",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },

			{ key = "H",          mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
			{ key = "H",          mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "M",          mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M",          mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "L",          mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L",          mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

			{ key = "o",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "O",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O",          mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

			{ key = "PageUp",     mods = "NONE",  action = act.CopyMode("PageUp") },
			{ key = "PageDown",   mods = "NONE",  action = act.CopyMode("PageDown") },
			{ key = "u",          mods = "CTRL",  action = act.CopyMode("PageUp") },
			{ key = "d",          mods = "CTRL",  action = act.CopyMode("PageDown") },

			{ key = "b",          mods = "CTRL",  action = act.CopyMode("PageUp") },
			{ key = "f",          mods = "CTRL",  action = act.CopyMode("PageDown") },

			-- Enter y to copy and quit the copy mode.
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple {
					act.CopyTo("ClipboardAndPrimarySelection"),
					act.CopyMode("Close"),
				}
			},
			-- Enter search mode to edit the pattern.
			-- When the search pattern is an empty string the existing pattern is preserved
			{ key = "/", mods = "NONE", action = act { Search = { CaseSensitiveString = "" } } },
			{ key = "?", mods = "NONE", action = act { Search = { CaseInSensitiveString = "" } } },
			{ key = "n", mods = "CTRL", action = act { CopyMode = "NextMatch" } },
			{ key = "p", mods = "CTRL", action = act { CopyMode = "PriorMatch" } },
		},

		search_mode = {
			{ key = "Escape", mods = "NONE", action = act { CopyMode = "Close" } },
			-- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
			-- to navigate search results without conflicting with typing into the search area.
			{ key = "Enter",  mods = "NONE", action = "ActivateCopyMode" },
			{ key = "c",      mods = "CTRL", action = "ActivateCopyMode" },
			{ key = "n",      mods = "CTRL", action = act { CopyMode = "NextMatch" } },
			{ key = "p",      mods = "CTRL", action = act { CopyMode = "PriorMatch" } },
			{ key = "r",      mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u",      mods = "CTRL", action = act.CopyMode("ClearPattern") },
		},
	},
}

if options.leader ~= nil then
	-- Window management
	options.keys.insert({ key = "-", mods = "LEADER", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } })
	options.keys.insert({ key = "\"", mods = "LEADER | SHIFT", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } })
	options.keys.insert({ key = "\\", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } })
	options.keys.insert({ key = "%", mods = "LEADER | SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } })
	options.keys.insert({ key = "z", mods = "LEADER", action = "TogglePaneZoomState" })
	options.keys.insert({ key = "c", mods = "LEADER", action = act { SpawnTab = "DefaultDomain" } })
	options.keys.insert({ key = "DownArrow", mods = "SHIFT", action = act { SpawnTab = "DefaultDomain" } })
	options.keys.insert({ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") })
	options.keys.insert({ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") })
	options.keys.insert({ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") })
	options.keys.insert({ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") })
	options.keys.insert({ key = "DownArrow", mods = "LEADER", action = act.ActivatePaneDirection("Down") })
	options.keys.insert({ key = "LeftArrow", mods = "LEADER", action = act.ActivatePaneDirection("Left") })
	options.keys.insert({ key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") })
	options.keys.insert({ key = "UpArrow", mods = "LEADER", action = act.ActivatePaneDirection("Up") })

	options.keys.insert({ key = "H", mods = "LEADER", action = act { AdjustPaneSize = { "Left", 5 } } })
	options.keys.insert({ key = "RightArrow", mods = "LEADER | SHIFT", action = act { AdjustPaneSize = { "Left", 5 } } })
	options.keys.insert({ key = "J", mods = "LEADER", action = act { AdjustPaneSize = { "Down", 5 } } })
	options.keys.insert({ key = "DownArrow", mods = "LEADER | SHIFT", action = act { AdjustPaneSize = { "Down", 5 } } })
	options.keys.insert({ key = "K", mods = "LEADER", action = act { AdjustPaneSize = { "Up", 5 } } })
	options.keys.insert({ key = "UpArrow", mods = "LEADER | SHIFT", action = act { AdjustPaneSize = { "Up", 5 } } })
	options.keys.insert({ key = "L", mods = "LEADER", action = act { AdjustPaneSize = { "Right", 5 } } })
	options.keys.insert({ key = "LeftArrow", mods = "LEADER | SHIFT", action = act { AdjustPaneSize = { "Right", 5 } } })

	options.keys.insert({ key = "Tab", mods = "LEADER", action = act.ActivateLastTab })
	options.keys.insert({ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) })
	options.keys.insert({ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) })
	options.keys.insert({ key = "1", mods = "LEADER", action = act { ActivateTab = 0 } })
	options.keys.insert({ key = "2", mods = "LEADER", action = act { ActivateTab = 1 } })
	options.keys.insert({ key = "3", mods = "LEADER", action = act { ActivateTab = 2 } })
	options.keys.insert({ key = "4", mods = "LEADER", action = act { ActivateTab = 3 } })
	options.keys.insert({ key = "5", mods = "LEADER", action = act { ActivateTab = 4 } })
	options.keys.insert({ key = "6", mods = "LEADER", action = act { ActivateTab = 5 } })
	options.keys.insert({ key = "7", mods = "LEADER", action = act { ActivateTab = 6 } })
	options.keys.insert({ key = "8", mods = "LEADER", action = act { ActivateTab = 7 } })
	options.keys.insert({ key = "9", mods = "LEADER", action = act { ActivateTab = 8 } })
	options.keys.insert({ key = "x", mods = "LEADER", action = act { CloseCurrentPane = { confirm = true } } })

	-- Activate Copy Mode
	options.keys.insert({ key = "[", mods = "LEADER", action = act.ActivateCopyMode })
	-- Paste from Copy Mode
	options.keys.insert({ key = "]", mods = "LEADER", action = act.PasteFrom("PrimarySelection") })

	options.keys.insert({
		key = ',',
		mods = 'LEADER',
		action = act.PromptInputLine {
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		},
	})
	options.keys.insert({
		key = 'F12',
		mods = 'NONE',
		action = wezterm.action { EmitEvent = "toggle-leader" },
	})
end

local config = {
	automatically_reload_config = true,
	default_cwd = '~',
	enable_wayland = true,
	window_decorations = 'NONE',
	term = 'screen-256color',
	use_ime = true,
	default_cursor_style = 'BlinkingBlock',
	animation_fps = 20,
	cursor_blink_ease_in = 'Linear',
	cursor_blink_ease_out = 'Linear',
	cursor_blink_rate = 800,

	----------------
	-- Appearance --
	----------------
	window_background_opacity = 0.8,
	color_scheme = "OneHalfDark",
	window_padding = {
		left = 3,
		right = 3,
		top = 3,
		bottom = 3,
	},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.3,
	},

	initial_rows = 50,
	initial_cols = 140,

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	-- How many lines of scrollback you want to retain per tab
	scrollback_lines = 3500,
	enable_scroll_bar = true,

	-----------
	-- Fonts --
	-----------
	--disable_default_key_bindings = true,
	--line_height = 1,
	font = wezterm.font_with_fallback {
		'JetBrains Mono',
		'Symbols Nerd Font Mono',
		'Fira Code',
		'Source Code Pro',
	},

	font_size = 12.0,

	-----------
	-- Keys  --
	-----------
	-- Rather than emitting fancy composed characters when alt is pressed, treat the
	-- input more like old school ascii with ALT held down
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,

	leader = options.leader,
	keys = options.keys,
	key_tables = options.key_tables,

	mouse_bindings = {
		{
			event = { Down = { streak = options.mouse.scroll.multiplier, button = { WheelUp = 1 } } },
			mods = 'NONE',
			action = act.ScrollByLine(-1),
		},
		{
			event = { Down = { streak = options.mouse.scroll.multiplier, button = { WheelDown = 1 } } },
			mods = 'NONE',
			action = act.ScrollByLine(1),
		},
	}
}


wezterm.on("toggle-leader", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.leader then
		-- replace it with an "impossible" leader that will never be pressed
		overrides.leader = { key = "_", mods = "CTRL|ALT|SUPER" }
		overrides.colors = { background = "#100000" }
		overrides.window_background_opacity = 0.95
		wezterm.log_warn("[leader] clear")
	else
		-- restore to the main leader
		overrides.leader = nil
		overrides.colors = nil
		overrides.window_background_opacity = nil
		wezterm.log_warn("[leader] set")
	end
	window:set_config_overrides(overrides)
end)

return config
