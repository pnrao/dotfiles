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
  'NotoSans Mono',
  'FontAwesome',
  'Fira Code'
}

config.default_prog = { '/bin/zsh' }

config.keys = {
  { key = '_', mods = 'SHIFT|CTRL', action = wezterm.action.Nop },
  { key = '-', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '_', mods = 'SHIFT|CTRL', action = wezterm.action.SendKey({ key = "_", mods = "SHIFT|CTRL" }) },
}

-- Finally, return the configuration to wezterm:
return config
