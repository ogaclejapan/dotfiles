alias ssh='env TERM=xterm ssh'
alias emacs='emacsclient -t --alternate-editor=mg'
alias e='emacsclient -c -u -F "\'(fullscreen . maximized)"'
alias ekill='emacsclient -e "(kill-emacs)"'
alias f='fuzzy_file_commander'
alias f0='f --depth 1'
alias d='fuzzy_directory_commander'
alias d0='d --depth 1'
alias rand16='openssl rand -hex 10 | fold -w 16 | head -n 1'

if type -q node
    alias aes256='node -p "require(\'crypto\').randomBytes(32).toString(\'base64\')"'
else if type -q python3
    alias aes256='python3 -c "import os,base64; print(base64.b64encode(os.urandom(32)).decode(\'utf-8\'))"'
else
    alias aes256='echo "unavailable :(" 1>&2'
end

if type -q brew
    # WORKAROUND https://qiita.com/takuya0301/items/695f42f6904e979f0152
    alias brew='env PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew'
end

if type -q gpg
    alias gpg='env LANG=en_US.UTF-8 gpg'
end

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
    if type -q rogcat
        alias rc='rogcat'
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

if type -q kubectl
    abbr --add k 'kubectl'
end

if type -q gcloud
    abbr --add c 'gcloud'
end

if type -q multipass
    abbr --add mp 'multipass'
end
