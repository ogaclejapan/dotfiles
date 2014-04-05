# command alias
alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -aF'
alias df='df -h'

# load os settings
case "${OSTYPE}" in
  "darwin*" ) [ -f ~/.bashrc.osx ] && source ~/.bashrc.osx ;;
  "linux*" ) [ -f ~/.bashrc.linux ] && source ~/.bashrc.linux ;;
esac

# load local settings
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
