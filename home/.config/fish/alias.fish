alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -nw'
alias e='emacsclient -n'
alias ekill='emacsclient -e "(kill-emacs)"'
if type -q hub
    alias git=hub
    alias g=giter
end
if type -q adb
    alias adb=adb_fzf
    alias cap='adb screencap'
    alias rec='adb screenrecord'
    alias am='adb shell am'
    alias pm='adb shell pm'
end
