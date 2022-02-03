#!/usr/bin/env bash
# set -euo pipefail

status=$(protonvpn status | grep -i status | awk '{print $2}')
if [ "${status}" = "Connected" ]; then
  echo -n "#[bg=colour255,fg=colour33]#[bg=colour33,fg=default] 🔒#[bg=colour33,fg=default]"
else
  echo -n "#[bg=colour255,fg=red]#[bg=red,fg=default] 🔓 #[bg=red,fg=default]"
fi
