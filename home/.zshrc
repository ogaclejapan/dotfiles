# __/__/__/__/__/__/__/__/__/__/__/__/__/__/__/
# __/.zshrc is file to customize for common.
# __/__/__/__/__/__/__/__/__/__/__/__/__/__/__/

if [ -d "$HOME/.oh-my-zsh" ]; then

  # Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

  # Set name of the theme to load.
  # Look in ~/.oh-my-zsh/themes/
  # Optionally, if you set this to "random", it'll load a random theme each
  # time that oh-my-zsh is loaded.
  ZSH_THEME="fishy"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(git z tmux sublime jira)

  source $ZSH/oh-my-zsh.sh

fi

# Load the local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

