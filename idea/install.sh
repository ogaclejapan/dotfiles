#!/bin/bash
# Installs IntelliJ configs into your user configs.

echo "Installing configs..."

dirs=(
  $HOME/Library/Preferences/IntelliJIdea*
  $HOME/Library/Preferences/IdeaIC*
  $HOME/Library/Preferences/AndroidStudio*
  $HOME/.IntelliJIdea*/config
  $HOME/.IdeaIC*/config
  $HOME/.AndroidStudio*/config
  )

# Install keymaps
for dir in "${dirs[@]}"
do
  if [ -e $dir ]; then
    if [ -d "$dir/keymaps" ]; then
      cp -frv $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/keymaps/* "$dir/keymaps" 2> /dev/null
    else
      cp -frv $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/keymaps $dir 2> /dev/null
    fi
  fi
done

echo "Done."
echo ""
echo "Restart IntelliJ and/or AndroidStudio, go to preferences, and apply the config."
