function git_list_fzf -d 'Execute git for-each-ref command to interactive when multiple branches found'

  if not type -q git
    echo "git: command not found"
    return 1
  end

  set origin (type -P git)
  
  for option in $argv
    switch "$option"
      case -l --local
        set refs 'refs/heads'
      case -r --remote
        set refs 'refs/remotes'
      case -t --tag
        set refs 'refs/tags'
      case \*
        set refs ''
    end
  end

  eval "$origin for-each-ref --format='%(refname:short)' $refs | fzf  --reverse --select-1"

end
