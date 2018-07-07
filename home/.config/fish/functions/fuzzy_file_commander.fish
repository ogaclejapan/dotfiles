function fuzzy_file_commander -d 'Open the selected file with the command using fuzzy finder'
    if not type -q fd
        echo "fd: not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: not found" >&2
        return 1
    end

    argparse -s 'c/command=' 'd/depth=' -- $argv

    set -l open_cmd 'open'
    set -q EDITOR; and set -l open_cmd $EDITOR
    set -q _flag_command; and set -l open_cmd $_flag_command

    set -l fd_cmd 'fd -H -L -E "**/.git" -t f'
    set -q _flag_depth; and set -l fd_cmd "$fd_cmd -d $_flag_depth"

    eval $fd_cmd | fzf --reverse --exact --prompt="$open_cmd> " | read -l file
    if test -z "$file"
        return 0
    end

    eval $open_cmd $file
end
