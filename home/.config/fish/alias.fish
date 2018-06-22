alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -nw --alternate-editor=mg'
alias em='emacs'
alias e='emacsclient -n'
alias ekill='emacsclient -e "(kill-emacs)"'
if type -q hub
    alias git=hub
    alias g=giter
    alias t=giter_worktree
end
if type -q adb
    alias adb=adb_fzf
    alias cap='adb screencap'
    alias rec='adb screenrecord'
    alias am='adb shell am'
    alias pm='adb shell pm'
end
if type -q emulator
    alias emulator=emulator_fzf
end
if type -q sdkmanager
    alias sdkmanager=sdkmanager_fzf
end
