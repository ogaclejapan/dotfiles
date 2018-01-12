function apk -d 'Find apk from under the current directory'
  if not type -q fd
    echo "fd: not found"
    return 1
  end

  set apk (fd -I -E '.git' -e 'apk' | fzf --min-height=2 --height=25% --reverse --select-1)
  if test -z $apk
    echo "apk: not found"
    return 1
  end
  
  if contains -- '-d' $argv
    dirname $apk
  else
    echo $apk
  end
    
end
