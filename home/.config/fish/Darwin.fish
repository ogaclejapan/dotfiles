alias ll='ls -lhF'
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



