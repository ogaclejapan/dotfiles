export LANG='ja_JP.UTF-8'
export EDITOR='vim'
export HISTSIZE=100000

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH="/usr/local/man:$MANPATH"


# Alias

alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -aF'
alias df='df -h'


# Load local settings
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
