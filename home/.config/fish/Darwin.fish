alias ll='ls -lahF'
alias la='ls -a'

if test -d ~/.rbenv/shims
	set -x PATH ~/.rbenv/shims $PATH
end

if /usr/libexec/java_home > /dev/null
  set -x JAVA_HOME (echo (command /usr/libexec/java_home))
end

if test -d /usr/local/opt/android-sdk
  set -x ANDROID_HOME /usr/local/opt/android-sdk
end

if test -d ~/Applications/Atom.app
  set -x ATOM_PATH ~/Applications
end

