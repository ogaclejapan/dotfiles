alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -nw'
alias e='emacsclient -n'
alias ekill='emacsclient -e "(kill-emacs)"'
if type -q hub
  alias git=hub
end
if type -q adb
  alias adb=adb_fzf
end
if type -q git
  alias gs=git_list_fzf
end

