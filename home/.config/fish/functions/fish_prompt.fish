function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function fish_prompt

  set -l cwd (set_color $fish_color_cwd)(prompt_pwd)
  set -l git_status (_git_branch_name)

  if test -n "$git_status"
    set git_status " $git_status"
  end

  echo -n $cwd(set_color cyan)$git_status(set_color normal)'$ '

end
