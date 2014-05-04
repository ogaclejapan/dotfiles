# Make sure using latest Homebrew
update

# Update already-installed formula (takes too much time, I will do it manually later)
upgrade

# Add repository
tap homebrew/versions || true
tap homebrew/binary || true

# Install packages
install git
install git-flow
install tig
install hub
install fish
install tmux
install reattach-to-user-namespace
install wget
install curl
install tree
install jq
install rbenv ruby-build
install the_silver_searcher
install vim --with-lua
install macvim --with-cscope --with-lua --HEAD

# Install formula (Optional)
#install boot2docker
#install docker

linkapps --local

# Remove outdated versions
cleanup
