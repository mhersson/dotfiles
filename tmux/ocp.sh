#!/usr/bin/env bash
set -euo pipefail

theme=github

if (oc whoami 1>&2 >/dev/null); then
  status=$(oc adm config current-context |
    awk -F'/' '{ print $2 }' |
    awk -F':' '{ print $1 }' |
    sed "s/ocp-\|api-\|-openshift-cue-cloud\|@stibodx.com//"g)
  #awk -F'/' '{ print $3 "@" $2 ":" $1}' |
  #awk -F':' '{ print $1 "/" $3 }' |
  #sed "s/ocp-\|api-\|-openshift-cue-cloud\|@stibodx.com//"g)

  #echo -n "#[fg=colour214]#[bg=colour214,fg=colour242] ${status} #[bg=colour214,fg=default]"

  case "$theme" in
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
