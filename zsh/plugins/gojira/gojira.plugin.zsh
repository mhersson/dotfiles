#compdef _gojira gojira


function _gojira {
  local -a commands

  _arguments -C \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "add:Add a comment or register time"
      "completion:Output shell completion code for the specified shell"
      "create:Create new issue"
      "describe:Display issue with all its gory details"
      "get:Display one or many resources"
      "help:Help about any command"
      "open:Open in browser"
      "set:Set issue active"
      "unset:Unset (clear) active issue"
      "update:Update issue"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  add)
    _gojira_add
    ;;
  completion)
    _gojira_completion
    ;;
  create)
    _gojira_create
    ;;
  describe)
    _gojira_describe
    ;;
  get)
    _gojira_get
    ;;
  help)
    _gojira_help
    ;;
  open)
    _gojira_open
    ;;
  set)
    _gojira_set
    ;;
  unset)
    _gojira_unset
    ;;
  update)
    _gojira_update
    ;;
  esac
}


function _gojira_add {
  local -a commands

  _arguments -C \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "comment:Add new comment"
      "work:Add work (format 2h or 120m)"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  comment)
    _gojira_add_comment
    ;;
  work)
    _gojira_add_work
    ;;
  esac
}

function _gojira_add_comment {
  _arguments
}

function _gojira_add_work {
  _arguments \
    '(-c --comment)'{-c,--comment}'[add a comment to you worklog]:' \
    '(-d --date)'{-d,--date}'[date, overrides the default date (today)]:'
}

function _gojira_completion {
  _arguments \
    '(-h --help)'{-h,--help}'[help for completion]'
}

function _gojira_create {
  _arguments
}

function _gojira_describe {
  _arguments
}


function _gojira_get {
  local -a commands

  _arguments -C \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "active:Display the active issue"
      "all:Display all issues assigned to you"
      "comments:Display all comments"
      "myworklog:Display your worklog for a given date"
      "status:Display the current status"
      "transitions:Display available transistions"
      "worklog:Display the worklog"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  active)
    _gojira_get_active
    ;;
  all)
    _gojira_get_all
    ;;
  comments)
    _gojira_get_comments
    ;;
  myworklog)
    _gojira_get_myworklog
    ;;
  status)
    _gojira_get_status
    ;;
  transitions)
    _gojira_get_transitions
    ;;
  worklog)
    _gojira_get_worklog
    ;;
  esac
}

function _gojira_get_active {
  _arguments
}

function _gojira_get_all {
  _arguments \
    '(-f --filter)'{-f,--filter}'[write your own jql filter]:'
}

function _gojira_get_comments {
  _arguments
}

function _gojira_get_myworklog {
  _arguments
}

function _gojira_get_status {
  _arguments
}

function _gojira_get_transitions {
  _arguments
}

function _gojira_get_worklog {
  _arguments
}

function _gojira_help {
  _arguments
}

function _gojira_open {
  _arguments
}


function _gojira_set {
  local -a commands

  _arguments -C \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "active:Set issue active"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  active)
    _gojira_set_active
    ;;
  esac
}

function _gojira_set_active {
  _arguments
}

function _gojira_unset {
  _arguments
}


function _gojira_update {
  local -a commands

  _arguments -C \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "assignee:Assign issue to user"
      "comment:Update (edit) comment"
      "description:Update the description"
      "status:Update the status"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  assignee)
    _gojira_update_assignee
    ;;
  comment)
    _gojira_update_comment
    ;;
  description)
    _gojira_update_description
    ;;
  status)
    _gojira_update_status
    ;;
  esac
}

function _gojira_update_assignee {
  _arguments \
    '(-u --username)'{-u,--username}'[username of the new assignee]:'
}

function _gojira_update_comment {
  _arguments
}

function _gojira_update_description {
  _arguments
}

function _gojira_update_status {
  _arguments
}

compdef _gojira gojira
