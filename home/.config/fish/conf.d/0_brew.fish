set BREW_DIR /opt/homebrew
if test -d "$BREW_DIR"
    source ($BREW_DIR/bin/brew shellenv | psub)
end
