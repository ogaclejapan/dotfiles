alias ll='ls -lahF'
alias la='ls -a'

if test -d ~/.rbenv/shims
	set -x PATH ~/.rbenv/shims $PATH
end

if test -d ~/.pyenv/shims
  set -x PATH ~/.pyenv/shims $PATH
  set -x PYENV_SHELL fish
end

if /usr/libexec/java_home > /dev/null
  set -x JAVA_HOME (echo (command /usr/libexec/java_home))
end

if test -d /usr/local/opt/android-sdk
  set -x ANDROID_HOME /usr/local/opt/android-sdk
end

if test -d /usr/local/opt/groovy/libexec
  set -x GROOVY_HOME /usr/local/opt/groovy/libexec
end

if test -d /usr/local/opt/go
  set -x GOPATH ~/.go
  set -x PATH $GOPATH/bin $PATH
  set -x PATH /usr/local/opt/go/libexec/bin $PATH
end

if test -d ~/Applications/Atom.app
  set -x ATOM_PATH ~/Applications
end

