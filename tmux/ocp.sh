#!/usr/bin/env bash
set -euo pipefail

theme=dark

if (oc whoami 1>&2 >/dev/null); then
  status=$(oc config current-context \
    | awk -F'/' '{ print $2 }' \
    | awk -F':' '{ print $1 }' \
    | sed "s/ocp-\|api-\|-openshift-cue-cloud\|@stibodx.com//"g)

  case "$theme" in
    "dark")
      echo -n "#[fg=colour111]#[bg=colour111,fg=colour238] ${status} #[bg=colour111,fg=colour235]"
      ;;
    "light")
      echo -n "#[fg=colour163]#[bg=colour163,fg=white] ${status} #[bg=colour163,fg=white]"
      ;;
    *)
      echo -n "#[fg=colour214]#[bg=colour214,fg=colour242] ${status} #[bg=colour214,fg=color236]"
      ;;
  esac
fi
