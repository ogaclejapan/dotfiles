set -x LANG ja_JP.UTF-8
set fish_greeting

set -l PARENTS_PATH $PATH
set -x PATH /usr/local/bin /usr/bin /bin $HOME/.local/bin $HOME/.bin /usr/local/sbin /usr/sbin /sbin

set HOST_FISH ~/.config/fish/(hostname).fish
if test -f $HOST_FISH
    source $HOST_FISH
else
    echo Creating host fish: $HOST_FISH
    cat ~/.config/fish/host.fish >$HOST_FISH
end

set PLATFORM_FISH ~/.config/fish/(uname -s).fish
if test -f $PLATFORM_FISH
    source $PLATFORM_FISH
else
    echo Creating platform fish: $PLATFORM_FISH
    touch $PLATFORM_FISH
end

# set TMUX_FISH ~/.config/fish/tmux.fish
# if type -q tmux; and test -f $TMUX_FISH
#     source $TMUX_FISH
# end

if type -q starship
    starship init fish | source
end

# path cleanup
set -x PATH $PATH $PARENTS_PATH
set NEW_PATH
for i in $PATH
    if not contains $i $NEW_PATH
        set NEW_PATH $NEW_PATH $i
    end
end
set -x PATH $NEW_PATH
set -e NEW_PATH

set ALIAS_FISH ~/.config/fish/alias.fish
if test -f $ALIAS_FISH
    source $ALIAS_FISH
end
