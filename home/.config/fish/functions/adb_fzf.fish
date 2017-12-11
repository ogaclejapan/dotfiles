function adb_fzf -d 'Execute adb command to interactive if multiple devices connected'
  
  if not type -q adb
    echo "adb: command not found"
    return 1
  end

  if not type -q fzf
    echo "fzf: command not found"
    return 1
  end

  set origin (type -P adb)

  if test (count $argv) -eq 0
    eval $origin
    return 0
  end

  for q in '-d' '-e' '-s'
    if contains -- $q $argv
      eval $origin $argv
      return 0
    end
  end

  switch $argv[1]
    case devices help version start-server kill-server connect disconnect
      eval $origin $argv
    case '*'
      set t (eval $origin 'devices -l' | sed -e '/^[<space><tab>]*$/d' -e '/^[<space><tab>]*\*.*\*[<space><tab>]*$/d' | fzf --header-lines=1 --select-1 --reverse --min-height=2 --height=25% --prompt='>> ' | tr -s '[:blank:]' '\t' | cut -f 1)
      if test -z $t
        return 0
      else
        eval $origin '-s' $t $argv
      end
  end
  
end
