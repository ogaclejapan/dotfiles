alias ll='ls -lhF'
alias la='ls -a'

set -xg JAVA_HOME (echo (command /usr/libexec/java_home))

if test -d ~/.rbenv/shims
	set -x PATH ~/.rbenv/shims $PATH
end



