function rehosts -d 'Refresh hosts'
    _rehosts_multipass
end

function _rehosts_multipass
    if not type -q multipass
        return 0
    end

    if not type -q awk
        echo "awk: command not found" >&2
        return 1
    end

    if not type -q hostctl
        echo "hostctl: command not found" >&2
        return 1
    end

    multipass list --format csv \
    | awk -F ',' 'NR>1 {print $3 " " $1".local"}' \
    | sudo hostctl set -p multipass --from /dev/fd/0

end
