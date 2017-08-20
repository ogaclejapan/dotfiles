set -x SHELL fish
set -x LANG ja_JP.UTF-8
set -x PATH ./bin $HOME/.bin /usr/local/bin $PATH

set ALIAS_FISH ~/.config/fish/alias.fish
if test -f $ALIAS_FISH
  source $ALIAS_FISH
end

set PLATFORM_FISH ~/.config/fish/(uname -s).fish
if test -f $PLATFORM_FISH
  source $PLATFORM_FISH
else
  echo Creating platform fish: $PLATFORM_FISH
  touch $PLATFORM_FISH
end

set HOST_FISH ~/.config/fish/(hostname).fish
if test -f $HOST_FISH
  source $HOST_FISH
else
  echo Creating host fish: $HOST_FISH
  cat ~/.config/fish/host.fish > $HOST_FISH
end

# e.g. ~/.tmux/2.4/Darwin.conf
set PLATFORM_TMUX ~/.tmux/(tmux -V | cut -c 6-)/(uname -s).conf
if not test -f $PLATFORM_TMUX
  # e.g. ~/.tmux/2.4/Default.conf
  set PLATFORM_TMUX ~/.tmux/(tmux -V | cut -c 6-)/Default.conf
  if not test -f $PLATFORM_TMUX
    # e.g. ~/.tmux/Darwin.conf
    set PLATFORM_TMUX ~/.tmux/(uname -s).conf
    if not test -f $PLATFORM_TMUX
      # e.g. ~/.tmux/Default.conf
      set PLATFORM_TMUX ~/.tmux/Default.conf
    end
  end
end

set PLATFORM_TMUX_SYMBOLIC ~/.tmux-platform.conf
if not test -e $PLATFORM_TMUX_SYMBOLIC
  echo Creating symbolic link: $PLATFORM_TMUX_SYMBOLIC
  ln -s $PLATFORM_TMUX $PLATFORM_TMUX_SYMBOLIC
end

if [ -n "$TMUX_AUTO_ATTACH" -a -z "$TMUX_PANE" ]
  set AUTO_TMUX $TMUX_AUTO_ATTACH
  if tmux has-session -t $AUTO_TMUX ^/dev/null
    if tmux list-sessions -F '#S:#{session_attached}' | grep -q "^$AUTO_TMUX:[1-9][0-9]*"
      set AUTO_TMUX ''
    end
  end
  test -n "$AUTO_TMUX" ; and tmux new-session -A -s $AUTO_TMUX
end
