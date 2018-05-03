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
        case cd
            __giter_cd $rootpath $argv
        case ls
            __giter_ls $rootpath $argv
        case clone
            __giter_clone $rootpath $argv
        case '*'
            __giter_exec $rootpath $subcommand $argv
    end
    
    return $status
end

function __giter_ls
    set -l rootpath $argv[1]    
    ls -1F $rootpath | tr -d '/'
end

function __giter_path
    set -l rootpath $argv[1]
    ls -1F $rootpath | tr -d '/' | fzf --reverse --min-height=2 --height=25% --bind=ctrl-v:page-down,alt-v:page-up,alt-n:half-page-down,alt-p:half-page-up
end

function __giter_help
    set -l rootpath $argv[1]
    printf "Usage: giter <command>\n"
    printf "\n"
    printf "   cd       Change directory to selected git repository\n"
    printf "   ls       Show managed git repositories\n"
    printf "  <any>     Execute git command on selected git repository\n"
    printf "   help     Print this help\n"
    printf "\n"
    printf "Settings:\n"
    printf "\n"
    printf "   giter.root: $rootpath\n"
    printf "\n"
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

function __giter_exec
    set -l rootpath $argv[1]
    set -e argv[1]
    set -l repopath (__giter_repo $rootpath)
    if test -z $repopath
        return 0
    end
    git -C $repopath $argv
    return $status
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
complete -f -c giter -n '__giter_needs_command' -a cd -d 'Change directory to selected git repository'
complete -f -c giter -n '__giter_needs_command' -a ls -d 'Show managed git repositories'
complete -c giter -w git
