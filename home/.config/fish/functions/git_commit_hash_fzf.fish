function git_commit_hash_fzf -d 'Execute git log command to interactive selecting commit hash '

    if not type -q git
        echo "git: command not found" >&2
        return 1
    end

    command git log --oneline --format='%h: %s' (string escape -- $argv) | fzf --reverse --multi --no-sort | cut -d ':' -f 1

end
