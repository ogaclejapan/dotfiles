function sdkmanager_fzf -d 'Extend a sdkmanager command'

    if not type -q sdkmanager
        echo "sdkmanager: command not found" >&2
        return 1
    end

    if not type -q fzf
        echo "fzf: command not found" >&2
        return 1
    end

    if test (count $argv) -eq 0
        __sdkmanager_exec $argv
        return 0
    end

    argparse -s 'b-bundle=?' 'e-export' 'm-multi' -- $argv 2>/dev/null
    if set -q _flag_bundle
        set pkg_file "$HOME/.android/packages.txt"
        if test -n "$_flag_bundle"
            set pkg_file (realpath $_flag_bundle)
        end
        __sdkmanager_bundle $pkg_file
    else if set -q _flag_export
        __sdkmanager_export
    else if set -q _flag_multi
        __sdkmanager_multi
    else
        __sdkmanager_exec $argv
    end
end

function __sdkmanager_exec
    command sdkmanager $argv
end

function __sdkmanager_multi
    #  Installed packages
    #    Path |...| Location
    #    ----
    #    xxx
    #    xxx
    #
    #  Available Packages
    #>   Path |...|
    #>   ----
    #>   xxx
    #>   xxx
    #
    command sdkmanager --list | sed -n -e '/^Available\ Packages/,/^$/p' | sed -e '/^[<space><tab>]*$/d' | fzf --reverse --multi --header-lines=3 --delimiter='\|' --nth 1 --exact --no-sort --tac | cut -d '|' -f 1 | tr -d ' ' | xargs -J % command sdkmanager --install %
end

function __sdkmanager_export
    #  Installed packages
    #>   Path |...| Location
    #>   ----
    #>   xxx
    #>   xxx
    #>
    #  Available Packages
    command sdkmanager --list | sed -n -e '/Location/,/^$/p' | sed -e '1,2d' | sed -e '/^[<space><tab>]*$/d' | cut -d '|' -f 1 | tr -d ' '
end

function __sdkmanager_bundle
    set -l pkg_file $argv[1]
    if not test -e $pkg_file
        echo "bundle: file not found. $pkg_file" >&2
        return 1
    end
    cat $pkg_file | xargs -J % command sdkmanager --install %
end
