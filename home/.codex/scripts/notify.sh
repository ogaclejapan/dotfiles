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

TITLE="Codex 🤖"
BODY="${ASSISTANT_MESSAGE}${TMUX_INFO}${GIT_INFO}"

# 完了通知を送信
# https://github.com/ghostty-org/ghostty/discussions/10387
if [ -n "$TMUX" ]; then
  PANE_TTY=$(tmux display-message -p '#{pane_tty}')
  printf '\ePtmux;\e\e]777;notify;%s;%s\a\e\\' "$TITLE" "$BODY" > "$PANE_TTY"
else
  printf '\e]777;notify;%s;%s\a' "$TITLE" "$BODY"
fi

# Slack 通知（SLACK_WEBHOOK_URL が設定されている場合）
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${BODY}\"}" "$SLACK_WEBHOOK_URL" || true
fi
