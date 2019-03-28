function emulator_fzf -d 'Execute android emulator command'

    if not type -q emulator
        echo "emulator: command not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: command not found" >&2
        return 1
    end

    if test (count $argv) -eq 0
        __emulator_exec $argv
        return 0
    end

    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case run
            __emulator_run $argv
        case '*'
            __emulator_exec $subcommand $argv
    end

end

function __emulator_exec
    command emulator $argv
end

function __emulator_run
    command emulator -list-avds | fzf --reverse --exact --height=30% --select-1 | read -l target
    if test -z $target
        return 0
    end
    command emulator "@$target" $argv
end

function __emulator_fzf_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    else
        return 1
    end
end

complete -f -c emulator_fzf -n '__emulator_fzf_needs_command' -a run -d 'Run selected emulator'
