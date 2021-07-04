#!/usr/bin/env bash
# set -euo pipefail

# Gruvbox
# if (piactl get connectionstate | grep Connected >/dev/null 2>&1); then
#     echo -n "#[fg=colour236]#[bg=colour236,fg=colour248] #h "
# else
#     echo -n "#[fg=colour196]#[bg=colour196,fg=colour236,bold] #h"
# fi

# Nord
# if (piactl get connectionstate | grep Connected >/dev/null 2>&1); then
#     echo -n "#[fg=black,bg=cyan,bold] #h "
# else
#     echo -n "#[fg=black,bg=red,bold] #h"
# fi

if (nmcli c show --active | grep -i protonvpn >/dev/null 2>&1); then
    echo -n "#[fg=black,bg=cyan,bold] #h "
else
    echo -n "#[fg=black,bg=red,bold] #h"
fi

