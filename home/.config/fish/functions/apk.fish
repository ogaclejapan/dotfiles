function apk -d 'Find apk from under the current directory'
  if not type -q fd
    echo "fd: not found"
    return 1
  end
  fd -I -E '.git' -e 'apk' | fzf --min-height=2 --height=25% --reverse --select-1
end
