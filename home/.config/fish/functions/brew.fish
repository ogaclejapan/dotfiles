# https://github.com/fish-shell/fish-shell/issues/6899
function brew
    # WORKAROUND https://qiita.com/takuya0301/items/695f42f6904e979f0152
    PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin command brew $argv
end
