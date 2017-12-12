function apk -d 'Find apk from under the current directory'
  rg -u -g '*.apk' --files | fzf --min-height=2 --height=25% --reverse --select-1
end
