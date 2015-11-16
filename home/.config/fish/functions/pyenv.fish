function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case activate deactivate rehash shell
    eval (pyenv "sh-$command" $argv)
  case '*'
    command pyenv "$command" $argv
  end
end

