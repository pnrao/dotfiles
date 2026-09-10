#!/bin/sh
# Toggle the lxqt-panel wingmenu (start menu) over its private D-Bus object.
# lxqt-globalkeysd (X11-only) can't grab keys under labwc/Wayland, so this
# calls the panel's global_key_shortcuts client object directly instead.

panel=$(busctl --user list | awk '$3 == "lxqt-panel" { print $1; exit }')
[ -n "$panel" ] || exit 1

busctl --user call "$panel" /global_key_shortcuts/panel/wingmenu/show_hide \
	org.lxqt.global_key_shortcuts.client activated
