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
