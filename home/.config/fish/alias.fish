alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -t --alternate-editor=mg'
alias e='emacsclient -c -u -F "\'(fullscreen . maximized)"'
alias ekill='emacsclient -e "(kill-emacs)"'
alias f='fuzzy_file_commander'
alias f0='f --depth 1'
alias d='fuzzy_directory_commander'
alias d0='d --depth 1'

if type -q brew
    # WORKAROUND https://qiita.com/takuya0301/items/695f42f6904e979f0152
    alias brew='env PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew'
end

if type -q hub
    alias git=hub
    alias g=giter
    alias t=giter_worktree
end

if type -q adb
    alias a=adb_fzf
    alias cap='a screencap'
    alias rec='a screenrecord'
    alias am='adb shell am'
    alias pm='adb shell pm'
    alias dumpsys='adb shell dumpsys'
    if type -q rogcat
        alias logcat='rogcat'
        abbr --add l 'logcat'
    end
end

if type -q emulator
    alias emulator=emulator_fzf
end

if type -q sdkmanager
    alias sdkmanager=sdkmanager_fzf
end


if type -q bat
    abbr --add p 'bat'
end

if type -q aria2c
    abbr --add aget 'aria2c'
end

if type -q glances
    abbr --add htop 'glances'
end
