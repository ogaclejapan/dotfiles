
# 起動時に指定したtmuxセッションに自動でアタッチする
set -x TMUX_AUTO_ATTACH ''

# デフォルトで起動するエディタ
#set -x EDITOR 'emacsclient -t --alternate-editor=mg'
#set -x EDITOR 'vim'

# JIRAコマンドのベースURL
set -x JIRA_URL ''

# GitHub personal access token for Homebrew
#set -x HOMEBREW_GITHUB_API_TOKEN 'your personal access token'

# fzf
set -x FZF_DEFAULT_COMMAND 'fd .'
set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CD_COMMAND 'fd -t d .'
set -x FZF_CD_WITH_HIDDEN_COMMAND 'fd -H -E '.git' -t d .'
