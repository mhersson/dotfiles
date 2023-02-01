#!/bin/bash

class="down"

if (command -v piactl >/dev/null); then
  VPN_CMD="piactl get connectionstate | grep -i connected >/dev/null"
elif (command -v protonvpn-cli >/dev/null); then
  VPN_CMD="protonvpn-cli status | grep -i country >/dev/null"
else
  VPN_CMD="nmcli c s --active | grep wireguard >/dev/null"
fi

if (eval "${VPN_CMD}"); then
  class="up"
fi

echo \{ \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
