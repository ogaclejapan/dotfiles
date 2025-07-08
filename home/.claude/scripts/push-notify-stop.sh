#!/bin/bash
# for Claude Code Hooks Stop

# ブランチ名が指定されていない場合は現在のブランチを取得
if [ -z "$1" ]; then
    BRANCH=$(git branch --show-current)
else
    BRANCH="$1"
fi

# リポジトリ名を取得
REPO_NAME=$(basename -s .git `git config --get remote.origin.url`)

# 完了通知を送信
terminal-notifier -title "Claude Code" -message "Task completed🎉 (${REPO_NAME}/${BRANCH})" -sound Glass
echo "✅ Notification sent: Task completed for ${REPO_NAME}/${BRANCH}"

# ----- ここから独自追加 ----- #

# tmux上で動いている場合は、ウィンドウタイトルを更新
if [ -n "$TMUX" ]; then
    tmux rename-window "cc/stop"
fi

# Slack通知を送信（SLACK_WEBHOOK_URLが設定されている場合）
if [ -n "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"Task completed🎉 (${REPO_NAME}/${BRANCH})\"}" "$SLACK_WEBHOOK_URL"
fi

# ----- ここまで独自追加 ----- #
