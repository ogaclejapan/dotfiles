function giter -d 'Local git repository management'

    if not type -q git
        echo "git: command not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: command not found" >&2
        return 1
    end

    git config giter.root | read -l dir
    if test $status -ne 0
        set dir ~/.giter
    end

    eval mkdir -p $dir
    if test $status -ne 0
        return 1
    end

    set rootpath (eval realpath $dir)
    if test (count $argv) -eq 0
        __giter_cd $rootpath
        return $status
    end

    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case help
            __giter_help $rootpath
        case root
            __giter_root $rootpath
        case cd
            __giter_cd $rootpath $argv
        case ls
            __giter_ls $rootpath $argv
        case clone
            __giter_clone $rootpath $argv
        case push
            __giter_push $rootpath $argv
        case pull
            __giter_pull $rootpath $argv
        case fetch
            __giter_fetch $rootpath $argv
        case merge
            __giter_merge $rootpath $argv
        case rebase
            __giter_rebase $rootpath $argv
        case cherry-pick
            __giter_cherrypick $rootpath $argv
        case checkout co
            __giter_checkout $rootpath $argv
        case new
            __giter_new $rootpath $argv
        case diet
            __giter_diet $rootpath $argv
        case done
            __giter_done $rootpath $argv
        case '*'
            __giter_exec $rootpath $subcommand $argv
    end

    return $status
end

function __giter_help
    set -l rootpath $argv[1]
    printf "Usage: giter <command>\n"
    printf "\n"
    printf "   root     Change directory to giter.root\n"
    printf "   cd       Change directory to selected git repository\n"
    printf "   ls       Show managed git repositories\n"
    printf "   clone    Clone git repository to managed directory\n"
    printf "   new      Create new branch\n"
    printf "   diet     Remove merged git branches\n"
    printf "   done     Remove selected git branches\n"
    printf "  <any>     Execute git command on selected git repository\n"
    printf "   help     Print this help\n"
    printf "\n"
    printf "Settings:\n"
    printf "\n"
    printf "   giter.root: $rootpath\n"
    printf "\n"
end

function __giter_ls
    set -l rootpath $argv[1]
    ls -1F $rootpath | tr -d '/'
end

function __giter_path
    set -l rootpath $argv[1]
    ls -1F $rootpath | tr -d '/' | fzf --reverse --min-height=2 --height=50% --bind=ctrl-v:page-down,alt-v:page-up,alt-n:half-page-down,alt-p:half-page-up
end

function __giter_root
    set -l rootpath $argv[1]
    cd $rootpath
end

function __giter_repo
    set -l rootpath $argv[1]
    set -l repo (__giter_path $rootpath)
    if test -z $repo
        return 0
    end
    printf "%s/%s" $rootpath $repo
end

function __giter_cd
    set -l rootpath $argv[1]
    set -l repopath (__giter_repo $rootpath)
    if test -z $repopath
        return 0
    end
    cd $repopath
end

function __giter_clone
    set -l rootpath $argv[1]
    set -e argv[1]
    git -C $rootpath clone $argv
    return $status
end

function __giter_push
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath push $argv
        return $status
    end
    set -l remote (__giter_remote $repopath)
    if test -z $remote
        return 0
    end
    set -l branchname (__giter_current_branch $repopath)
    read --prompt "echo -n 'Name for push branch? '; set_color green; echo -n '($branchname)'; set_color normal; echo -n ': '" -l pushbranch
    if test -z $pushbranch
        set pushbranch $branchname
    end
    git -C $repopath push $remote $branchname:$pushbranch
    return $status
end

function __giter_pull
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath pull $argv
        return $status
    end

    set -l remote (__giter_remote $repopath)
    if test -z $remote
        return 0
    end
    set -l branchname (__giter_current_branch $repopath)
    set -l remotename (printf "%s/%s" $remote $branchname)
    set -l is_ff (git -C $repopath branch -r --contains $branchname | grep -c "$remotename")
    if test $is_ff -ge 1
        git -C $repopath pull $remote $branchname
        return $status
    end

    read --prompt "echo 'Cannot be fast-forward.'; echo -n 'Rewrite for new commits? '; set_color green; echo -n '(--rebase=true)'; set_color normal; echo -n ': '" -l options
    if test -z $options
        set options '--rebase=true'
    end
    git -C $repopath pull $options $remote $branchname
    return $status
end

function __giter_fetch
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath fetch $argv
        return $status
    end

    set -l remote (__giter_remote $repopath)
    if test -z $remote
        return 0
    end
    git -C $repopath fetch $remote
    return $status
end

function __giter_merge
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath merge $argv
        return $status
    end
    set -l branch (__giter_select_branch $repopath)
    if test -z $branch
        return 0
    end
    git -C $repopath merge $branch
end

function __giter_rebase
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath rebase $argv
        return $status
    end
    set -l branch (__giter_select_branch $repopath)
    if test -z $branch
        return 0
    end
    git -C $repopath rebase $branch
end

function __giter_cherrypick
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath cherry-pick $argv
        return $status
    end
    set -l branch (__giter_select_branch $repopath)
    if test -z $branch
        return 0
    end
    set -l commits (git -C $repopath log --oneline --format='%h: %s' $branch | fzf --reverse --multi --exact --no-sort | cut -d ':' -f 1 | xargs)
    if test -z $commits
        return 0
    end
    git -C $repopath cherry-pick $commits
end

function __giter_checkout
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    if test (count $argv) -ne 0
        git -C $repopath checkout $argv
        return $status
    end
    set -l branch (__giter_select_branch $repopath)
    if test -z $branch
        return 0
    end
    git -C $repopath checkout $branch
end

function __giter_new
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    set -l branch (__giter_select_branch $repopath)
    if test -z $branch
        return 0
    end
    set -l branchname (basename $branch)
    read --prompt "echo -n 'Name for new branch? '; set_color green; echo -n '($branchname)'; set_color normal; echo -n ': '" -l newbranch
    if test -z $newbranch
        set newbranch $branchname
    end
    git -C $repopath checkout -b $newbranch $branch
end

function __giter_diet
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    set -l merged_branches (git -C $repopath branch --merged master | grep -vE '^\*|^master$' | tr -d '[:blank:]')
    for target in $merged_branches
        git -C $repopath branch -d $target
    end
end

function __giter_done
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    set -l selected_branches (git -C $repopath branch | grep -vE '^\*|^master$' | tr -d '[:blank:]' | fzf --multi --reverse)
    for target in $selected_branches
        git -C $repopath branch -D $target
    end
end

function __giter_select_branch
    set -l repopath $argv[1]
    set -e argv[1]
    git -C $repopath for-each-ref --format='%(refname:short)%(if)%(authorname)%(then)%09by %(authorname)%(end)' $argv | column -t -s \t | fzf --reverse --exact --no-sort --bind=ctrl-v:page-down,alt-v:page-up,alt-n:half-page-down,alt-p:half-page-up | cut -f 1 -d ' '
end

function __giter_exec
    set -l rootpath $argv[1]
    set -e argv[1]
    set repopath (git rev-parse --show-toplevel 2> /dev/null)
    if test -z $repopath
        set repopath (__giter_repo $rootpath)
    end
    if test -z $repopath
        return 0
    end
    git -C $repopath $argv
    return $status
end

function __giter_remote
    set -l repopath $argv[1]
    git -C $repopath remote | fzf --reverse --exact --height=25% --select-1 --exit-0
end

function __giter_current_branch
    set -l repopath $argv[1]
    git -C $repopath symbolic-ref --short HEAD
end

function __giter_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    else
        return 1
    end
end

complete -f -c giter -n '__giter_needs_command' -a help -d 'Display the manual of a giter command'
complete -f -c giter -n '__giter_needs_command' -a root -d 'Change directory to giter.root'
complete -f -c giter -n '__giter_needs_command' -a cd -d 'Change directory to selected git repository'
complete -f -c giter -n '__giter_needs_command' -a ls -d 'Show managed git repositories'
complete -f -c giter -n '__giter_needs_command' -a clone -d 'Clone git repository to managed directory'
complete -f -c giter -n '__giter_needs_command' -a new -d 'Create new branch'
complete -f -c giter -n '__giter_needs_command' -a diet -d 'Remove merged git branches'
complete -f -c giter -n '__giter_needs_command' -a done -d 'Remove selected git branches'
complete -c giter -w git
