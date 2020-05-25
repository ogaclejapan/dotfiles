# https://github.com/fish-shell/fish-shell/issues/6899
function gpg
    LANG=en_US.UTF-8 command gpg $argv
end
