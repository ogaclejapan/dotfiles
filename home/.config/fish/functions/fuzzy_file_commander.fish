function fuzzy_file_commander -d 'Open the selected file with the command using fuzzy finder'
    if not type -q fd
        echo "fd: not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: not found" >&2
        return 1
    end

    argparse -s 'c/command=' -- $argv
    set -l open_cmd 'open'
    if set -q _flag_command
        set open_cmd $_flag_command
    else if set -q EDITOR
        set open_cmd $EDITOR
    end

    fd -t f | fzf --reverse --exact --prompt="$open_cmd> " | read -l file
    if test -z "$file"
        return 0
    end

    eval $open_cmd $file
end
