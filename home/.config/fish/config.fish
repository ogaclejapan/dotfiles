set -x LANG ja_JP.UTF-8
set fish_greeting

if type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
    direnv hook fish | source
end

if type -q tmux
    abbr -a tm='tmux new -A -s main'
    abbr -a tmkill='tmux kill-session -t main'
end

if type -q docker
    abbr -a dshell='docker run -it --rm bash'
end

if type -q shfmt
    abbr -a shfmtw='shfmt -l -w -i 4'
end

if type -q uv
    abbr -a cclog='uvx claude-code-log --open-browser'
end

if type -q claude
    # e.g. gopass env xxx ccmcp
    abbr -a ccmcp --position anywhere 'claude --mcp-config (mcp)'
end

if type -q lumen
    abbr -a review 'lumen diff'
end
