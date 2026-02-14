#!/usr/bin/env bash
set -euo pipefail

# notifyは JSON を「第1引数」で渡してくる仕様
# https://developers.openai.com/codex/config-advanced/#notifications
PAYLOAD="${1:-"{}"}"
TYPE="$(printf '%s' "$PAYLOAD" | jq -r '.type')"

if [ -n "$TYPE" ] && [ "$TYPE" != "agent-turn-complete" ]; then
  exit 0
fi

ASSISTANT_MESSAGE="$(printf '%s' "$PAYLOAD" | jq -r '.["last-assistant-message"] // "Turn completed."')"

# tmuxのウィンドウ番号を取得してメッセージ用に整形
TMUX_INFO=""
if [ -n "${TMUX:-}" ]; then
  TMUX_INFO=" [tmux:$(tmux display-message -p '#I')]"
fi

# リポジトリ名を取得してメッセージ用に整形
GIT_INFO=""
GIT_REPO_NAME=$(basename -s .git "$(git config --get remote.origin.url || echo "")")
if [ -n "${GIT_REPO_NAME}" ]; then
  GIT_INFO=" [git:${GIT_REPO_NAME}]"
fi

MESSAGE="${ASSISTANT_MESSAGE}${TMUX_INFO}${GIT_INFO}"

# 完了通知を送信
terminal-notifier -title "Codex 🤖" -message "$MESSAGE" -sound Purr

# Slack 通知（SLACK_WEBHOOK_URL が設定されている場合）
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" "$SLACK_WEBHOOK_URL" || true
fi
