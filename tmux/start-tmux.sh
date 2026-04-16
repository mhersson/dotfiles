#!/bin/sh
# Start a named tmux session for Ghostty
# Names sessions ghostty-1, ghostty-2, etc., reusing gaps from closed sessions

TMUX_CMD=$(which tmux)

if [ -z "$TMUX_CMD" ]; then
  echo "tmux not found. Please install tmux and ensure it's in your PATH."
  exit 1
fi

n=1
while "$TMUX_CMD" has-session -t "$n" 2>/dev/null; do
  n=$((n + 1))
done

exec "$TMUX_CMD" new-session -s "$n"
