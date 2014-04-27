set -x LANG ja_JP.UTF-8
set -x EDITOR vim
set -x PATH $HOME/bin /usr/local/bin $PATH

set HOST_FISH ~/.config/fish/(hostname).fish
if test -f $HOST_FISH
   . $HOST_FISH
else
   echo Creating host fish: $HOST_FISH
   touch $HOST_FISH
   echo "set -x TMUX_AUTO_ATTACH ''" >> $HOST_FISH
end

set PLATFORM_FISH ~/.config/fish/(uname -s).fish
if test -f $PLATFORM_FISH
   . $PLATFORM_FISH
else
   echo Creating platform fish: $PLATFORM_FISH
   touch $PLATFORM_FISH
end

set PLATFORM_TMUX ~/.tmux/(uname -s).conf
if not test -f $PLATFORM_TMUX
   echo Creating platform tmux conf: $PLATFORM_TMUX
   touch $PLATFORM_TMUX
end

set PLATFORM_TMUX_SYMBOLIC ~/.tmux-platform.conf
if not test -e $PLATFORM_TMUX_SYMBOLIC
   echo Creating symbolic link: $PLATFORM_TMUX_SYMBOLIC
   ln -s $PLATFORM_TMUX $PLATFORM_TMUX_SYMBOLIC
end

set AUTO_TMUX $TMUX_AUTO_ATTACH
if [ -n "$AUTO_TMUX" -a -z "$TMUX_PANE" ]
  tmux has-session ^/dev/null; and tmux list-session | grep -q "\^$AUTO_TMUX"
  if [ $status -eq 0 ]
    tmux attach -t $AUTO_TMUX
  else
    tmux new -s $AUTO_TMUX
  end
end

