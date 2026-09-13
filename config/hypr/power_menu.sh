#!/bin/sh

option=$(printf "Logout\nReboot\nShutdown\nSuspend\nHibernate\nLock Screen" | wofi --dmenu --prompt="Session Options:" --style ~/.config/wofi/style.css --width 300)

case "$option" in
    "Logout")
        hyprctl dispatch exit
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Hibernate")
        systemctl hibernate
        ;;
    "Lock Screen")
        hyprlock
        ;;
    *)
        exit 0
        ;;
esac
