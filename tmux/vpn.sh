#!/usr/bin/env bash
# set -euo pipefail

theme=solarized

case "$theme" in
  "solarized")
    if (protonvpn-cli status | grep -i country >/dev/null); then
      echo -n "#[bg=default,fg=colour67]#[bg=colour67,fg=colour246] 🔐 "
    else
      echo -n "#[bg=default,fg=red]#[bg=red,fg=colour246] 🔓 "
    fi
    ;;
  *)
    if (protonvpn-cli status | grep -i country >/dev/null); then
      echo -n "#[bg=colour236,fg=colour239]#[bg=colour239,fg=colour246] 🔐 "
    else
      echo -n "#[bg=colour236,fg=red]#[bg=red,fg=colour246] 🔓 "
    fi
    ;;
esac
