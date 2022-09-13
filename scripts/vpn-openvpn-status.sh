#!/bin/sh
# printf "VPN: " && (pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1 && echo down) | head -n 1
printf "VPN: " &&  nmcli -t -f NAME c show --active | head -n 1
