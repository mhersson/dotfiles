#!/usr/bin/env bash
# set -euo pipefail

if (protonvpn-cli status | grep -i country >/dev/null); then
  echo -n "#[bg=colour236,fg=colour239]#[bg=colour239,fg=colour246] 🔐 #[bg=colour239,fg=colour236]"
else
  echo -n "#[bg=colour236,fg=red]#[bg=red,fg=colour246] 🔓 #[bg=red,fg=colour236]"
fi
