#!/usr/bin/env bash
set -euo pipefail

theme=github

if (oc whoami 1>&2 >/dev/null); then
  status=$(oc config current-context |
    awk -F'/' '{ print $2 }' |
    awk -F':' '{ print $1 }' |
    sed "s/ocp-\|api-\|-openshift-cue-cloud\|@stibodx.com//"g)

  case "$theme" in
    "dracula")
      echo -n "#[fg=colour162]#[bg=colour162,fg=colour235] ${status} #[bg=colour162,fg=colour235]"
      ;;
    "github")
      echo -n "#[fg=colour163]#[bg=colour163,fg=white] ${status} #[bg=colour163,fg=white]"
      ;;
    "solarized")
      echo -n "#[fg=colour214]#[bg=colour214,fg=colour242] ${status} #[bg=colour214,fg=default]"
      ;;
    *)
      # Gruvbox
      echo -n "#[fg=colour214]#[bg=colour214,fg=colour242] ${status} #[bg=colour214,fg=color236]"
      ;;
  esac
fi
