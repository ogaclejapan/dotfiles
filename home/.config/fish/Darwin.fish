alias ll='ls -lahF'
alias la='ls -a'

# It looks like a zeit/hyper terminal
if test $TERM != 'dumb'
  echo -n -e "\033]6;1;bg;red;brightness;40\a"
  echo -n -e "\033]6;1;bg;green;brightness;44\a"
  echo -n -e "\033]6;1;bg;blue;brightness;52\a"
end

if test -d ~/.rbenv/shims
	set -x PATH ~/.rbenv/shims $PATH
end

if /usr/libexec/java_home > /dev/null
  set -x JAVA_HOME (echo (command /usr/libexec/java_home))
end

if test -d /usr/local/share/android-sdk
  set -x ANDROID_HOME /usr/local/share/android-sdk
  set -x ANDROID_HVPROTO ddm
  set -x ANDROID_ROOT_SDK $ANDROID_HOME
  set -x PATH $PATH $ANDROID_HOME/platform-tools
  set -x PATH $PATH $ANDROID_HOME/emulator
end

if test -d /usr/local/opt/groovy/libexec
  set -x GROOVY_HOME /usr/local/opt/groovy/libexec
end

if test -d /usr/local/opt/go
  set -x GOPATH ~/.go
  set -x PATH $GOPATH/bin $PATH
  set -x PATH /usr/local/opt/go/libexec/bin $PATH
end

