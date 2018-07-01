alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -t --alternate-editor=mg'
alias e='emacsclient -c -F "\'(fullscreen . maximized)"'
alias ekill='emacsclient -e "(kill-emacs)"'
alias f='fuzzy_file_commander'
alias d='fuzzy_directory_commander'
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
if type -q aria2c
    alias dl=aria2c
end
