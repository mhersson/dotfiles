#!/usr/bin/env bash
# This script allows the user to select a working directory from a list of project roots.
# It uses 'fd' to find directories and 'fzf' for interactive selection.
# The selected directory is stored in a temporary file for later retrieval.
# Usage:
#   ./switch-project.sh show-picker  # to show the directory picker
#   ./switch-project.sh              # to retrieve the cached selection
# Requirements:
#   - fd
#   - fzf
#
# Example config for Helix to use this script:
# ```toml
# C-p = [
#     ":open %sh{~/.config/helix/utils/switch-project.sh show-picker}",
#     ":change-current-directory %sh{~/.config/helix/utils/switch-project.sh}",
#     ":redraw",
#     ":reload-all"
# ]
# ```
# Make sure to adjust the paths and project roots as needed.

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
PROJECT_ROOTS=("$HOME/Development" "$HOME/Documents")
FD_EXCLUDES=("go")

TMP="${XDG_RUNTIME_DIR:-/tmp}/helix-selected-project"

FD_ARGS=()
for ex in "${FD_EXCLUDES[@]}"; do
  FD_ARGS+=(--exclude "$ex")
done

if [ -f "$TMP" ]; then
  cat "$TMP"
  rm -f "$TMP"
  exit 0
fi

if [ "${1-}" = "show-picker" ]; then
  dir="$({
    printf '%s\n' "$DOTFILES_DIR"
    fd --type d --max-depth 1 "${FD_ARGS[@]}" . "${PROJECT_ROOTS[@]}"
  } | fzf)" || exit 1

  printf '%s' "$dir" >"$TMP"
  printf '%s' "$dir"
fi
