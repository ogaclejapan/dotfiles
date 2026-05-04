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
end

if type -q tuicr
    abbr -a cr 'tuicr'
    abbr -a crh 'tuicr -r HEAD'
end
