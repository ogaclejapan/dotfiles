alias ssh='env TERM=xterm-256color ssh'
alias emacs='emacsclient -t --alternate-editor=mg'
alias e='emacsclient -c -u -F "\'(fullscreen . maximized)"'
alias ekill='emacsclient -e "(kill-emacs)"'
alias nano='env LANG=en_US.UTF-8 nano'
alias f='fuzzy_file_commander'
alias f0='f --depth 1'
alias d='fuzzy_directory_commander'
alias d0='d --depth 1'
# 128bit
alias rand16='openssl rand -hex 16'
# 256bit
alias rand32='openssl rand -hex 32'
alias jcurl='curl -H "Accept: application/json" -H "Content-Type: application/json"'
alias xyz='mkdir -p xyz && cd xyz'

if type -q git
    alias g=giter
    alias t=giter_worktree
end

if type -q adb
    alias a=adb_fzf
    alias cap='a screencap'
    alias rec='a screenrecord'
    alias am='a shell am'
    alias pm='a shell pm'
    alias dumpsys='a shell dumpsys'
end

if type -q emulator
    alias emulator=emulator_fzf
end

if type -q sdkmanager
    alias sdkmanager=sdkmanager_fzf
end

if type -q kubectl
    alias k='kubectl'
    alias kshell='kubectl run -it --image bash --restart Never --rm shell'
end

if type -q docker
    alias dshell='docker run -it --rm bash'
end

if type -q shfmt
    alias shfmtw='shfmt -l -w -i 4'
end

if type -q node
    alias nanoid='npx nanoid'
end
