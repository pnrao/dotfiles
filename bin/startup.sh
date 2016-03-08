#!/usr/bin/dash

xrdb -merge .Xresources
xset r rate 250 30
# killall -HUP xbindkeys || xbindkeys
(start-pulseaudio-x11 --check || start-pulseaudio-x11 --start -D &)
(pgrep xflux || xflux -l 49.26742 -g 7.0284 -k 3400 &)
(pgrep cmst || cmst -m &)
(xscreensaver-command -restart || xscreensaver -no-splash &)
# (smartbg /usr/share/backgrounds &)
