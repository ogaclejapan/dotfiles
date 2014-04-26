function _tmux_colour --description 'show tmux colour'
  if [ (count $argv) -gt 0 ]
    set -l num $argv[1]
    printf '\x1b[38;5;'$num'mcolour'$num'■ '
  else
    echo "e.g. tmux_colour [0-255]"
  end
end

function tmux_colours --description 'show all tmux colours'
  for i in (seq 0 255)
    echo (_tmux_colour $i)
  end
end

