#!/usr/bin/env bash

TMP="${XDG_RUNTIME_DIR:-/tmp}/helix-project-chosen-dir"

if [ -f "$TMP" ]; then
  cat "$TMP"
  rm -f "$TMP"
  exit 0
fi

if [ "$1" = "show-picker" ]; then
  dir="$({
    printf '%s\n' "$HOME/.dotfiles"
    fd --type d --max-depth 1 --exclude go . ~/Development ~/Documents
  } | fzf)" || exit 1

  printf '%s' "$dir" >"$TMP"
  printf '%s' "$dir"
fi
