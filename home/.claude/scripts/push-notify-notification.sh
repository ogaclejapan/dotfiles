#!/bin/bash
# for Claude Code Hooks Notification

# ブランチ名が指定されていない場合は現在のブランチを取得
if [ -z "$1" ]; then
    BRANCH=$(git branch --show-current)
else
    BRANCH="$1"
fi

# リポジトリ名を取得
REPO_NAME=$(basename -s .git `git config --get remote.origin.url`)

# 確認通知を送信
terminal-notifier -title "Claude Code" -message "Action needed 💬 (${REPO_NAME}/${BRANCH})" -sound Purr
echo "✅ Notification sent: Action needed for ${REPO_NAME}/${BRANCH}"

# ----- ここから独自追加 ----- #

# tmux上で動いている場合は、ウィンドウタイトルを更新
if [ -n "$TMUX" ]; then
    tmux rename-window "cc/notif"
fi

# Slack通知を送信（SLACK_WEBHOOK_URLが設定されている場合）
if [ -n "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"Action needed 💬 (${REPO_NAME}/${BRANCH})\"}" "$SLACK_WEBHOOK_URL"
fi

# ----- ここまで独自追加 ----- #
