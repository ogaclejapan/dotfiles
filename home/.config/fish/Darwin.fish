alias ll='ls -lahF'
alias lr='ll -rt'
alias la='ls -a'

# It looks like a zeit/hyper terminal
if test $TERM != 'dumb'
    echo -n -e "\033]6;1;bg;red;brightness;40\a"
    echo -n -e "\033]6;1;bg;green;brightness;44\a"
    echo -n -e "\033]6;1;bg;blue;brightness;52\a"
end

if type -q rbenv
    status --is-interactive; and source (rbenv init - | psub)
end

if type -q plenv
    status --is-interactive; and source (plenv init - | psub)
end

if type -q pyenv
    status --is-interactive; and source (pyenv init - | psub)
end

if type -q n
    set -x N_PREFIX $HOME/.n
    set -x PATH $N_PREFIX/bin $PATH
end

if type -q nnn
    set -x NNN_USE_EDITOR 1
end

if test -e /usr/libexec/java_home
    set -x JAVA_HOME (command /usr/libexec/java_home)
end

if test -d /usr/local/share/android-sdk
    set -x ANDROID_ROOT_SDK /usr/local/share/android-sdk
    set -x ANDROID_HOME $ANDROID_ROOT_SDK
    set -x ANDROID_HVPROTO ddm
    if test -d $ANDROID_ROOT_SDK/platform-tools
        set -x PATH $PATH $ANDROID_ROOT_SDK/platform-tools
    end
    if test -d $ANDROID_ROOT_SDK/emulator
        set -x PATH $PATH $ANDROID_ROOT_SDK/emulator
    end
    set -x STUDIO_VM_OPTIONS $HOME/.android/studio.vmoptions
end

if test -d /usr/local/opt/groovy/libexec
    set -x GROOVY_HOME /usr/local/opt/groovy/libexec
end

if test -d /usr/local/opt/go
    set -x GOPATH ~/.go
    set -x PATH $GOPATH/bin $PATH
    set -x PATH /usr/local/opt/go/libexec/bin $PATH
end

if test -d "$HOME/.cargo"
    set -x CARGO_HOME $HOME/.cargo
    set -x PATH $CARGO_HOME/bin $PATH
end
