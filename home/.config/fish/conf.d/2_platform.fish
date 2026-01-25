set PLATFORM_FISH ~/.config/fish/(uname -s).fish
if test -f $PLATFORM_FISH
    source $PLATFORM_FISH
else
    echo Creating platform fish: $PLATFORM_FISH
    touch $PLATFORM_FISH
end
