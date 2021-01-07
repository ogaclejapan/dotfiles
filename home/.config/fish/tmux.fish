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
