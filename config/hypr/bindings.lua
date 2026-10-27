-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Close window with Alt+F4 only (default SUPER+W removed).
hl.unbind("SUPER + W")
o.bind("ALT + F4", "Close window", hl.dsp.window.close())

-- SUPER+C launches WezTerm in the active terminal's cwd (replaces Universal
-- copy). Foot stays the default terminal, so SUPER+RETURN and the screensaver,
-- which doesn't support WezTerm, use foot.
hl.unbind("SUPER + C")
o.bind("SUPER + C", "WezTerm", { launch = 'wezterm start --cwd "$(omarchy-cmd-terminal-cwd)"' })

-- Disable universal paste and cut.
hl.unbind("SUPER + V")
hl.unbind("SUPER + X")

-- Ctrl+Shift+Esc launches qps (task manager).
o.bind("CTRL + SHIFT + ESCAPE", "Task manager", "qps")

-- SUPER+X maximizes (fullscreen keeping the bar).
o.bind("SUPER + X", "Maximize", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- SUPER+E opens the default file manager (the inode/directory handler), so it
-- follows Omarchy if it ever changes from nautilus.
o.bind("SUPER + E", "File manager", { launch = "xdg-open " .. os.getenv("HOME") })

-- SUPER+SHIFT+B restarts the Omarchy shell (bar) instead of opening the browser.
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Reload bar", "omarchy restart shell")

-- SUPER+SHIFT+R reloads the Hyprland config.
o.bind("SUPER + SHIFT + R", "Reload Hyprland", "hyprctl reload")

-- ALT+F2 also opens the apps launcher (as SUPER+ALT+SPACE does).
o.bind("ALT + F2", "Apps menu", "omarchy-menu toggle apps")

-- SUPER+S launches Sublime Text instead of toggling the scratchpad, and the
-- scratchpad's move-window binding is dropped too.
hl.unbind("SUPER + S")
hl.unbind("SUPER + ALT + S")
o.bind("SUPER + S", "Sublime Text", "subl")
