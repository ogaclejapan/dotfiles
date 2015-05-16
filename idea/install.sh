#!/bin/bash
# Installs IntelliJ configs into your user configs.

echo "Installing configs..."

for i in $HOME/Library/Preferences/IntelliJIdea*/keymaps \
         $HOME/Library/Preferences/IdeaIC*/keymaps \
         $HOME/Library/Preferences/AndroidStudio*/keymaps \
         $HOME/.IntelliJIdea*/config/keymaps \
         $HOME/.IdeaIC*/config/keymaps \
         $HOME/.AndroidStudio*/config/keymaps
do
  cp -frv $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/keymaps/* $i 2> /dev/null
done

echo "Done."
echo ""
echo "Restart IntelliJ and/or AndroidStudio, go to preferences, and apply the config."
