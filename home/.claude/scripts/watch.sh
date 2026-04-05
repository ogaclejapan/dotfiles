#!/usr/bin/env bash
set -euo pipefail

# tmux外では何もしない
if [ -z "${TMUX:-}" ]; then
  exit 0
fi

TYPE="${1:-unknown}"

case "$TYPE" in
session-start)
  tmux set-option -w -t "$TMUX_PANE" @claude_original_name "$(tmux display-message -p -t "$TMUX_PANE" '#W')"
  tmux set-option -w -t "$TMUX_PANE" automatic-rename off
  tmux rename-window -t "$TMUX_PANE" "🤖"
  ;;
session-end)
  ORIGINAL=$(tmux show-option -wv -t "$TMUX_PANE" @claude_original_name 2>/dev/null || echo "")
  if [ -n "$ORIGINAL" ]; then
    tmux rename-window -t "$TMUX_PANE" "$ORIGINAL"
    tmux set-option -wu -t "$TMUX_PANE" @claude_original_name
    tmux set-option -w -t "$TMUX_PANE" automatic-rename on
  fi
  ;;
ongoing)
  tmux rename-window -t "$TMUX_PANE" "🤖🔥"
  ;;
pending)
  tmux rename-window -t "$TMUX_PANE" "🤖⏳"
  ;;
finish)
  tmux rename-window -t "$TMUX_PANE" "🤖🍣"
  ;;
abort)
  tmux rename-window -t "$TMUX_PANE" "🤖🚨"
  ;;
*)
  exit 0
  ;;
esac
