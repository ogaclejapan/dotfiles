function subl --description 'Open Sublime Text'

  if test -d "/Applications/Sublime Text 2.app"
    "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" $argv
  else
    echo "Sublime Text does not exist."
  end

end
