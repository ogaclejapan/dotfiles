# load alias
[ -f ~/.bashrc.alias ] && source ~/.bashrc.alias

# load os settings
case "${OSTYPE}" in
  "darwin*" ) [ -f ~/.bashrc.osx ] && source ~/.bashrc.osx ;;
  "linux*" ) [ -f ~/.bashrc.linux ] && source ~/.bashrc.linux ;;
esac

# load local settings
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
