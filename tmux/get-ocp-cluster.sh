#!/usr/bin/env bash
set -euo pipefail

if (oc whoami 1>&2 >/dev/null) ; then
  status=$(oc adm config current-context |
    awk -F'/' '{ print $3 "@" $2 ":" $1}' |
    awk -F':' '{ print $1 "/" $3 }' |
    sed "s/ocp-\|api-\|-openshift-cue-cloud\|@stibodx.com//"g)

  echo -n "#[fg=colour214]#[bg=colour214,fg=colour239,bold] ${status} #[bg=colour214,fg=colour237,nobold]"
fi
