-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.hide_tab_bar_if_only_one_tab = true

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 11
config.color_scheme = 'Abernathy'

config.font = wezterm.font_with_fallback {
  'JuliaMono',
  'Noto Sans Mono',
  'FontAwesome',
  'Fira Code'
}

config.default_prog = { '/bin/zsh' }

config.keys = {
  { key = '_', mods = 'SHIFT|CTRL', action = wezterm.action.Nop },
  { key = '_', mods = 'SHIFT|CTRL', action = wezterm.action.SendKey({ key = "_", mods = "SHIFT|CTRL" }) },
  { key = '-', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '0', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '1', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '2', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '3', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '4', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '5', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '6', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '7', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '8', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '9', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '=', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '[', mods = 'SUPER', action = wezterm.action.Nop },
  { key = ']', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '[', mods = 'SHIFT|SUPER', action = wezterm.action.Nop },
  { key = ']', mods = 'SHIFT|SUPER', action = wezterm.action.Nop },
  { key = '{', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '}', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '{', mods = 'SHIFT|SUPER', action = wezterm.action.Nop },
  { key = '}', mods = 'SHIFT|SUPER', action = wezterm.action.Nop },
  { key = 'c', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'f', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'k', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'm', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'n', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'r', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 't', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'v', mods = 'SUPER', action = wezterm.action.Nop },
  { key = 'w', mods = 'SUPER', action = wezterm.action.Nop },
}

config.mouse_bindings = {
  { event = { Drag = { streak = 1, button = 'Left' } }, mods = 'SUPER', action = wezterm.action.Nop },
}

-- Finally, return the configuration to wezterm:
return config
