function apk -d 'Find apk from under the current directory'
  set apks **/*.apk
  set apk_count (count $apks)
  if [ $apk_count -gt 1 ]
    echo $apks | fzf
  else if [ $apk_count -eq 1 ]
    echo $apks
  else
    echo "apk: not found."
  end
end

