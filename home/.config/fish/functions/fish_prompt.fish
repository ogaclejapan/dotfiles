function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _tmux_pane_number
  echo (tmux display -p -t $TMUX_PANE '#P')
end

function fish_prompt --on-event fish_prompt_event

  set -l cyan (set_color cyan)
  set -l normal (set_color normal)
  set -l yellow (set_color yellow)

  set -l cwd (set_color $fish_color_cwd)(prompt_pwd)
  set -l git_status (_git_branch_name)

  set prompt "$cwd$normal"

  if test -n "$git_status"
    set -l git_status $cyan$git_status$normal
    set prompt "$prompt $git_status"
  end

  if [ $TMUX ]
    set -l tmux_status (_tmux_pane_number)
    set prompt $prompt'$'$tmux_status
  else
    set prompt $prompt'$'
  end

  echo -n $prompt' '

end
