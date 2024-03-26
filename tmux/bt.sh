#!/usr/bin/env bash

theme=dark

case "$theme" in
  "dark")
    if (bt-device -i "H-Phonak Høreapparat" | grep "Connected: 1" >/dev/null); then
      echo -n "#[bg=colour235,fg=colour67]#[bg=colour67,fg=colour235] 🎧 #[bg=colourcolour67,fg=colour235]"
    fi
    ;;
  "light")
    if (bt-device -i "H-Phonak Høreapparat" | grep "Connected: 1" >/dev/null); then
      echo -n "#[bg=default,fg=colour67]#[bg=colour67,fg=white] 🎧 #[bg=colourcolour67,fg=white]"
    fi
    ;;
  "*")
    if (bt-device -i "H-Phonak Høreapparat" | grep "Connected: 1" >/dev/null); then
      echo -n "#[bg=colour236,fg=colour239]#[bg=colour239,fg=default] 🎧 #[bg=colour239,fg=colour236]"
    fi
    ;;

esac
