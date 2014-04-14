function jira

  if test -f ~/.jira-url
    set jira_url (cat ~/.jira-url)
  else if set -q JIRA_URL; and test -n "$JIRA_URL"
    set jira_url $JIRA_URL
  else
    echo "JIRA url is not specified anywhere."
    return
  end

  if test (count $argv) -eq 1; and test -n $argv[1]
    set -l ticket $argv[1]
    echo "Opening issue #$ticket"
    open "$jira_url/browse/$ticket"
  else
    echo "Opening new issue"
    open "$jira_url/secure/CreateIssue!default.jspa"
  end

end

