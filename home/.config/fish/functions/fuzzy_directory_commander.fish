function fuzzy_directory_commander -d 'Open the selected directory with the command using fuzzy finder'
    if not type -q fd
        echo "fd: not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: not found" >&2
        return 1
    end

    argparse -s 'c/command=' 'd/depth=' -- $argv

    set -l open_cmd 'cd'
    set -q _flag_command; and set -l open_cmd $_flag_command

    set -l fd_cmd 'fd -H -L -E "**/.git" -t d'
    set -q _flag_depth; and set -l fd_cmd "$fd_cmd -d $_flag_depth"

    eval $fd_cmd | fzf --reverse --exact --prompt="$open_cmd> " | read -l path
    if test -z "$path"
        return 0
    end

    eval $open_cmd "$path"
end
