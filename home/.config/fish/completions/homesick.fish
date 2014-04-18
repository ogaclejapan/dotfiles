
function __fish_homesick_needs_command
  set cmd (commandline -opc)
  if test (count $cmd) -eq 1 -a $cmd[1] = 'homesick'
    return 0
  end
  return 1
end

function __fish_homesick_using_command
  set cmd (commandline -opc)
  if test (count $cmd) -gt 1
    if test $argv[1] = $cmd[2]
      return 0
    end
  end
  return 1
end

function __fish_homesick_castles
  command ls ~/.homesick/repos/ ^/dev/null
end


### cd
complete -f -c homesick -n '__fish_homesick_needs_command' -a cd -d 'Open a new shell in the root of the given castle'
complete -f -c homesick -n '__fish_homesick_using_command cd' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### clone
complete -f -c homesick -n '__fish_homesick_needs_command' -a clone -d 'Clone URI as a castle for homesick'

### commit
complete -f -c homesick -n '__fish_homesick_needs_command' -a commit -d 'Commit the specified castles changes'
complete -f -c homesick -n '__fish_homesick_using_command commit' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### destroy
complete -f -c homesick -n '__fish_homesick_needs_command' -a destroy -d 'Delete all symlinks and remove the cloned repository'
complete -f -c homesick -n '__fish_homesick_using_command destroy' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### diff
complete -f -c homesick -n '__fish_homesick_needs_command' -a diff -d 'Shows the git diff of uncommitted changes in a castle'
complete -f -c homesick -n '__fish_homesick_using_command diff' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### generate
complete -f -c homesick -n '__fish_homesick_needs_command' -a generate -d 'Clone +uri+ as a castle for homesick'

### help
complete -f -c homesick -n '__fish_homesick_needs_command' -a help -d 'Display help'

### list
complete -f -c homesick -n '__fish_homesick_needs_command' -a list -d 'List cloned castles'

### open
complete -f -c homesick -n '__fish_homesick_needs_command' -a open -d 'Open your default editor in the root of the given castle'
complete -f -c homesick -n '__fish_homesick_using_command open' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### pull
complete -f -c homesick -n '__fish_homesick_needs_command' -a pull -d 'Update the specified castle'
complete -f -c homesick -n '__fish_homesick_using_command pull' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### push
complete -f -c homesick -n '__fish_homesick_needs_command' -a push -d 'Push the specified castle'
complete -f -c homesick -n '__fish_homesick_using_command push' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### rc
complete -f -c homesick -n '__fish_homesick_needs_command' -a rc -d 'Run the .homesickrc for the specified castle'
complete -f -c homesick -n '__fish_homesick_using_command rc' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### show_path
complete -f -c homesick -n '__fish_homesick_needs_command' -a show_path -d 'Prints the path of a castle'
complete -f -c homesick -n '__fish_homesick_using_command show_path' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### status
complete -f -c homesick -n '__fish_homesick_needs_command' -a status -d 'Shows the git status of a castle'
complete -f -c homesick -n '__fish_homesick_using_command status' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### symlink
complete -f -c homesick -n '__fish_homesick_needs_command' -a symlink -d 'Symlinks all dotfiles from the specified castle'
complete -f -c homesick -n '__fish_homesick_using_command symlink' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### track
complete -f -c homesick -n '__fish_homesick_needs_command' -a track -d 'add a file to a castle'
complete -c homesick -n '__fish_homesick_using_command track'

### unlink
complete -f -c homesick -n '__fish_homesick_needs_command' -a unlink -d 'Unsymlinks all dotfiles from the specified castle'
complete -f -c homesick -n '__fish_homesick_using_command unlink' -a '(__fish_homesick_castles)' -d 'List cloned castles'

### version
complete -f -c homesick -n '__fish_homesick_needs_command' -a version -d 'Display the current version of homesick'
