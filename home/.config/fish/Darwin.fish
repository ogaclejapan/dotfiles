
if test -d ~/.rbenv/shims
	set -x PATH ~/.rbenv/shims $PATH
end

if test -d "/Applications/MacVim.app"
	set -x PATH /Applications/MacVim.app/Contents/MacOS $PATH
end

