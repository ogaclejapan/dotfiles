#!/bin/bash
# Installs IntelliJ configs into your user configs.

echo "Installing configs..."

CONFIGS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/configs"

dirs=(
  $HOME/Library/Application\ Support/Google/AndroidStudio*
  $HOME/Library/Application\ Support/JetBrains/Idea*
  # Old IDEs
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
  if [[ -d "$dir" ]]; then
    mkdir -p "$dir/keymaps"
    cp -frv "$CONFIGS/keymaps"/* "$dir/keymaps"
  fi
done

echo "Done."
echo ""
echo "Restart IntelliJ and/or AndroidStudio, go to preferences, and apply the config."
