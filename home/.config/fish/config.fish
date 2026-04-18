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

if type -q claude
    # e.g. gopass env xxx ccmcp
    abbr -a ccmcp --position anywhere 'claude --mcp-config (mcp)'
    abbr -a ccauto 'claude --enable-auto-mode'
    abbr -a ccdev 'claude --append-system-prompt "(cat ~/.claude/contexts/dev.md)"'
    abbr -a ccresearch 'claude --append-system-prompt "(cat ~/.claude/contexts/research.md)"'
    abbr -a ccreview 'claude --append-system-prompt "(cat ~/.claude/contexts/review.md)"'
end

if type -q tuicr
    abbr -a cr 'tuicr'
    abbr -a crh 'tuicr -r HEAD'
end
