function apk -d 'Find apk from under the current directory'
  rg -u -g '*.apk' --files | fzf --height=25%
end
