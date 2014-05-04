function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end


function fish_prompt

  set -l color_normal (set_color normal)
  set -l color_git (set_color 7ACEFC)
  set -l color_pwd (set_color BAED23)

  set -l current_dir (prompt_pwd)
  set -l git_status (_git_branch_name)

  set prompt "$color_pwd$current_dir$color_normal"

  if test -n "$git_status"
    set -l git_status $color_git$git_status$color_normal
    set prompt "$prompt $git_status"
  end

  echo -n $prompt'$ '

end
