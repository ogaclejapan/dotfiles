alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -nw'
alias e='emacsclient -n'
alias ekill='emacsclient -e "(kill-emacs)"'
if type -q hub
  alias git=hub
end
