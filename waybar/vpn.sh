#!/bin/bash

class="down"

if (command -v piactl >/dev/null); then
  VPN_CMD="piactl get connectionstate | grep -i connected >/dev/null"
else
  VPN_CMD="protonvpn-cli status | grep -i country >/dev/null"
fi

if (eval $VPN_CMD); then
  class="up"
fi

echo \{ \"text\": \""${country}"\", \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
