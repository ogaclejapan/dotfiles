alias ll='ls -lahF'
alias la='ls -a'

if test -d /usr/local/tmp
    set -x TMPDIR /usr/local/tmp
end

if test -d /usr/local/lib/go
    set -x GOROOT /usr/local/lib/go
    set -x PATH $PATH $GOROOT/bin
end

