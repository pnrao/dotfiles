#!/bin/sh
# Weather stacked as icon/temp, located via WiFi triangulation (beacondb.net,
# a free open replacement for Mozilla's now-shut-down Location Service) so it
# tracks wherever the laptop actually is, not just IP-level city.

wifi_json() {
    nmcli -t -f BSSID,SIGNAL device wifi list 2>/dev/null | awk -F: '
        {
            sig = $(NF)
            bssid = ""
            for (i = 1; i < NF; i++) {
                gsub(/\\/, "", $i)
                bssid = (i == 1) ? $i : bssid ":" $i
            }
            if (bssid != "" && sig ~ /^[0-9]+$/) {
                if (n++ > 0) printf(",")
                printf("{\"macAddress\":\"%s\",\"signalStrength\":%d}", bssid, -100 + sig)
            }
        }
    '
}

APS=$(wifi_json)
latlon=""
if [ -n "$APS" ]; then
    resp=$(curl -s -m 5 -X POST \
        -H "Content-Type: application/json" \
        -d "{\"wifiAccessPoints\":[$APS]}" \
        "https://api.beacondb.net/v1/geolocate" 2>/dev/null)
    lat=$(echo "$resp" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['location']['lat'])" 2>/dev/null)
    lon=$(echo "$resp" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['location']['lng'])" 2>/dev/null)
    [ -n "$lat" ] && [ -n "$lon" ] && latlon="$lat,$lon"
fi

if [ -n "$latlon" ]; then
    query="wttr.in/$latlon"
    place=$(curl -s -m 5 -H "User-Agent: omarchy-waybar-weather/1.0" \
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=14" 2>/dev/null \
        | python3 -c "import json,sys; d=json.load(sys.stdin); a=d.get('address',{}); print(a.get('suburb') or a.get('city_district') or a.get('city') or d.get('display_name',''))" 2>/dev/null)
else
    query="wttr.in"  # fall back to IP-based lookup
    place="unknown (WiFi geolocation failed, used IP fallback)"
fi

condition=$(curl -s -m 5 "$query/?format=%c" 2>/dev/null | tr -d '\n ')
temp=$(curl -s -m 5 "$query/?format=%t" 2>/dev/null | tr -d '\n+°C ')

if [ -z "$condition" ] || [ -z "$temp" ]; then
    printf '%s\n' '{"text": "", "tooltip": "weather unavailable"}'
else
    printf '{"text": "%s\\n%s", "tooltip": "%s %sC\\n%s"}\n' "$condition" "$temp" "$condition" "$temp" "$place"
fi
