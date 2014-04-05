
# command alias
alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -aF'

# load os settings
case "${OSTYPE}" in
  "darwin*" ) [ -f ~/.bashrc.osx ] && source ~/.bashrc.osx ;;
  "linux*" ) [ -f ~/.bashrc.linux ] && source ~/.bashrc.linux ;;
esac

