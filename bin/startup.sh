#!/usr/bin/dash

xset r rate 250 30
killall -HUP xbindkeys || xbindkeys
(pkill -USR1 conky || conky -a top_left -b -d &)
(start-pulseaudio-x11 --check || start-pulseaudio-x11 --start -D &)
(pgrep xflux || xflux -l 49.26742 -g 7.0284 -k 3400 &)
#(pgrep redshift || redshift -l 49.26742:7.0284 &)
#(pgrep wicd-client || wicd-client -t &)
(pgrep connman-ui-gtk || connman-ui-gtk &)
(pgrep launchy || launchy &)
(pgrep volumeicon || volumeicon &)
(xscreensaver-command -restart || xscreensaver &)
(smartbg /home/prash/wallpapers &)
