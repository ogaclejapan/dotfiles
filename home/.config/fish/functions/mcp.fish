function mcp -d 'Select MCP server configs with fzf and merge into a single JSON file'
    if not type -q fzf
        echo "fzf: not found" >&2
        return 1
    end

    if not type -q jq
        echo "jq: not found" >&2
        return 1
    end

    set -l mcp_dir ~/.claude/mcp
    if not test -d $mcp_dir
        echo "mcp: $mcp_dir not found" >&2
        return 1
    end

    set -l configs $mcp_dir/*.json
    if test (count $configs) -eq 0
        echo "mcp: no JSON files in $mcp_dir" >&2
        return 1
    end

    argparse 'd/dir=' -- $argv
    or return 1

    set -l selected (__mcp_select $mcp_dir $configs)
    if test -z "$selected"
        return 0
    end

    set -l out_dir (__mcp_out_dir $_flag_dir)
    set -l out_file $out_dir/mcp.json

    __mcp_merge $mcp_dir $out_file $selected

    echo $out_file
end

function __mcp_select
    set -l mcp_dir $argv[1]
    set -e argv[1]
    for f in $argv
        basename $f
    end | fzf --multi --reverse --prompt="MCP> "
end

function __mcp_out_dir
    set -l dir
    if test (count $argv) -ge 1
        set dir $argv[1]
    else
        set dir (mktemp -d)
    end
    mkdir -p $dir
    echo $dir
end

function __mcp_merge
    set -l mcp_dir $argv[1]
    set -l out_file $argv[2]
    set -e argv[1..2]

    set -l files
    for name in $argv
        set -a files $mcp_dir/$name
    end

    jq -s 'reduce .[] as $item ({}; . * $item)' $files >$out_file
end

complete -f -c mcp
complete -c mcp -s d -l dir -r -a '(__fish_complete_directories)' -d 'Output directory for merged mcp.json'
