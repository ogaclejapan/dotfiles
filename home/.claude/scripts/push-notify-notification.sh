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
