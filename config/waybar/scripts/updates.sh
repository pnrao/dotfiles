#!/bin/sh
# Count pending apt upgrades (relies on the system's existing apt cache; does not run apt update).
count=$(apt list --upgradable 2>/dev/null | grep -c '^[a-z]')
if [ "$count" -gt 0 ] 2>/dev/null; then
    echo "{\"text\": \"$count\", \"tooltip\": \"$count package(s) upgradable\", \"class\": \"pending\"}"
else
    echo '{"text": "", "tooltip": "up to date"}'
fi
