#!/usr/bin/env bash

if (bt-device -i "H-Phonak Høreapparat" | grep "Connected: 1" >/dev/null); then
  echo -n "#[bg=colour236,fg=colour214]#[bg=colour214,fg=default] 🎧 #[bg=colour214,fg=colour236]"
fi
