function commitcheck -d 'Check the given commit message'

    if not type -q trans
        echo "trans: command not found" >&2
        return 1
    end

    if test (count $argv) -eq 0
        echo "error: message is required" >&2
        return 1
    end

    set -l message $argv[1]
    set -e argv[1]

    trans en:ja -brief "If applied, this commit will $message"
end
