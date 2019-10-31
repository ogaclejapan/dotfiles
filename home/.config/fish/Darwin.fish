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

if type -q goenv
    status --is-interactive; and source (goenv init - | psub)
end

if type -q direnv
    status --is-interactive; and source (direnv hook fish - | psub)
end

if type -q n
    set -x N_PREFIX $HOME/.n
    set -x PATH $N_PREFIX/bin $PATH
end

if type -q nnn
    set -x NNN_USE_EDITOR 1
end

if type -q goenv
    set -x GOENV_DISABLE_GOPATH 1
    set -x GOPATH ~/.go
    set -x PATH $GOPATH/bin $PATH
end

if test -e /usr/libexec/java_home
    set -x JAVA_HOME (command /usr/libexec/java_home)
end

if test -d /usr/local/share/android-sdk
    set -x ANDROID_ROOT_SDK /usr/local/share/android-sdk
    set -x ANDROID_HOME $ANDROID_ROOT_SDK
    set -x ANDROID_HVPROTO ddm
    if test -d $ANDROID_ROOT_SDK/platform-tools
        set -x PATH $ANDROID_ROOT_SDK/platform-tools $PATH
    end
    if test -d $ANDROID_ROOT_SDK/emulator
        set -x PATH $ANDROID_ROOT_SDK/emulator $PATH
    end
end

if test -d /usr/local/share/google-cloud-sdk
    set -x CLOUD_ROOT_SDK /usr/local/share/google-cloud-sdk
    source $CLOUD_ROOT_SDK/path.fish.inc
end

if test -d /usr/local/opt/groovy/libexec
    set -x GROOVY_HOME /usr/local/opt/groovy/libexec
end

if test -d "$HOME/.cargo"
    set -x CARGO_HOME $HOME/.cargo
    set -x PATH $CARGO_HOME/bin $PATH
end

if test -d "$HOME/.poetry"
    set -x POETRY_HOME $HOME/.poetry
    set -x PATH $POETRY_HOME/bin $PATH
end
