function git_branch_list_fzf -d 'Execute git for-each-ref command to interactive when multiple branches found'

  if not type -q git
    echo "git: command not found"
    return 1
  end

  set origin (type -P git)

  set refs ''
  set options ''
  for option in $argv
    switch "$option"
      case -l --local
        set refs 'refs/heads'
      case -r --remote
        set refs 'refs/remotes'
      case -t --tag
        set refs 'refs/tags'
      case \*
        set options $options $option
    end
  end

  eval "$origin for-each-ref --format='%(refname:short)%(if)%(authorname)%(then)%09by %(authorname)%(end)' $options $refs | fzf  --reverse --select-1 | cut -f 1"

end
