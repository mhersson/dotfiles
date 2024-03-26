#!/usr/bin/env bash
# set -euo pipefail

theme=dark

if (command -v piactl >/dev/null); then
  VPN_CMD="piactl get connectionstate | grep -i connected >/dev/null"
else
  VPN_CMD="protonvpn-cli status | grep -i country >/dev/null"
fi

case "$theme" in
  "dark")
    if (eval "$VPN_CMD"); then
      echo -n "#[bg=colour235,fg=colour238]#[bg=colour238,fg=colour246] 🔐 "
    else
      echo -n "#[bg=colour235,fg=red]#[bg=red,fg=colour246] 🔓 "
    fi
    ;;
  "light")
    if (eval "$VPN_CMD"); then
      echo -n "#[bg=default,fg=colour238]#[bg=colour238,fg=colour246] 🔐 "
    else
      echo -n "#[bg=default,fg=red]#[bg=red,fg=colour246] 🔓 "
    fi
    ;;
  *)
    if (eval "$VPN_CMD"); then
      echo -n "#[bg=colour236,fg=colour239]#[bg=colour239,fg=colour246] 🔐 "
    else
      echo -n "#[bg=colour236,fg=red]#[bg=red,fg=colour246] 🔓 "
    fi
    ;;
esac
