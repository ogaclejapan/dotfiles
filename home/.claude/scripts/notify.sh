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
notification)
  ASSISTANT_MESSAGE=$(echo "$PAYLOAD" | jq -r '.["message"] // "Turn completed."')
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

MESSAGE="${ASSISTANT_MESSAGE}${TMUX_INFO}${GIT_INFO}"

# 確認通知を送信
terminal-notifier -title "Claude Code 🤖" -message "$MESSAGE" -sound Purr

# Slack通知を送信（SLACK_WEBHOOK_URLが設定されている場合）
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" "$SLACK_WEBHOOK_URL" || true
fi
