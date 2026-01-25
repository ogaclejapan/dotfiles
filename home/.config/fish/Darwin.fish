alias ll='ls -lahF'
alias lr='ll -rt'
alias la='ls -a'

fish_add_path --path $HOME/.bin
fish_add_path --path $HOME/.local/bin

if set -q JDK_VERSION; and type -q /usr/libexec/java_home
    set -x JAVA_HOME (/usr/libexec/java_home -v $JDK_VERSION)
    set -x GRADLE_LOCAL_JAVA_HOME $JAVA_HOME
    fish_add_path --path $JAVA_HOME/bin
end

if test -d "$HOME/.android/cmdline-tools"
    set -x ANDROID_CMDTOOLS $HOME/.android/cmdline-tools
    fish_add_path --path $ANDROID_CMDTOOLS/bin
end

if test -d "$HOME/Library/Android/sdk"
    set -x ANDROID_SDK_ROOT $HOME/Library/Android/sdk
    set -x ANDROID_HOME $ANDROID_SDK_ROOT
    set -x ANDROID_HVPROTO ddm
    if test -d $ANDROID_SDK_ROOT/cmdline-tools
        fish_add_path --path $ANDROID_SDK_ROOT/cmdline-tools/latest/bin
    end
    if test -d $ANDROID_SDK_ROOT/platform-tools
        fish_add_path --path $ANDROID_SDK_ROOT/platform-tools
    end
    if test -d $ANDROID_SDK_ROOT/emulator
        fish_add_path --path $ANDROID_SDK_ROOT/emulator
    end
    set -x ANDROID_BUILD_TOOL_VERSION (ls $ANDROID_SDK_ROOT/build-tools/ | sort -r | head -n 1)
    if test -d $ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOL_VERSION
        fish_add_path --path $ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOL_VERSION
    end
end

if test -d "$HOME/.bun"
    set -x BUN_INSTALL "$HOME/.bun"
    fish_add_path --path $BUN_INSTALL/bin
end

if test -d "$HOME/.sdk/google-cloud-sdk"
    set -x CLOUD_ROOT_SDK $HOME/.sdk/google-cloud-sdk
    source $CLOUD_ROOT_SDK/path.fish.inc
end

if test -d /usr/local/opt/llvm
    set -x LLVM_ROOT /usr/local/opt/llvm
    set -x LDFLAGS -L/usr/local/opt/llvm/lib
    set -x CPPFLAGS -I/usr/local/opt/llvm/include
    fish_add_path --path $LLVM_ROOT/bin
end
