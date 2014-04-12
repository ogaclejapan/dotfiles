# __/__/__/__/__/__/__/__/__/__/__/__/__/__/__/
# __/.zshenv is file to customize for common.
# __/__/__/__/__/__/__/__/__/__/__/__/__/__/__/

export LANG='ja_JP.UTF-8'
export EDITOR='vim'
export HISTSIZE=100000

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH="/usr/local/man:$MANPATH"

# Load the local settings
[ -f ~/.zshenv.local ] && source ~/.zshenv.local

