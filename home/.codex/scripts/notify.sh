#!/bin/bash
set -euo pipefail

# notifyは JSON を「第1引数」で渡してくる仕様
# https://developers.openai.com/codex/config-advanced/#notifications
PAYLOAD="${1:-"{}"}"
TYPE="$(printf '%s' "$PAYLOAD" | jq -r '.type')"

if [ -n "$TYPE" ] && [ "$TYPE" != "agent-turn-complete" ]; then
  exit 0
fi

LAST_MESSAGE="$(printf '%s' "$PAYLOAD" | jq -r '.["last-assistant-message"] // Turn Complete!')"

# tmuxのウィンドウ番号を取得してメッセージ用に整形
TMUX_WINDOW=""
if [ -n "${TMUX:-}" ]; then
  TMUX_WINDOW=" [tmux:$(tmux display-message -p '#I')]"
fi

MESSAGE="${LAST_MESSAGE}${TMUX_WINDOW}"

# 完了通知を送信
terminal-notifier -title "Codex" -message "$MESSAGE" -sound Glass
echo "✅ Notification sent: $MESSAGE"

# Slack 通知（SLACK_WEBHOOK_URL が設定されている場合）
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" "$SLACK_WEBHOOK_URL" || true
fi
