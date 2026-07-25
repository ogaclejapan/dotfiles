function tmux_file_picker -d 'Pick files or directories and send them to the current tmux pane'
    if not set -q TMUX
        echo "Error: This function must be run inside a tmux session." >&2
        return 1
    end

    if not type -q fzf
        echo "Error: Required command 'fzf' not found. Please install it." >&2
        return 1
    end

    if not type -q fd
        echo "Error: Required command 'fd' not found. Please install it." >&2
        return 1
    end

    if not type -q bat
        echo "Error: Required command 'bat' not found. Please install it." >&2
        return 1
    end

    argparse -s 'g/git-root' 'd/directories' -- $argv
    or return 1

    if test (count $argv) -gt 1
        echo "Error: Only one path argument is allowed." >&2
        return 1
    end

    set -l use_git_root false
    set -q _flag_git_root; and set use_git_root true

    set -l select_directories false
    set -q _flag_directories; and set select_directories true

    set -l path_arg ''
    test (count $argv) -eq 1; and set path_arg $argv[1]

    set -l pane_id (tmux display-message -p '#{pane_id}')
    set -l pane_dir (tmux display-message -p '#{pane_current_path}')
    set -l pane_pid (tmux display-message -p '#{pane_pid}')

    set -l search_dirs
    set -l search_dir $pane_dir
    test -n "$path_arg"; and set search_dir $path_arg

    if not string match -q '/*' -- "$search_dir"
        set search_dir "$pane_dir/$search_dir"
    end

    set search_dir (__tmux_file_picker_realpath "$search_dir")
    if test -z "$search_dir"
        echo "Error: Directory '$path_arg' does not exist." >&2
        return 1
    end

    set search_dirs $search_dir

    for dir in $search_dirs
        if not test -d "$dir"
            echo "Error: Directory '$dir' does not exist." >&2
            return 1
        end
    end

    set -l at_prefix_mode false
    if pgrep -P "$pane_pid" -f '.*claude.*|node.*gemini|codex' >/dev/null 2>&1
        set at_prefix_mode true
    end

    set -l git_root ''
    if test "$use_git_root" = true
        set git_root (git rev-parse --show-toplevel 2>/dev/null)
        if test -z "$git_root"
            echo "Error: --git-root flag used, but not inside a git repository." >&2
            return 1
        end
        set git_root (__tmux_file_picker_realpath "$git_root")
    end

    set -l fd_flags
    set -l preview_cmd
    set -l grep_toggle_flags

    if test "$select_directories" = true
        if set -q TMUX_FILE_PICKER_FD_FLAGS
            set fd_flags (string split ' ' -- $TMUX_FILE_PICKER_FD_FLAGS)
        else
            set fd_flags -H --follow --type d --exclude .git
        end

        set preview_cmd (__tmux_file_picker_dir_preview)
    else
        if set -q TMUX_FILE_PICKER_FD_FLAGS
            set fd_flags (string split ' ' -- $TMUX_FILE_PICKER_FD_FLAGS)
        else
            set fd_flags -H --follow --type f --type d --exclude .git --exclude .DS_Store
        end

        set preview_cmd (__tmux_file_picker_entry_preview)
        set grep_toggle_flags \
            --prompt 'Files> ' \
            --header 'C-s: toggle grep mode' \
            --preview "if string match -q 'Grep*' -- \"\$FZF_PROMPT\"; rg --context 3 --color=always -- {q} {} 2>/dev/null || true; else; $preview_cmd; end" \
            --bind 'start:unbind(change)' \
            --bind "change:reload:rg --files-with-matches --hidden --glob '!.git' --color=never -- {q} 2>/dev/null || true" \
            --bind "ctrl-s:transform:if test \"\$FZF_PROMPT\" = 'Files> '; printf '%s' 'change-prompt(Grep> )+disable-search+clear-query+reload(true)+rebind(change)'; else; printf '%s' 'change-prompt(Files> )+enable-search+clear-query+unbind(change)+reload(fd $fd_flags)'; end"
    end

    set -l selected_files
    if test (count $search_dirs) -eq 1
        pushd "$search_dirs[1]" >/dev/null
        set selected_files (fd $fd_flags | fzf --multi --reverse --freeze-right=1 --bind 'tab:toggle' --preview "$preview_cmd" $grep_toggle_flags)
        set -l fzf_status $pipestatus[2]
        popd >/dev/null

        if test $fzf_status -ne 0
            return 0
        end
    else
        set selected_files (fd $fd_flags $search_dirs | fzf --multi --reverse --freeze-right=1 --bind 'tab:toggle' --preview "$preview_cmd" $grep_toggle_flags)
        set -l fzf_status $pipestatus[2]

        if test $fzf_status -ne 0
            return 0
        end
    end

    set -l output_paths
    if test (count $selected_files) -eq 0
        return 0
    else if test (count $search_dirs) -eq 1
        for file in $selected_files
            if test -n "$path_arg"
                set -a output_paths "$search_dirs[1]/$file"
            else
                set -a output_paths "$file"
            end
        end
    else
        set output_paths $selected_files
    end

    if test "$use_git_root" = true
        set -l relative_paths
        for path in $output_paths
            set -a relative_paths (__tmux_file_picker_relative_path "$git_root" (__tmux_file_picker_realpath "$path"))
        end
        set output_paths $relative_paths
    end

    if test (count $output_paths) -eq 0
        return 0
    end

    __tmux_file_picker_send_paths "$pane_id" "$at_prefix_mode" $output_paths
end

function __tmux_file_picker_dir_preview
    if type -q tree
        echo 'tree -C {} | head -n 30'
    else
        echo 'ls -ap {}'
    end
end

function __tmux_file_picker_entry_preview
    set -l dir_preview (__tmux_file_picker_dir_preview)

    echo "if test -d {}; $dir_preview; else; bat --style=numbers --color=always {}; end"
end

function __tmux_file_picker_realpath -a target
    if type -q realpath
        realpath "$target" 2>/dev/null
        and return 0
    end

    path resolve "$target" 2>/dev/null
end

function __tmux_file_picker_relative_path -a base target
    set -l normalized_base (string replace -r '/$' '' -- "$base")
    set -l escaped_base (string escape --style=regex -- "$normalized_base")

    if test "$target" = "$normalized_base"
        echo .
    else if string match -qr "^$escaped_base/" -- "$target"
        string replace -r "^$escaped_base/" '' -- "$target"
    else
        echo "$target"
    end
end

function __tmux_file_picker_send_paths -a pane_id at_prefix_mode
    set -e argv[1 2]

    set -l formatted_paths
    if test "$at_prefix_mode" = true
        for path in $argv
            set -a formatted_paths "@$path"
        end
    else
        for path in $argv
            set -a formatted_paths (string escape -- "$path")
        end
    end

    set -l output (string join ' ' -- $formatted_paths)
    tmux send-keys -t "$pane_id" "$output "
end
