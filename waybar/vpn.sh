#!/usr/bin/env bash

class="up"
tooltip="VPN connected"

if (piactl get connectionstate | grep -i disconnected >/dev/null); then
  class="down"
  tooltip="VPN disconnected"
fi

echo "{\"class\":\"$class\", \"tooltip\":\"$tooltip\"}"
