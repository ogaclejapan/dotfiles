#!/bin/bash
set -euo pipefail

# tmuxのウィンドウ番号を取得してメッセージ用に整形
TMUX_WINDOW=""
if [ -n "${TMUX:-}" ]; then
  TMUX_WINDOW=" [tmux:$(tmux display-message -p '#I')]"
fi

MESSAGE="Action needed!${TMUX_WINDOW}"

# 確認通知を送信
terminal-notifier -title "Claude Code" -message "$MESSAGE" -sound Purr
echo "✅ Notification sent: $MESSAGE"

# Slack通知を送信（SLACK_WEBHOOK_URLが設定されている場合）
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" "$SLACK_WEBHOOK_URL" || true
fi
