-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Workspace 1 is dedicated to the browser: it stays tiled; anything else opened there floats instead
o.window({ workspace = "1" }, { float = true })
o.window({ workspace = "1", class = "^(brave-browser)$" }, { float = false })

-- No border when a workspace has only one tiled window
o.window({ workspace = "w[tv1]" }, { border_size = 0 })
-- No border when maximized (SUPER+X) or fullscreen, even if other windows are tiled behind it
o.window({ fullscreen = true }, { border_size = 0 })
