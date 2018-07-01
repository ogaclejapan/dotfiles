function magit -d 'Run magit-status on emacs'
    if not type -q git
        echo "git: not found" >&2
        return 1
    end
    if not type -q emacsclient
        echo "emacsclient: not found" >&2
        return 1
    end
    set rootdir (git rev-parse --show-toplevel)
    emacsclient -t -u --eval "(magit-status \"$rootdir\")"
end
