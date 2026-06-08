#!/usr/bin/env bash
set -euo pipefail

# hookは JSON を標準入力で渡してくる仕様
# https://github.com/disler/claude-code-hooks-mastery
PAYLOAD=$(cat)
TYPE="${1:-unknown}"

case "$TYPE" in
question)
  ASSISTANT_MESSAGE=$(echo "$PAYLOAD" | jq -r '.tool_input.question // .tool_input.questions[0].question // "Answer needed."')
  ;;
permission)
  ASSISTANT_MESSAGE=$(echo "$PAYLOAD" | jq -r '.["message"] // "Permission needed."')
  ;;
idle)
  ASSISTANT_MESSAGE=$(echo "$PAYLOAD" | jq -r '.["message"] // "Turn completed."')
  ;;
stop)
  ASSISTANT_MESSAGE=$(echo "$PAYLOAD" | jq -r '.["last_assistant_message"] // "Agent stopped."')
  ;;
*)
  exit 0
  ;;
esac

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

TITLE="Claude Code 🤖"
BODY="${ASSISTANT_MESSAGE}${TMUX_INFO}${GIT_INFO}"

# 確認通知を送信
# https://github.com/ghostty-org/ghostty/discussions/10387
if [ -n "$TMUX" ]; then
  PANE_TTY=$(tmux display-message -p '#{pane_tty}')
  printf '\ePtmux;\e\e]777;notify;%s;%s\a\e\\' "$TITLE" "$BODY" > "$PANE_TTY"
else
  printf '\e]777;notify;%s;%s\a' "$TITLE" "$BODY"
fi

# Slack通知を送信（SLACK_WEBHOOK_URLが設定されている場合）
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${BODY}\"}" "$SLACK_WEBHOOK_URL" || true
fi
