alias ll='ls -lahF'
alias la='ls -a'

# It looks like a zeit/hyper terminal
if test $TERM != 'dumb'
    echo -n -e "\033]6;1;bg;red;brightness;40\a"
    echo -n -e "\033]6;1;bg;green;brightness;44\a"
    echo -n -e "\033]6;1;bg;blue;brightness;52\a"
end

if type -q rbenv
    status --is-interactive; and source (rbenv init -|psub)
end

if type -q plenv
    plenv init - | source
end

if type -q n
    set -x N_PREFIX $HOME/.n
    set -x PATH $N_PREFIX/bin $PATH
end

if test -e /usr/libexec/java_home
    set -x JAVA_HOME (command /usr/libexec/java_home)
end

if test -d /usr/local/share/android-sdk
    set -x ANDROID_HOME /usr/local/share/android-sdk
    set -x ANDROID_HVPROTO ddm
    set -x ANDROID_ROOT_SDK $ANDROID_HOME
    if test -d $ANDROID_HOME/platform-tools
        set -x PATH $PATH $ANDROID_HOME/platform-tools
    end
    if test -d $ANDROID_HOME/emulator
        set -x PATH $PATH $ANDROID_HOME/emulator
    end
end

if test -d /usr/local/opt/groovy/libexec
    set -x GROOVY_HOME /usr/local/opt/groovy/libexec
end

if test -d /usr/local/opt/go
    set -x GOPATH ~/.go
    set -x PATH $GOPATH/bin $PATH
    set -x PATH /usr/local/opt/go/libexec/bin $PATH
end



