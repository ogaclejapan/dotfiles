function fuzzy_directory_commander -d 'Open the selected directory with the command using fuzzy finder'
    if not type -q fd
        echo "fd: not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: not found" >&2
        return 1
    end

    argparse -s 'c/command=' -- $argv
    set -l open_cmd 'cd'
    if set -q _flag_command
        set open_cmd $_flag_command
    end

    fd -t d | fzf --reverse --exact --prompt="$open_cmd> " | read -l path
    if test -z "$path"
        return 0
    end

    eval $open_cmd "$path"
end
