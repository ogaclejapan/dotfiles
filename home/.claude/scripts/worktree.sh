#!/usr/bin/env bash
set -euo pipefail

# hookは JSON を標準入力で渡してくる仕様
PAYLOAD=$(cat)
TYPE="${1:-unknown}"

get_worktree_base() {
  local repo_dir="$1"
  local dir
  dir=$(git -C "$repo_dir" config giter.worktree 2>/dev/null || echo "$HOME/.giter_worktree")
  dir=$(eval realpath "$dir")
  mkdir -p "$dir"
  echo "$dir"
}

case "$TYPE" in
create)
  WT_NAME=$(echo "$PAYLOAD" | jq -r '.name')
  CWD=$(echo "$PAYLOAD" | jq -r '.cwd')

  ORIGIN_REPO=$(git -C "$CWD" rev-parse --show-toplevel)
  REPO_NAME=$(basename "$ORIGIN_REPO")
  WORK_BASE=$(get_worktree_base "$CWD")
  WT_PATH="$WORK_BASE/$REPO_NAME/$WT_NAME"

  git -C "$CWD" worktree add -b "$WT_NAME" "$WT_PATH" HEAD >&2
  echo "$WT_PATH"
  ;;
remove)
  WT_PATH=$(echo "$PAYLOAD" | jq -r '.worktree_path')
  git -C "$WT_PATH" worktree remove --force "$WT_PATH" >&2
  ;;
*)
  exit 1
  ;;
esac
