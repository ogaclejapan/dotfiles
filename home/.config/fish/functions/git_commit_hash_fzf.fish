function git_commit_hash_fzf -d 'Execute git log command to interactive selecting commit hash '

  if not type -q git
    echo "git: command not found"
    return 1
  end

  set origin (type -P git)

  eval "$origin log --oneline --format='%h: %s' $argv | fzf  --reverse --multi --no-sort | cut -d ':' -f 1"

end
