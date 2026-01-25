# デフォルトで起動するエディタ
#set -x EDITOR 'emacsclient -t --alternate-editor=nano'
#set -x EDITOR 'vim'

# ANSI "color" escape sequences are output in "raw" form
set -x LESS '-R'

# Colorized format for ls command
set -x LSCOLORS exfxcxdxbxxggxabagacad

# GPG pinentry
# ref. https://man.archlinux.org/man/gpg-agent.1
set -x GPG_TTY (tty)

# Sops
#set -x SOPS_AGE_KEY_FILE <path>

# JIRA api token for go-jira
# https://id.atlassian.com/manage/api-tokens
#set -x JIRA_API_TOKEN 'your personal access token'

# GitHub personal access token for Homebrew
#set -x HOMEBREW_GITHUB_API_TOKEN 'your personal access token'

# fzf
set -x FZF_DEFAULT_COMMAND 'fd .'
set -x FZF_DEFAULT_OPTS '--layout=reverse --height=10%'
set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CD_COMMAND 'fd -t d .'
set -x FZF_CD_WITH_HIDDEN_COMMAND 'fd -H -E '.git' -t d .'

# Version of the JDK for JAVA_HOME
# ref. /usr/libexec/java_home -V
#set -x JDK_VERSION 21

# Android Studio for low memory
#set -x STUDIO_VM_OPTIONS $HOME/.android/studio.vmoptions

# Build Enhancements for Docker
#set -x DOCKER_BUILDKIT 1

# iOS Debug Bridge
#set -x IDB_UDID <udid>

# Tailscale
#alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
