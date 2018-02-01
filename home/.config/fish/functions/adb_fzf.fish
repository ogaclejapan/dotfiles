function adb_fzf -d 'Execute adb command to interactive if multiple devices connected'

    if not type -q adb
        echo "adb: command not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: command not found" >&2
        return 1
    end

    if test (count $argv) -eq 0
        command adb (string escape -- $argv)
        return 0
    end

    if contains -- -d $argv or contains -- -e $argv or contains -- -s $argv
        command adb (string escape -- $argv)
        return 0
    end

    switch $argv[1]
        case devices help version start-server kill-server connect disconnect
            command adb (string escape -- $argv)
        case '*'
            command adb devices -l | sed -e '/^[<space><tab>]*$/d' -e '/^[<space><tab>]*\*.*\*[<space><tab>]*$/d' | fzf --header-lines=1 --select-1 --reverse --min-height=2 --height=25% --prompt='>> ' | tr -s '[:blank:]' '\t' | cut -f 1 | read -l serial
            if test -z $serial
                return 0
            end
            command adb -s "$serial" (string escape -- $argv)
    end

end
