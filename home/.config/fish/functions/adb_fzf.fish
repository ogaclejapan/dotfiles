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
        __adb_exec $argv
        return 0
    end

    if contains -- -d $argv; or contains -- -e $argv; or contains -- -s $argv
        __adb_exec $argv
        return 0
    end

    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case devices help version start-server kill-server connect disconnect
            __adb_exec $subcommand $argv
        case screencap
            __adb_screencapture $argv
        case screenrecord
            __adb_screenrecord $argv
        case '*'
            __adb_exec_with_serial $subcommand $argv
    end

end

function __adb_device
    command adb devices -l | sed -e '/^[<space><tab>]*$/d' -e '/^[<space><tab>]*\*.*\*[<space><tab>]*$/d' | fzf --header-lines=1 --select-1 --reverse --min-height=2 --height=25% --prompt='>> ' | tr -s '[:blank:]' '\t' | cut -f 1
end

function __adb_exec
    command adb $argv
end

function __adb_exec_with_serial
    set serial (__adb_device)
    if test -z $serial
        return 0
    end
    command adb -s $serial $argv
end

function __adb_screencapture
    set serial (__adb_device)
    if test -z $serial
        return 0
    end
    set fpath (realpath ~/Desktop)
    argparse -s 'p/path=' -- $argv
    if set -q _flag_path
        set fpath (eval realpath $_flag_path)
    end
    set timestamp (date "+%Y%m%d%H%M%S")
    set fname (printf "screen_%s.png" $timestamp)
    set tmp (printf "/data/local/tmp/%s" $fname)
    set dst (printf "%s/%s" $fpath $fname)

    command adb -s $serial shell screencap -p $tmp
    and command adb -s $serial pull $tmp $dst >/dev/null
    and command adb -s $serial shell rm $tmp
    and echo $dst
end

function __adb_screenrecord
    set serial (__adb_device)
    if test -z $serial
        return 0
    end
    set fpath (realpath ~/Desktop)
    argparse -s 'p/path=' 'g/gif' -- $argv
    if set -q _flag_gif; and not type -q ffmpeg
        echo "ffmpeg: command not found" >&2
        return 1
    end
    if set -q _flag_path
        set fpath (eval realpath $_flag_path)
    end
    set timestamp (date "+%Y%m%d%H%M%S")
    set fname (printf "screen_%s.mp4" $timestamp)
    set tmp (printf "/data/local/tmp/%s" $fname)
    set dst (printf "%s/%s" $fpath $fname)

    command adb -s $serial shell screenrecord $tmp &
    jobs -lp | grep -v 'Process' | read -l pid
    if test -z $pid
        echo "screenrecord: not running" >&2
        return 1
    end

    set answer 'n'
    while test $answer != 'Y'
        read -P 'Recording, finish? [Y/n]: ' -c 'Y' answer
    end

    kill -9 $pid

    set is_running 1
    while test $is_running -ne 0
        command adb -s $serial shell ps | grep -c screenrecord | read is_running
    end

    command adb -s $serial pull $tmp $dst >/dev/null
    and command adb -s $serial shell rm $tmp

    if not set -q _flag_gif
        echo $dst
        return 0
    end

    set fname (printf "screen_%s.gif" $timestamp)
    ffmpeg -i $dst -loglevel error -vf scale=360:-1 -r 10 (printf "%s/%s" $fpath $fname)
    and rm $dst

end

function __adb_fzf_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    else
        return 1
    end
end

complete -f -c adb_fzf -n '__adb_fzf_needs_command' -a screencap -d 'Taking a screenshot of a device display'
complete -f -c adb_fzf -n '__adb_fzf_needs_command' -a screenrecord -d 'Recording the display of devices running Android 4.4 and higher'
complete -c adb_fzf -w adb
