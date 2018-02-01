function apk -d 'Find apk from under the current directory'
    if not type -q fd
        echo "fd: not found" >&2
        return 1
    end

    command fd -I -E '.git' -e 'apk' | fzf --min-height=2 --height=25% --reverse --select-1 | read -l apk
    if test -z $apk
        return 0
    end

    argparse 'd/dir' -- $argv
    if set -q _flag_dir
        dirname $apk
    else
        echo $apk
    end

end
