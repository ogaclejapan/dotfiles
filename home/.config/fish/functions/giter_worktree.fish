function giter_worktree -d 'Local git worktree management'

    if not type -q git
        echo "git: command not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: command not found" >&2
        return 1
    end

    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        echo "giter: not a git repository" >&2
        return 1
    end

    if test (count $argv) -eq 0
        __giter_worktree_cd $repopath
        return $status
    end

    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case help
            __giter_worktree_help $repopath
        case cd
            __giter_worktree_cd $repopath $argv
        case ls
            __giter_worktree_ls $repopath $argv
        case new
            __giter_worktree_new $repopath $argv
        case view
            __giter_worktree_view $repopath $argv
        case '*'
            __giter_worktree_exec $repopath $subcommand $argv
    end

    return $status
end

function __giter_worktree_help
    set -l repopath $argv[1]
    set -l workpath (__giter_worktree_path $repopath)
    printf "Usage: giter_worktree <command>\n"
    printf "\n"
    printf "   new      Create working tree with new branch\n"
    printf "   view     Create working tree without new branch\n"
    printf "   cd       Change directory to selected git working trees\n"
    printf "   ls       Show managed git working trees\n"
    printf "  <any>     Execute git worktree command on git repository\n"
    printf "   help     Print this help\n"
    printf "\n"
    printf "Settings:\n"
    printf "\n"
    printf "   giter.worktree: $workpath\n"
    printf "\n"
end

function __giter_worktree_ls
    set -l repopath $argv[1]
    git -C $repopath worktree list | fzf --reverse --exact --no-sort --multi --header-lines=1 | cut -f 1 -d ' '
end

function __giter_worktree_path
    set -l repopath $argv[1]
    git config giter.worktree | read -l dir
    if test $status -ne 0
        set dir .giter
    end
    printf "%s/%s" $repopath $dir
end

function __giter_worktree_cd
    set -l repopath $argv[1]
    git -C $repopath worktree list | fzf --reverse --exact --no-sort --height=50% | cut -f 1 -d ' ' | read -l dir
    if test -z $dir
        return 0
    end
    cd $dir
end

function __giter_worktree_new
    set -l repopath $argv[1]
    set -l workpath (__giter_worktree_path $repopath)
    set -l workbranch (__giter_worktree_select_branch $repopath)
    if test -z $workbranch
        return 0
    end

    set -l branchname (basename $workbranch)
    read --prompt "echo 'Name for new branch: '" --command "$branchname" -l newbranch
    if test -z $branchname
        return 0
    end

    set -l path (printf "%s/%s" $workpath $newbranch)
    git -C $repopath worktree add -b $newbranch $path $workbranch
end

function __giter_worktree_view
    set -l repopath $argv[1]
    set -l workpath (__giter_worktree_path $repopath)
    set -l workbranch (__giter_worktree_select_branch $repopath)
    if test -z $workbranch
        return 0
    end
    set -l branchname (basename $workbranch)
    set -l path (printf "%s/%s/%s" $workpath 'view' $branchname)
    git -C $repopath worktree add $path $workbranch
end

function __giter_worktree_select_branch
    set -l repopath $argv[1]
    set -e argv[1]
    git -C $repopath for-each-ref --format='%(refname:short)%(if)%(authorname)%(then)%09by %(authorname)%(end)' $argv | column -t -s \t | fzf --reverse --exact --no-sort --bind=ctrl-v:page-down,alt-v:page-up,alt-n:half-page-down,alt-p:half-page-up | cut -f 1 -d ' '
end

function __giter_worktree_exec
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    git -C $repopath worktree $argv
    return $status
end

function __giter_worktree_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    else
        return 1
    end
end

complete -f -c giter_worktree -n '__giter_worktree_needs_command' -a help -d 'Display the manual of a giter_worktree command'
complete -f -c giter_worktree -n '__giter_worktree_needs_command' -a new -d 'Create working tree with new branch'
complete -f -c giter_worktree -n '__giter_worktree_needs_command' -a view -d 'Create working tree without new branch'
complete -f -c giter_worktree -n '__giter_worktree_needs_command' -a cd -d 'Change directory to selected git working trees'
complete -f -c giter_worktree -n '__giter_worktree_needs_command' -a ls -d 'Show managed git working trees'