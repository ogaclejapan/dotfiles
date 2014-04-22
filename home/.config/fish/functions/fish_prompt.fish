function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _tmux_pane_number -d 'pane-base-index must be 1'
  if [ -n "$TMUX" -a -n "$TMUX_PANE" ]
    set -l pane_no ( echo $TMUX_PANE | sed -e 's/^%//' )
    echo (math $pane_no + 1)
  else
    echo ""
  end
end

function fish_prompt

  set -l cyan (set_color cyan)
  set -l normal (set_color normal)
  set -l yellow (set_color yellow)

  set -l cwd (set_color $fish_color_cwd)(prompt_pwd)
  set -l git_status (_git_branch_name)
  set -l tmux_status (_tmux_pane_number)

  set prompt "$cwd$normal"

  if test -n "$git_status"
    set -l git_status $cyan$git_status$normal
    set prompt "$prompt $git_status"
  end

  if test -n "$tmux_status"
    set -l tmux_status '%'$tmux_status
    set prompt "$prompt $tmux_status"
  else
    set prompt $prompt'$'
  end

  echo -n $prompt' '

end
