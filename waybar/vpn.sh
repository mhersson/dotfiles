#!/usr/bin/env bash

if (command -v piactl >/dev/null); then
  vpnip=$(piactl get vpnip)
  class="up"
  tooltip="VPN connected: ${vpnip}"

  if (piactl get connectionstate | grep -i disconnected >/dev/null); then
    class="down"
    tooltip="VPN disconnected"
  fi

else

  # For NixOS using wg-quick
  class="down"
  tooltip="VPN disconnected"
  ip=$(sudo wg show | grep endpoint | awk '{split($0, a, ":"); print a[2]}')
  if [ "${ip}" != "" ]; then
    class="up"
    tooltip="VPN connected: ${ip}"
  fi
fi

echo "{\"class\":\"$class\", \"tooltip\":\"$tooltip\"}"
