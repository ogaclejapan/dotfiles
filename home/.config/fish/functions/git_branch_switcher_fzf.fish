function git_branch_switcher_fzf -d 'Execute git for-each-ref command to interactive when multiple branches found'

    if not type -q git
        echo "git: command not found" >&2
        return 1
    end

    argparse -s 'l/local' 'r/remote' 't/tag' -- $argv
    if set -q _flag_local
        set refs 'refs/heads'
    else if set -q _flag_remote
        set refs 'refs/remotes'
    else if set -q _flag_tag
        set refs 'refs/tags'
    else
        set refs 'refs'
    end

    command git for-each-ref --format='%(refname:short)%(if)%(authorname)%(then)%09by %(authorname)%(end)' $refs (string escape -- $argv) | fzf --reverse --select-1 --no-sort | cut -f 1 | read -l branch
    if test -z branch
        return 0
    end

    command git checkout $branch
    
end
