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

if type -q tmux
    alias tm='tmux new -A -s main'
    alias tmkill='tmux kill-session -t main'
end

if type -q git
    alias g=giter
    alias t=giter_worktree
end

if type -q adb
    alias a=adb_fzf
    alias cap='a screencap -j'
    alias rec='a screenrecord'
    alias am='a shell am'
    alias pm='a shell pm'
    alias dumpsys='a shell dumpsys'
end

if type -q docker
    alias dshell='docker run -it --rm bash'
end

if type -q shfmt
    alias shfmtw='shfmt -l -w -i 4'
end

if type -q bun
    alias ccusage='bunx ccusage'
end

if type -q uv
    alias cclog='uvx claude-code-log --open-browser'
end

if type -q claude
    # e.g. gopass env xxx ccmcp
    abbr -a ccmcp --position anywhere 'claude --mcp-config (mcp)'
    abbr -a ccauto 'claude --enable-auto-mode'
    abbr -a ccdev 'claude --append-system-prompt "(cat ~/.claude/contexts/dev.md)"'
    abbr -a ccresearch 'claude --append-system-prompt "(cat ~/.claude/contexts/research.md)"'
    abbr -a ccreview 'claude --append-system-prompt "(cat ~/.claude/contexts/review.md)"'
end
