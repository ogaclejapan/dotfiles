set HOST_FISH ~/.config/fish/(hostname).fish
if test -f $HOST_FISH
    source $HOST_FISH
else
    echo Creating host fish: $HOST_FISH
    cat ~/.config/fish/host.fish >$HOST_FISH
end
