#!/usr/bin/env bash

vpnip=$(piactl get vpnip)
class="up"
tooltip="VPN connected: ${vpnip}"

if (piactl get connectionstate | grep -i disconnected >/dev/null); then
  class="down"
  tooltip="VPN disconnected"
fi

echo "{\"class\":\"$class\", \"tooltip\":\"$tooltip\"}"
