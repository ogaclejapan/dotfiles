alias ll='ls -lahF'
alias lr='ll -rt'
alias la='ls -a'

if type -q rbenv
    status --is-interactive; and source (rbenv init - | psub)
end

if type -q plenv
    status --is-interactive; and source (plenv init - | psub)
end

if type -q pyenv
    status --is-interactive; and source (pyenv init - | psub); and source (pyenv init --path | psub)
end

if type -q nodenv
    status --is-interactive; and source (nodenv init - | psub)
end

if type -q jenv
    status --is-interactive; and source (jenv init - | psub)
    set -x PATH $HOME/.jenv/bin $PATH
end

if type -q direnv
    status --is-interactive; and source (direnv hook fish - | psub)
end

if type -q nnn
    set -x NNN_USE_EDITOR 1
end

if type -q go
    set -x GO111MODULE on
    set -x GOPATH (go env GOPATH)
    set -x PATH $GOPATH/bin $PATH
end

if test -d "$HOME/.android/cmdline-tools"
    set -x ANDROID_CMDTOOLS $HOME/.android/cmdline-tools
    set -x PATH $ANDROID_CMDTOOLS/bin $PATH
end

if test -d "$HOME/Library/Android/sdk"
    set -x ANDROID_SDK_ROOT $HOME/Library/Android/sdk
    set -x ANDROID_HOME $ANDROID_SDK_ROOT
    set -x ANDROID_HVPROTO ddm
    if test -d $ANDROID_SDK_ROOT/cmdline-tools
        set -x PATH $ANDROID_SDK_ROOT/cmdline-tools/latest/bin $PATH
    end
    if test -d $ANDROID_SDK_ROOT/platform-tools
        set -x PATH $ANDROID_SDK_ROOT/platform-tools $PATH
    end
    if test -d $ANDROID_SDK_ROOT/emulator
        set -x PATH $ANDROID_SDK_ROOT/emulator $PATH
    end
    set -x ANDROID_BUILD_TOOL_VERSION (ls $ANDROID_SDK_ROOT/build-tools/ | sort -r | head -n 1)
    if test -d $ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOL_VERSION
        set -x PATH $ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOL_VERSION $PATH
    end
end

if test -d "$HOME/.flutter"
    set -x FLUTTER_ROOT $HOME/.flutter
    set -x PATH $FLUTTER_ROOT/bin $PATH
end

if test -d "$HOME/.cargo"
    set -x CARGO_HOME $HOME/.cargo
    set -x PATH $CARGO_HOME/bin $PATH
end

if test -d "$HOME/.poetry"
    set -x POETRY_HOME $HOME/.poetry
    set -x PATH $POETRY_HOME/bin $PATH
end

if test -d /usr/local/share/google-cloud-sdk
    set -x CLOUD_ROOT_SDK /usr/local/share/google-cloud-sdk
    source $CLOUD_ROOT_SDK/path.fish.inc
end

if test -d /usr/local/opt/llvm
    set -x LLVM_ROOT /usr/local/opt/llvm
    set -x PATH $LLVM_ROOT/bin $PATH
    set -x LDFLAGS "-L/usr/local/opt/llvm/lib"
    set -x CPPFLAGS "-I/usr/local/opt/llvm/include"
end
